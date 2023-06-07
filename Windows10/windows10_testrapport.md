# Testrapport 3.X: Windows 10
Auteur : Clemmens Benny, 23/5/2023

## Opmerking
* Om alle functionaliteit van de Windows 10 VM's te testen is de fysieke netwerkapparatuur nodig, verbonden met meerdere andere VM's soms noodzakelijk. Zodoende zijn niet alle deliverables voor één persoon makkelijk te testen.
* Voor het opzetten van de machines dienen de [instructies](windows10_instructies.md) te worden gevolgd.
* Met .\Administrator / 22Admin23 kan na joinen van het domain nog als lokaal admin worden ingelogd

## Testen

* (VM met) OS: Windows 2010 PRO
  * Start een VM op en kijk het OS na

  ***verwacht***:  Windows 2010 PRO

  ***resultaat***: Windows 2010 PRO

* Installatie en configuratie van de Windows systemen gebeurt deels in de GUI en deels aan de hand van PowerShell scripts
  * bekijk en run de scripts in scripts/keuzemenu_win10base en scripts/keuzemenu_win10clones

  ***verwacht***: Een semi-automatische installatie

  ***resultaat***: slechts enkele vragen te beantwoorden, de rest loopt automatisch
  
* Herbruikbare, interactieve powershell scripts met variabelen
  * Insalleer meerdere VM's met hetzelfde script

  ***verwacht***:  het script is interactief en kan herbruikt worden

  ***resultaat***: op verschillende pc's geprobeerd, werkt
  
* Correcte hostnaam: DirectorPC, PCrew1, ...
  * Kijk de computernaam na in Systeem/info

  ***verwacht***:  De computers hebben de correcte naam verkregen

  ***resultaat***: Check voor DirectorPC, PCCrew1, PcCast1
  
* Dynamische, private IPv4-adressen (via DHCP)
  * Enkel in netwerklokaal deftig te testen
  * Kiest tijdens aanmaken van de VM de optie DHCP
  * Mogelijk thuis te testen indien aan een telenet/belgacom router/switch/dns kan worden gehangen
  * check met ipconfig /all

  ***verwacht***:  De VM krijgt de nodige configuratie van de router

  ***resultaat***: In testomgeving een fixed ip : 192.168.20.151, 152, ...
  

* Authenticatie van gebruikers gebeurt via de Domain Controller
  * Log in als lokaal admin
  * Bekijk de local users

  ***verwacht***:  Er zijn geen gewone local users

  ***resultaat***: Enkel een local Administrator
  

* Zorg ervoor dat je de servers via RSAT kan configureren vanop de DirectorPC (tools beschikbaar op de DirectorPC)
  * Log in als THEMATRIX\Administrator
  * Connecteer met Server Manager met agentsmith

  ***verwacht***:  De server kan worden geconfigureerd

  ***resultaat***: na toevoegen van de domain controller waren de tools beschikbaar
  

* Gebruikers kunnen via theoracle.thematrix.local inloggen en een geëncrypteerd gesprek voeren
  * Start NeoChat op op twee VM's
  * Log in volgens de instructies in theoracle.thematrix.local
  * Join een room en heb een gesprek

  ***verwacht***:  Er kan een gesprek worden gevoerd

  ***resultaat***: Tijdens een contactmoment lukt dit, nu niet kunnen testen
  

* Testplan met exacte procedures
  * Wordt momenteel gevolgd

* Testrapport
  * Dit bestand