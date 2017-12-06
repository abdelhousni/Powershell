# based on https://www.reddit.com/r/AskGreg/comments/2k0siw/powershell_get_shortcut_target/

# get Target of Windows shortcut files (*.LNK)
# $path = path where *.lnk files are located
# $filter = filter
function Get-ShortcutsTarget ($path, $filter){
    $Shortcuts = Get-ChildItem -Force -Recurse $destpath -Include *.lnk -Filter $filter
    $Shell = New-Object -ComObject WScript.Shell
    foreach ($Shortcut in $Shortcuts)
    {
        $Properties = @{
        Name = $Shortcut.Name;
        FullName = $Shortcut.FullName;
        DirectoryName = $shortcut.DirectoryName
        Target = $Shell.CreateShortcut($Shortcut).targetpath
        }
        New-Object PSObject -Property $Properties
    }
[Runtime.InteropServices.Marshal]::ReleaseComObject($Shell) | Out-Null
}
  
