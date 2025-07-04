#Author: Nguyen Dang Manh Cuong
#Created on : 2025-07-04
$global:session
while ($true) {
    Write-Host "[+]Choose your environment:`n`t1.Windows`n`t3.Retrieve Logs" -ForegroundColor Cyan
    $selection = Read-Host "-->"
    switch ($selection) {
        1 { 
            $ipadd = Read-Host "[+]Enter Ipadd of the remote machine-->"
             $session = New-PSSession -ComputerName $ipadd -Credential (Get-Credential) 
            ;break
         }
         3{
            $logName = Read-Host "[+]Enter logname-->"
            $maxEntries = Read-Host "[+]Enter MaxEntries appearing-->"
            Write-Host "[+]Filter by:`n`t`t`1.ID`n`t`t2.date"
            $option = Read-Host "-->"
            switch ($option) {
                1 {
                    try {
                        
                    $ID = Read-Host "[+]Enter LogID-->"
                    $ID = [INT]$ID
                    Invoke-Command -Session ${using:sesion} -ScriptBlock {
                        Get-WinEvent -FilterHashtable @{LogName="${using:logName}";ID=${using:ID}} -MaxEvents ${using:maxEntries}}
                    }
                    catch{
                        Write-Host -ForegroundColor red "[-]Error: $($_.Exception.Message)"
                    }
                    ; break
                  }
                2 {
                    try{

                    $startDate = Read-Host "[+]Enter the start written-->"
                    $endDate = Read-Host "[+]Enter the end written-->"
                    Get-WinEvent -FilterHashtable @{LogName=$logName;StartTime=$startDate;EndTime=$endDate}
                    }
                    catch{
                        Write-Host -ForegroundColor red "[-]Error: $($_.Exception.Message)"
                    }
                    ;break
                }
                }
            
            ;break
         }
    }
}