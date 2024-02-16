# Overview

Analysing JSON data has been a significant challenge for large companies, with organizations like Uber ingesting millions of logs per second and eBay storing multiple petabytes of log events each day - all in JSON format. Building analytics with this large, complex data can be inefficient and complicated. This repository explores three techniques for ingesting JSON data - in this example we will use log events from GCP Cloud Run - and querying it from Clickhouse.

# Approaches

## Approach One: Single JSON Object

The first approach - `json_data` - stores data as JSON objects within a column named `_source`. Each `_source` row houses a JSON object containing every field found across the dataset, leading to numerous fields populated with default values (e.g., "" and None). See `./clickhouse/raw_json`.

## Approach Two: Flattened JSON Data

The second approach - `json_data_flattened` - flattens JSON data into a table with columns for each terminal path in the JSON dataset. For instance, the `_source.protoPayload.request.service.metadata.labels.cloud.googleapis.com/location` column stores the location of requests to the GCP Cloud Run instance. This approach significantly improves query speed, up to 5x-10x faster than approach one and three. However, it scales poorly due to the linear growth in disk files as new columns are added, coupled with an inability to adapt dynamically to unfamiliar fields within the JSON data. To prevent `INSERT` queries from failing when new JSON fields are ingested, you can use `input_format_skip_unknown_fields=1`. Take note, however, that this will discard data from new, unknown fields.
 
## Approach Three: Key-Value Arrays

The third approach - `json_data_key_value_array` - converts logs into key-value pairs grouped by value types (String, Number, Boolean, etc.), stored in paired arrays. It keeps common metadata in dedicated columns for quick access, maintaining raw logs in the `_source` column for full log reconstruction when needed.

# Data

The data analysis revealed varying performance across different storage approaches:

![Query Performance](data/query_performance.png)

- **Query Performance**: As expected the `json_data_flattened` table was the fastest; however, surprisingly, the `json_data` method was ~3x faster than `json_data_key_value_array`. Clickhouse is awesome! Most databases handle JSON data very poorly, due to the fact that it's just stored as a string. 

| database | table                      | compressed | uncompressed | compr_rate | rows   | part_count |
|----------|----------------------------|------------|--------------|------------|--------|------------|
| default  | json_data_flattened        | 6.68 MiB   | 119.20 MiB   | 17.84      | 249700 | 3          |
| default  | json_data                  | 6.65 MiB   | 120.59 MiB   | 18.14      | 249700 | 3          |
| default  | json_data_key_value_array  | 3.04 MiB   | 387.96 MiB   | 127.44     | 249700 | 3          |


- **Data Compression: No Table Order Key**: The `json_data_key_value_array` approach is the worst in terms of query speed; however, it demonstrated significantly better compression rates, possibly indicating its efficiency for large-scale JSON storage and analysis.  It was nearly 3x larger uncompressed compared to other tables but used less than half the storage space once compressed. Note, the metrics above are without specifying an `ORDER` key during table creation. To learn more about why this impacts compression, read [How to improve Clickhouse table compression](https://medium.com/datadenys/how-to-improve-clickhouse-table-compression-697ef8f4ccb3). 

- **Data Compression: With Table Order Key**: To demonstrate the impact of an `ORDER` key on data compression, the table below shows a comparison between `json_data_key_value_array` and `json_data`. I wrote a python script that duplicated my GCP Cloud Run logs 5000 times and inserted it into each table. As you can see the uncompressed version of `json_data_key_value_array` is ~4x bigger than `json_data`; however, once compressed `json_data_key_value_array` is 1/3 the size of `json_data`. 

Note, the `json_data_key_value_array` table only used `timestamp` as an `ORDER` key due to the cimplicity of the GCP Cloud Run data. With more complicated data, a more complex `ORDER` key will give you even better compression compared to storing data as a JSON object. 

| database | table                      | compressed | uncompressed | compr_rate | rows   | part_count |
|----------|----------------------------|------------|--------------|------------|--------|------------|
| default  | json_data                  | 148.83 MiB   | 2.68 GiB   | 18.14      | 5675000 | 1          |
| default  | json_data_key_value_array  | 55.67 MiB   | 10.45 GiB   | 192.24     | 5675000 | 1          |


# Improvements
- Test With More Complicated/Diverse Data: My data was very primitive as it wasn't from a popular production app. For example, the metadata fiels in the `json_data_key_value_array` table only really had one or two values; meaning implementing skip indices or more `ORDER` keys wouldn't really make a difference. However, these strategies promise huge improvements on more complicated, diverse data. 
- Materialized Columns: Implementing a materialized column, for any commonly used JSON field can significantly speed up filtering and sorting operations.
- Skip Index Implementation: The `json_data_key_value_array` approach enable you to implement a skip index that radically improves query performance. 
- `ORDER` Key Adjustment: Fine-tune the ORDER BY clause in the table creation statement to improve data compression and query efficiency.