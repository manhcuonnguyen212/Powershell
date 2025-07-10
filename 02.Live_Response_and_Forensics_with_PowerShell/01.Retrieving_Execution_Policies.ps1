 
 
 # Retrieve the effective execution policy
 Get-ExecutionPolicy
 # Retrieve all execution policies that affect the current session
 Get-ExecutionPolicy -List
 # Retrieve the execution policies by scope
 Get-ExecutionPolicy -Scope CurrentUser
 Get-ExecutionPolicy -Scope LocalMachine
 Get-ExecutionPolicy -Scope MachinePolicy
 Get-ExecutionPolicy -Scope Process
 Get-ExecutionPolicy -Scope UserPolicy
