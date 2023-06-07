# Testplan Role Active Directory Domain Services (AD DS) installed on server

(Een testplan is een *exacte* procedure van de handelingen die je moet uitvoeren om aan te tonen dat de opdracht volledig volbracht is en dat aan alle specificaties voldaan is. Een teamlid moet aan de hand van deze procedure in staat zijn om de tests uit te voeren en erover te rapporteren (zie testrapport). Geef bij elke stap het verwachte resultaat en hoe je kan verifiëren of dat resultaat ook behaald is. Kies zelf de structuur: genummerde lijst, tabel, secties, ... Verwijder deze uitleg als het plan af is.)
1. Login to the server 
2. Execute the following command:
```powershell
    Get-WindowsFeature -Name AD-Domain-Services
```
When the role AD DS is installed on the server , the commandand will output the install state "Installed".

3. Get the list of AD-users from the server:
```
Get-ADUser -Filter *
```


Auteur(s) testplan: Naoufal


