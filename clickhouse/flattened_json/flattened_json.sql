-- Table Setup
SET allow_experimental_object_type=1;
SET output_format_json_named_tuples_as_objects = 1;
SET input_format_values_interpret_expressions = 1;
SET input_format_with_types_use_header=1;
SET input_format_skip_unknown_fields=1;


CREATE TABLE json_data_flattened (
    `_source.httpRequest.latency` String,
    `_source.httpRequest.protocol` String,
    `_source.httpRequest.referer` String,
    `_source.httpRequest.remoteIp` String,
    `_source.httpRequest.requestMethod` String,
    `_source.httpRequest.requestSize` String,
    `_source.httpRequest.requestUrl` String,
    `_source.httpRequest.responseSize` String,
    `_source.httpRequest.serverIp` String,
    `_source.httpRequest.status` UInt32,
    `_source.httpRequest.userAgent` String,
    `_source.insertId` String,
    `_source.labels.container_name` String,
    `_source.labels.instanceId` String,
    `_source.logName` String,
    `_source.protoPayload.@type` String,
    `_source.protoPayload.authenticationInfo.principalEmail` String,
    `_source.protoPayload.authenticationInfo.principalSubject` String,
    `_source.protoPayload.methodName` String,
    `_source.protoPayload.request.@type` String,
    `_source.protoPayload.request.name` String,
    `_source.protoPayload.request.parent` String,
    `_source.protoPayload.request.region` String,
    `_source.protoPayload.request.service.apiVersion` String,
    `_source.protoPayload.request.service.kind` String,
    `_source.protoPayload.request.service.metadata.annotations.run.googleapis.com/client-name` String,
    `_source.protoPayload.request.service.metadata.annotations.run.googleapis.com/client-version` String,
    `_source.protoPayload.request.service.metadata.annotations.run.googleapis.com/ingress` String,
    `_source.protoPayload.request.service.metadata.annotations.run.googleapis.com/ingress-status` String,
    `_source.protoPayload.request.service.metadata.annotations.run.googleapis.com/launch-stage` String,
    `_source.protoPayload.request.service.metadata.annotations.run.googleapis.com/operation-id` String,
    `_source.protoPayload.request.service.metadata.annotations.serving.knative.dev/creator` String,
    `_source.protoPayload.request.service.metadata.annotations.serving.knative.dev/lastModifier` String,
    `_source.protoPayload.request.service.metadata.creationTimestamp` String,
    `_source.protoPayload.request.service.metadata.generation` UInt32,
    `_source.protoPayload.request.service.metadata.labels.cloud.googleapis.com/location` String,
    `_source.protoPayload.request.service.metadata.labels.run.googleapis.com/satisfiesPzs` String,
    `_source.protoPayload.request.service.metadata.name` String,
    `_source.protoPayload.request.service.metadata.namespace` String,
    `_source.protoPayload.request.service.metadata.resourceVersion` String,
    `_source.protoPayload.request.service.metadata.selfLink` String,
    `_source.protoPayload.request.service.metadata.uid` String,
    `_source.protoPayload.request.service.spec.template.metadata.annotations.autoscaling.knative.dev/maxScale` String,
    `_source.protoPayload.request.service.spec.template.metadata.annotations.run.googleapis.com/client-name` String,
    `_source.protoPayload.request.service.spec.template.metadata.annotations.run.googleapis.com/client-version` String,
    `_source.protoPayload.request.service.spec.template.metadata.annotations.run.googleapis.com/startup-cpu-boost` String,
    `_source.protoPayload.request.service.spec.template.metadata.labels.client.knative.dev/nonce` String,
    `_source.protoPayload.request.service.spec.template.metadata.labels.run.googleapis.com/startupProbeType` String,
    `_source.protoPayload.request.service.spec.template.spec.containerConcurrency` UInt32,
    `_source.protoPayload.request.service.spec.template.spec.serviceAccountName` String,
    `_source.protoPayload.request.service.spec.template.spec.timeoutSeconds` UInt32,
    `_source.protoPayload.request.service.status.latestCreatedRevisionName` String,
    `_source.protoPayload.request.service.status.latestReadyRevisionName` String,
    `_source.protoPayload.request.service.status.observedGeneration` UInt32,
    `_source.protoPayload.request.service.status.url` String,
    `_source.protoPayload.requestMetadata.callerIp` String,
    `_source.protoPayload.requestMetadata.callerSuppliedUserAgent` String,
    `_source.protoPayload.requestMetadata.requestAttributes.time` String,
    `_source.protoPayload.resourceName` String,
    `_source.protoPayload.response.@type` String,
    `_source.protoPayload.response.apiVersion` String,
    `_source.protoPayload.response.kind` String,
    `_source.protoPayload.response.metadata.annotations.autoscaling.knative.dev/maxScale` String,
    `_source.protoPayload.response.metadata.annotations.run.googleapis.com/client-name` String,
    `_source.protoPayload.response.metadata.annotations.run.googleapis.com/client-version` String,
    `_source.protoPayload.response.metadata.annotations.run.googleapis.com/ingress` String,
    `_source.protoPayload.response.metadata.annotations.run.googleapis.com/ingress-status` String,
    `_source.protoPayload.response.metadata.annotations.run.googleapis.com/operation-id` String,
    `_source.protoPayload.response.metadata.annotations.run.googleapis.com/startup-cpu-boost` String,
    `_source.protoPayload.response.metadata.annotations.serving.knative.dev/creator` String,
    `_source.protoPayload.response.metadata.annotations.serving.knative.dev/lastModifier` String,
    `_source.protoPayload.response.metadata.creationTimestamp` String,
    `_source.protoPayload.response.metadata.generation` UInt32,
    `_source.protoPayload.response.metadata.labels.client.knative.dev/nonce` String,
    `_source.protoPayload.response.metadata.labels.cloud.googleapis.com/location` String,
    `_source.protoPayload.response.metadata.labels.run.googleapis.com/satisfiesPzs` String,
    `_source.protoPayload.response.metadata.labels.run.googleapis.com/startupProbeType` String,
    `_source.protoPayload.response.metadata.labels.serving.knative.dev/configuration` String,
    `_source.protoPayload.response.metadata.labels.serving.knative.dev/configurationGeneration` String,
    `_source.protoPayload.response.metadata.labels.serving.knative.dev/route` String,
    `_source.protoPayload.response.metadata.labels.serving.knative.dev/service` String,
    `_source.protoPayload.response.metadata.labels.serving.knative.dev/serviceUid` String,
    `_source.protoPayload.response.metadata.name` String,
    `_source.protoPayload.response.metadata.namespace` String,
    `_source.protoPayload.response.metadata.resourceVersion` String,
    `_source.protoPayload.response.metadata.selfLink` String,
    `_source.protoPayload.response.metadata.uid` String,
    `_source.protoPayload.response.spec.containerConcurrency` UInt32,
    `_source.protoPayload.response.spec.serviceAccountName` String,
    `_source.protoPayload.response.spec.template.metadata.annotations.autoscaling.knative.dev/maxScale` String,
    `_source.protoPayload.response.spec.template.metadata.annotations.run.googleapis.com/client-name` String,
    `_source.protoPayload.response.spec.template.metadata.annotations.run.googleapis.com/client-version` String,
    `_source.protoPayload.response.spec.template.metadata.annotations.run.googleapis.com/startup-cpu-boost` String,
    `_source.protoPayload.response.spec.template.metadata.labels.client.knative.dev/nonce` String,
    `_source.protoPayload.response.spec.template.metadata.labels.run.googleapis.com/startupProbeType` String,
    `_source.protoPayload.response.spec.template.spec.containerConcurrency` UInt32,
    `_source.protoPayload.response.spec.template.spec.serviceAccountName` String,
    `_source.protoPayload.response.spec.template.spec.timeoutSeconds` UInt32,
    `_source.protoPayload.response.spec.timeoutSeconds` UInt32,
    `_source.protoPayload.response.status.address.url` String,
    `_source.protoPayload.response.status.imageDigest` String,
    `_source.protoPayload.response.status.latestCreatedRevisionName` String,
    `_source.protoPayload.response.status.latestReadyRevisionName` String,
    `_source.protoPayload.response.status.logUrl` String,
    `_source.protoPayload.response.status.observedGeneration` UInt32,
    `_source.protoPayload.response.status.url` String,
    `_source.protoPayload.serviceName` String,
    `_source.protoPayload.status.code` UInt32,
    `_source.protoPayload.status.message` String,
    `_source.receiveTimestamp` String,
    `_source.resource.labels.configuration_name` String,
    `_source.resource.labels.location` String,
    `_source.resource.labels.project_id` String,
    `_source.resource.labels.revision_name` String,
    `_source.resource.labels.service_name` String,
    `_source.resource.type` String,
    `_source.severity` String,
    `_source.spanId` String,
    `_source.textPayload` String,
    `_source.timestamp` String,
    `_source.trace` String,
    `_source.traceSampled` UInt8
)
ENGINE = MergeTree
ORDER BY ();

