# Matrix Synapse en Discord Bridge Setup

Dit document begeleidt je door het opzetten van een Matrix Synapse server met een Discord-bridge op een virtuele machine met behulp van Vagrant en VirtualBox.

Auteur(s): Olivier Saenen

&nbsp;

## Vereisten Matrix Synapse

Zorg ervoor dat de volgende software op je systeem is geïnstalleerd:

- Vagrant: Een tool voor het bouwen en beheren van virtuele machine-omgevingen.
- VirtualBox: Een open-source virtualisatiesoftware.
- Git: Een versiebeheersysteem dat we zullen gebruiken om onze code te downloaden van GitHub.

Als je deze tools nog niet hebt geïnstalleerd, volg dan de onderstaande links voor instructies over hoe je dit kunt doen:

- [Vagrant installatiegids](https://www.vagrantup.com/docs/installation/)
- [VirtualBox installatiegids](https://www.virtualbox.org/wiki/Downloads)
- [Git Installatiegids](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)

Daarnaast heb je toegang nodig tot een command-line interface:

- Voor Windows-gebruikers, open de Command Prompt. Je kunt dit doen door te zoeken naar 'cmd' in het Start-menu of de zoekbalk.
- Voor Linux-gebruikers, open een Terminal venster. Meestal kan je dit doen door te zoeken naar 'terminal' in je applicaties.

In deze command-line interface zul je de commando's invoeren om Vagrant gebruiken.

&nbsp;

## Download de Repository

De benodigde bestanden voor deze setup bevinden zich in een GitHub-repository. Volg de onderstaande stappen om deze repository te klonen:

1. Open de command-line interface (Command Prompt voor Windows, Terminal voor Linux).
2. Navigeer naar de map waar je de repository wilt opslaan met behulp van het `cd` commando. Voorbeeld: `cd C:\Users\jouwgebruikersnaam\Documents`.
3. Voer het volgende commando uit om de repository te klonen: `git clone https://github.com/HoGentTIN/SEP-2223-sep-2223-t01.git`.

Dit zal een nieuwe map maken met de naam `SEP-2223-sep-2223-t01` in de huidige directory, en daar de inhoud van de repository in downloaden.

Het `Vagrantfile` bestand dat we gaan aanpassen bevindt zich in de map `opdracht Matrix.org`. Je kunt navigeren naar deze map met het commando: `cd SEP-2223-sep-2223-t01/opdracht Matrix.org`.

&nbsp;

## Aanpassingen aan het Vagrantfile bestand

Voordat je de virtuele machine opzet, moet je de naam van jouw network adapter opzoeken in jouw systeem en invoeren in het volgende gedeelte van de Vagrantfile:

- nic: _"\<VUL-NAAM-VAN-NIC-IN>\"_,

- vb.gui: _"\<TRUE-OF-FALSE>\"_

&nbsp;

## Opzetten van de virtuele machine

Om de virtuele machine te starten en de Matrix Synapse server en Discord-bridge te installeren en te configureren, voer je het volgende commando uit in de terminal in de map waar je `Vagrantfile` zich bevindt:

```bash
vagrant up
```

Laat het terminal venster open en merk op dat de volledige installatie ongeveer 15-20 minuten in beslag kan nemen.

&nbsp;

## Opzetten van de Discord Bridge

Voor het opzetten van de Discord Bridge is een client zoals Element nodig. Hiervoor is een extra VM voorzien onder directory 'opdracht Matrix.org/matrix-chat-os'. Binnen deze folder pas je aan de hand van de instructies hierboven het Vagrantfile bestand aan en voor je het `vagrant up` commando uit.

Daarnaast is er voor het gebruik van de Discord Bridge ook een Discord account nodig. Dit kan je aanmaken via de volgende link: https://discord.com/register.

Eenmaal ingelogd in Discord moet je de volgende stappen volgen om een server aan te maken:

1. Klik in de linker balk op het plus (+) pictogram in de cirkel.
2. Klik op "Create My Own".

- ![Discord create server](/opdracht%20Matrix.org/imgs/discord-create-server-1.png)

3. Klik op "For me and my friends".

- ![Discord create server](/opdracht%20Matrix.org/imgs/discord-create-server-1.png)

4. Vul de naam van je server in het 'SERVER NAME' veld in.

- ![Discord create server](/opdracht%20Matrix.org/imgs/discord-create-server-1.png)

5. Klik op 'Create' om je nieuwe server te maken.

&nbsp;
