# List Printers (name, IP Address) from Windows Printer Server

#source : https://powershell.org/forums/topic/get-name-and-ip-address-of-a-printer/

$print_server = 'server-printer'
Get-WMIObject -Class Win32_Printer -Computer $print_server | %{ $printer = $_.Name; $port = $_.portname; gwmi win32_tcpipprinterport -computername $print_server | where { $_.Name -eq $port } | select @{name="printername";expression={$printer}}, hostaddress }
