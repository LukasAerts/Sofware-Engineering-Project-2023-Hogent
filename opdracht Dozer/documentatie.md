### Documentatie Opdracht Dozer: (Vagrantscript,Emscripten,QuakeJS,Shorturl)

De Dozer-opdracht heeft als doel een werkende Almalinux-VM op te zetten die is opgenomen in het 'thematrix.local'-domein. Nadat de VM is opgezet, kunnen alle computers die met dit netwerk zijn verbonden, toegang krijgen tot QuakeJS via het IP-adres dat is toegewezen aan de Almalinux-VM. De opdracht omvat ook de creatie van een shorturl.
Na het uitvoeren van deze scripts zou u in staat moeten zijn QuakeJs te raadplegen op "192.168.20.5"  (nader te veranderen door de shorturl link).
Hieronder vindt u de documentatie voor elk van de vier scripts.

### Login gegevens dozer VM

Login: vagrant
Password: vagrant

###  1.Vagrantscript
Voor het aanmaken van een ​​Almalinux virtuele machine en het configureren maken we gebruik van Vagrant. Het script installeert de vereiste software (Git, Ansible) en configureert de virtuele machine om te worden gebruikt met Ansible. Vervolgens start het script de virtuele machine.
Dit script bevindt zich in de hoofdfolder voor deze opdracht: ./Dozer/
Om het script uit te voeren, moet u Vagrant en VirtualBox op uw computer hebben geïnstalleerd. U kunt het script uitvoeren door het bestand uit te voeren met de naam "vagrant.sh".
-> Powershell
cd 'C:\Folder waarin het script zich bevindt'
in powershell -> vagrant up

### 2.Dozer script

Door middel van dit script zorgen we ervoor dat we enkele configuratiewijzigingen aan brengen op de Almalinux-machine. Het script schakelt de mogelijkheid uit om als root verbinding te maken via SSH, schakelt wachtwoordgebaseerde verificatie uit en schakelt SSH-sleutelverificatie in. Het script schakelt SELinux in en configureert Nano en Git. 
Het dozer script bevindt zich in ./Dozer/Shared/Script
Om het script uit te voeren, moet u het uitvoerbare bestand met de naam "dozer.sh" uitvoeren. 

### 3.Emscripten script

Dit script kan worden gebruikt om Emscripten te installeren, een LLVM-gebaseerde toolkit die wordt gebruikt om C- en C ++ -code te compileren naar WebAssembly. Het script installeert de vereiste software (Git, Python, CMake, Node.js, Java JDK) en downloadt en installeert Emscripten vanuit de broncode. Ten slotte stelt het script de omgevingsvariabelen in voor de huidige shell.
Het emscripten script bevindt zich in ./Dozer/Shared/Script
Om het script uit te voeren, moet u Git, Python, CMake, Node.js en Java JDK op uw computer hebben geïnstalleerd. U kunt het script uitvoeren door het bestand uit te voeren met de naam "emscripten.sh". 

### 4.Quakejscript

Vervolgens maken we gebruik van het script datwordt gebruikt om een ​​Quake III Arena-server op te zetten met behulp van de QuakeJS-code. Het script installeert de vereiste software (Git, Node.js) en downloadt de QuakeJS-code. Vervolgens initialiseert en werkt het script de submodules bij, installeert het de afhankelijkheden en downloadt het de basisgamebestanden. Ten slotte wordt de server gestart met behulp van een configuratiebestand.
Het Quake3 script bevindt zich in ./Dozer/Shared/Script
Om het script uit te voeren, moet u Git en Node.js op uw computer hebben geïnstalleerd. U kunt het script uitvoeren door het bestand uit te voeren met de naam "quakejs.sh". 

Om toegang te krijgen tot QuakeJS, moet je naar het IP-adres van de virtuele machine navigeren, dat wordt weergegeven in de uitvoer van het vagrantscript. Dit IP-adres is "192.168.20.5".

http://www.quakejs.com/play?connect%20192.168.20.5:27960


### 5.Shorturl script

Het ShortURL-script is een zelfgehoste URL-verkorterwebtoepassing. Het biedt de mogelijkheid om lange en complexe URL's te verkorten, waardoor ze gemakkelijker kunnen worden gedeeld of ingebed.

Het script wordt geïnstalleerd met behulp van Go en maakt gebruik van verschillende externe pakketten, zoals go.rice voor het inbedden van statische assets en bitcask als een key/value-opslag voor het opslaan van URL-gegevens.

Het installatieproces omvat het ophalen van de vereiste pakketten met behulp van go get en het bouwen van de applicatie met go build. Vervolgens kan de ShortURL-webtoepassing worden uitgevoerd met het commando ./shorturl.

De webtoepassing wordt standaard uitgevoerd op http://192.168.20.5:8000/, waar gebruikers verkorte URL's kunnen maken en de gegenereerde URL's kunnen openen om naar de oorspronkelijke URL te worden doorverwezen.

Het script ondersteunt configuratieopties, zoals het opgeven van een aangepast pad voor het opslaan van URL-gegevens en het instellen van een basis-URL voor weergavedoeleinden.