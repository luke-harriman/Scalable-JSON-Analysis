import clickhouse_connect
from datetime import datetime

# Function to query data from ClickHouse
def query_data_from_clickhouse(query):
    # Establish a connection to the ClickHouse server
    client = clickhouse_connect.get_client(host='localhost', username='default', database='default')
    
    # Query the data from ClickHouse
    result = client.query(query)
    
    # Initialize an empty list to store the rows as lists
    list_of_lists = []
    
    # Convert each tuple row into a list and append to list_of_lists
    for row in result.result_rows:
        list_of_lists.append(list(row))
    
    return list_of_lists

# Main function to handle the workflow
def main():
    # Define the SQL query to select data from the 'details' table
    query = "SELECT * FROM json_data"

    # Query the data from ClickHouse and transform into a list of lists
    data_as_list_of_lists = query_data_from_clickhouse(query)
    
    # Print the transformed data
    for row in data_as_list_of_lists:
        print(row)

if __name__ == '__main__':
    main()
        
        
