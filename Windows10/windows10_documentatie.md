# Documentatie Opdracht 3.X: Windows10

## Deliverables

* (VM met) OS: Windows 2010 PRO
  * Met behulp van VirtualBox unattended install vanop de .iso welke van academic software werd gedownload

* Installatie en configuratie van de Windows systemen gebeurt deels in de GUI en deels aan de hand van PowerShell scripts
  * Alles verloopt via powershell scripts
  * één basis vm per machine maken met win10base script
  * verschillende clones kunnen van deze base gemaakt worden met win10clones script

* Herbruikbare, interactieve powershell scripts met variabelen
  * voor meerdere vm's kan hetzelfde script telkens worden gebruikt
  * makkelijk aanpasbaar in 02_set_variables.ps1

* Correcte hostnaam: DirectorPC, PCrew1, ...
  * afhankelijk van de keuze in het interactief script, automatisch toegekend

* Dynamische, private IPv4-adressen (via DHCP)
  * Standaard DHCP voor netadapters. IPv6 werd disabled

* Authenticatie van gebruikers gebeurt via de Domain Controller
  * Enkel één lokale Adminstrator werd initieel aangemaakt, de rest komt uit het domain

* Zorg ervoor dat je de servers via RSAT kan configureren vanop de DirectorPC (tools beschikbaar op de DirectorPC)
  * Script installeert deze automatisch en silent met behulp van wusa.exe

* Gebruikers kunnen via theoracle.thematrix.local inloggen en een geëncrypteerd gesprek voeren
  * Applicatie beschibaar op alle hosts: NeoChat, een client voor synapse welke draait op theoracle
