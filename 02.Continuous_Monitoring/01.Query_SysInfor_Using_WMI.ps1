#Author: Nguyen Dang Manh Cuong
#Created on: 20250-07-04

While($true)
{
    Write-Host -ForegroundColor Red "+++++++++++++++++++++++++++++++++++++===+++++++++++++++++++++++++++++++++++++" 
    Write-Host "[+]Providing your option:`n`t1.Getting supporting classes`n`t2.Getting Infor from a specific CimClasss`n`t3.OS Infor`n`t4.Local Accounts`n`t5.Hardware Infor`n`t6.Service Infor`n`t7.BIOS Infor`n`t8.NetAdap Infor`n`t9.Group Infor`n`t10.Reboot A Remote Machine`n`t11.Set the start mode of the specified service" -ForegroundColor Green
    $selection = Read-Host "----->"
    switch ($selection) {
        1 { 
            $pattern = Read-Host "[+]Enter your pattern "
            try {
                Get-CimClass | Where-Object { $_.CimClassName -like "*$pattern*"}
            }
            catch {
                Write-Host "[-]Error: $($_.Exception.Message)" -ForegroundColor Red
            }
            ;break 
         }
         2{
            $cimClass = Read-Host "Enter cimClass->"
            Get-CimInstance -ClassName $cimClass 
            ;break
         }
         3{
            Write-Host "____________=OS Version Infor=____________" -ForegroundColor Red
            Get-CimInstance -ClassName Win32_OperatingSystem | Format-List *
            ;break 
         }
         4{
           Write-Host "____________=LocalAccounts=____________" -ForegroundColor Red
            Get-CimInstance -ClassName Win32_UserAccount -Filter "LocalAccount=True"
            ;break
         }
        5{
                Write-Host "____________=Computer-Hardward System Infor=____________" -ForegroundColor Red
                Get-CimInstance –class Win32_ComputerSystem | Format-List –Property *
            ;break
        }
        6{
                Write-Host "____________=Service Infor=____________" -ForegroundColor Red
                Get-WmiObject –Class Win32_Service
            ;break
        }
        7{
                Write-Host "____________=BIOS Infor=____________" -ForegroundColor Red
                Get-CimInstance -ClassName Win32_BIOS
            ;break 
        }
        8{
                Write-Host "____________=NetWorkAdapter Infor=____________" -ForegroundColor Red
            Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration
            ;break
        }
        9{
                Write-Host "____________=Group Infor=____________" -ForegroundColor Red
                $data = Get-CimInstance –ClassName Win32_Group -ComputerName localhost
                $group_arrays = @()
                foreach($x in $data)
                {
                    $group_arrays+=$($x.Name)
                }
                foreach($x in $group_arrays)
                {
                    Write-Host "$($x):`n`t"
                    try{
                       $members =  Get-LocalGroupMember -Group "$($x)"
                       foreach($y in $members)
                       {
                            Write-Host "`t$($y.Name) -> $($y.SID)" -ForegroundColor green
                       }
                    }
                    catch{
                        Write-Host "[-] Error: $($_.Exception.Message)"
                    }
                    }
                ; break
        }
        10{
            $IpAdd = Read-Host "[+]Enter IpAdd of the remote machine(can be empty=localhost):"
            if($IpAdd){
                Invoke-CimMethod -ClassName Win32_OperatingSystem -ComputerName $IpAdd -MethodName Reboot 
                break 
            }
            Invoke-CimMethod -ClassName Win32_OperatingSystem -ComputerName localhost -MethodName Reboot 
            
            ;break 
        }
        11{
            $name = Read-Host "[+]Enter the name of the serice->"
            Get-CimInstance -ClassName Win32_Service -Filter "Name='$name'" | Invoke-CimMethod -Name ChangeStartMode -Arguments "Automatic"
            ;break 
        }
         Default {}
    }

}