# Documentatie Opdracht 3.3: Domain Controller

## Deliverables

* Domain: thematrix.local
  * Met behulp van het de automatische installatiescripts, meer bepaald in smith_02_ad_feature.ps1, waarbij ${SMITH_DOM} de waarde thematrix.local heeft
```code
Install-ADDSForest -CreateDnsDelegation:$false -DatabasePath "C:\Windows\NTDS" -DomainMode "WinThreshold" -DomainName ${SMITH_DOM} -DomainNetbiosName ${SMITH_OLDDOM} -ForestMode "WinThreshold" -InstallDns:$true -LogPath "C:\Windows\NTDS" -NoRebootOnCompletion:$false -SysvolPath "C:\Windows\SYSVOL" -Force:$true -SafeModeAdministratorPassword ${SMITH_SECUREPASS}
```

* Vast IPv4-adres cfr. IP-adrestabel
  * Met behulp van het de automatische installatiescripts, meer bepaald in agentsmith_00_netwerk.ps1, waarbij de variabelen zijn bepaald door de keuzes welke door de uitvoerder werden gemaakt (en opgehaald uit een .csv bestand). Ipv6 werd uitgeschakeld.
```code
Get-NetAdapter | ForEach-Object { Disable-NetAdapterBinding -interfacealias $_.Name -ComponentID ms_tcpip6 }
New-NetIPAddress -InterfaceAlias ethernet -AddressFamily ipv4 -IPAddress $SMITH_IP -PrefixLength 24 -DefaultGateway $SMITH_GW
Set-DnsClientServerAddress -InterfaceAlias ethernet -ServerAddresses $SMITH_DNS
```

* Hostname: agentsmith
  * Met behulp van het de automatische installatiescripts, meer bepaald in 04_unattended.ps1, waarbij ${SEP_VMHOSTNAMEFQDN} ervoor zorgt dat de correcte hostname wordt ingesteld.
```code
vBoxManage unattended install ${SEP_VMNAAM} --iso ${SEP_VMISO} --image-index ${SEP_WHAT} --hostname ${SEP_VMHOSTNAMEFQDN} --user ${SEP_VMUSER} --password ${SEP_VMPASSWORD} --full-user-name ${SEP_VMFULLUSER} --country ${SEP_VMCOUNTRY} --locale ${SEP_VMLOCALE} --time-zone CET --install-additions --post-install-command='powershell Set-WinUserLanguageList -LanguageList nl-BE -Force && VBoxControl guestproperty set unattended_finished y && Shutdown /r /t 5'
```

* (VM met) OS: Windows Server 2019 CLI
  * In bovenstaand codeblok zorgen ${SEP_VMISO} en ${SEP_WHAT} ervoor dat de correcte versie van Windows Server wordt geïnstalleerd

* Herbruikbare, interactieve powershell scripts met variabelen
  * 00_winserver2019.ps1 runnen zorgt voor een interactieve installatie

* Domainstructuur cfr. opgave en automatisch geïmplementeerd via een powershellscript
  * Terug te vinden in smith_03_ad_objecten.ps1
```code
sep_fmakecontainers "${SEP_UITVOERDIR}\structuur.csv"

# Place computers in given csv in the correct container in the domain
function sep_fmakecomputers($tmp_csv){
    $SEP_COMPUTERS = Import-Csv "${tmp_csv}" -Delimiter ";"
    foreach ($SEP_COMPUTER in ${SEP_COMPUTERS}){
        [String]$SEP_COMPUTERHOST = ${SEP_COMPUTER}.host
        [String]$SEP_COMPUTEROU = ${SEP_COMPUTER}.ou
        [String]$SEP_COMPUTERDESCRIPTION = ${SEP_COMPUTER}.description
        [String]$SEP_COMPUTERPATHDN = ${SEP_COMPUTEROU} + ',' + ${SEP_ADDOMAINDN}
        if (Get-ADComputer -F { Name -eq ${SEP_COMPUTERHOST} }) {
            Write-Warning "> NOT adding ${SEP_COMPUTERHOST} to ${SEP_ADDOMAINDN} (allready present)"
        }
        else {
            write-host "> adding ${SEP_COMPUTERHOST} to ${SEP_ADDOMAINDN}"
            new-adcomputer `
                -Name ${SEP_COMPUTERHOST} `
                -Path ${SEP_COMPUTERPATHDN} `
                -Description ${SEP_COMPUTERDESCRIPTION}
        }
    }
}
```


* Domain users (acteurs en crewleden) via csv geïmporteerd via een powershellscript
```code
sep_fmakeusers "${SEP_UITVOERDIR}\users.csv"

