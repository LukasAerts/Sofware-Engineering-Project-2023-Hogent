# Testplan Opdracht: bericht naar room wanneer webserver afgesloten is

Auteur(s) testplan: Olivier Saenen
&nbsp;

## Requirements

- Een werkende computer die draait op Windows of Linux met GUI
- De computer maakt deel uit van het netwerk waar de Matrix Synapse server op draait

&nbsp;

## Scope

De bedoeling van dit testplan is om na te gaan dat er een bericht naar de Matrix room gestuurd wordt wanneer de nginx webserver afgesloten wordt of heropstart.

Indien het testplan success afgerond kan worden ziet de geaccepteerde member van de room een bericht verschijnen wanneer de nginx webserver afsluit of heropstart. In het geval van een :

- shutdown is dit "Shutting nginx webserver down. Going Offline..."
- heropstart is dit "Restarting... server will be up in a few moments"

> **Extra**: Indien gewenst bestaat er onder de map /opdracht Matrix.org/matrix-chat-os/ een Vagrantfile bestand. Deze kan u a.d.h.v. de stappen "Aanpassingen aan het Vagrantfile bestand" en "Opzetten van de virtuele machine" uit het [procedures.md](procedures.md) bestand configureren. Vervolgens kan u een Debian VM opzetten met GUI die de Element en Fractal clients automatisch zal installeren. In dat geval mag u in dit document de stap "Open de Element Matrix client" in dit bestand overslaan.

&nbsp;

## Procedure:

### 1. Open de Element Matrix client

Voor het bekijken van dit bericht is een Matrix client nodig. Hierbij wordt gekozen voor Element. Hieronder volgt een installatie procedure voor Linux en Windows.

#### Windows

1. Ga naar de [Element download pagina](https://element.io/download) op uw webbrowser.
2. Klik op 'Windows' onder het gedeelte "Desktop".
3. Het downloaden van de Element installatie bestand begint automatisch.
4. Na het downloaden, ga naar de map waar het installatiebestand is opgeslagen. Dubbelklik op het bestand om het installatieproces te starten.
5. Volg de instructies op het scherm om de installatie te voltooien.

#### Linux

1. Voor de installatie van Element gebruiken we Flatpak, deze dien je dus eerst te installeren. Open een terminal en voer de volgende commando's uit:
   ```bash
   sudo dnf update -y
   sudo dnf install flatpak -y
   ```
2. Voeg de Flathub repository toe, die de meeste Flatpak applicaties bevat:
   ```bash
   flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```
3. Nu kun je Element installeren met het volgende commando:
   ```bash
   flatpak install flathub im.riot.Riot -y
   ```
4. Na de installatie, kan je Element starten in de GUI door deze aan te klikken in de lijst met applicaties of met het volgende commando:

   ```bash
   flatpak run im.riot.Riot
   ```

> **Opmerking**: afhankelijk van de Linux distro moet je `dnf` vervangen door `apt`.

**Verwacht Resultaat**: De Element client is geïnstalleerd en je kan deze openen.

**Bevestiging**:

- Windows:
  - Open het start menu en voor "Element" in de zoekbalk in. Je ziet de applicatie nu in de lijst staan.
  - Draai de applicatie door deze aan te klikken
- Linux:

  - Voer in een terminal shell het volgende commando in:
    ```bash
    flatpak list
    ```
  - Indien de applicatie in de uitvoer staat kan je deze nu draaien door deze in de VM in de lijst met applicaties aan te klikken

  - ![Flatpak list](/opdracht%20Matrix.org/imgs/flatpak-list-riot.png)
  - ![Element client](/opdracht%20Matrix.org/imgs/element-client.png)

&nbsp;

### 2. Element gebruiken

Nu de Element client functioneert dienen we deze zo te configureren dat deze gebruik maakt van de onze http://theoracle.thematrix.local homeserver. Bij het installeren van de VM [(zie testplan-installatie-vm.md)](testplan-installatie-vm.md) werd er reeds een script gedraaid dat automatisch een account aanmaakte voor de leden van de groep. De username, wachtwoord en homeserver zijn terug te vinden in het [documentatie.md](documentatie.md) bestand.

**Opmerking**: De instructies hieronder gaan ervan uit dat je Nederlands hebt ingesteld als taal van de client. Indien je deze wenst te veranderen kan je dit doen met behulp van de keuzelijst.

![Element taal](/opdracht%20Matrix.org/imgs/element-taal.png)

1. Op het startscherm van de Element client vindt je de volgende knoppen `Inloggen`, `Registreren` en `Kamers ontdekken`. Kies `Inloggen`.

   ![Element stap 1](/opdracht%20Matrix.org/imgs/element-stap-1.png)

2. Op het scherm "Inloggen" kies je de homeserver. Dit is de server waarop we Matrix Synapse installeerden (http://theoracle.thematrix.local). Om deze in te stellen druk onder "Homeserver" op `Bewerken`.

   ![Element stap 2](/opdracht%20Matrix.org/imgs/element-stap-2.png)

   - Onder het scherm "Login op jouw homeserver" vink je vervolgens `Andere homeserver` aan en voer je de volgende data in:

   ```bash
   http://theoracle.thematrix.local
   ```

   - Klik op `Doorgaan`

     ![Element stap 2 homeserver](/opdracht%20Matrix.org/imgs/element-stap-2-homeserver.png)

3. De vorige actie brengt je terug op het scherm "Inloggen" waar we nu onze username en wachtwoord kunnen ingeven. Druk vervolgens op `Inloggen`.

   ![Element stap 3](/opdracht%20Matrix.org/imgs/element-stap-3.png)

4. Klik op het scherm nu de "WE ARE HOGENT" room aan. Merk op dat je de vraag krijgt of je tot deze room wil toetreden. Je krijgt de keuze `Aannemen`, `Weigeren en persoon negeren` en `Weigeren`. Druk op `Aannemen`.

   ![Element stap 4](/opdracht%20Matrix.org/imgs/element-stap-4.png)

5. Vanuit het toestel dat de Matrix Synapse server (en nginx webserver) draait, zullen we nu de nginx service uitschakelen en heropstarten om na te gaan of er een bericht gestuurd wordt naar de Matrix room. Hiervoor dienen we ingelogd te zijn op de server. Dit doet je door vanuit de server een terminal venster te openen en het volgende commando uit te voeren:

   > **Belangrijk**: Laat ten minste een minuut de tijd tussen de onderstaande commando's zodat deze uitgevoerd kunnen worden en dat de output ervan nagekeken kan worden in jouw Matrix client (hier Element)

   - ```bash
     sudo systemctl restart nginx
     ```

   - ```bash
     sudo systemctl stop nginx
     ```

   - ```bash
     sudo systemctl start nginx
     ```

   - ![Element client](/opdracht%20Matrix.org/imgs/element-stap-5-start.png)

- > **Opmerking**: Indien je geen toegang hebt tot dit toestel kan je de admin vragen om de bovenstaande commando's uit te voeren

**Verwacht Resultaat**:

- Je ontvangt in de Element room een bericht bij het heropstarten of afsluiten van de nginx service.

  - In het geval van een heropstart is dit:

    > Shutting nginx webserver down. Going Offline...

    > Nginx up and running again!

  - In het geval een start van de nginx service is dit:

    > Nginx up and running again!

  - In het geval van een shutdown is dit:
    > Shutting nginx webserver down. Going Offline...

**Bevestiging**: Voer de bovenstaande stappen uit en ga na of de berichten gestuurd werden in de room.

&nbsp;

## Rapport

- De resultaten van dit testplan zijn na te lezen in het [testrapport](testrapport-server-down-message.md)
