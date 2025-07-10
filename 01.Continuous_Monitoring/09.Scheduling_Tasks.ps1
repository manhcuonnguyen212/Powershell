#Author: Nguyen Dang Manh Cuong
#Created on : 2025-05-15
$action = New-ScheduledTaskAction -Execute "D:\CodePowerShell\PowerShell\01.Continuous_Monitoring\08.Getting_Remote_logs.ps1"
$trigger = New-ScheduledTaskTrigger -Once -At '08:26 AM' 
$principles = New-ScheduledTaskPrincipal -UserId (whoami.exe) -RunLevel Highest
$settings = New-ScheduledTaskSettingsSet -WakeToRun
$task = New-ScheduledTask -Action $action -Principal $principles -Trigger $trigger -Settings $settings
Register-ScheduledTask -InputObject $task -TaskName "Getting server infor"
