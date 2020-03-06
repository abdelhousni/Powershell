# source :
# How to enable the Firewall rules required by Veeam ONE on the Windows Server Core OS : https://www.veeam.com/kb2696
# How to Enable COM+ in Windows Server 2016 : https://www.jorgebernhardt.com/how-to-enable-com-in-windows-server-2016/
Set-NetFirewallRule -Name 'RemoteEventLogSvc-NP-In-TCP' -Enabled True
Set-NetFirewallRule -Name 'RemoteEventLogSvc-In-TCP' -Enabled True
Set-NetFirewallRule -Name 'RemoteEventLogSvc-RPCSS-In-TCP' -Enabled True
Set-NetFirewallRule -Name 'ComPlusNetworkAccess-DCOM-In' -Enabled True

# cmd equivalent
# netsh advfirewall firewall set rule name="Remote Event Log Management (NP-In)" new enable= Yes
# netsh advfirewall firewall set rule name="Remote Event Log Management (RPC)" new enable= Yes
# netsh advfirewall firewall set rule name="Remote Event Log Management (RPC-EPMAP)" new enable= Yes
# netsh advfirewall firewall set rule name="COM+ Network Access (DCOM-In)" new enable= Yes

# source :
# Windows Server – Configuration WinRM / Remote PowerShell : https://www.virtualease.fr/windows-server-configuration-winrm-remote-powershell/
  # Configuration de WinRM
    Get-Service WinRM
    Enable-PSRemoting
  # Autorisation d’écoute sur l’IP de la machine et de loopback
    Remove-WSManInstance winrm/config/Listener -SelectorSet @{Address="*";Transport="http"}
    New-WSManInstance winrm/config/Listener -SelectorSet @{Address="*";Transport="http"}
  # Redémarrage du service
    Restart-Service winrm
  # Vérification de la configuration
    winrm get winrm/config/client
    winrm e winrm/config/listener
  # A faire sur la machine de Management
  #   Autorisation du serveur Remote (Dans le cas ou ils ne sont pas dans le même domaine)
    Set-Item WSMan:\localhost\Client\TrustedHosts <IP_Remote_Server>
