# View latency statistics for 5-minute intervals
filter @type = "REPORT"
| stats avg(@duration), max(@duration), min(@duration) by bin(5m)

# Determine the amount of overprovisioned memory
filter @type = "REPORT"
| stats max(@memorySize / 1000 / 1000) as provisionedMemoryMB,
  min(@maxMemoryUsed / 1000 / 1000) as smallestMemoryRequestMB,
  avg(@maxMemoryUsed / 1000 / 1000) as avgMemoryUsedMB,
  max(@maxMemoryUsed / 1000 / 1000) as maxMemoryUsedMB,
  provisionedMemoryMB - maxMemoryUsedMB as overProvisionedMB

# Find the most expensive requests
filter @type = "REPORT"
| fields @requestId, @billedDuration
| sort by @billedDuration desc
