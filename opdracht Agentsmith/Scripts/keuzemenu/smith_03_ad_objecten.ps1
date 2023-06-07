# smith_03_ad_objecten.ps1
# structuur.csv
# computers.csv
# users.csv

$SEP_UITVOERDIR= Split-Path $MyInvocation.MyCommand.Path -Parent
$SEP_ADDOMAINDN = (get-addomain).distinguishedname # "DC=thematrix,DC=local"
$SEP_USERPASS = "22Student23"
$SEP_COMPUTERNAME= $($Env:computername).tolower() #  agentsmith
$SEP_USERDNSDOMAIN = $($Env:USERdnsDOMAIn).tolower() # thematrix.local
$SEP_USERDOMAIN = $Env:USERDOMAIN # THEMATRIX

#hulpfunctie om eerste 3 (default) letters van een string terug te geven (of minder)
function sep_eerste([String] $inputString, [int] $numberOfChars = 3) {
    return $inputString.substring(0, @($inputString.length,$numberOfChars)[$inputString.length -ge $numberOfChars]) 
}

#hulpfunctie om sam te maken met voor en achternaam
function sep_fmaaksam([String]$voor, [String]$achter) {
    return $(sep_eerste $voor 3).toLower() + "_" + $(sep_eerste $achter 3).toLower()
}

#hulpfunctie om te controleren of sam lang genoeg is en nog niet bestaat
function sep_fcontroleersam([String]$sam){
if ($sam.length -le 6) { write-warning "> NOT adding ${SEP_SAM} to ${SEP_ADDOMAINDN} (SamAccountName too short)"}
if ([bool](Get-ADUser -Filter { SamAccountName -eq $sam })) { write-warning "> NOT adding ${SEP_SAM} to ${SEP_ADDOMAINDN} (SamAccountName (${sam}) allready present)"}
return ($sam.length -gt 6) -and (-not [bool](Get-ADUser -Filter { SamAccountName -eq $sam }))
}

# TODO : origineel was dit een hulpfunctie om passwoord te genereren, nu hard coded (complexity issues buiten scope)
function sep_fmaakpass([String]$sam){
    #return $sam.substring(0,1).toUpper() + $sam.substring(1,2) + '&' + $sam.substring(4,1).toUpper() + $sam.substring(5,2)
    #mooi concept maar werkte niet voor Joe omdat die z'n naam in een dictionary stond  
    return ${SEP_USERPASS}
}

