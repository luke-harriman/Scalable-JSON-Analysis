import clickhouse_connect
import json

# Opening Local File
with open('path/to/local/json/file', 'r') as f:
    data = json.load(f)

new_data = []

for element in data:
    element = {'_source': element}
    new_data.append(element)

# Saving to Clickhouse user_files repository
with open('path/to/user_files', 'w') as f:
    json.dump(new_data, f)
