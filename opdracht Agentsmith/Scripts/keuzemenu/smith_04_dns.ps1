# smith_04_dns.ps1

[String]$SMITH_NAAM = ""
[String]$SMITH_IPNR = ""
[String]$SMITH_CSVSTATIC = "dnsstatic.csv"
[String]$SMITH_CSVCNAME = "dnscname.csv" 
[String]$SEP_USERDNSDOMAIN = $($Env:USERDNSDOMAIN).tolower()

#convert decimal number to hexadeciam to reversed string usable for ipv6 reverselookup zone
function sep_fmakerevershex ($tmp_dec){
        $hexnr = '{0:X}' -f $tmp_dec
        $hexstr = $hexnr.ToString()
        $paddedstr = $hexstr.PadLeft(16, '0')
        return $($paddedstr[-1..-$paddedstr.Length] -join '.')
}

#adds static dns A en AAAA en PTR records
function sep_fverwerkstatic ($sep_tmp_basis){
    foreach ($SEP_RECORD in ${SMITH_STATIC}){
        $SMITH_NAAM = ${SEP_RECORD}.naam
        $SMITH_IPNR = ${SEP_RECORD}.ipnr
        
        write-host ">>> adding A- and PTR-record for ${SMITH_NAAM} @ ${SMITH_IPNR}"
        Add-DnsServerResourceRecordA -ZoneName ${SEP_USERDNSDOMAIN} -Name "${SMITH_NAAM}" -IPv4Address "${sep_tmp_basis}.${SMITH_IPNR}" -CreatePtr -AllowUpdateAny
        
        write-host ">>> adding AAAA-record for ${SMITH_NAAM} @ ${SMITH_IPNR}"
        Add-DnsServerResourceRecordAAAA -ZoneName ${SEP_USERDNSDOMAIN} -Name "${SMITH_NAAM}" -IPv6Address "2023:2023:2023:2023::${SMITH_IPNR}" -AllowUpdateAny
        
        write-host ">>> adding PTR-record for host ${SMITH_IPNR} @ ${SMITH_NAAM}"
        $tmp_name = sep_fmakerevershex "${SMITH_IPNR}"
        Add-DnsServerResourceRecordPtr -ZoneName "3.2.0.2.3.2.0.2.3.2.0.2.3.2.0.2.ip6.arpa" -Name "${tmp_name}" -PtrDomainName "${SMITH_NAAM}.$SEP_USERDNSDOMAIN"
    }
}

#adds cnames from csv file
function sep_fverwerkcname ($sep_tmp_zonename){
    foreach ($SEP_ALIAS in ${SMITH_CNAME}){
        $SMITH_name = ${SEP_ALIAS}.name
        $SMITH_hostnamealiasshort = ${SEP_ALIAS}.hostnamealiasshort
        write-host ">>> adding CNAME ${SMITH_name} pointing to ${SMITH_hostnamealiasshort}.${sep_tmp_zonename}"
        Add-DnsServerResourceRecordCName -Name "${SMITH_name}" -HostNameAlias "${SMITH_hostnamealiasshort}.${sep_tmp_zonename}" -ZoneName "${sep_tmp_zonename}"
    }
}

# MAIN
write-host "> making unsecure update possible (to be safe)"
Set-DnsServerPrimaryZone -Name "thematrix.local" -DynamicUpdate "NonSecureAndSecure"
write-host "> creating ipv4 reverse lookup zones subnets included"
$sep_ip = (get-NetIPAddress -AddressFamily IPv4 -InterfaceAlias Ethernet).IPAddress # 192.168.20.1
$sep_ip_zonder_host = ${sep_ip} -replace '\.\d+$'                                   # 192.168.20
$sep_ip_vlan = $sep_ip_zonder_host -replace '^\d+\.\d+\.'                           # 20
$sep_vlans = (${sep_ip_vlan},30,40)                                                 # (20,30,40)
foreach ($vlanid in ${sep_vlans}) {
    Add-DnsServerPrimaryZone -NetworkID "192.168.${vlanid}.0/24" -ReplicationScope "Forest" -DynamicUpdate NonsecureAndSecure
}

write-host "> creating ipv6 reverse lookup zone"
Add-DnsServerPrimaryZone -NetworkID "2023:2023:2023:2023::/64" -ReplicationScope "Forest" -DynamicUpdate NonsecureAndSecure
#creates 3.2.0.2.3.2.0.2.3.2.0.2.3.2.0.2.ip6.arpa

write-host "> reading csv: $SMITH_CSVSTATIC"
$SMITH_STATIC = Import-Csv "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\$SMITH_CSVSTATIC" -Delimiter ";"

write-host "> processing all lines in $SMITH_CSVSTATIC"
sep_fverwerkstatic ${sep_ip_zonder_host}

write-host "> reading csv: $SMITH_CSVCNAME"
$SMITH_CNAME = Import-Csv "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\$SMITH_CSVCNAME" -Delimiter ";"
sep_fverwerkcname $SEP_USERDNSDOMAIN

write-host "> adding MX-record manual?"
#Add-DnsServerResourceRecordMX -ZoneName "${SEP_USERDNSDOMAIN}" -Name "@" -MailExchange "neo.${SEP_USERDNSDOMAIN}" -Preference 10
#gaf problemen om neo toe te voegen, zat er zogezegd reeds in !

#signaal voor oproepend script om verder te gaan ...
write-host "> sending host a signal"
VBoxControl guestproperty set dns_finished y

# new line has a function