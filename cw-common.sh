25 most recently added log events
fields @timestamp, @message
| sort @timestamp desc
| limit 25
Apply
Number of exceptions logged every 5 minutes
filter @message like /Exception/
| stats count(*) as exceptionCount by bin(5m)
| sort exceptionCount desc
Apply
List of log events that are not exceptions
fields @message
| filter @message not like /Exception/
Apply
To parse and count fields
fields @timestamp, @message
| filter @message like /User ID/
| parse @message "User ID: *" as @userId
| stats count(*) by @userId
Apply
To Identify faults on any API calls
filter Operation = <operation> AND Fault > 0
| fields @timestamp, @logStream as instanceId, ExceptionMessage
Apply
To get the number of exceptions logged every 5 minutes using regex where exception is not case sensitive
filter @message like /(?i)Exception/
| stats count(*) as exceptionCount by bin(5m)
| sort exceptionCount desc
Apply
To parse ephemeral fields using a glob expression
parse @message "user=*, method:*, latency := *" as @user, @method, @latency
| stats avg(@latency) by @method, @user
Apply
To parse ephemeral fields using a glob expression using regular expression
parse @message /user=(?<user2>.*?), method:(?<method2>.*?), latency := (?<latency2>.*?)/
| stats avg(latency2) by @method2, @user2
Apply
To extract ephemeral fields and display field for events that contain an ERROR string
fields @message
| parse @message "* [*] *" as loggingTime, loggingType, loggingMessage
| filter loggingType IN ["ERROR"]
| display loggingMessage, loggingType = "ERROR" as isError
Apply
To trim whitespaces from query results
fields trim(@message) as trimmedMessage
| parse trimmedMessage "[*] * * Retrieving CloudWatch Metrics for AccountID : *, CloudWatch Metric : *, Resource Type : *, ResourceID : *" as level, time, logId, accountId, metric, type, resourceId
| display level, time, logId, accountId, metric, type, resourceId
| filter level like "INFO"
Apply
Get the most recent log event for each unique value of the server field
fields @timestamp, server, severity, message 
| sort @timestamp asc 
| dedup server
Apply
Get the most recent log event for each unique value of the server field for each severity type
fields @timestamp, server, severity, message 
| sort @timestamp desc 
| dedup server, severity
