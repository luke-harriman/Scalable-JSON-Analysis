-- Table Setup
SET allow_experimental_object_type=1;
SET output_format_json_named_tuples_as_objects = 1;
SET input_format_values_interpret_expressions = 1;
SET input_format_with_types_use_header=1;
SET input_format_skip_unknown_fields=1;


CREATE TABLE json_data_key_value_array (
    -- Common metadata fields
    `timestamp` Datetime,
    `location` String,
    `project_id` String,
    `revision_name` String,
    `severity` String,
    `method_name` String,

    -- Raw JSON Data
    `_source` String,

    -- Type-specific field names and field values 
    `string.names` Array(String),
    `string.values` Array(String),
    `number.names` Array(String),
    `number.values` Array(Float64),
    `boolean.names` Array(String),
    `boolean.values` Array(UInt8)
)
ENGINE = MergeTree
ORDER BY ();

DROP TABLE json_data_key_value_array;

INSERT INTO json_data_key_value_array  SELECT * FROM file('path/to/user_files','JSONEachRow');

-------------------------------------------------- Analytical Queries
-- Count of Events by Day
SELECT 
    date_trunc('day', `timestamp`) AS event_date,
    count() AS service_creation_count, 
    `method_name` as method_name
FROM json_data_key_value_array
WHERE method_name != ''
GROUP BY event_date, method_name
ORDER BY event_date
SETTINGS use_query_cache = false;


-- Service Speed[
SELECT 
    arrayElement(`string.values`, indexOf(`string.names`, 'resource.labels.service_name')) AS service_name,
    avg(arrayElement(`number.values`, indexOf(`number.names`, 'protoPayload.request.service.spec.template.spec.containerConcurrency'))) AS concurrency,
    avg(arrayElement(`number.values`, indexOf(`number.names`, 'protoPayload.request.service.spec.template.spec.timeoutSeconds'))) AS timeout_seconds
FROM json_data_key_value_array
GROUP BY service_name
SETTINGS use_query_cache = false;

-- User Agent Analysis
SELECT 
    arrayElement(`string.values`, indexOf(`string.names`, 'protoPayload.requestMetadata.callerSuppliedUserAgent')) AS user_agent,
    count() AS count
FROM json_data_key_value_array
GROUP BY user_agent
ORDER BY count DESC
SETTINGS use_query_cache = false;


-- Geographic Distribution of Deployments
SELECT 
    arrayElement(`string.values`, indexOf(`string.names`, 'resource.labels.location')) AS location,
    count() AS deployment_count
FROM json_data_key_value_array
WHERE location != ''
GROUP BY location
ORDER BY deployment_count DESC
SETTINGS use_query_cache = false;