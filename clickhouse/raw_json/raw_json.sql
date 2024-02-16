-- Table Setup
SET allow_experimental_object_type=1;
SET input_format_json_try_infer_numbers_from_strings=1;

CREATE TABLE json_data (
    _source json
)
ENGINE = MergeTree
PRIMARY KEY ();

DROP TABLE json_data;

INSERT INTO json_data (_source) SELECT * FROM file('path/to/user_files', 'JSON');

-------------------------------------------------- Analytical Queries
-- Count of Events by Day
SELECT 
    date_trunc('day', toDate(arrayStringConcat(arrayPopBack(splitByString('.', _source.timestamp))))) AS event_date,
    count() AS service_creation_count, 
    _source.protoPayload.methodName as method_name
FROM json_data
WHERE _source.protoPayload.methodName != ''
GROUP BY event_date, method_name
ORDER BY event_date
SETTINGS use_query_cache = false;


-- Service Speed
SELECT 
    _source.resource.labels.service_name AS service_name,
    avg(_source.protoPayload.request.service.spec.template.spec.containerConcurrency) AS concurrency,
    avg(_source.protoPayload.request.service.spec.template.spec.timeoutSeconds) AS timeout_seconds
FROM json_data
GROUP BY service_name
SETTINGS use_query_cache = false;


-- User Agent Analysis
SELECT 
    _source.protoPayload.requestMetadata.callerSuppliedUserAgent AS user_agent,
    count() AS count
FROM json_data
GROUP BY user_agent
ORDER BY count DESC
SETTINGS use_query_cache = false;

-- Geographic Distribution of Deployments
SELECT 
    _source.resource.labels.location AS location,
    count() AS deployment_count
FROM json_data
GROUP BY location
ORDER BY deployment_count DESC
SETTINGS use_query_cache = false;
