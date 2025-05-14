#author: Nguyen Dang Manh Cuong

#retrieving process information
        function processInfor {
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
                write-host "The program has run completely." -ForegroundColor white
            }
            # retrieve process attributes
            get-process -IncludeUserName | where-object {$_.Username -like "*system*"} | Select-Object name,startTime,@{Name="CPU";Expression={[math]::Round($_.CPU,2)}},Path
            # get processes belog to system and show out name,starttime, cpu using and path.
        }
        $name = read-host "Enter a process that you want to get infor " # get name of the process
        processInfor($name)