# Add the users in the give csv to the domain
function sep_fmakeusers($tmp_csv){
    $SEP_USERS = Import-Csv "${tmp_csv}" -Delimiter ";"
    foreach ($SEP_USER in ${SEP_USERS}){
        [String]$SEP_FIRSTNAME = ${SEP_USER}.firstname
        [String]$SEP_LASTNAME = ${SEP_USER}.lastname
        [String]$SEP_SAM = sep_fmaaksam ${SEP_FIRSTNAME} ${SEP_LASTNAME}

        if (sep_fcontroleersam ${SEP_SAM}) {
            write-host "> adding ${SEP_SAM} to the domain"
            [String]$SEP_NAME = "${SEP_FIRSTNAME} ${SEP_LASTNAME}"
            [String]$SEP_DISPLAYNAME = "${SEP_FIRSTNAME} ${SEP_LASTNAME}"
            [String]$SEP_TITLE = ${SEP_USER}.title
            [String]$SEP_OU = ${SEP_USER}.ou
            [String]$SEP_USERPATHDN = ${SEP_OU} + ',' + ${SEP_ADDOMAINDN}
            [String]$SEP_PASS = sep_fmaakpass ${SEP_SAM}
        
           if (-not ${SEP_USER}.description) {
                [String]$SEP_DESCRIPTION = ""
            }
            else {
                [String]$SEP_DESCRIPTION  = ${SEP_USER}.description
            }
            
            if (-not ${SEP_USER}.middlename) {
                [String]$SEP_MIDDLENAME = ""
            }
            else {
                [String]$SEP_MIDDLENAME  = ${SEP_USER}.middlename
            }
        
            [String]$SEP_DEPARTMENT = (Get-ADOrganizationalUnit -Identity "${SEP_USERPATHDN}").name
            [String]$tmp_profpath= "\\${SEP_COMPUTERNAME}\UserProfiles\${SEP_SAM}"
            [String]$tmp_foldpath= "\\${SEP_COMPUTERNAME}\UserFolders\${SEP_SAM}"
            
            New-ADUser `
                -Name "${SEP_NAME}" `
                -givenname "${SEP_FIRSTNAME}" `
                -Surname "${SEP_LASTNAME}" `
                -Initials "${SEP_MIDDLENAME}" `
                -DisplayName "${SEP_DISPLAYNAME}" `
                -SamAccountName "${SEP_SAM}" `
                -UserPrincipalName "${SEP_SAM}@$SEP_USERDNSDOMAIN" ` `
                -Path ${SEP_USERPATHDN} `
                -Enabled $True `
                -AccountPassword (ConvertTo-SecureString ${SEP_PASS} -AsPlainText -Force) `
                -ChangePasswordAtLogon $False `
                -Title "${SEP_TITLE}" `
                -Description "${SEP_DESCRIPTION}" `
                -Department "${SEP_DEPARTMENT}" `
                -ProfilePath "${tmp_profpath}" `
               -HomeDirectory "${tmp_foldpath}" `
                -HomeDrive "Y:" 
        }
        else {
            write-warning "> NOT adding ${SEP_SAM} to ${SEP_ADDOMAINDN} (allready present)"
        }
    }
}

```

* Domain PC's (minstens 2 in elke OU) via csv geïmporteerd via een powershellscript
```code
sep_fmakecomputers "${SEP_UITVOERDIR}\computers.csv"

