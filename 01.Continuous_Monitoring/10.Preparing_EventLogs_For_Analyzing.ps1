

# Set the Log to Export and OutPut Location and FileName
$log = "Security"
$logDate = Get-Date -Format "yyyy-MM-dd-HHmmss"
$path = (Get-Location).Path
$file = ".evtx"
$output = $path + $log + "-" + $logDate + $file

# Export the Log using weututil 
wevtutil.exe epl $log $output
