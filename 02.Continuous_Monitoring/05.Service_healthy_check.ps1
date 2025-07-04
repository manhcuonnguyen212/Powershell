# Author: Nguyen Dang Manh Cuong
# Created on 2025-07-04
#Objectives: view the services installed on the system to determine which services are
#  running and if any of their dependent services haven’t started.

function func1()
{
    Write-Host "[+] Starting checking service healthy." -ForegroundColor Green
    # get services and sort by name
    $get_services = Get-Service | Sort-Object -Property DisplayName 
    # list the status of services
    $get_services | ForEach-Object {
        if($_.Status -eq "stopped")
        {
            Write-Host "$($_.DisplayName) is $($_.Status)" -ForegroundColor green
        }
        else 
        {
            Write-Host "$($_.DisplayName) is $($_.Status)"
        }
    }
    # dispaly dependencies of services
    $get_services | ForEach-Object{
        if($_.Status -eq "stopped")
        {
            $_.ServicesDependedOn | Select-Object -Property name,DisplayName,status
            
        }

    }
}

func1