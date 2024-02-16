import json
import pprint as pp 

def get_terminal_key_paths(data, base_path='_source'):
    key_paths = {}
    if isinstance(data, dict):
        for key, value in data.items():
            path = f"{base_path}.{key}" if base_path else key
            if not isinstance(value, (dict, list)):
                key_paths[path] = type(value).__name__
            else:
                key_paths.update(get_terminal_key_paths(value, path))
    elif isinstance(data, list):
        if data and isinstance(data[0], (dict, list)):
            for i, item in enumerate(data):
                path = f"{base_path}"
                key_paths.update(get_terminal_key_paths(item, path))

    return key_paths

def item_generator(json_input, lookup_key):
    if isinstance(json_input, dict):
        for k, v in json_input.items():
            if k == lookup_key:
                yield v
            else:
                yield from item_generator(v, lookup_key)
    elif isinstance(json_input, list):
        for item in json_input:
            yield from item_generator(item, lookup_key)

def process_record(record, key_paths):
    processed = {
        "timestamp": next(item_generator(record, 'timestamp'), None).split('.')[0],
        "method_name": next(item_generator(record, 'methodName'), None),
        "location": next(item_generator(record, 'location'), None),
        "project_id": next(item_generator(record, 'project_id'), None), 
        "revision_name": next(item_generator(record, 'revision_name'), None), 
        "severity": next(item_generator(record, 'severity'), None),
        "_source": record,
        "string.names": [],
        "string.values": [],
        "number.names": [],
        "number.values": [],
        "boolean.names": [],
        "boolean.values": []
    }
    for path, value_type in key_paths.items():
        keys = path.split(".")[1:]
        value = record
        for key in keys:
            if isinstance(value, dict):
                if key.isdigit() and isinstance(value, list):
                    value = value[int(key)]
                else:
                    value = value.get(key)
            else:
                break
        if value is not None:
            if value_type == 'str':
                processed['string.names'].append('.'.join(keys))
                processed['string.values'].append(value)
            elif value_type in ['int', 'float']:
                processed['number.names'].append('.'.join(keys))
                processed['number.values'].append(float(value))
            elif value_type == 'bool':
                processed['boolean.names'].append('.'.join(keys))
                processed['boolean.values'].append(int(value))
    return processed

# Opening Local File
with open('path/to/local/json/file', 'r') as file:
    data = json.load(file)
    
key_paths = get_terminal_key_paths(data)

processed_records = [process_record(record, key_paths) for record in data]

# Saving to Clickhouse user_files repository
with open('path/to/user_files', 'w') as file:
    json.dump(processed_records, file)

