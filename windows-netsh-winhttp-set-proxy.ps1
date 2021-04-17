# Windows - Netsh Winhttp set proxy server parameters (for windows update etc...)
# Abdellatif Housni - 2019

$proxy_server = "http://proxy.acme.com:3128"
$bypass_list = "<local>;172.22.*;192.168.*;*.localdomain.lan"
netsh winhttp set proxy proxy-server=$proxy_server bypass-list=$bypass_list
