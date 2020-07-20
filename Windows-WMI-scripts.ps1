
# Get list of printers ports with (IP) Address
Get-WmiObject Win32_TCPIPPrinterPort -ComputerName srv-printers | select name,queue,HostAddress
