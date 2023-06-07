#### AD DC #####

Import-Module ActiveDirectory

#Aanmaken OU structuur projectbrochure

New-ADOrganizationalUnit -Name "DomainWorkstations" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "PCs" -ProtectedFromAccidentalDeletion $false -Path "OU=Domainworkstations,DC=TheMatrix,DC=Local"
New-ADOrganizationalUnit -Name "Servers" -ProtectedFromAccidentalDeletion $false -Path "OU=DomainWorkstations,DC=TheMatrix,DC=Local"
New-ADOrganizationalUnit -Name "Cast" -ProtectedFromAccidentalDeletion $false -Path "OU=PCs,OU=DomainWorkstations,DC=TheMatrix,DC=Local"
New-ADOrganizationalUnit -Name "Crew" -ProtectedFromAccidentalDeletion $false -Path "OU=PCs,OU=DomainWorkstations,DC=TheMatrix,DC=Local"
New-ADOrganizationalUnit -Name "Directors" -ProtectedFromAccidentalDeletion $false -Path "OU=Crew,OU=PCs,OU=DomainWorkstations,DC=TheMatrix,DC=Local"

New-ADOrganizationalUnit -Name "DomainUsers" -ProtectedFromAccidentalDeletion $false
New-ADOrganizationalUnit -Name "Cast" -ProtectedFromAccidentalDeletion $false -Path "OU=DomainUsers,DC=TheMatrix,DC=Local"
New-ADOrganizationalUnit -Name "Crew" -ProtectedFromAccidentalDeletion $false -Path "OU=DomainUsers,DC=TheMatrix,DC=Local"
New-ADOrganizationalUnit -Name "Directors" -ProtectedFromAccidentalDeletion $false -Path "OU=Crew,OU=DomainUsers,DC=TheMatrix,DC=Local"
New-ADOrganizationalUnit -Name "Producers" -ProtectedFromAccidentalDeletion $false -Path "OU=Crew,OU=DomainUsers,DC=TheMatrix,DC=Local"

#Variable met CSV data
$ADUsers = Import-Csv C:\Windows\Temp\users.csv -Delimiter ";"

#domein variabele
$domein = "TheMatrix.local"


#Onderverdeling velden over verschillende variabelen
#Voor elke user of computer wordt de data verdeeld

foreach ($User in $ADUsers){
$firstname = $User.Firstname
$lastname = $User.Lastname
$initials = $User.Initials
$username = $User.Username
$email = $User.Email
$password = $user.Password
$deparment = $User.Department
$OU = $User.OU


#Volgende stuk maakt de gebruikers/computers aan per OU. Op basis van de naam van de OU wordt bepaald of het een server of user is.

if ($OU.Contains("OU=DomainUsers")){
    if (Get-ADUser -F { SamAccountName -eq $username}) {
        Write-Warning "User already exists with username $username"
    }
    Else {
        New-ADUser `
            -SamAccountName $username `
            -UserPrincipalName "$username@$domein" `
            -Name "$firstname $lastname" `
            -GivenName $firstname `
            -Surname $lastname `
            -Displayname "$firstname, $lastname" `
            -Initials $initials `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True `
            -EmailAddress $email `
            -Department $deparment `
            -Path $OU `
            -Enabled $true

        Write-Host "User created with username $username"
         }
    } 
ElseIf ($OU.Contains("OU=DomainWorkStations")){
     if (Get-ADComputer -F { SamAccountName -eq $username}) {
            Write-Warning "Computer already exists with name $username"
     }
     Else {
        New-ADComputer `
            -SamAccountName $username `
            -Name $username `
            -DisplayName $username `
            -Path $OU `
            -AccountPassword (ConvertTo-SecureString $password -AsPlainText -Force) -ChangePasswordAtLogon $True `
            -Enabled $true

        Write-Host "Computer created with name $username"
     }

    }

}