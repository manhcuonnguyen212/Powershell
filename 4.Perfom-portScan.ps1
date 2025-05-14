#Author: Nguyen Dang Manh Cuong
#Create on: 2025-05-15
function portScan([string]$subnet,[Int32]$start,[Int32]$end){
    foreach($x1 in $start..$end)
    {
        $ip = "$subnet.$x1"
        foreach($x2 in (53,80,443))
        {
            write-host $ip":"$x2 (Test-Connection $ip -TcpPort $x2)  
        }
    }
}
#portScan 192.168.1 1 5
function portScan2($subnet,$start,$end)
{
    foreach($x1 in $start..$end){
        $ip = "$subnet.$x1"
            nmap -p 53,80,443 -sA -Pn $ip 
    }
}
#portScan2 "192.168.1" 1 5
function portScan3($network,$port)
{
   

            $client = New-Object System.Net.Sockets.TcpClient  
            $client.Connect($network,$port)
}
portScan3 "192.168.1.1" 80