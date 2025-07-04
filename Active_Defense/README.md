## What does active defense mean?
    that's mean proactive measures taken by an organization to detect, respond and prevent to cyber threats.
## Active defense techniques 
    1. Continuous monitoring and analysis of network traffic 
    2. Proactively patching systems
    3. Deception technology 
        Honeypots and decoys
    4. Red team and penetration testing
## Why make use of powershell for active defense
    make sure configurations be consistent on windows or linux machines
    deep automation capabilities
    easy-to-use and implement
## Settings Trap
    What kinds of trap can be set 
        Hotpots
    1.Create a Honeyport 
        Run : HoneyPort.ps1
        Check connection: Test-NetConnection -Computername localhost -Port 12345 
        Stop the script: netstat -ano | Where-object{$_ -like "*12345*"} # find out PID
            Stop-Process -PID ... -Force