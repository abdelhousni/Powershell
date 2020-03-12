
## source : [Windows Server 2008 R2 PowerShell Backup](https://social.technet.microsoft.com/wiki/contents/articles/2216.windows-server-2008-r2-powershell-backup.aspx)
# Windows 2008 - Enable Windows PowerShell Support for Windows Server Backup
```powershell
Import-Module ServerManager 
Add-WindowsFeature Backup-Features -Include 
Add-PSSnapin Windows.ServerBackup
```
# Create /Get/Edit Policy (Schedule) 
# The backup is controlled by the WBPolicy. This policy includes all the information necessary to perform a backup, including the backup schedule. You can create a new policy, retrieve an existing policy, or open an existing policy in edit mode to change it.
```powershell
$BPol = Get-WBPolicy 
$BPol = Get-WBPolicy -edit  
$BPol = New-WBPolicy
```
