# Resolve host names 
function resolve-hostName($ip)
    {
            try{
                #Resolve-DnsName $IP -ErrorAction stop 
                #Using Resolve-DnsName powershell command
                $H = [System.Net.DNS]::GetHostByAddress($ip).HostName
                write-host $ip " -> "$H -ForegroundColor Green
            }
            catch {
                Write-host "Cant resolve $IP"
            }
    }
if(!$args[0])
{
    Write-Host "[+] Usage: $PSCommandPath ipadd `n EX: program.ps1 8.8.8.8" -ForegroundColor red
    exit 1
}
resolve-hostName($args[0])
