get-service | Where-Object {$_.Name -eq 'wuauserv'} | Stop-Service
get-service | Where-Object {$_.Name -eq 'wuauserv'} | Set-Service -StartupType Disabled
# get-service | where {$_.Name -eq 'wuauserv'} | Select-Object *
