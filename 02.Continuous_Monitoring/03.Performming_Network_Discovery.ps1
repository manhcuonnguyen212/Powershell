#Author: Nguyen Dang Manh Cuong
#Created on: 2025-05-15
#In this file, we will carry out network discovery.

# 1. Test connection between mutiple devices 

function func1()
    { 
        # using Test-Connection
        $results = @{}
        
        Write-Host "$subnet $A $B"
        if(!($subnet -or $A -or $B))
        {
            Write-Host  "[+] Usage: $PSCommandPath subnet A B `n Ex: $PSCommandPath 192.168.1 1 50" -ForegroundColor red
            exit 1
        }
        ForEach($machine in $A..$B)
        {
            $machine = "$subnet"+"."+"$machine"
            $result = (Test-Connection -ComputerName $machine -Count 1 -TimeoutSeconds 1).Status
            $results[$machine] = $result 
        }
        ForEach($x in $results.Keys){
            $value = $results[$x]
            Write-Host "$x -> $value" -ForegroundColor Green
        }
    }
function func2()
{
    $results = @{}
    #using System.Net.NetInformation.Ping
    $Ping = New-Object System.Net.NetworkInformation.Ping 
    $timeout = 50
    ForEach($x in $A..$B)
    {
        $machine = "$subnet" + "." + $x 
        $result = $Ping.Send($machine,$timeout).Status
        $results[$machine] = $result
    }   
    ForEach($x in $results.Keys)
    {
        $status = $results[$x]
        Write-Host "$x -> $status" -ForegroundColor Green

    }
}
$subnet = $args[0]
$A = [INT]$args[1]
$B = [INT]$args[2]
#test-Con
func2