# clone_00_network.ps1
# stelt de netwerk-eigenschappen in van een clone

[String]$TMP_IP = ""
[String]$TMP_GW = ""
[String]$TMP_DNS = ""
[String]$TMP_SEARCH = "thematrix.local"

#Stap 0: stopping updates
get-service | Where-Object {$_.Name -eq 'wuauserv'} | Stop-Service
get-service | Where-Object {$_.Name -eq 'wuauserv'} | Set-Service -StartupType Disabled
get-service | Where-Object {$_.Name -eq 'wuauserv'} | Select-Object *

$trigger = New-JobTrigger -AtStartup -RandomDelay 00:00:30
Register-ScheduledJob -Trigger $trigger -FilePath C:\disable.ps1 -Name SEPdisable

#stap 1 : disable ipv6
write-host "Disabling IPv6"
Get-NetAdapter | ForEach-Object { Disable-NetAdapterBinding -interfacealias $_.Name -ComponentID ms_tcpip6 }

$testje = "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\netwerk.csv"
if (-not (Test-Path  ${testje})) {
    write-host 'netwerk.csv not found, skipping'
    write-host ""
}
else {
    $TMP_netwerk = Import-Csv "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\netwerk.csv" -Delimiter ";"
    write-host "Retrieving values from .csv-file"
    $TMP_IP = $($TMP_netwerk).guestip
    write-host "IP: ${TMP_IP}"
    $TMP_GW = $($TMP_netwerk).guestgw
    write-host "Default gateway: ${TMP_GW}"
    $TMP_DNS = $($TMP_netwerk).guestdns
    write-host "Dns: ${TMP_DNS}"

    write-host ""
    write-host "setting ip and default gateway"
    New-NetIPAddress -InterfaceAlias ethernet -AddressFamily ipv4 -IPAddress $TMP_IP -PrefixLength 24 -DefaultGateway $TMP_GW

    write-host ""
    write-host "setting DNS"
    Set-DnsClientServerAddress -InterfaceAlias ethernet -ServerAddresses $TMP_DNS

    write-host ""
    write-host "setting primary search suffix" # TODO: variable
    #Set-DnsClientGlobalSetting -SuffixSearchList "themarix.local"
    #Set-DnsClient -InterfaceAlias ethernet -ConnectionSpecificSuffix "thematrix.local"
    Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters" -Name "Domain" -Value ${TMP_SEARCH}
}

write-host ""
write-host "Sth for dns pushing ..."
Set-DnsClient -InterfaceAlias ethernet -UseSuffixWhenRegistering $true

write-host ""
write-host "Adding a icmpv4 rule in the firewall ..."
netsh advfirewall firewall add rule name="ping4" protocol=icmpv4:8,any dir=in action=allow

#signaal voor oproepend script om verder te gaan ...
write-host "Sending signal to host"
VBoxControl guestproperty set clone_network_finished y

# new line has a function!
