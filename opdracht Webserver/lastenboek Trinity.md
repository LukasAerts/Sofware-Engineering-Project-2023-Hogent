# Lastenboek Opdracht web server Trinity

## Deliverables

Een Almalinux machine waar een apache web server draait om een wordpress website te hosten. de wordpress website wordt ondersteund met behulp van een MariaDB datbase server. Op de server draait eveneens de open source group meeting scheduling tool Rallly (https://github.com/lukevella/rallly). Beiden Rallly and wordpress zijn enkel bereikbaar via de reverse proxy nginx met zowel http als https.

Bijkomende voorwaarden:
* connectie via ssh als root is niet toegelaten
* connecite va ssh met username en wachtwoord niet toegelaten enkel via key based authenticatie is toegelaten
* web server moet zowel de http als de https protocol ondersteunen, voor https ondersteuning maken we gebruiken van een self-sgined certicate.
* wanneer webserver gescand wordt met nmap mag geen informatie of de versie ervan gegeven worden.
* De rallly applicatie en de wordpress website moeten beiden tegelijk bereikbaar zijn.

## Deeltaken


1. Vagrantfile schrijven voor deployment almalinux server
    - Verantwoordelijke: Naoufal Thabet
    - Tester: Naoufal Thabet
    - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-59)
2. Trinity script: algemene script om voorwaarden omtrent ssh te configureren
    - Verantwoordelijke: Naoufal Thabet
    - Tester: Naoufal Thabet
    - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-98)
3. Web service script: een script dat apache installeert, configureert om samen te werken met reverse proxy en om geen info en versie weer te geven wanneer gescand met nmap
    - Verantwoordelijke: Naoufal Thabet
    - Tester: Naoufal Thabet
    - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-59)
4. db script: een script om MariaDB te installeren en te initialiseren
    - Verantwoordelijke: Naoufal Thabet
    - Tester: Naoufal Thabet
    - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-59)
5. cms script: een script om wordpress en te installeren zonder input en gebruikmakend van de mariadb database
    - Verantwoordelijke: Naoufal Thabet
    - Tester: Naoufal Thabet
    - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-59)
6. reverse proxy script: een script om nginx te installeren en te configureren als reverse proxy server voor apache en de Rallly app. De reverse proxy moet ook https ondersteunen en mag geen info of versie geven wanneer gescand met nmap 
    - Verantwoordelijke: Naoufal Thabet
    - Tester: Naoufal Thabet
    - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-59)
7. Rallly script: een script om rallly en de prerequisites te downloaden, te installeren, te configureren en te deployen
    - Verantwoordelijke: Naoufal Thabet
    - Tester: Naoufal Thabet
    - [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-59)

## Tijdbesteding

| Student             | Geschat | Gerealiseerd |
| :------------------ | :------ | :----------- |
| Naoufal Thabet      | 4h      |  3h 45m      |
|                     | 2h      |  1h 30m      |
|                     | 2h      |  2h          |
|                     | 2h      |  1h 30m      |
|                     | 6h      |  6h 30m      |
|                     | 6h      |  7h          |
|                     | 16h     |  1d 12h 30m  |
| **totaal**          | 1d 14h  |  2d 10 45m   |


![deeltaak vagrant](screenshots%20lastenboek%20trinity/vagrant.PNG)

![deeltaak general script aka trinity script](screenshots%20lastenboek%20trinity/general%20script.PNG)

![deeltaak web service script](screenshots%20lastenboek%20trinity/web%20script.PNG)

![deeltaak database script](screenshots%20lastenboek%20trinity/db%20script.PNG)

![deeltaak cms script](screenshots%20lastenboek%20trinity/cms.PNG)

![deeltaak reverse proxy script](screenshots%20lastenboek%20trinity/reverse%20proxy.PNG)

![deeltaak rallly script](screenshots%20lastenboek%20trinity/rallly.PNG)

![deeltaak troubleshooting trinity](screenshots%20lastenboek%20trinity/troubleshooting%20trinity.PNG)

![deeltaak troubleshooting rallly](screenshots%20lastenboek%20trinity/troubleshooting%20rallly.PNG)