# Set domain structure as defined in given csv
function sep_fmakecontainers($tmp_csv){
    $SEP_STRUCTUUR = Import-Csv "${tmp_csv}" -Delimiter ";"
    foreach ($SEP_CONTAINER in ${SEP_STRUCTUUR}){
        [String]$SEP_CONTAINERNAAM = ${SEP_CONTAINER}.Containernaam;
        [String]$SEP_DELIM = ","
        if (-not ${SEP_CONTAINER}.Prepath) {
            $SEP_DELIM = ""
        }
        [String]$SEP_VOLLEDIGPATH = ${SEP_CONTAINER}.Prepath + ${SEP_DELIM} + ${SEP_ADDOMAINDN}
        [String]$SEP_DN="OU=${SEP_CONTAINERNAAM},${SEP_VOLLEDIGPATH}"
        if (Get-ADOrganizationalUnit -F {DistinguishedName -eq ${SEP_DN}}) {
            Write-Warning "> NOT adding ${SEP_CONTAINERNAAM} to ${SEP_ADDOMAINDN} (allready present)"
        }
        else {
            write-host "> adding ${SEP_CONTAINERNAAM} to ${SEP_VOLLEDIGPATH}"
            New-ADOrganizationalUnit -Name ${SEP_CONTAINERNAAM} -ProtectedFromAccidentalDeletion $false -Path ${SEP_VOLLEDIGPATH}
            if (${SEP_CONTAINER}.maakgroep) {
                write-host ">>> adding a Security Group ${SEP_CONTAINERNAAM} in OU=${SEP_CONTAINERNAAM},${SEP_VOLLEDIGPATH}"
                New-ADGroup -name "${SEP_CONTAINERNAAM}SG" -path "OU=${SEP_CONTAINERNAAM},${SEP_VOLLEDIGPATH}" -Description "Security Group to manage ${SEP_CONTAINERNAAM} shares" -GroupScope Global
            }
        }
    }
}

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

            $tmp_icaclspath = "S:\UserData\Folders\${SEP_SAM}"
            New-Item -ItemType Directory -Path "${tmp_icaclspath}" > $null
            
            $tmp_grant = "/grant:r"
            $tmp_inherit = "/inheritance:d"
            $tmp_user = "${SEP_USERDOMAIN}\${SEP_SAM}"
            icacls ${tmp_icaclspath} ${tmp_inherit} ${tmp_grant} ${tmp_user}:`(OI`)`(CI`)F > $null

            $tmp_remove = "/remove:g"
            $tmp_users = "BUILTIN\Users"
            icacls ${tmp_icaclspath} ${tmp_remove} ${tmp_users} > $null
            
            if ((${SEP_USERPATHDN}).Contains(",OU=DomainUsers,")) {
                if ((${SEP_USERPATHDN}).Contains("OU=Cast,")) {
                    write-host ">>> adding ${SEP_SAM} to security group CastSG"
                    Add-ADGroupMember -Identity "CastSG" -Members "${SEP_SAM}"
                    # fix for logon to specific pcs:
                    sep_fpaslogonpcsaan ${SEP_SAM} "Cast"
                }
                else {
                    write-host ">>> adding ${SEP_SAM} to security group CrewSG"
                    Add-ADGroupMember -Identity "CrewSG" -Members "${SEP_SAM}"
                    # fix for logon to specific pcs:
                    sep_fpaslogonpcsaan ${SEP_SAM} "Crew"
                    if ((${SEP_USERPATHDN}).Contains("OU=Directors,")) {
                        write-host ">>> adding ${SEP_SAM} to security group CrewSG"
                        Add-ADGroupMember -Identity "DirectorsSG" -Members "${SEP_SAM}"
                        # fix for logon to specific pcs:
                        sep_fpaslogonpcsaan ${SEP_SAM} "Directors"
                    }
                }
           }  
        }
        else {
            write-warning "> NOT adding ${SEP_SAM} to ${SEP_ADDOMAINDN} (allready present)"
        }
    }
}

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
    
    [String]$sep_wall = "S:\Shared\WALLPAPER"

    $tmp_grant = "/grant:r"
    $tmp_inherit = "/inheritance:d"
    icacls ${sep_wall} ${tmp_inherit} ${tmp_grant} Everyone:`(OI`)`(CI`)`(RX`) > $null

    $tmp_remove = "/remove:g"
    $tmp_users = "BUILTIN\Users"
    icacls ${sep_wall} ${tmp_remove} ${tmp_users} > $null
}


#MAIN
write-host ""
write-host "*******************************************************************************************"
write-host "* Importing AD-Structure from structuur.csv                                               *"
write-host "*******************************************************************************************"
write-host ""
sep_fmakecontainers "${SEP_UITVOERDIR}\structuur.csv"
VBoxControl guestproperty set ad_objecten_01 y

write-host ""
write-host "*******************************************************************************************"
write-host "* Importing the computers from computers.csv                                              *"
write-host "*******************************************************************************************"
write-host ""
sep_fmakecomputers "${SEP_UITVOERDIR}\computers.csv"
VBoxControl guestproperty set ad_objecten_02 y

write-host ""
write-host "*******************************************************************************************"
write-host "* Importing the users from users.csv                                                      *"
write-host "*******************************************************************************************"
write-host ""
sep_fmakeusers "${SEP_UITVOERDIR}\users.csv"
VBoxControl guestproperty set ad_objecten_03 y

write-host ""
write-host "*******************************************************************************************"
write-host "* Setting permissions for shared directories                                              *"
write-host "*******************************************************************************************"
write-host ""
sep_fsettingshared

# alert the calling script it can continue
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5

VBoxControl guestproperty set ad_objecten_04 y #temporarely without a function, seems to hang ...

# new line has a function!
