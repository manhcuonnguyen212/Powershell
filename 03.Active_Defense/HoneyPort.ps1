
# # 1. Define a port that running and where lofFile placed
# $port = 12345
# $logFile = Invoke-Expression "pwd"
# $logFile = [STRING]$logFile +"\logHoney.txt"
$port = $args[0]
if(!$port)
{
    Write-host "[+]Usage: $PSCommandPath port" -ForegroundColor Red
    exit 1
}
$logPath = Invoke-Expression "pwd"
$logFile = [STRING]$logPath + "\logHoneyPorts.txt"
Write-Host "[+] Listening on TCP $port ... " -ForegroundColor Green
# Write-Host "[*] Listening on TCP port $port..." -ForegroundColor Cyan
# ## Create a new object from TcpListener class
$ip = [System.Net.IPAddress]::Any 
$listener = New-Object System.Net.Sockets.TcpListener -ArgumentList ($ip,$port)
try {
    $listener.Start()
    Write-Host "[+] Listenign started successfully." -ForegroundColor Blue
}
catch {
    Write-Host "[-] Failed to start listener " -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}
# $listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, $port)
# $listener.Start()
while($true)
{
    if($listener.Pending())
    {
        $client = $listener.AcceptTcpClient()
        $remoteIP = $client.Client.RemoteEndPoint.Address.ToString()
        $time = Get-Date -format "yyyy-MM-dd HH:mm:ss"
        $message = "[+ ALERT] Connection from $remoteIP at $time"
        Write-host "$message" -ForegroundColor Cyan
        Add-Content -path $logFile -Value $message 
        $client.Close()
    }
    Start-Sleep -Milliseconds 500

}

# while ($true) {
#     if ($listener.Pending()) {
#         $client = $listener.AcceptTcpClient()
#         $remoteIP = $client.Client.RemoteEndPoint.Address.ToString()
#         $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

#         $message = "[ALERT] Connection from $remoteIP at $time"
#         Write-Host $message -ForegroundColor Red
#         Add-Content -Path $logFile -Value $message

#         # Optional: block IP after attempt (requires admin rights)
#         # netsh advfirewall firewall add rule name="Block $remoteIP" dir=in action=block remoteip=$remoteIP
#         $client.Close()
#     }
#     Start-Sleep -Milliseconds 500
# }
