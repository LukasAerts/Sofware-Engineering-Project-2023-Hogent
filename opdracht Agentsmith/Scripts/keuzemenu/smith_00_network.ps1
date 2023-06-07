# agentsmith_00_netwerk
# stelt de netwerk-eigenschappen in

[String]$SMITH_IP = ""
[String]$SMITH_GW = ""
[String]$SMITH_DNS = ""

#smith_fprint for now prints to the screen
function smith_fprint ([String]$message) {
        write-host ${message}
}

#stap 1 : disable ipv6
smith_fprint "Disabling IPv6"
Get-NetAdapter | ForEach-Object { Disable-NetAdapterBinding -interfacealias $_.Name -ComponentID ms_tcpip6 }

$SMITH_netwerk = Import-Csv "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\netwerk.csv" -Delimiter ";"


smith_fprint "Retrieving values from .csv-file"
$SMITH_IP = $($SMITH_netwerk).guestip
smith_fprint "IP:  ${SMITH_IP}"
$SMITH_GW = $($SMITH_netwerk).guestgw
smith_fprint "Default gateway: ${SMITH_GW}"
$SMITH_DNS = $($SMITH_netwerk).guestdns
smith_fprint "Dns: ${SMITH_DNS}"

smith_fprint ""
smith_fprint "setting ip and default gateway"
New-NetIPAddress -InterfaceAlias ethernet -AddressFamily ipv4 -IPAddress $SMITH_IP -PrefixLength 24 -DefaultGateway $SMITH_GW

smith_fprint ""
smith_fprint "setting DNS"
Set-DnsClientServerAddress -InterfaceAlias ethernet -ServerAddresses $SMITH_DNS

smith_fprint ""
smith_fprint "Adding a icmpv4 rule in the firewall ..."
netsh advfirewall firewall add rule name="ping4" protocol=icmpv4:8,any dir=in action=allow

#signaal voor oproepend script om verder te gaan ...
VBoxControl guestproperty set network_finished y

# new line has a function