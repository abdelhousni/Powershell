#sources :
# https://www.tenforums.com/general-support/107659-how-sign-powershell-profile-w-self-signed-certificate-2.html?s=40bc576298d26cce56f481e4fd0c40ab
# https://searchitoperations.techtarget.com/tutorial/Create-a-self-signed-certificate-to-control-PowerShell-scripts
# https://community.spiceworks.com/how_to/122368-windows-7-signing-a-powershell-script-with-a-self-signed-certificate

# Create Self-signed certificate
$mycert = New-SelfSignedCertificate  -Subject "CN=PowerShell Script Sign" `
              -KeyAlgorithm RSA -KeyLength 2048   -Type CodeSigningCert `
              -CertStoreLocation Cert:\LocalMachine\My\
# Move Self-signed certificate to CA Root Folder
Move-Item "Cert:\LocalMachine\My\$($mycert.Thumbprint)" Cert:\LocalMachine\Root
# Get certificate Thumprint
$myrootcert = "Cert:\LocalMachine\Root\$($mycert.Thumbprint)"
# sign the powershel script
set-AuthenticodeSignature "$path_to_script\test.ps1" $mycert
