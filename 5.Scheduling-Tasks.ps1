#Author: Nguyen Dang Manh Cuong
#Created on : 2025-05-15
$action = New-ScheduledTaskAction -Execute 'D:\CodePowerShell\PowerShell\5.2Query-LogsRemotely.ps1'
$trigger = New-ScheduledTaskTrigger -Once -At '01:14 AM'
$principles = New-ScheduledTaskPrincipal -UserId (whoami.exe) -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Principal $principles -Trigger $trigger -Settings $settings
Register-ScheduledTask -InputObject $task
