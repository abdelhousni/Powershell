# Installing OpenSSH with PowerShell
# Tested with Windows 10 1809
# source : https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse
# source : http://garrettyamada.com/powershell-remoting/


# Verify if OpenSSH Client/Server available/installed
Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'

# Install the OpenSSH Client
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Install the OpenSSH Server
Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0

# Change the shell (cmd by default)

# powershell
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH" -Name DefaultShell -Value "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -PropertyType String -Force
# bash
New-ItemProperty -Path "HKLM:\SOFTWARE\OpenSSH\" -Name DefaultShell -Value "C:\Windows\System32\bash.exe" -PropertyType String -Force

# powershell core

# Start sshd Service
Start-Service sshd
# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured. It should be created automatically by setup. 
Get-NetFirewallRule -Name *ssh*
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled 

