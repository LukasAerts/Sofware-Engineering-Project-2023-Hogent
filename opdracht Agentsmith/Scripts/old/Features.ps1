#### AD DC #####

# Values

$SecurePass = (ConvertTo-SecureString -String "22Admin23" -AsPlainText -Force)
$IP = "192.168.20.1"
$GW = "192.168.20.1"
$DNS = "192.168.20.1"

# Keyboard Layout

Set-WinUserLanguageList -LanguageList nl-BE -Force


# Static IP
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress $IP -AddressFamily IPv4 -PrefixLength 24 -DefaultGateway $GW
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses $DNS

# AD Feature Installatie

Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools -verbose
Import-Module ADDSDeployment
Install-ADDSForest -DomainName "TheMatrix.local" -Force -SafeModeAdministratorPassword $SecurePass -InstallDNS -NoRebootOnCompletion -verbose
Install-ADDSDomainController -DomainName "TheMatrix.local" -InstallDns:$true -Credential (Get-Credential "THEMATRIX\Administrator") -Force -SafeModeAdministratorPassword $SecurePass -NoRebootOnCompletion:$true -verbose

Restart-Computer

