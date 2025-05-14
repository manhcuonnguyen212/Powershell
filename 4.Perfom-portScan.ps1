#Author: Nguyen Dang Manh Cuong
#Create on: 2025-05-15
function portScan1($ComputerName){
    #Port scan using .NET API
    foreach($port in (53,80,443) )
    {

        $tcp = New-Object System.Net.Sockets.TcpClient
        try {
            $tcp.Connect($ComputerName, $port)
            if ($tcp.Connected) {
                Write-Host "Port $port is open on $ComputerName"
            }
        } catch {
            # Port closed or filtered; do nothing or log
        } finally {
            $tcp.Close()
        }
    }
}
# portScan1 -ComputerName "192.168.1.100"
function portScan2()
{
        # using .NET API but faster 
        # require powershell 7+
1..1024 | ForEach-Object -Parallel {
    try {
        $tcp = [System.Net.Sockets.TcpClient]::new()
        $tcp.Connect("192.168.1.100", $_)
        if ($tcp.Connected) {
            Write-Host "Port $_ is open"
        }
        $tcp.Close()
    } catch {}
} -ThrottleLimit 100 # powershell runs 50 iterations in parallel at the same time 
}
portScan2 
    
    function portScan3($network)
    {
    #Port scan using Test-NetConnection powershell command 
        foreach ($port in (53,80,443)) {
        $result = Test-NetConnection -ComputerName $network -Port $port
        if ($result.TcpTestSucceeded) {
            Write-Host "Port $port is open"
        }
    }

}
#portScan3 "192.168.1.100"