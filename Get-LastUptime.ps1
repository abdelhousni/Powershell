# From https://blogs.technet.microsoft.com/heyscriptingguy/2013/03/27/powertip-get-the-last-boot-time-with-powershell/

# Method 1
Get-CimInstance -ClassName win32_operatingsystem | select csname, lastbootuptime

# Method 2
Get-WmiObject win32_operatingsystem | select csname, @{LABEL='LastBootUpTime' ;EXPRESSION={$_.ConverttoDateTime($_.lastbootuptime)}}

# Method 3
systeminfo /FO CSV | ConvertFrom-CSV

# Method 4
net statistics workstation
