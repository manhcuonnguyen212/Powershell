#Author: Nguyen Dang Manh Cuong
#Create on: 2025-05-15
#Objectives: Display ports openning on the targeted host 
function portScan1(){
    #Port scan using .NET API 
    param($ip,$A,$B)
    if (!($ip -or $A))
    {
        Write-Host -ForegroundColor red "[+] Usage: program.ps1 ipadd portA port B `n Means that the programm will scan host from A to B ports"
        exit 1
    }
    if (!$B)
    {
        Write-Host $ip+"`t"+$A
        $connection = New-Object System.Net.Sockets.TcpClient
        $result = $connection.Connect($ip,$A)
        if($result.Connected)
        {
            Write-Host "$A is open on $ip" -ForegroundColor Cyan
        }
        $connection.close()  
        exit 1
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
    
function portScan3()
    {
    param($ip,[INT]$port1,[INT]$port2)
    #Port scan using Test-NetConnection\Test-Connection powershell command 
    if(!($ip -or $port1))
    {
        Write-Host -ForegroundColor red "[+] Usage: program.ps1 ip port | program.ps1 ip port1 port2"
        exit 1
    }
    if(!($port2))
    {
        $result = Test-Connection -ComputerName $ip -TcpPort $port1 
        if($result)
        {
            Write-Host -ForegroundColor Cyan "$port1 is open on $ip"
            exit 1
        }
        Write-Host -ForegroundColor blue "$port1 is filtered or inactive on $ip"
        exit 1
    }
    ## using ${using:external_variables} to pass external variables to ForEach-Object blocks
    $port1..$port2  | ForEach-Object -Parallel {  
        if((Test-Connection -TargetName ${using:ip} -TcpPort $_))
        {
            Write-Host -ForegroundColor Cyan "$_ is open on ${using:ip}."
        }
    } -ThrottleLimit 100 
}
    
Write-Host "[+] Start scanning process." -ForegroundColor green
#portScan1 $args[0] $args[1] $args[2]
portScan3 $args[0] $args[1] $args[2]