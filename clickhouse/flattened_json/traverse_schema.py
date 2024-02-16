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

with open('path/to/local/file', 'r') as file:
    data = json.load(file)

# Get the key paths and their value types
key_paths = get_terminal_key_paths(data)

pp.pprint(key_paths)