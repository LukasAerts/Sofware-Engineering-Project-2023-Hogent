#Variable met CSV data
$ADUsers = Import-Csv C:\Users\Administrator\Downloads\users.csv -Delimiter ";"

#domein variabele
$domein = "TheMatrix.local"


#Sessie aanmaken voor het verkrijgen van Exchange commands
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://neo.thematrix.local/PowerShell/ -Authentication Kerberos
Import-PSSession $Session -DisableNameChecking

#Aanmaken van mailbox voor elke user
Get-User -RecipientTypeDetails User -Filter "UserPrincipalName -ne `$null" -ResultSize unlimited | Enable-Mailbox
