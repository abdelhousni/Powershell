# Windows Server 2008 R2 PowerShell Backup
source : [https://social.technet.microsoft.com/wiki/contents/articles/2216.windows-server-2008-r2-powershell-backup.aspx](https://social.technet.microsoft.com/wiki/contents/articles/2216.windows-server-2008-r2-powershell-backup.aspx)

The Windows Server Backup feature of Windows Server 2008 R2 includes an enhanced Windows PowerShell Snap-in that can be used to manage and control Windows Server backups. But before you can use the Snap-in, you need to enable the feature on Windows Server, and then load the snap-in.

Once the feature is enabled, and the snap-in loaded, you then build the backup policy a step at a time. Once the policy has been built, you set the new policy as the system backup policy.

Alternately, if the server has an existing backup policy, you can modify it by changing what is backed up, or what the backup target is, by opening the existing policy in edit mode.

1.) **Enable Windows PowerShell Support for Windows Server Backup**

`Import-Module ServerManager `

`Add-WindowsFeature Backup-Features -Include `

`Add-PSSnapin Windows.ServerBackup`

2.) **Create /Get/Edit Policy (Schedule)**   
The backup is controlled by the WBPolicy. This policy includes all the information necessary to perform a backup, including the backup schedule. You can create a new policy, retrieve an existing policy, or open an existing policy in edit mode to change it.

`$BPol` `= Get-WBPolicy `

`$BPol` `= Get-WBPolicy -edit  `

`$BPol` `= New-WBPolicy`

3.) **Include Volumes in the Backup  
**Create individual WBVolume objects by selecting on the MountPath (or other property) of the volume. Combine WBVolume objects as a list and add to the WBPolicy with Add-WBVolume.

`$volC` `= Get-WBVolume –AllVolumes | Where {``$_``.MountPath –eq “C:” }   `

`$volD` `= Get-WBVolume –All | Where {``$_``.MountPath –eq “D:” }   `

`Add-WBVolume –policy ``$BPol` `–volume ``$volC``,``$volD`

4.) **Exclude Files/Folders from Backup  
**Next, create a new WBFileSpec object for each exclusion or inclusion. Inclusions and exclusions are assumed to be recursive unless -nonrecursive is specified. If no inclusions or exclusions are specified for a volume that is included, then the entire volume is assumed. Add all the WBFileSpec objects as a list to the WBPolicy.

`$exclTemp` `= New-WBFileSpec –FileSpec D:\Temp –exclude  `

`$exclMP3` `= New-WBFileSpec –File  “D:\Users\*.MP3” –exc `

`$exclWMA` `= New-WBFileSpec -File  “D:\Users\Charlie\Music\*.wma” –exc –nonrecursive `

`$FileExclusions` `= ``$exclTemp``,``$exclMP3``,``$exclWMA`  

`Add-WBFileSpec -policy ``$BPol` `-filespec ``$FileExclusions`

5.) **Define Backup Target/Device  
**Define one or more backup targets. WBBackupTarget objects can be dedicated external disks, dedicated or shared internal disks, or network share.  
You can define a Backup Target as an external disk by selecting it from the WBDisk objects on the system.

`$extDisk` `= Get-WBDisk | where {``$_``.Properties –eq “External, ValidTarget” }  `

`Add-WBBackupTarget ``$BPol` `–target ``$extDisk`

To back up to a network share, you need to first set the credential that will be used to connect to the share using Get-Credential.

`$cred` `= Get-Credential DOMAIN\User  `

`$netTarget` `= New-WBBackupTarget -NetworkPath \\server\share -cred ``$cred`  

`Add-WBBackupTarget -policy ``$BPol` `-target ``$netTarget`

6.) **Define a backup schedule  
**Add backup schedule times to the backup. Define for the current day and the schedule will repeat daily. So, for twice a day, at 12:30 PM and 9PM

`$sch1` `= [datetime]”02/01/2011 12:30:00”`

`$sch2` `= [datetime]”02/01/2011 21:00:00”`

`Set-WBSchedule -policy ``$BPol` `-schedule ``$sch1``,``$sch2`

7.) **Enable System State Backup**

Add-WBSystemState -policy $BPol  
  
8.) **Enable Bare Metal Recovery  
**When enabled, the bare metal recovery option will set the system volume to a full image backup. This will override any file exclusions set on the system volume.   
  
Add-WBBareMetaRecovery -policy $BPol  

9.) **Define the Volume Shadow Copy Options  
**Set Volume Shadow Copy to** VssFullBackup** when Windows Server Backup is the only application performing backups. Use **VssCopyBackup** when additional backup applications are in use.

`Set-WBVssBackupOptions -policy $BPol –VssFullBackup`

`Set-WBVssBackupOptions -policy $BPol -VssCopyBackup`

10.) **Enable the Backup Policy  
**Finally, before the backup policy actually does anything, we need to set it in place. Use the ‑force parameter to avoid prompting.

`Set-WBPolicy -policy $BPol -force `

# Start a One-Time Backup

Using the current scheduled backup settings for items to be backed up, and backup target.

`$BPol = Get-WBPolicy`

`Start-WBBackup -policy $BPol`

  
To perform a one-time backup using different settings, without modifying the existing backup settings, first create a new policy with  

`$NewPol = New-WBPolicy `

  
Then, build the one-time backup policy just as you would the standard policy, but without a schedule. Then when you’ve added what is backed up, and where it will be backed up to,  do not run Set-WBPolicy, but rather use:  

`Start-WBBackup -policy $NewPol  
  
`

  

* * *

# See Also

-   [PowerShell Portal](http://social.technet.microsoft.com/wiki/contents/articles/24187.powershell-portal.aspx)
-   [Wiki: Portal of TechNet Wiki Portals](http://social.technet.microsoft.com/wiki/contents/articles/20459.wiki-portal-of-technet-wiki-portals.aspx)

source : [https://social.technet.microsoft.com/wiki/contents/articles/2216.windows-server-2008-r2-powershell-backup.aspx](https://social.technet.microsoft.com/wiki/contents/articles/2216.windows-server-2008-r2-powershell-backup.aspx)

