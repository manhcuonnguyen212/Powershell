#Author: Nguyen Dang Manh Cuong
#Created on: 2025-05-15
# Preparing event logs for analyzing
$log = "security"
$logDate = get-date -format yyyyMMddHHmm
$path = "D:\CodePowerShell\PowerShell\"
$file = ".evtx"
$output = $path+$log+$logDate+$file
# Export the log
wevtutil.exe epl $log $output 

#Query security logs
Get-WinEvent -FilterHashtable @{Path=$output;ID=4648}


