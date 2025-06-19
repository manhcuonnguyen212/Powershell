
# 1. Define a port that running and where lofFile placed
$port = 12345
$logFile = Invoke-Expression "pwd"
$logFile = [STRING]$logFile +"\logHoney.txt"


Write-Host "[*] Listening on TCP port $port..." -ForegroundColor Cyan

## Create a new object from TcpListener class
$listener = [System.Net.Sockets.TcpListener]::new([System.Net.IPAddress]::Any, $port)
$listener.Start()

while ($true) {
    if ($listener.Pending()) {
        $client = $listener.AcceptTcpClient()
        $remoteIP = $client.Client.RemoteEndPoint.Address.ToString()
        $time = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

        $message = "[ALERT] Connection from $remoteIP at $time"
        Write-Host $message -ForegroundColor Red
        Add-Content -Path $logFile -Value $message

        # Optional: block IP after attempt (requires admin rights)
        # netsh advfirewall firewall add rule name="Block $remoteIP" dir=in action=block remoteip=$remoteIP
        $client.Close()
    }
    Start-Sleep -Milliseconds 500
}
