# Testplan 3.3: Domain Controller
Auteur : Clemmens Benny

## Benodigdheden:
* Volgdende draaiende virtuele machines:
  * Agentsmith ([instucties](agentsmith_instructies.md))
  * DirectorPC ([instucties](../Windows10/windows10_instructies.md))
  * PCCrew1 ([instucties](../Windows10/windows10_instructies.md))
  * PCCast1 ([instucties](../Windows10/windows10_instructies.md))
* De geconfigureerde netwerkinfrastructuur (of een switch in testscenario)
* Credentials (user / password):
  * domain admin: THEMATRIX\Adminstrator / 22Admin23
  * director: THEMATRIX\lil_wac / 22Student23
  * cast : THEMATRIX\kea_ree / 22Student23
  * cast : THEMATRIX\car_mos / 22Student23
  * crew : THEMATRIX\tom_bar / 22Student23

## Opmerking:
* Er wordt van uit gegaan dat de machines zijn opgezet volgens de beschikbare instructies
* Mogelijks moeten voor het uittesten van deliverables in een andere omgeving dan het netwerklokaal andere keuzes worden gemaakt bij opzetten van de machines.
* Soms is het mogelijk een deliverable op meerdere manieren te testen. De keuze ligt bij de uitvoerder.
* Om de instucties niet te langdradig te maken wordt afgekort :
  * PS C:\Users\Adminstrator> uit te voeren in Powershell rechtstreeks op de Domain Controller

## Deliverables:

* Domain: thematrix.local
* Vast IPv4-adres cfr. IP-adrestabel
* Hostname: agentsmith
* (VM met) OS: Windows Server 2019 CLI
* Herbruikbare, interactieve powershell scripts met variabelen
* Domainstructuur cfr. opgave en automatisch geïmplementeerd via een powershellscript
* Domain users (acteurs en crewleden) via csv geïmporteerd via een powershellscript
* Domain PC's (minstens 2 in elke OU) via csv geïmporteerd via een powershellscript
* Server via RSAT te configureren vanop de DirectorPC
* Authenticatie van gebruikers gebeurt via de Domain Controller
* Cast kan enkel inloggen in de cast-Pc’s
* Crew kan enkel inloggen op de crew-Pc’s
* Directors kunnen overal inloggen
* Elke user krijgt automatisch zijn eigen persoonlijke shared folder
* Een shared folder voor de cast en een groep om de toegang tot die shared folder te regelen
* Een shared folder voor de crew en een groep om de toegang tot die shared folder te regelen
* Beleidsregel op gebruikersniveau: Enkel directors hebben toegang tot het control panel
* Beleidsregel op gebruikersniveau: Niemand kan werkbalken (toolbars) toevoegen aan de taakbalk
* Beleidsregel op gebruikersniveau: De cast heeft geen toegang tot de eigenschappen van de netwerkadapters
* DNS-server welke alle queries binnen het domein “thematrix.local” beantwooord
* DNS-server forward de queries voor andere domeinen naar een geschikte DNS-server
* Zonebestand met A-records (IPv4) voor elke host binnen het domein
* Zonebestand met AAAA-records (IPv6) voor elke host binnen het domein
* Zonebestanden met PTR-records (IPv4 en IPv6) voor elke host binnen het domein
* Geschikte CNAME-records voor elke host om de functie van een server aan te duiden
* Aanvullende recordes waar nuttig/nodig
* Testplan met exacte procedures
* Testrapport

## Testen:

* Domain: thematrix.local
  * PS C:\Users\Adminstrator> ``` (Get-WmiObject Win32_ComputerSystem).Domain ```
  * PS C:\Users\Adminstrator> ``` (Get-ADDomain).DistinguishedName ```

  ***verwacht***:  thematrix.local / "DC=thematrix,DC=local"


