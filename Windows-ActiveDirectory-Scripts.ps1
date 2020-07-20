
# Users DISABLED for members of group XenApp6_Broll
Get-ADUser -LDAPFilter '(&(objectCategory=Person)(objectClass=User)(samAccountType:1.2.840.113556.1.4.803:=805306368)((userAccountControl:1.2.840.113556.1.4.803:=2))(memberOf=CN=XenApp6_Broll,OU=Applications,OU=Access Rights,OU=Groups,OU=CPAS,DC=broll,DC=be))' | select Name, SamAccountName|Sort-Object -Property name