DROP TABLE json_data_flattened;

INSERT INTO json_data_flattened  SELECT * FROM file('path/to/user_files','JSONEachRow');

-------------------------------------------------- Analytical Queries
-- Count of Events by Day
SELECT 
    date_trunc('day', toDate(arrayStringConcat(arrayPopBack(splitByString('.', `_source.timestamp`))))) AS event_date,
    count() AS service_creation_count, 
    `_source.protoPayload.methodName` as method_name
FROM json_data_flattened
WHERE `_source.protoPayload.methodName` != ''
GROUP BY event_date, method_name
ORDER BY event_date
SETTINGS use_query_cache = false;


-- Service Speed
SELECT 
    `_source.resource.labels.service_name` AS service_name,
    avg(`_source.protoPayload.request.service.spec.template.spec.containerConcurrency`) AS concurrency,
    avg(`_source.protoPayload.request.service.spec.template.spec.timeoutSeconds`) AS timeout_seconds
FROM json_data_flattened
GROUP BY service_name
SETTINGS use_query_cache = false;



-- User Agent Analysis
SELECT 
    `_source.protoPayload.requestMetadata.callerSuppliedUserAgent` AS user_agent,
    count() AS count
FROM json_data_flattened
GROUP BY user_agent
ORDER BY count DESC
SETTINGS use_query_cache = false;


-- Geographic Distribution of Deployments
SELECT 
    `_source.resource.labels.location` AS location,
    count() AS deployment_count
FROM json_data_flattened
WHERE location != ''
GROUP BY location
ORDER BY deployment_count DESC
SETTINGS use_query_cache = false;

