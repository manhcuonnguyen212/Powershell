#Author: Nguyen Dang Manh Cuong
#Created on: 2025-05-15
# Create a sessions on windows-based system
    <#
    A basic setup 
        on server side:
            Enable-PSRemoting -force 
            Test-wsman #check setup
        on client side: 
            $session = new-sesion -computerName ipadd -credential (get-credential)
            get-pssession 
            enter-pssession -id id
    #>
# Create a session on linux-based system
    <#
        On server side: 
            edit /etc/ssh/sshd_config:
                PasswordAuthentication yes 
                Subsystem powershell /usr/bin/pwsh -sshn -NoLogo
        On Client side:
            $session = new-pssession -HostName ipadd -Username "kali"
            get-pssession
            enter-pssession -id id
    #>