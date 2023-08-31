Number of log entries by service, event type, and region
stats count(*) by eventSource, eventName, awsRegion
Apply
Number of log entries by region and EC2 event type
filter eventSource="ec2.amazonaws.com"
| stats count(*) as eventCount by eventName, awsRegion
| sort eventCount desc
Apply
Regions, usernames, and ARNs of newly created IAM users
filter eventName="CreateUser"
| fields awsRegion, requestParameters.userName, responseElements.user.arn
Apply
Find EC2 hosts that were started or stopped in a given AWS Region
filter (eventName="StartInstances" or eventName="StopInstances") and region="us-east-2"
Apply
Find the number of records where an exception occurred while invoking the UpdateTrail API
filter eventName="UpdateTrail" and ispresent(errorCode) | stats count(*) by errorCode, errorMessage
Apply
Find log entries where TLS 1.0 or 1.1 was used
filter tlsDetails.tlsVersion in [ "TLSv1", "TLSv1.1" ]
| stats count(*) as numOutdatedTlsCalls by userIdentity.accountId, recipientAccountId, eventSource, eventName, awsRegion, tlsDetails.tlsVersion, tlsDetails.cipherSuite, userAgent
| sort eventSource, eventName, awsRegion, tlsDetails.tlsVersion
Apply
Find the number of calls per service that used TLS versions 1.0 or 1.1
filter tlsDetails.tlsVersion in [ "TLSv1", "TLSv1.1" ]
| stats count(*) as numOutdatedTlsCalls by eventSource
| sort numOutdatedTlsCalls desc
