# Testplan Opdracht web server Trinity

**Auteur(s) testplan: Naoufal Thabet**

Aan de hand van deze tesplan zullen we alle deeltaken / deliverables testen of ze voldaan zijn of niet. In elke deeltaak zal er vermeld worden: wat er wordt gestest, wat we nodig hebben, welke stappen we moeten uitvoeren en het verwachte resultaat.

Wanneer er een gui nodig is adviseer ik om een kalilinux VM te gebruiken die uiteraard in hetzelfde subnet zit als de server(s).

# Server Configuration test

## Test Vagrant script

Hier testen we of Server Trinity succesvol gedeployed kan worden via de vagrant script.

Disclaimer :warning: deployment kan heel zelden falen door dat de mirrors van waar de resourcen worden opgehaald onbereikbaar zijn, in dat geval gewoon opnieuw proberen.

**Benodigdheden**

- requirments uit installatieplan server Trinity

**Test**

- Volg installatieplan server Trinity

**resultaat**

in het command line venster waar je `vagrant up` hebt ingegeven zal je de output van de installatie zien, bij sucesvol deployment krijg je als laatste zin:"Vagrant has completed building server trinity successfully!"

## Test script Trinity 

Hier testen we of de algemene script voor Trinity de configuratie omtrent ssh correct heeft uitgevoerd. Enkel key authentication is toegestaan (je public key moet aanwezig zijn in het bestand "authorized_keys" op de Trinity server)

**Benodigheden**

- een VM met een ssh client in hetzelfde subnet

### Inlogen met wachtwoord niet toegestaan

**Test**

- open terminal
- geef de commando `ssh vagrant@192.168.20.2` in 

**Resultaat**

- Wanneer je een wachtwoord prompt krijgt dan is server niet goed geconfigureerd 
- indien je permission denied krijgt betekent het dat je public key niet aanwezig is op server Trinity

### Inlogen met wachtwoord als root

**Test**

- open terminal
- geef de commando `ssh root@192.168.20.2` in 

**Resultaat**

- Wanneer je een wachtwoord prompt krijgt dan is server niet goed geconfigureerd
- Je moet permission denied krijgen

### Inlogen als root en public key aanwezig in "authorized_keys" op Trinity

**Test**

- open terminal
- geef de commando `ssh root@192.168.20.2` in 

**Resultaat**

Je moet permission denied krijgen

### Inlogen wanner je public key aanwezig is op Trinity

**Test**

- open terminal
- geef de commando `ssh vagrant@192.168.20.2` in 

**Resultaat**

Je terminal prompt moet veranderen naar vagrant@trintiy 

## Test web service

Hier testen we enkel of de webservice apache loopt en automatisch opstart met de server en op welk poort de service luistert, resterende apache configuratie zullen in andere testen (thematrix website en de reverse proxy test) gestresst worden.

**Test status httpd**

- open terminal
- geef de commando `systemctl status httpd` in 

**Resulaat**

- De lijn Loaded: (eerste) van de output moet:"Loaded: loaded (/usr/lib/systemd/system/httpd.service; enabled; vendor preset: disabled)" lezen
- De lijn  Active: (derde) van de output moet beginnen met "active (running)"

**Test poorten httpd**

- open terminal
- geef de commando `sudo ss -tlpn | grep httpd` in 

**Resulaat**

- ja mag maar 1 lijntje zien waar httpd naar poort 8080 luistert
  
  vb: LISTEN 0      511                *:8080            *:*    users:(("httpd",pid=982,fd=4),("httpd",pid=976,fd=4),("httpd",pid=975,fd=4),("httpd",pid=915,fd=4))

## Test database voor wordpress website

Hier testen we enkel of MariaDB loop en automatisch opstart met de server, rest van de configuratie zal gestresst worden tijdens thematrix website testen.

**Test**

- open terminal
- geef de commando `systemctl status mariadb` in 

**Resulaat**

- De lijn Loaded: (eerste) van de output moet: "Loaded: loaded (/usr/lib/systemd/system/mariadb.service; enabled; vendor preset: disabled)" lezen
- De lijn  Active: (derde) van de output moet beginnen met "active (running)"

## Test insallatie wordpress

Gaan we niet testen, want er zijn hier geen special requirments. De correctheid van de installatie zal gestresst worden bij het surfen naar thematrix.local


## Test reverse proxy basis configuratie

Hier testen we of nginx loopt, automatisch opstart met de server en luistert naar poorten 80 en 443.

**Test status nginx**

- open terminal
- geef de commando `systemctl status nginx` in 

**Resulaat**

- De lijn Loaded: (eerste) van de output moet:"Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; vendor preset: disabled)" lezen
- De lijn  Active: (derde) van de output moet beginnen met "active (running)"

**Test poorten nginx**

- open terminal
- geef de commando `sudo ss -tlpn | grep nginx` in 

**Resulaat**

- ja mag maar 4 lijntje zien waar nginx naar poorten 80 en 443 luistert via ipv6 en ipv6 adressen
  
  vb: 

      LISTEN 0      511          0.0.0.0:80        0.0.0.0:*    users:(("nginx",pid=950,fd=6),("nginx",pid=948,fd=6))         
      LISTEN 0      511          0.0.0.0:443       0.0.0.0:*    users:(("nginx",pid=950,fd=8),("nginx",pid=948,fd=8))         
      LISTEN 0      511             [::]:80           [::]:*    users:(("nginx",pid=950,fd=7),("nginx",pid=948,fd=7))         
      LISTEN 0      511             [::]:443          [::]:*    users:(("nginx",pid=950,fd=9),("nginx",pid=948,fd=9)) 

