Number of requests received every 10 minutes by edge location
stats count(*) by queryType, bin(10m)
Apply
Number of unsuccessful requests by domain
filter responseCode="SERVFAIL"
| stats count(*) by queryName
Apply
Top 10 DNS resolver IPs with highest number of requests
stats count(*) as numRequests by resolverIp
| sort numRequests desc
| limit 10
