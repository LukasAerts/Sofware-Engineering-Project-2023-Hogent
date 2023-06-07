# Testplan Opdracht: voeren geëcrypteerd gesprek

Auteur(s) testplan: Olivier Saenen
&nbsp;

## Requirements

- Een werkende computer die draait op Windows of Linux met GUI
- De computer maakt deel uit van het netwerk waar de Matrix Synapse server op draait

&nbsp;

## Scope

De bedoeling van dit testplan is om na te gaan dat we via onze Matrix server die gehost wordt op http://theoracle.thematrix.local effectief ook een chatgesprek kunnen voeren tussen ten minste twee verschillende gebruikers. Hiervoor zullen we een room aanmaken, gebruikers uitnodigen en tot slot ook een korte chat voeren. Om diverse omgevingen uit te testen, geeft dit testplan de setup voor:

- Element (Windows)
- Fractal (Almalinux)

De gegevens om in te loggen op de clients kan je terugvinden in het [documentatie.md](documentatie.md) bestand.

> **Opmerking**: De bovenstaande clients werken op meerdere distributies, maar voor het aanmaken van dit testplan werd gebruik gemaakt van de hierboven vernoemde besturingssystemen/distro's.

> **Opmerking**: De setup van Element werd reeds uitgescreven in [het testplan-server-down-message.md bestan](testplan-server-down-message.md). Er wordt vanuit gegaan dat deze client werkt. We bouwen hierop verder.

> **Extra**: Indien gewenst bestaat er onder de map /opdracht Matrix.org/matrix-chat-os/ een Vagrantfile bestand. Deze kan u a.d.h.v. de stappen "Aanpassingen aan het Vagrantfile bestand" en "Opzetten van de virtuele machine" uit het [procedures.md](procedures.md) bestand configureren. Vervolgens kan u een Debian VM opzetten met GUI die de Element en Fractal clients automatisch zal installeren. In dat geval mag u in dit document meteen de stap "Een room aanmaken en gebruikers uitnodigen" in dit bestand uitvoeren.

Indien alles geluk is ziet het eindresultaat er als volgt uit vanuit de client:

- ![Chat gesprek Element](/opdracht%20Matrix.org/imgs/eindresultaat-gesprek.png)

&nbsp;

## Procedure Element

Zoals eerder vermeld gaan we er hier van uit dat Element reeds geïnstalleerd werd. Bij het schrijven van het testplan voor het gedeelte waar Element geconfigureerd wordt, was het ingelogde account op deze client `@olivier:theoracle.thematrix.local`.

### 1. Een room aanmaken en gebruikers uitnodigen

Een room aanmaken en gebruikers uitnodigen
Vanuit het startscherm dat we zien na het inloggen op de homeserver, voeren we volgende zaken uit:

1. Klik op het "+" icoon naast "Kamers" in de linker zijbalk.
2. Selecteer "Nieuwe kamer".
3. Geef je kamer een naam en optioneel een onderwerp. De kamer is een privékamer. We schakelen de eind-tot-end-versleuteling in.

   ![Element nieuwe room maken](/opdracht%20Matrix.org/imgs/element-nieuwe-kamer.png)

4. Klik op "Ruimte aanmaken".

   ![Element room aanmaken](/opdracht%20Matrix.org/imgs/element-privekamer-aanmaken.png)

5. De kamer is aangemaakt en zichtbaar op het scherm. Om gebruikers uit te nodigen, klik je op "Uitnodigen voor deze kamer". Voer de username van de gebruiker(s) in die je wilt uitnodigen en klik op "Uitnodigen".

   - de username kent de volgende vorm: `@<naam>:theoracle.thematrix.local`

   ![Element uitnodigingen sturen](/opdracht%20Matrix.org/imgs/element-uitnodigen.png)
   ![Element uitnodigingen sturen](/opdracht%20Matrix.org/imgs/element-uitnodigingen.png)

6. Verstuur een bericht naar keuze, bijvoorbeeld "Hallo, ik ben @olivier:theoracle.thematrix.local. Ik verstuur vanuit Element".

**Verwacht Resultaat**: De uitnodigingen werden verstuurd.

**Bevestiging**: Je kan nagaan dat de uitnodigingen verstuurd werden door de room aan te klikken. Er wordt een melding gegeven wanneer een uitnodiging verstuurd werd.

![Element uitnodigingen verstuurd](/opdracht%20Matrix.org/imgs/element-uitnodigingen-verstuurd.png)

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
   sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
   ```
3. Nu kun je Fractal installeren met het volgende commando:
   ```bash
   sudo flatpak install flathub org.gnome.Fractal -y
   ```
4. Na de installatie, kan je Fractal starten in de GUI door deze aan te klikken in de lijst met applicaties of met het volgende commando:

   ```bash
   sudo flatpak run org.gnome.Fractal
   ```

### 2. Login Fractal

1. Op het startscherm dien je eerst een "Provider" in te voeren. Dit staat synoniem met onze homeserver. Voer deze in en klik op `Next`.

   > http://theoracle.thematrix.local

   ![Fractal provider](/opdracht%20Matrix.org/imgs/fractal-provider.png)

2. Voer je username en wachtwoord in en klik op `Log In`.

   ![Fractal login](/opdracht%20Matrix.org/imgs/fractal-login.png)

**Verwacht Resultaat**: De Fractal client is geïnstalleerd en je kan deze openen.

**Bevestiging**:

- Voer in een terminal shell het volgende commando in:

  ```bash
    flatpak list
  ```

- Indien de applicatie in de uitvoer staat kan je deze nu draaien door deze in de lijst met applicaties aan te klikken

  ![Flatpak list](/opdracht%20Matrix.org/imgs/flatpak-list-fractal.png)

### 3. Een room aanmaken en gebruikers uitnodigen

Eens ingelogd op de Fractal client, zal je merken dat er in de linkse balk een lijst staat met rooms waarvoor we uitgenodigd zijn:

1. Klik op de "Groepsgesprek" room
2. Klik op "Accept" om het gesprek in de "Groepsgesprek" room bij te wonen

   - ![Fractal invite aanvaarden](/opdracht%20Matrix.org/imgs/fractal-invited-groepsgesprek.png)

3. Ga naar de linkerbalk en klik onder "Rooms" de room "Groepsgesprek" aan. Verstuur een bericht naar keuze, bijvoorbeeld "Hallo, ik ben @stein:theoracle.thematrix.local. Ik verstuur vanuit Fractal".

   - ![Fractal bericht](/opdracht%20Matrix.org/imgs/fractal-bericht.png)

**Verwacht Resultaat**: Gebruiker @stein:theoracle.thematrix.local verstuurde een bericht in de room.

**Bevestiging**: Gebruiker @olivier:theoracle.thematrix.local ziet in zijn Element client het bericht van stein verschijnen.

- ![Element tweede bericht](/opdracht%20Matrix.org/imgs/element-tweede-bericht.png)

- ![Element derde bericht](/opdracht%20Matrix.org/imgs/eindresultaat-gesprek.png)

&nbsp;

## Rapport

- De resultaten van dit testplan zijn na te lezen in het [testrapport](testrapport-gesprek.md)