# Place computers in given csv in the correct container in the domain
function sep_fmakecomputers($tmp_csv){
    $SEP_COMPUTERS = Import-Csv "${tmp_csv}" -Delimiter ";"
    foreach ($SEP_COMPUTER in ${SEP_COMPUTERS}){
        [String]$SEP_COMPUTERHOST = ${SEP_COMPUTER}.host
        [String]$SEP_COMPUTEROU = ${SEP_COMPUTER}.ou
        [String]$SEP_COMPUTERDESCRIPTION = ${SEP_COMPUTER}.description
        [String]$SEP_COMPUTERPATHDN = ${SEP_COMPUTEROU} + ',' + ${SEP_ADDOMAINDN}
        if (Get-ADComputer -F { Name -eq ${SEP_COMPUTERHOST} }) {
            Write-Warning "> NOT adding ${SEP_COMPUTERHOST} to ${SEP_ADDOMAINDN} (allready present)"
        }
        else {
            write-host "> adding ${SEP_COMPUTERHOST} to ${SEP_ADDOMAINDN}"
            new-adcomputer `
                -Name ${SEP_COMPUTERHOST} `
                -Path ${SEP_COMPUTERPATHDN} `
                -Description ${SEP_COMPUTERDESCRIPTION}
        }
    }
}
```

* Server via RSAT te configureren vanop de DirectorPC
  * Op de Server dienen hiervoor geen extra maatregelen te worden getroffen. Op de DirectorPc wordt automatisch de juiste softwareupdate geïnstalleerd zodat als Domain Administrator vanop afstand kan worden geconfigureerd.

* Authenticatie van gebruikers gebeurt via de Domain Controller
  * Er werden op de workstations geen extra gebruikers aangemaakt dan de initiële Administrator, dus iedereen dient aan te loggen met de een in het domein aangemaakte gebruiker.

* Cast kan enkel inloggen in de cast-Pc’s
  * Op twee manieren geïmplementeerd, een eerste bij het aanmaken van de users:
```code
# maakt van de opgegeven groep een lijst van komma seperated computers
function sep_geeflijsttoegelatenpcs {
    param($tmp_ouvanusers)

    switch("$tmp_ouvanusers") {
        "Cast" {
            $tmp_pcs = Get-ADComputer -filter * -SearchBase "OU=Cast,OU=PCs,OU=DomainWorkstations,${SEP_ADDOMAINDN}" -SearchScope OneLevel | ForEach-Object  {$_.Name}
            break            
        }
        "Crew" {
            $tmp_pcs = Get-ADComputer -filter * -SearchBase "OU=Crew,OU=PCs,OU=DomainWorkstations,${SEP_ADDOMAINDN}" -SearchScope OneLevel | ForEach-Object  {$_.Name}
            break
        }
        "Directors" {
            $tmp_pcs = Get-ADComputer -filter * -SearchBase "OU=PCs,OU=DomainWorkstations,${SEP_ADDOMAINDN}" | ForEach-Object  {$_.Name}
            break
        }
        default {
            Write-Warning "TODO : niet voorzien: ongeldige waarde ingevuld in parameter tmp_ouvanuser van function sep_geeflijsttoegelatenpcs: ${tmp_ouvanuser}"
            break
        }
    }
    $tmp_pcs_met_kommas = $tmp_pcs -join ","
    return $tmp_pcs_met_kommas
}

# vult de lijst van toegelaten computers van tmp_sam met alle computers die behoren tot tmp_groep 
function sep_fpaslogonpcsaan {
    param($tmp_sam,$tmp_groep)

    $tmp_pcskommas = sep_geeflijsttoegelatenpcs $tmp_groep
    $tmp_user = Get-ADUser -Identity ${tmp_sam}
    $tmp_adsi = [ADSI]"LDAP://$(${tmp_user}.DistinguishedName)"
    $tmp_adsi.Put("userWorkstations", $tmp_pcskommas)
    $tmp_adsi.setinfo()
}

sep_fpaslogonpcsaan ${SEP_SAM} "Cast"
```
  * Ook in smith_05_gpo.ps1 is iets voorzien, maar dit moet nog via de GUI aangepast worden (Edit en Define de GPO onder Group Policy Objects: Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment > Allow log on locally ; Voeg Administrators, THEMATRIX\DirectorsSG en THEMATRIX\CastSG toe):
```code
write-host ">>> Cast kan enkel inloggen in de cast-Pcs"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
# mind you, via de user settings is deze deliverable ook reeds afgevinkt
$tmp_gponame = "sep_cast_inloggen_op_castpcs"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=Cast,DomainWorkstations,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_ou}
```

* Crew kan enkel inloggen op de crew-Pc’s
  * gelijkaardig als hierboven

* Directors kunnen overal inloggen
  * gelijkaardig als hierboven

* Elke user krijgt automatisch zijn eigen persoonlijke shared folder
  * wordt aangemaakt bij aanmaken van user
  * met icacls worden permissies goed gezet
```code
$tmp_icaclspath = "S:\UserData\Folders\${SEP_SAM}"
New-Item -ItemType Directory -Path "${tmp_icaclspath}" > $null

$tmp_grant = "/grant:r"
$tmp_inherit = "/inheritance:d"
$tmp_user = "${SEP_USERDOMAIN}\${SEP_SAM}"
icacls ${tmp_icaclspath} ${tmp_inherit} ${tmp_grant} ${tmp_user}:`(OI`)`(CI`)F > $null

$tmp_remove = "/remove:g"
$tmp_users = "BUILTIN\Users"
icacls ${tmp_icaclspath} ${tmp_remove} ${tmp_users} > $null
```

* Een shared folder voor de cast en een groep om de toegang tot die shared folder te regelen
  * De folder werd aangemaakt op de S-schijf:
```code
mkdir S:\Shared
mkdir S:\Shared\CAST
New-SmbShare -Name Cast -Path "S:\Shared\CAST\" -FullAccess "Everyone" -Description "Gedeelde map voor de Cast"
```
  * De user wordt bij aanmaken in de correcte groep geplaatst:
```code
write-host ">>> adding ${SEP_SAM} to security group CastSG"
Add-ADGroupMember -Identity "CastSG" -Members "${SEP_SAM}"
```
  * De permissies worden als volgt goed gezet voor deze map:
```code
function sep_fsettingshared(){
    
    $sep_shares = ("cast","crew")
    $sep_basefolder = "S:\Shared\"
    foreach ($map in $sep_shares) {
        [String]$sep_volpad = $sep_basefolder + $map 
        
        $tmp_grant = "/grant:r"
        $tmp_inherit = "/inheritance:d"
        icacls ${sep_volpad} ${tmp_inherit} ${tmp_grant} ${map}SG:`(OI`)`(CI`)F > $null

        $tmp_remove = "/remove:g"
        $tmp_users = "BUILTIN\Users"
        icacls ${sep_volpad} ${tmp_remove} ${tmp_users} > $null
    }
}
```

* Een shared folder voor de crew en een groep om de toegang tot die shared folder te regelen
  * zie hierboven, gelijkaardig

* Beleidsregel op gebruikersniveau: Enkel directors hebben toegang tot het control panel
  * GPO werd in code aangmaakt, maar dient nog met GUI te worden ingesteld
```code
write-host "> Beleidsregel op gebruikersniveau: Enkel directors hebben toegang tot het control panel"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou's, de rest gebeurt in gui via DirectorPc, zie instructies
$tmp_gponame = "sep_controlpanel_domainusers_denied"
new-gpo -name ${tmp_gponame}
$tmp_ou_denied = "OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_ou_denied}
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
$tmp_gponame = "sep_controlpanel_directors_allowed"
new-gpo -name ${tmp_gponame}
$tmp_allowed = "OU=Directors,OU=Crew,OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_allowed}
```

* Beleidsregel op gebruikersniveau: Niemand kan werkbalken (toolbars) toevoegen aan de taakbalk
  * gelijkaardig

* Beleidsregel op gebruikersniveau: De cast heeft geen toegang tot de eigenschappen van de netwerkadapters
  * gelijkaardig

* DNS-server welke alle queries binnen het domein “thematrix.local” beantwooord
  * Komt mee bij installeren van ADDS. Ip wordt door DHCP aan clients doorgegeven.

* DNS-server forward de queries voor andere domeinen naar een geschikte DNS-server
  * Doordat initieel bij het instellen van DNS van agentsmith 8.8.8.8 werd meegegeven, werd deze automatisch als forwarder ingesteld.

* Zonebestand met A-records (IPv4) voor elke host binnen het domein
* Zonebestand met AAAA-records (IPv6) voor elke host binnen het domein
  * script_04_dns.ps1
  * de AAAA-records staan in hetzelfde bestand als de A-records
  * door de dynamische updates verdwijnen ze wel wanneer de hosts zich aanmelden zonder ipv6
```code
write-host "> reading csv: $SMITH_CSVSTATIC"
$SMITH_STATIC = Import-Csv "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\$SMITH_CSVSTATIC" -Delimiter ";"

write-host "> processing all lines in $SMITH_CSVSTATIC"
sep_fverwerkstatic ${sep_ip_zonder_host}

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
```

* Zonebestanden met PTR-records (IPv4 en IPv6) voor elke host binnen het domein
  * Worden aangemaakt in smith_04_dns.ps1
```code
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

```

* Geschikte CNAME-records voor elke host om de functie van een server aan te duiden
  * ingelezen vanuit een .csv
```code
write-host "> reading csv: $SMITH_CSVCNAME"
$SMITH_CNAME = Import-Csv "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\$SMITH_CSVCNAME" -Delimiter ";"
sep_fverwerkcname $SEP_USERDNSDOMAIN

#adds cnames from csv file
function sep_fverwerkcname ($sep_tmp_zonename){
    foreach ($SEP_ALIAS in ${SMITH_CNAME}){
        $SMITH_name = ${SEP_ALIAS}.name
        $SMITH_hostnamealiasshort = ${SEP_ALIAS}.hostnamealiasshort
        write-host ">>> adding CNAME ${SMITH_name} pointing to ${SMITH_hostnamealiasshort}.${sep_tmp_zonename}"
        Add-DnsServerResourceRecordCName -Name "${SMITH_name}" -HostNameAlias "${SMITH_hostnamealiasshort}.${sep_tmp_zonename}" -ZoneName "${sep_tmp_zonename}"
    }
}

```

* Aanvullende recordes waar nuttig/nodig
  * TODO: Een MX-record voor de exchange server
