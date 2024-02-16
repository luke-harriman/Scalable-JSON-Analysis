# Overview

Analysing JSON data has been a significant challenge for large companies, with organizations like Uber ingesting millions of logs per second and eBay storing multiple petabytes of logs each day, all in JSON format. Building analytics with this voluminous and complex data can be inefficient and complicated. This document outlines a technique for ingesting JSON data and formatting it in a fixed schema within Clickhouse, accommodating structural changes in the JSON data.

## Approaches

### Approach One: Single JSON Object

Storing data as a single JSON object in one column allows for the creation of fields within each row for every unique field found in the JSON. This approach leads to many fields having default values like None and "", impacting table compression, as discussed in the Data section.

### Approach Two: Flattened JSON Data

Flattening JSON data significantly improves query speed, up to 5x-10x faster than other schemas. However, it doesn't scale well due to linear growth in the number of disk files as new JSON fields are identified. To prevent INSERT query failures with new fields, you can use `input_format_skip_unknown_fields=1`, though this discards data from unknown fields.

### Approach Three: Key-Value Arrays

This method flattens logs into key-value pairs grouped by value types (String, Number, Boolean, etc.), stored in paired arrays for efficient query execution and compression. It keeps common metadata in dedicated columns for quick access, maintaining raw logs in a _source column for full log reconstruction when needed. This dual storage approach leverages Clickhouse's array functions for fast field value access, suggesting the use of materialized columns for commonly accessed fields to optimize queries.

## Data

The data analysis revealed varying performance across different storage approaches:

![Query Performance](data/query_performance.png)


- **Query Performance**: Initial tests showed that `json_data_flattened` performed fastest but had scalability issues. `json_data_key_value_array` took longer but offered better compression, suggesting potential cost and performance benefits at scale.
- **Compression and Storage**: The `json_data_key_value_array` approach demonstrated significantly better compression rates, indicating its efficiency for large-scale JSON log data storage and analysis, even when storing raw logs.

## Improvements

Future enhancements include testing with larger datasets to validate the `json_data_key_value_array` approach's scalability and performance benefits. Additionally, exploring the performance impact of materialized columns and skip indexes, and adjusting `ORDER BY` statements in table creation could further optimize query execution and data management.


# Setup 

### 1: Download the binary
ClickHouse runs natively on Linux, FreeBSD and macOS, and runs on Windows via the WSL. The simplest way to download ClickHouse locally is to run the following curl command. It determines if your operating system is supported, then downloads an appropriate ClickHouse binary:

```bash
curl https://clickhouse.com/ | sh
```

### 2: Start the server
Run the following command to start the ClickHouse server:

```bash
./clickhouse server
```

### 3: Start the client
Use the ```clickhouse-client``` to connect to your ClickHouse service. Open a new Terminal, change directories to where your ```clickhouse``` binary is saved, and run the following command:

```bash
./clickhouse client
```

You should see a smiling face as it connects to your service running on localhost:

```bash
my-host :)
```

### 4: Create a table and Insert Data

See directory ```clickhouse```