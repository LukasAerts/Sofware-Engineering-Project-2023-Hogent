# Lastenboek Opdracht 3.3: Domain Controller

## Deliverables

| Deliverable                                                                                                             | Deeltaak | Status |
| :---------------------------------------------------------------------------------------------------------------------- | :------: | :----: |
| Domain: thematrix.local                                                                                                 | 5        | V      |
| Vast IPv4-adres cfr. IP-adrestabel                                                                                      | 5        | V      |
| Hostname: agentsmith                                                                                                    | 5        | V      |
| (VM met) OS: Windows Server 2019 CLI                                                                                    | 5        | V      |
| Herbruikbare, interactieve powershell scripts met variabelen                                                            | 5        | V      |
| Domainstructuur cfr. opgave en automatisch geïmplementeerd via een powershellscript                                     | 5        | V      | 
| Domain users (acteurs en crewleden) via csv geïmporteerd via een powershellscript                                       | 5        | V      |
| Domain PC's (minstens 2 in elke OU) via csv geïmporteerd via een powershellscript                                       | 5        | V      |
| Server via RSAT te configureren vanop de DirectorPC                                                                     | 7        | V      |
| Authenticatie van gebruikers gebeurt via de Domain Controller                                                           | 5        | V      |
| Cast kan enkel inloggen in de cast-Pc’s                                                                                 | 8        | V      |
| Crew kan enkel inloggen op de crew-Pc’s                                                                                 | 8        | V      |
| Directors kunnen overal inloggen                                                                                        | 8        | V      |
| Elke user krijgt automatisch zijn eigen persoonlijke shared folder                                                      | 9        | V      |
| Een shared folder voor de cast en een groep om de toegang tot die shared folder te regelen                              | 9        | V      |
| Een shared folder voor de crew en een groep om de toegang tot die shared folder te regelen                              | 9        | V      |
| Beleidsregel op gebruikersniveau: Enkel directors hebben toegang tot het control panel                                  | 10       | V      |
| Beleidsregel op gebruikersniveau: Niemand kan werkbalken (toolbars) toevoegen aan de taakbalk                           | 10       | V      |
| Beleidsregel op gebruikersniveau: De cast heeft geen toegang tot de eigenschappen van de netwerkadapters                | 10       | V      |
| DNS-server welke alle queries binnen het domein “thematrix.local” beantwooord                                           | 6        | V      |
| DNS-server forward de queries voor andere domeinen naar een geschikte DNS-server                                        | 6        | V      |
| Zonebestand met A-records (IPv4) voor elke host binnen het domein                                                       | 6        | V      |
| Zonebestand met AAAA-records (IPv6) voor elke host binnen het domein                                                    | 6        | V      |
| Zonebestanden met PTR-records (IPv4 en IPv6) voor elke host binnen het domein                                           | 6        | V      |
| Geschikte CNAME-records voor elke host om de functie van een server aan te duiden                                       | 6        | V      |
| Aanvullende recordes waar nuttig/nodig                                                                                  | 6        | V      |
| Testplan met exacte procedures                                                                                          | 3        | V      |
| Testrapport                                                                                                             | 4        | V      |


## Deeltaken

1. Aanmaken lastenboek
  - Dit .md bestand
  - Deliverables en deeltaken, verdeeld in Kanban-tickets
  - Verantwoordelijke: Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-128)

2. Opmaken documentatie
  - opgave.md: Om ook later efficiënt in het finaal dossier over te zetten
  - instucties.md: uitleg hoe de machines correct op te zetten
  - documentatie.md: specifieke uitleg hoe de deliverables werden bekomen
  - Verantwoordelijke: Lukas Aerts & Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-133)

3. Aanmaken testplan
  - Instructies om uit te voeren ter controle van de deliverables
  - Verantwoordelijke: Naoufal Thabet & Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-129)
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-20)

4. Testrapport
  - Uitvoeren testrapporten om de deliverables te controleren
  - Verantwoordelijke: Wim Meirlaen & Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-131)

5. Virtuele Machine opzetten (inclusief Active Directory)
  - Herbruikbare, interactieve powershell scripts met variabelen [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-45)
  - (VM met) OS: Windows Server 2019 CLI (of GUI tijdens testfase)
  - Vast IPv4-adres cfr. IP-adrestabel
  - Hostname: agentsmith
  - ADDS Rol: Domain: thematrix.local
  - Domainstructuur cfr. opgave en automatisch geïmplementeerd via een powershellscript
  - Domain users (acteurs en crewleden) via csv geïmporteerd via een powershellscript
  - Domain PC's (minstens 2 in elke OU) via csv geïmporteerd via een powershellscript
  - Verantwoordelijke: Lukas Aerts & Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-2)

6. DNS
  - DNS-server welke alle queries binnen het domein “thematrix.local” beantwooord
  - DNS-server forward de queries voor andere domeinen naar een geschikte DNS-server
  - Zonebestand met A-records (IPv4) voor elke host binnen het domein
  - Zonebestand met AAAA-records (IPv6) voor elke host binnen het domein
  - Zonebestanden met PTR-records (IPv4 en IPv6) voor elke host binnen het domein
  - Zonebestand met A-records Voor elke host binnen het domein
  - Geschikte CNAME-records voor elke host om de functie van een server aan te duiden
  - Aanvullende recordes waar nuttig/nodig
  - Verantwoordelijke: Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-4)

7. Server via RSAT te configureren vanop de DirectorPC
  - Access control rules m.b.v. powershell script
  - Verantwoordelijke: Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-130)

8. Toegangscontrole
  - Cast kan enkel inloggen in de cast-Pc’s
  - Crew kan enkel inloggen op de crew-Pc’s
  - Directors kunnen overal inloggen
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-134)

9.  Shared folders
  - Elke user krijgt automatisch zijn eigen persoonlijke shared folder
  - Een shared folder voor de cast en een groep om de toegang tot die shared folder te regelen
  - Een shared folder voor de crew en een groep om de toegang tot die shared folder te regelen
  - Verantwoordelijke: Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-135)

10. Beleidsregels op gebruikersniveau
  - Enkel directors hebben toegang tot het control panel
  - Niemand kan werkbalken (toolbars) toevoegen aan de taakbalk
  - De cast heeft geen toegang tot de eigenschappen van de netwerkadapters
  - Verantwoordelijke: Benny Clemmens
  - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-132)


## Tijdbesteding

| Student                 | Geschat | Gerealiseerd |
| :------------------     | :------ | :----------- |
| Naoufal Thabet          | X       | 8,75         | 
| <del>Wim Meirlaen</del> | X       | 7,5          | 
| Stein Van Driessche     | X       | 7            | 
| Lukas Aerts             | X       | 12,5         | 
| Benny Clemmens          | X       | 55,5         | 
| Olivier Saenen          | X       | 3            | 
| **totaal**              | X       | 94.25        |

***Opmerking*** : Mogelijks werden een aantal uren welke aan deze opdracht werden besteed geregistreerd als overhead. Ook het steeds van scratch runnen van de hele setup om zeker te zijn dat alles in één keer kon runnen was zeer tijdsintensief. Een makkelike manier om een screenshot van een issue te maken helaas niet gevonden in jira.
