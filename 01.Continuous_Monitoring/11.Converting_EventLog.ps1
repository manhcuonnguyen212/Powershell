

# Convert to CSV format
$log = "security"
$path = (Get-Location).Path + "\$log.csv"
Get-WinEvent -LogName $log | Export-Csv $path 

#Convert to XML format
$path = (Get-Location).Path + "\$log.xml"
Get-WinEvent -LogName $log | export-Cilixml $path