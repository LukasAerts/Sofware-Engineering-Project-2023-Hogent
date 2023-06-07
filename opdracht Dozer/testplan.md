### Testplan Opdracht Dozer: (Vagrantscript,Emscripten,QuakeJS,Shorturl,Contentserver)

(Een testplan is een *exacte* procedure van de handelingen die je moet uitvoeren om aan te tonen dat de opdracht volledig volbracht is en dat aan alle specificaties voldaan is. Een teamlid moet aan de hand van deze procedure in staat zijn om de tests uit te voeren en erover te rapporteren (zie testrapport). Geef bij elke stap het verwachte resultaat en hoe je kan verifiëren of dat resultaat ook behaald is. Kies zelf de structuur: genummerde lijst, tabel, secties, ... Verwijder deze uitleg als het plan af is.)

Auteur(s) testplan: Van Driessche Stein

De volledige te volgen stappen voor het opbouwen van dozer staan vermeld in de documentatie alsook de correcte procedures.
Voor de test dien je de volledige inhoud van opdracht dozer te copy/pasten naar je eigen pc.
Er dienen reeds nog enkele aanpassingen te gebeuren zodat je dit script kan testen.


## WINDOWS CLIENT VOOR QUAKEJS TEST

Hou er rekening mee dat voor QuakeJS effectief te testen je reeds over een windows 10 VM dient te beschikken die zich in hetzelfde subnet bevindt.
Pas hiervoor volgende instellingen aan als voorbeeld voor de windows 10 VM die moet dienen als clientaccount:

Adapter 1: NAT
Adapter 2: Bridged adapter
    config.vm.network "public_network", 
    bridge: "eth1",
    nic: "VUL HIER JE EIGEN NIC IN",
    ip: "192.168.20.205" 

## VAGRANTSCRIPT aanpassingen voor de test

 # nic aan te passen voor test
    config.vm.network "public_network", 
    bridge: "eth1",
    nic: "Qualcomm Atheros QCA9377 Wireless Network Adapter" `=> naar je eigen NIC`,
    ip: "192.168.20.5"  


## Login gegevens dozer VM

Login: vagrant
Password: vagrant


### TESTPLAN

Wat volgt is een samenstelling van commando's voor de creatie van de VM alsook QuakeJS en Shorturl en eventuele controle commando's.

## 1. Testplan voor het Vagrant-script

1. Ga naar de map waarin het Vagrant-script is opgeslagen in powershell.
-> Voer het commando `vagrant up` uit om de virtuele machine te starten.

2. Log manueel in op de opgestarte vm nadat powershell klaar is met het runnen van alle scripts.

3. Controleer of de juiste softwarepakketten zijn geïnstalleerd door de relevante commando's in de VM uit te voeren 
-> `node -v` en `npm -v`

## 2. Testplan voor Dozer script:

2. Controleer of SELinux is geconfigureerd om in permissive mode te draaien door de volgende commando's uit te voeren:
-> `sudo sestatus`
    -> Controleer of SELinux is ingeschakeld en of de huidige mode permissive is.

-> `sudo nano /etc/selinux/config`
    -> Controleer of SELINUX=enforcing is gewijzigd naar SELINUX=permissive.
   
3. Controleer of nano en git correct zijn geïnstalleerd door de volgende commando's uit te voeren:
->`nano --version`
    -> Controleer of nano is geïnstalleerd en de versie wordt weergegeven.

-> `git --version`
    -> Controleer of git is geïnstalleerd en de versie wordt weergegeven.


## 3. Testplan voor het Emscripten Script

1. Controleer of alle vereiste pakketten correct zijn geïnstalleerd. 
-> commando: `dnf list installed | grep <pakketnaam>`. 
    -> Controleer de volgende pakketten:
    - `python3`
    - `cmake`
    - `nodejs`
    - `java-1.8.0-openjdk-devel`
    
2. Controleer of de Emscripten-repository correct is gekloond door naar de map te navigeren waarin deze zich bevindt.
 -> commando: `cd emsdk`
 -> commando: `git status`
    -> Branch is up to date

3. Controleer of de Emscripten-versie correct is geïnstalleerd en geactiveerd.
-> commando: `./emsdk list`. 
    -> De uitvoer moet de geïnstalleerde versie van Emscripten bevatten en deze moet zijn gemarkeerd als actief.


## 4. Testplan voor het QuakeJS-script

1. Ga naar de map waarin het QuakeJS-script is opgeslagen.
-> `cd quakejs` (vanuit root dus eerst cd)

2. Controleer of de QuakeJS-map correct is gekloond.
-> commando: `ls`

3. Controleer of de dedicated server correct werkt door de server te starten.
-> commando: `sudo node build/ioq3ded.js +set fs_game baseq3 +set dedicated 2 +set net_ip 192.168.20.5 +set net_port 27960 +exec server.cfg`


## 5. Testplan voor Shorturl script.

1. Ga naar de Root directory en kijk of de go-map correct is aangemaakt.
-> commando: `ls`

2. Laat de ShortURL-webtoepassing starten.
-> commando `./shorturl & sleep 2`

3. Surf via de windows VM naar `http://192.168.20.5:8000/`
-> Je kan eventueel een url toevoegen bv voor Quakejs:

http://www.quakejs.com/play?connect%20192.168.20.5:27960
Zorg er echter wel voor dat je een geldige URL gebruikt (start met http:// or https://).

## 6. Login op BaldnB Carnagefield

1. Start de Windows 10 VM op met onderstaande netwerk instellingen:

Adapter 1: NAT
Adapter 2: Bridged adapter
    config.vm.network "public_network", 
    bridge: "eth1",
    nic: "VUL HIER JE EIGEN NIC IN",
    ip: "192.168.20.205" 

2. ping vanuit cmd prompt naar 192.168.20.5
-> commando: `ping 192.168.20.2`

3. Start je internetbrowser en surf naar http://www.quakejs.com/play?connect%20192.168.20.5:27960
-> Scroll de tekst naar beneden en `keur goed`.
-> Vervolgens start het downloaden van QuakeJS

4. Het spel start op en is speelbaar.
-> Tijdens de uitvoering van het project zal QuakeJS beschikbaar zijn vanaf je eigen pc die verbonden is met thematrix.local waarbij we gebruik maken van routers en switchen die als dit netwerk fungeren.
-> neem een `screenshot` als bewijs van de werking van deze server.

