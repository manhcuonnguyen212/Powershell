#author: Nguyen Dang Manh Cuong
#date: 2025-05-15
# 1. retrieving process information
<#        function processInfor {
            param ($name)
            # retrieve running processes    
            try{
            Get-Process -Name $name -ErrorAction stop | format-list *
                #get process infor using Get-Process cmdlet and stop if an error occurs
                # else getting a listing of process infor instead of a table 
            }
            catch 
            {
                Write-Host "An error occured: $_.Exeception" -ForegroundColor green
                # writing out the error
            }
            finally {
                write-host "The program 1 has run completely." -ForegroundColor white
            }
            # retrieve process attributes
            get-process -IncludeUserName | where-object {$_.Username -like "*system*"} | Select-Object name,startTime,@{Name="CPU";Expression={[math]::Round($_.CPU,2)}},Path
            # get processes belog to system and show out name,starttime, cpu using and path.
        }
        $name = read-host "Enter a process that you want to get infor " # get name of the process
        processInfor($name)
#>
 # 2. retrieve services running 
<#        Function serviceInfor {
            param($name)
            try {
                $var1 = get-service -Name $name -ErrorAction stop  
                #get a specific service infor using get-service cmdlet and stop if there was an error 
                $var1.DisplayName
                $var1.RequiredServices
                $var1.DependentServices
            }
            catch {
                write-host "An error occured: $_.Exception" -ForegroundColor green 
            }
            finally 
            {
                write-host "The program 2 has run completely."
            }
            # Controlling services
        # Start-Service-Name 'wscsvc'
        # Stop-Service-Name 'wscsvc'
        # Restart-Service-Name 'wscsvc'
        }
        $name = read-host "Enter a serice that you want to get infor " # wscsvc == windows security center service
        serviceInfor($name)
#>
# 3. Collect Windows Event Log Entries
<#
function logInfor()
{
# collect windows logs using Get-EventLog
    get-eventLog system -After (get-date).AddHours(-12) | where-object { $_.EntryType -match "Error" -or $_.EntryType -match "Warning"}
    #get system logs from 12h priviously to now 
  #  get-eventLog system -before (get-date -Format "2025-05-10") | where-object { $_.EntryType -match "Error" -or $_.EntryType -match "Warning"}
    #get system logs from 2025-05-10 to past. 
# collect windows logs using Get-WinEvent
        Get-WinEvent -FilterHashtable @{LogName="System";Level=2,3;StartTime=(get-date).AddHours(-12)} | Format-List *       
}
        
logInfor
#>

# 4. Query networking information 
function networkingInfor()
{
    param($interface)
    # Query Computer Network Properties
        Get-NetAdapter -name *
        get-netadapter -name *   -includehidden
        # get all apdapter interface 
        Get-NetAdapter -name $interface | format-list *
        #get a specific interface information
    #Perform a Network Trace
}
networkingInfor("wi-fi")
