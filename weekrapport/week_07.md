# Voortgangsrapport week 07

- Groep: T01
- Periode: donderdag 23 Maart - woensdag 29 Maart 23:59
- Datum voortgangsgesprek: donderdag 30-03-2023, van 18:00 tot 21:30 in het netwerklokaal

| Student             | Aanw. | Opmerking |
| :------------------ | :---: | :-------- |
| Naoufal Thabet      |   V   |           |
| Wim Meirlaen        |   V   |           |
| Stein Van Driessche |   V   |           |
| Lukas Aerts         |   V   |           |
| Benny Clemmens      |   V   |           |
| Olivier Saenen      |   V   |           |

=======

## Wat heb je deze week gerealiseerd?

- Start opdracht dozer en aanmaak van vagrantscript + dozer script
- Verdere uitwerking van exchange server + testen
- Labo 2 afwerking + documentatie + fysiek testen in netwerk lokaal
- Voortgang e-mail Exchange server (Neo) (CLI installatie, documentatie uitschrijven)
- Dozer opdracht (installatie, documentatie, QuakeJS, Vagrant script)
- Matrix.org server is verder uitgewerkt (werkende op eigen setup + begin documentatie (testplan en stappenplan))

![Oplijsting Kanbanbord week 07](/weekrapport/img/weekrapporten/week-7/kanbanweek7.png)

![Cumulative Flow Chart week 07](/weekrapport/img/weekrapporten/week-7/cumulative-flow-week7.PNG)

&nbsp;

### Algemeen

### Naoufal Thabet

- troubleshooten directorpc, dc en dns
- general config, web service, db en cms script gemaakt voor Trinity

![Tijdregistratie Naoufal, 24-30 maart 2023](/weekrapport/img/timesheets/week-7/Naoufal_07_Timesheet.PNG)

### Wim Meirlaen

- Poging tot installatie van de CLI-Exchange server (Nio)
- Aanmaken installatieverslag + troubleshooting (met Lukas)

![Tijdregistratie Wim, 24-30 maart 2023](/weekrapport/img/timesheets/week-7/Wim_w07_Timesheet.PNG)

### Stein Van Driessche

- Start opdracht dozer
- Dozer script install QuakeJS (v1)
- Vagrantscript voor aanmaken dozer VM (v1)
- Opzoekwerk dozer voor Vagrant,QuakeJS,Kutt.IT
- Schrijven testplan exchange server
- Schrijven documentatie exchange server
- Schrijven lastenboek exchange server
- Meeting exchange

![Tijdsregistratie Stein, 23-29 maart 2023](/weekrapport/img/timesheets/week-7/Stein_07_Timesheet.PNG)

### Lukas Aerts

- Scripts Exchange server
- Troubleshooting Scripts
- Documentatie bijwerken

![Tijdsregistratie Lukas, 23-29 maart 2023](/weekrapport/img/timesheets/week-7/Lukas_07_Timesheet.PNG)

### Benny Clemmens

- Controle commando's op de devices in het netwerklokaal (na problemen met Packet Tracer versie)
- Alle Cisco labo's volledig uitgewerkt en gedocumenteerd
- VM's met windows 10 voorbereid om onze setup in het netwerklokaal te testen
- Commando's op echte devices voorbereid om setup in netwerklokaal te kunnen testen
- Opgave en lastenboek Opdracht 3.2 Netwerk uitgewerkt

![Tijdsregistratie Benny, 23-29 maart 2023](/weekrapport/img/timesheets/week-7/Benny_07_Timesheet.PNG)

### Olivier Saenen

- Begonnen aan documentatie lezen voor uitrol via Vagrant file
- Testplan uitgeschreven voor Matrix.org (inclusief connection via 2 verschillende clients)
- Stappenplan uitgeschreven voor installatie Matrix.org Synapse
- Synapse server werkende gekregen op eigen setup op AlmaLinux

![Tijdsregistratie Olivier, 23-29 maart 2023](/weekrapport/img/timesheets/week-7/Olivier_07_timesheet.png)

## Wat plan je volgende week te doen?

### Algemeen

### Naoufal Thabet

- reverse proxy installeren op Trinity
- Rally installeren op Trinity
- Als er tijd is verder aan DC, dns en DirectorPC en waarschijnlijk exchange om seemles heads te installern en enrollement in het domein

### Wim Meirlaen

### Stein Van Driessche

- Vagrantscript dozer voor het aanmaken van VM voltooien (v2)
- Script install voor QuakeJS (dozer)
- Script Kutt.IT voor shorturl (dozer)
- Uitvoeren testen labo 2 volgens testplan
- Schrijven documentatie dozer
- Samenkomst Hogent op 30/03

### Lukas Aerts

- Vereenvoudigen Exchange Server scripts
- Documentatie bijwerken

### Benny Clemmens

- Na de stand van zaken tijdens ons fysiek overlegmoment te hebben besproken: backlog overlopen en vervolledigen
- Tijdens de Paasvakantie meerdere testplannen uitvoeren om testrapporten te kunnen genereren (van de installaties van de collega's die klaar zijn)

### Olivier Saenen

- Bash scripts opzetten (deel van Matrix opdracht)
- ipv eigen domein ons domein thematrix.local gebruiken (wijzigingen script)
- Vagrant installation file maken voor Matrix.org
- Instructies wat opschonen
- Eventueel bridges installeren naar bvb Signal/Discord indien tijd hiervoor

&nbsp;

## Waar hebben jullie nog problemen mee?

- Stein: Script succesvol laten werken zonder eigen input (dozer)
- Benny: enkele onderdelen van de opgave zijn onlogisch, deze bespreken we met de lectoren tijdens het fysiek overlegmoment
- Olivier: kleine moeilijkheden ivm local setup van matrix.org server (config files) door hierdoor probleem te hebben aanmaak SSL certs
- Wim: installatie headless Exchange server werkt nog niet zoals het hoort

&nbsp;

## Feedback technisch luik

### Algemeen

- AD/DC is een dode branch?

#### Trinity (Naoufal)

  - Nog geen lastenboek, testplan of documentatie?
  - Scripts zien er OK uit. Kan een kleine demo tijdens het contactmoment?
 
#### Neo

  - Lastenboek: AD, spam filter en virusscan niet vermeld?
  - Problemen met headless install?

#### Agent Smith

  - Scripts lijken OK. Werkt alles? Policies en shared folders?
  - DNS: :Lastenboek, testplan en testrapport zijn wel heel summier.
  - Nergens melding van de policies in een lastenboek, testplan of testrapport?
  - Korte demo tijdens het contactmoment dat de DirectorPC de nodige admin acties kan uitvoeren via RSAT?

### Naoufal Thabet

### Wim Meirlaen

### Stein Van Driessche

### Lukas Aerts

### Benny Clemmens

### Olivier Saenen

&nbsp;

## Feedback analyseluik

### Algemeen

### Naoufal Thabet

### Wim Meirlaen

### Stein Van Driessche

### Lukas Aerts

### Benny Clemmens

### Olivier Saenen
