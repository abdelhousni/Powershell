# Script d'installation du VPN Fortinet pour Windows 10

# Création de la connexion FortiClient
# vérifie que le package Forticlient du Windows Store est bien installé, sinon l'installer
if((Get-AppxPackage "FortinetInc.FortiClient").Status -eq "Ok") {
	$xml = "<MobileConnect><Port>4433</Port></MobileConnect>";		# port par défaut
	$sourceXml=New-Object System.Xml.XmlDocument;
	$sourceXml.LoadXml($xml);
	Add-VpnConnection	-Name "VPN WorkPlace" `											# nom de la session VPN
						-SplitTunneling:$True `											# Split-Tunneling actif
						-DnsSuffix "work.lan" `											# renvoyer les requetes vers le domaine LAN vers la connexion VPN
						-ServerAddress "https://vpn-WorkPlace.acme.com" `				# addresse/URL du VPN
						-PlugInApplicationID "FortinetInc.FortiClient_sq9g7krz3c65j" `	# id du package Windows Store
						-RememberCredential:$false `									# ne pas sauver le login/password
						-CustomConfiguration $sourceXml;								
}
else {
	# installation manuelle du package provenant du Windows Store (*.AppxBundle)
	Add-AppxPackage -Path "./FortinetInc.FortiClient_*.AppxBundle"
	$xml = "<MobileConnect><Port>4433</Port></MobileConnect>";		# port par défaut
	$sourceXml=New-Object System.Xml.XmlDocument;
	$sourceXml.LoadXml($xml);
	Add-VpnConnection	-Name "VPN WorkPlace" `											# nom de la session VPN
						-SplitTunneling:$True `											# Split-Tunneling actif
						-DnsSuffix "work.lan" `								      		# renvoyer les requetes vers le domaine LAN vers la connexion VPN
						-ServerAddress "https://vpn-WorkPlace.acme.com" `				# addresse/URL du VPN
						-PlugInApplicationID "FortinetInc.FortiClient_sq9g7krz3c65j" `	# id du package Windows Store
						-RememberCredential:$false `									# ne pas sauver le login/password
						-CustomConfiguration $sourceXml;								
};
	
# Afficher les connexions VPN
start 'ms-settings:network-vpn'

