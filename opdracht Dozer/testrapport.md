### Testrapport Opdracht dozer: (Vagrantscript,Emscripten,QuakeJS,Shorturl)

(Een testrapport is het verslag van de uitvoering van het testplan door een teamlid (iemand anders dan de auteur van het testplan!). Deze noteert bij elke stap in het testplan of het bekomen resultaat overeenstemt met wat verwacht werd. Indien niet, dan is het belangrijk om gedetailleerd op te geven wat er misloopt, wat het effectieve resultaat was, welke foutboodschappen gegenereerd werden, enz. De tester kan meteen een Github issue aanmaken en er vanuit het testrapport naar verwijzen. Wanneer het probleem opgelost werdt, wordt een nieuwe test uitgevoerd, met een nieuw verslag.)

### 1. Testplan voor het Vagrant-script

Uitvoerder(s) test: Lukas
Uitgevoerd op: 10/05
Github commit:  COMMIT HASH

1. Ga naar de map waarin het Vagrant-script is opgeslagen in powershell.
-> Voer het commando `vagrant up` uit om de virtuele machine te starten.

Gebruik gemaakt van het commando cd om te navigeren naar de dozer folder.


2. Log manueel in op de opgestarte vm nadat powershell klaar is met het runnen van alle scripts.

Gebruikte inloggegevens "Vagrant" voor user & password => Werkt

3. Controleer of de juiste softwarepakketten zijn geïnstalleerd door de relevante commando's in de VM uit te voeren 
-> `node -v` en `npm -v`

Node -v = v16.18.1
npm -v = 9.6.5


### 2. Testplan voor Dozer script:

Uitvoerder(s) test: Lukas
Uitgevoerd op: 10/05
Github commit:  COMMIT HASH

2. Controleer of SELinux is geconfigureerd om in permissive mode te draaien door de volgende commando's uit te voeren:
-> `sudo sestatus`
    -> Controleer of SELinux is ingeschakeld en of de huidige mode permissive is.

    Commando geeft als output: "Current mode: Permissive" en de status "SELinux Status: Enabled"

-> `sudo nano /etc/selinux/config`
    -> Controleer of SELINUX=enforcing is gewijzigd naar SELINUX=permissive.

    Commando toont aan dat SELINUX=permissive toegewezen staat
   
3. Controleer of nano en git correct zijn geïnstalleerd door de volgende commando's uit te voeren:
->`nano --version`
    -> Controleer of nano is geïnstalleerd en de versie wordt weergegeven.

    Nano version = 5.6.1

-> `git --version`
    -> Controleer of git is geïnstalleerd en de versie wordt weergegeven.

    git version = 2.31.1   

### 3. Testplan voor het Emscripten Script

Uitvoerder(s) test: Lukas
Uitgevoerd op: 10/05
Github commit:  COMMIT HASH

1. Controleer of alle vereiste pakketten correct zijn geïnstalleerd. 
-> commando: `dnf list installed | grep <pakketnaam>`. 
    -> Controleer de volgende pakketten:
    - `python3`
    - `cmake`
    - `nodejs`
    - `java-1.8.0-openjdk-devel`
    
    `dnf list installed | grep python3` geeft een lijst terug met een grote hoeveelheid python3 files
    `dnf list installed | grep cmake` geeft een lijst terug met 4 files
    `dnf list installed | grep nodejs` geeft een lijst terug met 4 files
    `dnf list installed | grep java-1.8.0-openjdk-devel` geeft 1 file terug

2. Controleer of de Emscripten-repository correct is gekloond door naar de map te navigeren waarin deze zich bevindt.
 -> commando: `cd emsdk`
 -> commando: `git status`
    -> Branch is up to date

    'cd emsdk' commando werkt.
    git status geeft terug dat de branch up to date is met 'Origin/Main'


3. Controleer of de Emscripten-versie correct is geïnstalleerd en geactiveerd.
-> commando: `./emsdk list`. 
    -> De uitvoer moet de geïnstalleerde versie van Emscripten bevatten en deze moet zijn gemarkeerd als actief.

    Commando werkt en toont dat de tools geïnstalleerd & compiled zijn voor gebruik.


### 4. Testplan voor het Quake3-script

Uitvoerder(s) test: Lukas
Uitgevoerd op: 10/05
Github commit:  COMMIT HASH

1. Ga naar de map waarin het QuakeJS-script is opgeslagen.
-> `cd quakejs` (vanuit root dus eerst cd)

    Na het terugkeren naar de default map met gebruik van 'cd ..' is het mogelijk om 'cd quakejs' uit te voeren en in de map te geraken.

2. Controleer of de QuakeJS-map correct is gekloond.
-> commando: `ls`

    Map bevat volgende structuur:
    ./Base
    ./bin
    ./Build
    ./ioq3
    ./lib
    ./node_modules
    package.json
    package-lock.json
    README.md

3. Controleer of de dedicated server correct werkt door de server te starten.
-> commando: `sudo node build/ioq3ded.js +set fs_game baseq3 +set dedicated 2 +set net_ip 192.168.20.5 +set net_port 27960 +exec server.cfg`

    Commando werkt en vraagt voor de EULA agreement met de "Y" toets


### 5. Testplan voor Shorturl script.

Shorturl kan verkregen worden.

Uitvoerder(s) test: Lukas
Uitgevoerd op: 19/05
Github commit:  COMMIT HASH

### 6. Login server.

Server kan bereikt worden via de shorturl en het spel kan in de browser gespeeld worden

Uitvoerder(s) test: Lukas
Uitgevoerd op: 19/05
Github commit:  COMMIT HASH
