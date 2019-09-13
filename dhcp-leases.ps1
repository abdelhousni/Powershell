$server = 'ServerAddress.domain'
$csvpath = '.\'
$rundate = Get-Date -Format 'yyyyMMdd'
# Récupérer toutes les Id Scope (IPv4) du serveur DHCP
$dhcpScopes = Get-DhcpServerv4Scope -ComputerName $server

# For each scope get the leases and export result in 
foreach ($scope in $dhcpScopes)
{
	Get-DhcpServerv4Lease -ComputerName $server -ScopeId $scope.ScopeId |Export-Csv -Path $csvpath"$rundate-$server-dhcp-leases.txt" -Append -NoClobber -NoTypeInformation
}
