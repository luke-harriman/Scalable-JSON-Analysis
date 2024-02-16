import pprint as pp
import json 

def flatten_json(y):
    out = {}
    def flatten(x, name='_source'):
        if type(x) is dict:
            for a in x:
                flatten(x[a], name + a + '.')
        elif type(x) is list:
            i = 0
            for a in x:
                flatten(a, name + '.')
                i += 1
        else:
            out[name[:-1]] = x
    flatten(y)
    return out

# Opening Local File
with open('path/to/local/json/file', 'r') as file:
    data = json.load(file)


data_list = []

for element in data:
    flattened_json = flatten_json(element)
    flattened_json = [flattened_json]
    data_list.append(flattened_json)

# Saving to Clickhouse user_files repository
with open('path/to/user_files', 'w') as file:
    json.dump(data_list, file)
