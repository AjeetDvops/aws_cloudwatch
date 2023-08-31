Number of unique HTTP status codes
fields ispresent(graphQLAPIId) as isApi
| filter isApi | filter logType = "RequestSummary"
| stats count() as statusCount by statusCode
| sort statusCount desc
Apply
Top 10 resolvers with maximum latency
fields resolverArn, duration
| filter logType = "Tracing"
| sort duration desc
| limit 10
Apply
Most frequently invoked resolvers
fields ispresent(resolverArn) as isRes
| stats count() as invocationCount by resolverArn
| filter isRes | filter logType = "Tracing"
| sort invocationCount desc
| limit 10
Apply
Resolvers with most errors in mapping templates
fields ispresent(resolverArn) as isRes
| stats count() as errorCount by resolverArn, logType
| filter isRes and (logType = "RequestMapping" or logType = "ResponseMapping") and fieldInError
| sort errorCount desc
| limit 10
Apply
Field latency statistics
stats min(duration), max(duration), avg(duration) as avgDur by concat(parentType, '/', fieldName) as fieldKey
| filter logType = "Tracing"
| sort avgDur desc
| limit 10
Apply
Resolver latency statistics
fields ispresent(resolverArn) as isRes
| filter isRes | filter logType = "Tracing"
| stats min(duration), max(duration), avg(duration) as avgDur by resolverArn
| sort avgDur desc
| limit 10 
Apply
Top 10 requests with maximum latency
fields requestId, latency
| filter logType = "RequestSummary"
| sort latency desc
| limit 10
