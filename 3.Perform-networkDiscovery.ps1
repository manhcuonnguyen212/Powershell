#Author: Nguyen Dang Manh Cuong
#Created on: 2025-05-15
#In this file, we will carry out network discovery, including test connection and resolve host name.

# 1. Test connection between mutiple devices 
    function test-Con()
    {
        $result = $()
        $server = @("192.168.1.1","192.168.1.2","192.168.1.100")
        #$ping = New-object System.Net.NetworkInformation.ping 
        foreach($x in $server)
        {
            $device = (Test-Connection $x -Count 1)
            if($device.status -eq "Success")
            {
                $mac = $null
                arp -a | ForEach-Object{ 
                    if ($_ -match $x)
                    {
                        $mac = [Regex]::matches($_,"[0-9a-z]{2}-[0-9a-z]{2}-[0-9a-z]{2}-[0-9a-z]{2}-[0-9a-z]{2}-[0-9a-z]{2}").value
                    try
               {
                
                $vendor = Invoke-WebRequest -Uri "https://api.macvendors.com/$mac"
               }
               catch{
                    $vendor = $null
                }
                finally{
                   
                   if ($vendor){
                    $ob = [PSCustomObject]@{
                        "IPv4" = $x 
                        "HostName" = (Resolve-DnsName $x -ErrorAction SilentlyContinue).NameHost
                        "Response" = $device.Status
                        "Manufacturer"=$vendor  
                    }
                    write-host $ob
                    }
                } 
                }
                }
        } 
    }
}
test-Con
# 2. Resolve host names 
<#function resolve-hostName()
    {
        param($ip)
        foreach($h in 1..254)
        {
            $IP =  "$ip.$h"
            try{
                #Resolve-DnsName $IP -ErrorAction stop 
                #Using Resolve-DnsName powershell command
                $H = [System.Net.DNS]::GetHostEntry($IP).HostName
                write-host $IP " -> "$H
            }
            catch {
                Write-host "Cant resolve $IP"
            }
            finally 
            { 
                $ip= "192.168.1"
            }
            }
    }
resolve-hostName("192.168.1")
#>