#Author: Nguyen Dang Manh Cuong
#Created on: 2025-05-15
#In this file, we will carry out network discovery, including test connection and resolve host name.

# 1. Test connection between mutiple devices 
    function test-Con()
    {
        param($ip)
        $ping = New-object System.Net.NetworkInformation.ping 

        foreach($x in 1..254)
        {
         <# using Test-Connection/Test-NetConnection powershell command (ICMP ping)
            try{
                #write-host " Connection to $ip.$x :" 
                <#if((Test-Connection "$ip.$x" -count 1 ).Status -eq "Success")
                {
                    write-host "Sucessfully"
                } 
                else 
                {
                    write-host "Unreachablely"
                } 
            }
            catch {
                write-host $_.Exception
            }
                #>
            #Using .Net API
            $ping.send("$ip.$x")
            write-host $ping
     }
         
        
    }
test-Con("192.168.1")
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