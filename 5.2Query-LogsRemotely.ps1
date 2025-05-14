#Author: Nguyen Dang Manh Cuong
#Created on: 2025-05-15
# In this section, we will connect to  windows-based system and export log entries 


$servers = Import-Csv -Path "D:\CodePowerShell\PowerShell\5.1Server.csv"
$path = "D:\CodePowerShell\PowerShell\"
function Invoke-RemoteConnection
{
    [CmdLetBinding()]param( [parameter(position=0,Mandatory=$true)][String[]]$Server)
    $session = New-PSSession -ComputerName $server -Credential (Get-Credential)
    return $session 
}
$servers | foreach-object { Invoke-RemoteConnection $_.Name}
 function invoke-LogEntries
 {
    param( [System.Management.Automation.Runspaces.PSSession[]]$session, $log)
    $result = invoke-command -session $session -ScriptBlock {
        Get-WinEvent -LogName $Using:log -MaxEvents 10 | Where-Object { $_.TimeCreated -gt (get-date).AddHours(-24) } | select-object Id,Message
        # note that : $Using:log brings the local $log variable into the remote session.
    }
    return $result
 }
 $sessions = Get-PSSession
 Foreach ($session in $sessions)
 {

    $secLog = invoke-LogEntries -session $session -log "security"
    $appLog = invoke-LogEntries -session $session -log "application"
    $sysLog = invoke-LogEntries -session $session -log "system"
    
    $secLog | export-csv -path "$path\$computerName-Security.csv"
    $appLog | export-csv -path "$path\$computerName-Application.csv"
    $sysLog | export-csv -path "$path\$computerName-System.csv"
 
}
remove-pssession *