### Procedures Opdracht Dozer: (Vagrantscript,Emscripten,QuakeJS,Shorturl)

**_ Folderstructuur _**
Voor het succesvol uitvoeren van de scripts moet je beschikken over volgende structuur:
    ./Dozer/ -> Bevat Vagrantscript voor het aanmaken van de Almalinux VM.
    ./Dozer/Shared/Script -> Bevat dozer.sh, quake3.sh en emscripten.sh (later volgt contentserver.sh en shorturl.sh)

 **_ Pas Script Aan_**

 # nic aan te passen naargelang pc
    config.vm.network "public_network", 
    bridge: "eth1",
    nic: "Realtek PCIe GBE Family Controller" `-> PAS NIC AAN MET JE EIGEN NIC`,
    ip: "192.168.20.5"  

 **_ Start Script _**
Dozer maakt gebruik van een vagrantscript voor de aanmaak van een Almalinux virtuele machine en installeert vervolgens door middel van de 3 bovenvernoemde scripts QuakeJS alsook ShortURL (nog niet aangemaakt op 27/04).

Ga in powershell naar de map waarin het Vagrant-script is opgeslagen.
Dit kan door middel van cd 'C:\locatievanscript'

-> Voer het commando "vagrant up" uit om de virtuele machine te starten.

Het script zal automatisch verder gaan met de installatie van de Provisioning scripts in de volgorde: dozer, emscripten, quakejs en shorturl alsook de VM starten.

-> voer na het inloggen op de VM onderstaande commando uit voor het starten van de QUAKEJS server.

commando: `sudo node build/ioq3ded.js +set fs_game baseq3 +set dedicated 2 +set net_ip 192.168.20.5 +set net_port 27960 +exec server.cfg`


 **_ Login gegevens dozer VM _**
 
Login: vagrant
Password: vagrant