* Vast IPv4-adres cfr. IP-adrestabel
  * PS C:\Users\Adminstrator> ``` ipconfig /all ```

  ***verwacht***: ip:192.168.20.1/24 gw:192.168.20.254 dns:127.0.0.1 search:thematrix.local


* Hostname: agentsmith
  * PS C:\Users\Adminstrator> ``` [System.Net.Dns]::GetHostName() ```

  ***verwacht***: agentsmith


* (VM met) OS: Windows Server 2019 CLI
  * PS C:\Users\Adminstrator> ``` (Get-WmiObject Win32_OperatingSystem).Caption ```

  ***verwacht***: Microsoft Windows Server 2019 Standard


* Herbruikbare, interactieve powershell scripts met variabelen
  * check de code in de volledige map keuzemenu

  ***verwacht***: ruim voldoende, om niet te zeggen zeer goed :)


* Domainstructuur cfr. opgave en automatisch geïmplementeerd via een powershellscript
  * check de code in smith_03_ad_objecten.ps1:

  ***verwacht***: function sep_fmakecontainers($tmp_csv) voldoet aan deze eis


* Domain users (acteurs en crewleden) via csv geïmporteerd via een powershellscript
  * check de code in smith_03_ad_objecten.ps1: 

  ***verwacht***: function sep_fmakeusers($tmp_csv) voldoet aan deze eis


* Domain PC's (minstens 2 in elke OU) via csv geïmporteerd via een powershellscript
  * check de code in smith_03_ad_objecten.ps1

  ***verwacht***: function sep_fmakecomputers($tmp_csv) voldoet aan deze eis


* Server via RSAT te configureren vanop de DirectorPC
  * Log in als THEMATRIX\Adminstrator
  * Configurereer met behulp van
    * Server Manager
    * Active Directory Uqers and Computers
    * DNS
    * ...

  ***verwacht***: De Server is vanop afstand te configureren


* Authenticatie van gebruikers gebeurt via de Domain Controller
  * Log in op een workstation naar keuze, bij voorkeur als .\Administrator
  * Run : op een pc lusrmgr.msc

  ***verwacht***: er zijn geen lokale gebruikers


* Cast kan enkel inloggen in de cast-Pc’s
  * Probeer in te loggen als kea_ree op PCCrew1
  * Probeer in te loggen als kea_ree op PCCast1
  * Probeer in te loggen als kea_ree op DirectoPC

  ***verwacht***: Acteur Keanu Reeves kan enkel op PCCast1 onloggen


* Crew kan enkel inloggen op de crew-Pc’s
  * Probeer in te loggen als ton_bar op PCCrew1
  * Probeer in te loggen als ton_bar op PCCast1
  * Probeer in te loggen als ton_bar op DirectoPC


  ***verwacht***: Enkel op PCCrew kan Tony Bardolph, uit de Art Department, inloggen


* Directors kunnen overal inloggen
  * Probeer in te loggen als lan_wac op PCCrew1
  * Probeer in te loggen als lan_wac op PCCast1
  * Probeer in te loggen als lan_wac op DirectoPC
  
  ***verwacht***: Director Lana Wachowski kan overal inloggen


* Elke user krijgt automatisch zijn eigen persoonlijke shared folder
  * Log in als ton_bar op PCCrew1
  * Open een verkenner en bekijk de Y: schijf bij 'This PC'
  * Maak er een folder test
  * Log in als kea_ree op PCCast1
  * Open een verkenner en bekijk de Y: schijf bij 'This PC'
  * Kijk of deze schijf leeg is

  ***verwacht***: Y: is een persoonlijke gedeelde map per user: \\agentsmith\Userfolders\username


* Een shared folder voor de cast en een groep om de toegang tot die shared folder te regelen
  * Log in als kea_ree op PCCast1
  * Open een verkenner en vul \\agentsmith\cast in
  * Maak er een tijdelijk mapje testsharecast
  * Log in als car_mos op PCCast1
  * Open een verkenner en vul \\agentsmith\cast in
  * Delete het tijdelijk mapje
  * Probeer \\agentsmith\crew te bereiken

  ***verwacht***: De acteurs Keanu Reeves en Carrie-Anne Moss hebben toegang tot de shared folder van de cast, maar niet tot die van de crew


