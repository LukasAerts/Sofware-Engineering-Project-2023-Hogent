# Testrapport Opdracht thematrix.local: voeren geëcrypteerd gesprek

(Een testrapport is het verslag van de uitvoering van het testplan door een teamlid (iemand anders dan de auteur van het testplan!). Deze noteert bij elke stap in het testplan of het bekomen resultaat overeenstemt met wat verwacht werd. Indien niet, dan is het belangrijk om gedetailleerd op te geven wat er misloopt, wat het effectieve resultaat was, welke foutboodschappen gegenereerd werden, enz. De tester kan meteen een Github issue aanmaken en er vanuit het testrapport naar verwijzen. Wanneer het probleem opgelost werdt, wordt een nieuwe test uitgevoerd, met een nieuw verslag.)

## Test voeren geëcrypteerd gesprek

Uitvoerder(s) test: Van Driessche Stein
Uitgevoerd op: 24/05/2023
Github commit: COMMIT HASH

### 1. Een room aanmaken en gebruikers uitnodigen

Een room aanmaken en gebruikers uitnodigen
Vanuit het startscherm dat we zien na het inloggen op de homeserver, voeren we volgende zaken uit:

1. Klik op het "+" icoon naast "Kamers" in de linker zijbalk.
2. Selecteer "Nieuwe kamer".
3. Geef je kamer een naam en optioneel een onderwerp. De kamer is een privékamer. We schakelen de eind-tot-end-versleuteling in.
4. Klik op "Ruimte aanmaken".
5. De kamer is aangemaakt en zichtbaar op het scherm.

   ![Element nieuwe room maken](/opdracht%20Matrix.org/imgs/newroomstein.PNG)

Om gebruikers uit te nodigen, klik je op "Uitnodigen voor deze kamer". Voer de username van de gebruiker(s) in die je wilt uitnodigen en klik op "Uitnodigen".

- de username kent de volgende vorm: `@<naam>:theoracle.thematrix.local`

![Element uitnodigingen sturen](/opdracht%20Matrix.org/imgs/element-uitnodigen.png)
![Element uitnodigingen sturen](/opdracht%20Matrix.org/imgs/element-uitnodigingen.png)

6. Verstuur een bericht naar keuze, bijvoorbeeld "Hallo, ik ben @olivier:theoracle.thematrix.local. Ik verstuur vanuit Element".

**Verwacht Resultaat**: De uitnodigingen werden verstuurd.

**Bevestiging**: Je kan nagaan dat de uitnodigingen verstuurd werden door de room aan te klikken. Er wordt een melding gegeven wanneer een uitnodiging verstuurd werd.

-> Stein invited olivier

&nbsp;

## Procedure Fractal (Almalinux)

Bij het schrijven van het testplan voor het gedeelte waar Fractal geconfigureerd wordt, logden we op deze client in als `@stein:theoracle.thematrix.local`.

### 1. Installatie Fractal

1. Voor de installatie van Fractal gebruiken we Flatpak, deze dien je dus eerst te installeren. Open een terminal en voer de volgende commando's uit:
   ```bash
   sudo dnf update -y
   sudo dnf install flatpak -y
   ```
2. Voeg de Flathub repository toe, die de meeste Flatpak applicaties bevat:
   ```bash
   flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```
3. Nu kun je Fractal installeren met het volgende commando:

   ```bash
   flatpak install flathub org.gnome.Fractal -y

   -> uitvoeren met sudo anders failed to install
   ```

4. Na de installatie, kan je Fractal starten in de GUI door deze aan te klikken in de lijst met applicaties of met het volgende commando:

   ```bash
   flatpak run org.gnome.Fractal

   -> Werkt en start op
   ```

### 2. Login Fractal

1. Op het startscherm dien je eerst een "Provider" in te voeren. Dit staat synoniem met onze homeserver. Voer deze in en klik op `Next`.

   > http://theoracle.thematrix.local

   ![Fractal provider](/opdracht%20Matrix.org/imgs/fractal-provider.png)

2. Voer je username en wachtwoord in en klik op `Log In`.

   ![Fractal login](/opdracht%20Matrix.org/imgs/fractal-login.png)

**Verwacht Resultaat**: De Fractal client is geïnstalleerd en je kan deze openen.

![Fractal installed](/opdracht%20Matrix.org/imgs/fractalinstalled.PNG)

**Bevestiging**:

- Voer in een terminal shell het volgende commando in:

  ```bash
    flatpak list
  ```

  ```
  [vagrant@almalinux ~]$ flatpak list

  Name Application ID Version Branch Installation
  Element im.riot.Riot 1.11.31 stable system
  Freedesktop Platform org.freedesktop.Platform 22.08.11 22.08 system
  Mesa org.freedesktop.Platform.GL.default 23.0.2 22.08 system
  Mesa (Extra) org.freedesktop.Platform.GL.default 23.0.2 22.08-extra system
  ffmpeg-full org.freedesktop.Platform.ffmpeg-full 22.08 system
  openh264 org.freedesktop.Platform.openh264 2.1.0 2.2.0 system
  Fractal org.gnome.Fractal 4.4.2 stable system
  GNOME Application Platform version 44 org.gnome.Platform 44 system

  ```

- Indien de applicatie in de uitvoer staat kan je deze nu draaien door deze in de lijst met applicaties aan te klikken

  ![Flatpak list](/opdracht%20Matrix.org/imgs/flatpak-list-fractal.png)

  ![Fractal client](/opdracht%20Matrix.org/imgs/fractal-client.PNG)

  ```

  ```

### 3. Een room aanmaken en gebruikers uitnodigen

Eens ingelogd op de Fractal client, zal je merken dat er in de linkse balk een lijst staat met rooms waarvoor we uitgenodigd zijn:

1. Klik op de "Groepsgesprek" room
2. Klik op "Accept" om het gesprek in de "Groepsgesprek" room bij te wonen

![invite olivier](/opdracht%20Matrix.org/imgs/inviteolivier.PNG)

3. Ga naar de linkerbalk en klik onder "Rooms" de room "Groepsgesprek" aan. Verstuur een bericht naar keuze, bijvoorbeeld "Hallo, ik ben @stein:theoracle.thematrix.local. Ik verstuur vanuit Fractal".

-![Fractal bericht](/opdracht%20Matrix.org/imgs/gesprek.PNG)

**Verwacht Resultaat**: Gebruiker @olivier:theoracle.thematrix.local verstuurde een bericht in de room.

**Bevestiging**: Gebruiker @olivier:theoracle.thematrix.local ziet in zijn Element client het bericht van olivier verschijnen.

-![Fractal bericht](/opdracht%20Matrix.org/imgs/gesprek.PNG)
