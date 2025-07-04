# Author: Nguyen Dang Manh Cuong
# Created on: 2025-07-04


while($true)
{
Write-Host -ForegroundColor blue "[+]Choose your selection: `n`t1.Creating a folder`n`t2.Creating a file`n`t3.Removing a files`n`t4.Reading a file`n`t5.Searching contents in a file`n`t6.Search the file"
$selection = Read-Host
switch ($selection) {
    1 { 
        try{
            $name  = Read-Host "[+]Enter name of the folder "
            $path  = Read-Host "[+]Enter the path of the folder "
            New-item -Name $name -Path $path -ItemType Directory
            Write-Host "[+]Creating the folder successfully!" -ForegroundColor Green
        }
        catch{
            Write-Host "[-]Failed to create the folder!" -ForegroundColor Red
            Write-Host "$($_.Exception.Message)"
        }
            ;break }
    2 {
        $name = Read-Host "[+]Enter name of the file "
        $path = Read-Host "[+]Enter the path of the file "
        $value = Read-Host "[+]Enter contents for file (can be empty) "
            try {
                if($value)
                {
                    New-Item -Name $name -Path $path -ItemType File -Value $value
                    #Method2:
                    #Out-File -FilePath $path -Append $value
                }
                else{
                    New-Item -Name $name -Path $path -ItemType File -Value ""
                }                
                Write-Host "[+]Creating the file successfully!" -ForegroundColor green
            }
            catch {
                Write-Host "[-]Failed to create the file!" -ForegroundColor Red
                Write-Host "$($_.Exception.Message)"                        
            }
        ; break  }
        3 {
            $path = Read-Host "[+]Enter the path (quotes should be stripped out)"
            try {
                Remove-Item -Path $path -Recurse
                Write-Host "[+]Removing items in $path succesfully!" -ForegroundColor Green       
            }
            catch {
                
                Write-Host "[-]Failed to remove items!" -ForegroundColor Red
                Write-Host "$($_.Exception.Message)"                       
            }
            ; break
        }
        4
        {
            $path = Read-Host "[+]Enter the path of the file"
            try {
                # open the file
                if(Test-Path -Path $path) # Check if whether the existence of the file
                {
                    Get-Content -Path $path 
                    break
                }
                Write-Host "[-]Can't find the file"
            }
            catch {
                                    
                Write-Host "[-]Failed to read the file!" -ForegroundColor Red
                Write-Host "$($_.Exception.Message)"   
            }
            ;break
        }
        5 {
            $name = Read-Host "[+]Enter the path of the file"
            $pattern = Read-Host "[+]Enter the pattern"
            try {
                Select-String -Path $name -Pattern $pattern -AllMatches

            }
            catch {
                Write-Host "[-]Failed to seek contents in the file!" -ForegroundColor Red
                Write-Host "$($_.Exception.Message)"  
            }
            ; break
        }
        6 
        {
            $name = Read-Host "[+]Enter the path(quotes should be stripped out) "
            $filter = Read-Host "[+]Enter the filter "
            try {
               Get-ChildItem -Path $name -Filter $filter -Recurse
           
            }
            catch {
                Write-Host "[-]Failed to read the file!" -ForegroundColor Red
                Write-Host "$($_.Exception.Message)"   
            }
            ;break
        }
}
}