* Een shared folder voor de crew en een groep om de toegang tot die shared folder te regelen
  * Log in ton_bar op PCCrew1
  * Open een verkenner en vul \\agentsmith\crew in
  * Maak er een tijdelijk mapje testsharecrew
  * Log in als lan_wac op DirectorPC
  * Open een verkenner en vul \\agentsmith\ccrew in
  * Delete het tijdelijk mapje
  * Probeer \\agentsmith\cast te bereiken

  ***verwacht***: Crew leden Tony Bardolph en Lana Wachowski hebben toegang tot de shared folder van de crew, maar niet tot die van de cast


* Beleidsregel op gebruikersniveau: Enkel directors hebben toegang tot het control panel
  * Log in als lan_wac
  * open het control panel
  * Log in ton_bar op PCCrew1
  * probeer het control panel te openen
  * Log in als kea_ree op PCCast1
  * probeer het control panel te openen

  ***verwacht***: Enkel als director is het control panel toegankelijk


* Beleidsregel op gebruikersniveau: Niemand kan werkbalken (toolbars) toevoegen aan de taakbalk
  * Log in met een gebruiker naar keuze
  * klik rechts op de taakbalk en probeer Toolbars > New Toolbar te vinden

  ***verwacht***: Het submenu is grayed out, niet beschikbaar


* Beleidsregel op gebruikersniveau: De cast heeft geen toegang tot de eigenschappen van de netwerkadapters
  * Log in als kea_rea
  * Probeer de eigenschappen van de netwerkadapters te bekijken

  ***verwacht***: Lukt niet (ook al niet omdat dit onder control panel valt)


* DNS-server welke alle queries binnen het domein “thematrix.local” beantwooord
  * Log in op om het even welke PC en voer enkele nslookup requests uit
  * nslookup trinity
  * nslookup neo
  * ...

  ***verwacht***: De nameserver van het domain (192.168.20.1) beantwoordt de request voor het domein ipv4 en ipv6


* DNS-server forward de queries voor andere domeinen naar een geschikte DNS-server
  * Log in op om het even welke PC en voer een externe nslookup uit
  * nslookup www.google.be
  * PS C:\Users\Adminstrator> ``` (Get-DnsServerForwarder).IPAddress.tostring() ```

  ***verwacht***: De nameserver forwardt (8.8.8.8) de vraag en geeft dan het non authoritive answer terug


* Zonebestand met A-records (IPv4) voor elke host binnen het domein
<br> Zonebestand met AAAA-records (IPv6) voor elke host binnen het domein
<br> Zonebestanden met PTR-records (IPv4 en IPv6) voor elke host binnen het domein
<br> Geschikte CNAME-records voor elke host om de functie van een server aan te duiden
<br> Aanvullende recordes waar nuttig/nodig
  * Connecteer zoals eerder besproken via RSAT op de DirectorPC met de DNS-server agentsmith.thematrix.local
  * bekijk de zone-bestanden
  * ping www.thematrix.local
  * ping mail.thematrix.local
  * ping smtp.thematrix.local
  * nslookup agentsmith
  * nslookup 192.168.20.2
  * nslookup 2023:2023:2023:2023::1
  * ...

  ***verwacht***: correcte zonebestanden, pings en resultaten


* Testplan met exacte procedures

  ***verwacht***: Testplannen met excacte procedures die toelaten te valideren of een deeltaak is uitgevoerd volgens de specificaties.

  ***resultaat***: OK, dit bestand

* Testrapport

  ***verwacht***: Een [rapport](agentsmith_testrapport.md) waar de resultaten van dit testplan na te lezen zijn.