## Test reverse proxy selfsigned ssl certificaat

Deze test gaan we stressen wanneer we surfen naar thematrix.local en rallly.thematrix.local

## Test reverse proxy hidding version

**Benodigdhed**

- VM met of zonder gui in dezelfde subnet als Trinity waar nmap op geinstalleerd is

**Test**

- open terminal
-  geef de commando `nmap -sV 192.168.20.2` in 

**Resultaat**

Wanneer je een versie nummer zie naast nginx dan is de server slecht geconfigureerd

## Test rallly script

Hier testen we enkel de requirments om rallly uit te rollen

### Postgreql status

Rallly heeft een posgresql nodig om te starten en te werken

**Test**

- open terminal
- geef de commando `systemctl status postgresql` in 

**Resulaat**

- De lijn Loaded: (eerste) van de output moet: "Loaded: loaded (/usr/lib/systemd/system/postgresql.service; enabled; vendor preset: disabled)" lezen
- De lijn  Active: (derde) van de output moet beginnen met "active (running)"

### Postgresql configuratie

Zal gestresst worden wanneer we rallly.thematrix.local testen, zonder postgreql database werkt de node js applicatie gewoon weg niet. 

### Node js versie

Rallly heeft minstens een Node js 18.x versie nodig om te werken

**Test**

- open terminal
- geef de commando `node -v` in 

**Resulaat**

Je moet versie v18.16.0 of hoger aflezen

### Poorten node js

De process van rallly build (node js instantie) luistert naar poort 3000, nginx (de reverse proxy) hoeft request over poort 3000 op te vangen aangezien de http en https request over poort 80 en 443 komen en poort 3000 gesloten is voor de buitenwereld.

**Test poort**

- open terminal
- geef de commando `sudo ss -tlpn | grep node` in

**Resulaat**
1 lijn moet "LISTEN 0      511                *:3000            *:*    users:(("node",pid=1894,fd=19))" lezen, pid mag verschillen.

**Test welk process node luistern naar poort 3000**

- open terminal
- geef de commando `ps` + `pid`  (de process id van het process dat naar poort luistert 3000)
  
  vb: `ps 1894`

**Resulaat**
the command moet: "/usr/bin/node /home/vagrant/rallly/node_modules/.bin/next dev" lezen.

### (optional) Status rallly service

Optionele stap, we hebben van de rallly app een systemd service gemaakt zodat de app automatisch opstart met de server

**Test**

- open terminal
- geef de commando `systemctl status postgresql` in 

**Resulaat**

- De lijn Loaded: (eerste) van de output moet: "Loaded: loaded (/etc/systemd/system/rallly.service; enabled; vendor preset: disabled)" lezen
- De lijn  Active: (derde) van de output moet beginnen met "active (running)"

# Testen Thematrix.local wordpress website en rallly.thematrix.local applicatie

**Benodigdheden**

- Server agentsmith die de dns service levert voor ons netwerk
- VM met gui in dezelfde subnet als Trinity en agentsmith

## (optinal ) http wordt naar https geridrect
Deze requirement werd niet expliciet vermedt in het projectbrochure maar aangezien we werken met een reverse proxy dat een self-signed ssl certificaat heeft voor https traffic.

:warning: aangezien we gebruiken van een self-signed ssl certificaat en onze server is geen gekende CA in onze web browser

**Test**

surf naar: http://rallly.thematrix.local en http://www.rallly.thematrix.local en  http://thematrix.local en  http://www.thematrix.local

**resultaat**

Indien niet gedirect wordt naar: https://rallly.thematrix.local en https://www.rallly.thematrix.local en  https://thematrix.local en  https://www.thematrix.local dan is de server niet geconfigureerd

## website / app beschermd met een certificaat
voor https verkeer is er een certificaat nodig

**Test**

surf naar rallly.thematrix.local of thematrix.local, klik op het slotje in het adresbalk voor de url om meer informatie te vinden over het certificaat

**Resultaat**

volgende info zou je moeten zien:

- Common Name: thematrix.local
- Subject Alternative Names:
- Organization: Hogent
- Organization Unit:
- Locality: Ghent
- State: OV
- Country: BE

:warning: je zal ook een serienummer, thumb print, een valid from to date, maar die heb ik niet vermeld.

## website en app enkel bereikbaar via reverse proxy

De wordpress website en rallly zijn enkel bereikbaar via de web browser met poort 80 of 443 (poorten van nginx)

:information_source Ter info de response header zal server nginx tonen (zonder versie) wanneer je de developer tool  van je browser opent en gewoon suft naar de wordpress site of rallly.

**Test**

- wordpress website: surf naar thematrix.local:8080
- rallly: surf naar rallly.thematrix.local:3000

**Resultaat**

- De wordpress website and rallly mogen niet weergegeven worden in de web browser


## website en app gelijktijdig bereikbaar

**Test**

surf naar: http://rallly.thematrix.local ; https://rallly.thematrix.local ; http://www.rallly.thematrix.local ; https://www.rallly.thematrix.local ; http://thematrix.local ; https://thematrix.local ; http://www.thematrix.local en https://www.thematrix.local

**Resultaat**

- Je zal 4 tabs van https://rallly.thematrix.local en 4 tabs van https://thematrix.local krijgen bij succes
- Indien rallly en thematrix niet laden en je krijgt de volgende melding: "We’re having trouble finding that site" dan hebben we dns probleem (geen Trinity issue)
- Indien één of de twee sites niet werken en we krijgen een response status 503 in onze web browser terug dan is er een issue met de reverse proxy configuratie
