# Testplan server promoted to a domain controller
Alle testen op de domain controller zullen vanop afstand uigevoerd worden van op computer "DirectorPC" met account "TBD"
De manuele acties kunnen ook rechtreeks op de Domain controller zelf uitgevoerd worden 
## Manueel via powershell
1. Login als "TBD" op computer met hostname "DirectorPC"
2. Open Winows PowerShell als administrator.
3. Geef de volgende commando in om te zien of de domain controller geconfigureerd is met hostname "agentsmith",deel uitmaakt van domein"thematrix.local" en IP "192.168.20.2" heeft:
```powershell
    "Resolve-DnsName -Name "agentsmith"
```
Output van het commando moet de waarde "agentsmith.thematrix.local" voor Name geven en "192.168.20.1" voor IPAddress

4. Voer de volgende commando in om te controlleren of de server naar een domain controller gepromoveerd is:
```powershell
   Invoke-Command -ComputerName "agentsmith" -ScriptBlock { (Get-WmiObject Win32_ComputerSystem).DomainRole -ge 4}
```
De output zal true geven wanneer agentsmith een domain controller is

5. agensmith moet zich eveneens bevinden in organizational unit (ou) Servers om volledig geconfigureerd te zijn, dit kan geconrolleerd worden via:
```powershell
   Invoke-Command -ComputerName "agentsmith" -ScriptBlock {Get-ADOrganizationalUnit -Filter 'Name -eq "Servers"' | (Get-ADComputer "agentsmith").DistinguishedName}
```
Je zou de volgende output moeten zien: "CN=agentsmith,OU=Servers,OU=Workstations,DC=thematrix,DC=local

## Via script
1. Ga naar "C:\Users\Administrator\Downloads"
2. voer bestand testDC.ps1 als administrator
   


Auteur(s) testplan: Naoufal Thabet

