# Testplan Opdracht Email: (Exchange server)

(Een testplan is een *exacte* procedure van de handelingen die je moet uitvoeren om aan te tonen dat de opdracht volledig volbracht is en dat aan alle specificaties voldaan is. Een teamlid moet aan de hand van deze procedure in staat zijn om de tests uit te voeren en erover te rapporteren (zie testrapport). Geef bij elke stap het verwachte resultaat en hoe je kan verifiëren of dat resultaat ook behaald is. Kies zelf de structuur: genummerde lijst, tabel, secties, ... Verwijder deze uitleg als het plan af is.)
**Domaincontroller en Exchange moeten aanstaan tijdens het volledige proces !**

# Deel Exchange server

1. Login to the exchange server client (neo)
    -> User: "TheMatrix\Administrator", Password : 22Admin23
2. Execute the following command in cmd:
    -> Ping 192.168.20.1 
    Ping the domaincontroller to ensure a network connection has been established.
3. Check that the firewall has been disabled:
    -> Netsh firewall Show State

    Profile = Standard
    Operational mode = Disable
    Exception mode = Enable
    Multicast/broadcast response mode = Enable
    Notification mode = Disable
    Group policy version = Windows Defender Firewall
    Remote admin mode = Disable

4. Check if the network settings are correct
    -> ipconfig /all

    Ipv4Address = 192.168.20.3
    Gateway = 192.168.20.254
    DNS = 192.168.20.1

5. Check if all the activated accounts of AD users can be found
    -> Powershell Get-ADUser -LDAPFilter '(!userAccountControl:1.2.840.113556.1.4.803:=2)'

For the next tests Exchange commands need to be loaded in. Open a powershell prompt using cmd
    -> powershell
    -> $Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://neo.thematrix.local/PowerShell/ -Authentication Kerberos
    -> Import-PSSession $Session -DisableNameChecking

6. Check if all active users in the AD have a mailbox
    -> Get-Mailbox

7. Check if the Mail Transport Service and Malware Agent is enabled 
    -> Get-TransportAgent

8. Check if all active users have a mailbox
    -> Get-User -RecipientTypeDetails User -Filter "UserPrincipalName -ne `$null" -Resultsize Unlimited
        This should give you nothing!

# Deel Client PC domain (DirectorPC)

1. Login using the DirectorPC VM with the following credentials on https://192.168.20.3/owa.
    -> User: "TheMatrix\kea_ree", Password: 22User23

2. Login using the windows 10 mail application with the following credentials on https://192.168.20.3/owa.
    -> Email: kea_ree@TheMatrix.local, Password: 22User23
3. Create a test e-mail and send it to Lana Wachowski
    -> Click new email
    -> Fill in: Lan_wac@TheMatrix.local
    -> Fill in random test text
    -> Send email
    -> Wait 1min (to ensure the email has been send and not stuck in the outbox)

4. Log out of the user account Keanu Reeves
    -> Start -> User -> Log off

5. Login using the DirectorPC VM with the following credentials on https://192.168.20.3/owa.
    -> User: "TheMatrix\Lan_wac", Password: 22User23

6. Login using the windows 10 mail application with the following credentials on https://192.168.20.3/owa.
    -> Email: Lan_wac@TheMatrix.local, Password: 22User23

7. Check your inbox for received emails
    -> The test email from Keanu Reeves should be in your inbox.


Auteur(s) testplan: Stein / Lukas


