# Author: Nguyen Dang Manh Cuong
# Created on : 2025-07-4
# Objectives: How the usage of CPU and Memory of processes running on the targeted system

function func1()
{
    # Displaying process infor
    Write-Host "[+] Starting checking..." -ForegroundColor Cyan
    Get-Process | Sort-Object -Property $_.CPU -Descending | Select-Object -first 10 Name, 
        @{Name="CPU(s)";Expression={$_.CPU}},
        @{Name="VM(M)";Expression={[INT]($_.VM/1mb)}},Handles | Sort-Object Mem -Descending 

}
function func2()
{
    param($id)
    # Stop process
    Stop-Process -Id $id

}
function func3()
{
    # Launching process
    $filePath = Read-Host "Enter the path of the file: " 
    Write-Host "Choose the method: `n`t 1.Using Start-Process`n`t2.Using WMIClass"
    $x  = Read-Host
    switch ($x) {
        1 { 
            Start-Process -FilePath $filePath ; break 
         }
        2 {
            Invoke-WmiMethod -Class Win32_process -name Create -ArgumentList $filePath ; break
        }
        Default {
                Write-Host "Please, providing the parameters"
        }
    }
}

func3
