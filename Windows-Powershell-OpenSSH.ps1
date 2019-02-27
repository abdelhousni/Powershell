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
