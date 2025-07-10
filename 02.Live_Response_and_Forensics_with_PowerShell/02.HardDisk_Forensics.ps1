
# Objectives: Performing Disk Forensic Task with PowerForensics module 
# Install PowerForensics manually -> Install-Module PowerForensics
# Import module -> Import-Module PowerForensics 
# Check module imported -> Get-Command -Module PowerForensics

Write-Host "------------------The Script will carry out Disk Forensic tasks------------------" -ForegroundColor Cyan
while(1){
  Write-Host "`tChoose your selection: " -ForegroundColor Green
  Write-Host "`t`t1.Get items in the specific path" -ForegroundColor Green
  Write-Host "`t`t2.Retrieve deleted file records" -ForegroundColor Green
  Write-Host "`t`t3.Retrieve modified filed records by date" -ForegroundColor Green
  Write-Host "`t`t4.Exist programme"
  $selection = Read-Host "`t[+]Enter-> "
  if($selection -eq "4")
  {
    break
  }
  switch ($selection) {
      1 {
        while(1){
          $path = Read-Host "`t`t[+]Enter the path or empty to exist current selection->" 
          if($path -eq "")
          {
            break
          }
          Try {
            Get-ForensicChildItem -path $path
          }
          Catch {
              Write-Host "[-]Error: $($_.Exception.Message)" -ForegroundColor Red
           }
        }
        ;; break
        }

        (2){
          while(1)
          {
            $volumeName = Read-Host "`t`t[+]Enter volume name or empty to exist current selection->"
            if($volumeName -eq "")
            { 
                break
            }
            $maxEntries = Read-Host "`t`t[+]Enter max items->"
            if($volumeName -eq "")
            { 
                break
            }
            try{
              Get-ForensicFileRecord -VolumeName $volumeName | Where-Object {$_.Deleted} | Select-Object -first $maxEntries
            }
            catch {
              Write-Host "`t`t[-]Error: $($_.Exception.Message)" -ForegroundColor read 
            }
          }
        }
        3{
          while(1)
        {
            $volumeName = Read-Host "`t`t[+]Enter volume name or empty to exist current selection->"
            if($volumeName -eq "")
            { 
                break
            }
            $maxEntries = Read-Host "`t`t[+]Enter max items->"

            $modifiedDate = Read-Host "`t`t[+]Enter modified dat in format dd/mm/yyyy hh:mm:ss AM|PM->"
            try{
            Get-ForensicFileRecord -VolumeName $volumeName | Where-Object {$_.modifiedTime -gt $modifiedDate} | Select-Object -first $maxEntries
            }
            catch {
              Write-Host "`t`t`[-]Error: $($_.Exception.Message)" -ForegroundColor red
            }
        }
        }
  }
}