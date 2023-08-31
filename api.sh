fields @timestamp, @message
| sort @timestamp desc
| filter @message like /500/
| filter @message not like /200/


fields @timestamp, @message, @logStream, @log
#| filter @message like "Unable to contact the License Server"
| filter @message like "cash-srvr-1-6db55c8c88-rhvxp"
| filter @message like "sfs.lms"
| sort @timestamp desc
#| limit 20
