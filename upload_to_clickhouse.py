import clickhouse_connect
import json

def insert_data_into_clickhouse(table_name, data):
    # Establish a connection to the ClickHouse server
    client = clickhouse_connect.get_client(host='localhost', username='default', database='default')

    # Insert the data into ClickHouse
    client.insert(table_name, data)

