# Abdellatif Housni 2020
# Monitoring des Sessions Citrix
# pré-requis : Broker_PowerShellSnapIn_x64.msi
# 

asnp citrix*

# Adresse du Citrix Delivery Controller
$DeliveryControllerHost = $args[0]

# Scope IP VPN
$IP_VPN = '192.168.*'

# All Sessions
$Citrix_All_Sessions = ((Get-BrokerSession -AdminAddress $DeliveryControllerHost -MaxRecordCount 1200 -Filter { BrokeringUserName -ne $null}) `
 | select BrokeringUserName,BrokeringTime,CatalogName,ClientAddress, `
 ClientName,ClientPlatform,ClientVersion,ConnectedViaHostName,       `
 ConnectedViaIP,ControllerDNSName,DNSName,DesktopGroupName,          `
 EstablishmentDuration,EstablishmentTime,IPAddress,InMaintenanceMode,`
 LaunchedViaHostName,LaunchedViaIP,LogoffInProgress,LogonInProgress,`
 MachineName,ReceiverIPAddress,ReceiverName,SecureIcaActive,`
 SessionKey,SessionState ).count


# VPN Sessions
$Citrix_VPN_Sessions = ((Get-BrokerSession -AdminAddress $DeliveryControllerHost -MaxRecordCount 1200 -Filter { BrokeringUserName -ne $null -and ClientAddress -like $IP_VPN }) `
 | select BrokeringUserName,BrokeringTime,CatalogName,ClientAddress, `
 ClientName,ClientPlatform,ClientVersion,ConnectedViaHostName,       `
 ConnectedViaIP,ControllerDNSName,DNSName,DesktopGroupName,          `
 EstablishmentDuration,EstablishmentTime,IPAddress,InMaintenanceMode,`
 LaunchedViaHostName,LaunchedViaIP,LogoffInProgress,LogonInProgress,`
 MachineName,ReceiverIPAddress,ReceiverName,SecureIcaActive,`
 SessionKey,SessionState ).count

# Non-VPN Sessions
$Citrix_Non_VPN_Sessions = ((Get-BrokerSession -AdminAddress $DeliveryControllerHost -MaxRecordCount 1200 -Filter { BrokeringUserName -ne $null -and ClientAddress -notlike $IP_VPN }) `
 | select BrokeringUserName,BrokeringTime,CatalogName,ClientAddress, `
 ClientName,ClientPlatform,ClientVersion,ConnectedViaHostName,       `
 ConnectedViaIP,ControllerDNSName,DNSName,DesktopGroupName,          `
 EstablishmentDuration,EstablishmentTime,IPAddress,InMaintenanceMode,`
 LaunchedViaHostName,LaunchedViaIP,LogoffInProgress,LogonInProgress,`
 MachineName,ReceiverIPAddress,ReceiverName,SecureIcaActive,`
 SessionKey,SessionState ).count

# Proportion d'utilisateurs VPN
$Citrix_VPN_Sessions_Proportion = [math]::Round((($Citrix_VPN_Sessions/$Citrix_All_Sessions)*100))

"<prtg>"
	"<result>"   
		"<channel>Citrix - Toutes Sessions</channel>"
		"<value>$Citrix_All_Sessions</value>"
	"</result>"
	"<result>"   
		"<channel>Citrix - Sessions Sur Site</channel>"
		"<value>$Citrix_Non_VPN_Sessions</value>"
	"</result>"
	"<result>"   
		"<channel>Citrix - Sessions via VPN</channel>"
		"<value>$Citrix_VPN_Sessions</value>"
	"</result>"
	"<result>"   
		"<channel>Citrix - Sessions via VPN vs Sessions Sur Site</channel>"
        "<Unit>Percent</Unit>"
		"<value>$Citrix_VPN_Sessions_Proportion</value>"
	"</result>"
"</prtg>"

