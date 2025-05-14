#author : Nguyen Dang Manh Cuong


$location = (get-location).path
#get the current directory
try{
  new-item -path "$location\PSReport" -ItemType Directory -ErrorAction stop
    #create a new directory that you want to save the file
}
catch {
    write-host "$_.Exception"
}
$desktop = Get-CimInstance -ClassName Win32_Desktop
$bios = Get-CimInstance -ClassName Win32_BIOS
$processor = Get-CimInstance -ClassName Win32_ComputerSystem | select-object -Property systemtype 
$manufacturer = Get-CimInstance -ClassName Win32_ComputerSystem
$os = Get-CimInstance -ClassName Win32_OperatingSystem
$service = Get-CimInstance -ClassName Win32_Service | select-object name,status,DisplayName
# get system infor with Get-CimInstance
$report  = "$location\PSReport\report.log"
# create a report file 
try {
New-Item $report -ItemType file -value "Powershell Report" -ErrorAction stop
}
catch 
  { 
     write-host "the file already exists" -ForegroundColor green
}
add-content $report -Value "-----------DESKTOP-----------"
add-content $report -Value $desktop
add-content $report -Value "-----------BIOS-----------"
add-content $report -Value $bios 
add-content $report -Value "-----------PROCESSOR-----------"
add-content $report -Value $processor
add-content $report -Value "-----------MANUFACTURER-----------"
add-content $report -Value $manufacturer
add-content $report -Value "-----------OS-----------"
add-content $report -Value $os 
add-content $report -Value "-----------SERVICE-----------"
add-content $report -Value $service 
add-content $report -Value "-----------NETWORKING-----------"
add-content $report -Value (Get-NetAdapter -name *)
add-content $report -Value "-----------LOG ENTRIES-----------"
add-content $report -Value (Get-WinEvent -FilterHashtable @{LogName="System"} | select-object *) 
# writing content to the report file 






