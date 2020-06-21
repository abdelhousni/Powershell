# Script exécutant un Job Windows Backup vers un share distant en excluant les fichiers *.ft et dossiers *ftgi*
#
# source : https://social.technet.microsoft.com/wiki/contents/articles/2216.windows-server-2008-r2-powershell-backup.aspx
# source : https://docs.microsoft.com/en-us/powershell/module/windowserverbackup/start-wbbackup?view=winserver2012r2-ps

# Execution Command : powershell.exe -executionpolicy bypass -file .\wbackup_arg.ps1 "c:\Batch" "\\share\folder$\BROLL"

Param(
  [string]$PathToBackup,
  [string]$BackupLocationPath
)
$RunFolder="C:\Batch"
$date=Get-Date -Format 'yyyyMMdd-hhmmss'

# Check if folder and exists
if(Test-Path $PathToBackup -PathType Container)
{
    if(Test-Path $BackupLocationPath -PathType Container)
    {
        Import-Module ServerManager 
        Add-WindowsFeature Backup-Features -Include 
        Add-PSSnapin Windows.ServerBackup
        $FilespecInclude = New-WBFileSpec -FileSpec $PathToBackup
        # Exclure fichiers *.ft
        $Filespec = New-WBFileSpec -FileSpec "$PathToBackup\*.ft" -Exclude
        # Lister dossiers FTGI et les ajouter à Exclude 
        $list_ftgi = Get-ChildItem -filter *ftgi* -Recurse $PathToBackup | ?{ $_.PSIsContainer }|select Fullname
        $filelist=@();foreach($file in $list_ftgi) { $filelist += $file.Fullname }
        $FilespecFTGI = New-WBFileSpec -FileSpec $filelist -Exclude
        $Policy = New-WBPolicy -Verbose
        Add-WBFileSpec -Policy $Policy -FileSpec $FilespecInclude
        Add-WBFileSpec -Policy $Policy -FileSpec $Filespec
        Add-WBFileSpec -Policy $Policy -FileSpec $FilespecFTGI
        $BackupLocation = New-WBBackupTarget -NetworkPath $BackupLocationPath
        Add-WBBackupTarget -Policy $Policy -Target $BackupLocation
        Set-WBVssBackupOptions -Policy $Policy -VssCopyBackup
        $Policy > C:\Batch\$date-$($MyInvocation.MyCommand.Name).txt
        $Policy.FilesSpecsToExclude | Export-Csv -Path C:\Batch\$date-wbackup-FilesSpecsToExclude.csv -NoClobber -NoTypeInformation -Force -Encoding UTF8
        $Policy
        Start-WBBackup -Policy $Policy -Force -Async
    }
    else
    {
        "BackupLocation (arg2) not valid (reason : not exist or not folder)"
	      "BackupLocation (arg2) not valid (reason : not exist or not folder)" >> c:\batch\$date-$($MyInvocation.MyCommand.Name).txt
    }
}
else
{
    "PathToBackup (arg1) not valid (reason : not exist or not folder)"
    "PathToBackup (arg1) not valid (reason : not exist or not folder)" >> c:\batch\$date-$($MyInvocation.MyCommand.Name).txt
}
