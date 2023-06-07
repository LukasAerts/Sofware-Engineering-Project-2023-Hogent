#### DirectorPC #####

# Values
$IP = "192.168.40.1"
$GW = "192.168.20.1"
$DNS = "192.168.20.1"

# Keyboard Layout

Set-WinUserLanguageList -LanguageList nl-BE -Force


# Static IP
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress $IP -AddressFamily IPv4 -PrefixLength 24 -DefaultGateway $GW
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses $DNS

# Install all RSAT tools
# CAUTION an internet connection is needed!!! 

Get-WindowsCapability -Name RSAT* -Online | Add-WindowsCapability -Online



Restart-Computer

