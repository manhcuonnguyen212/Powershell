
#author: nguyen dang manh cuong
# finding mac address of a host in a network 
function resolveIp{
param ( [parameter(Mandatory = $true)] [string]$ip)
$result = Resolve-DnsName $ip
return $ip + "->"+ $result.Namehost
}
$ip = "192.168.1.1"
resolveIp($ip)
Write-Host $mac
