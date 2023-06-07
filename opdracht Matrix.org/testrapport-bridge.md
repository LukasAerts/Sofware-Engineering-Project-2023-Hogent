# Testrapport Opdracht Matrix.org: (bridge naar Discord)

## Test bridge naar Discord

Uitvoerder(s) test: Van Driessche Stein
Uitgevoerd op: 24/05/2023
Github commit: COMMIT HASH

# Testplan Opdracht: bridge naar Discord

Auteur(s) testplan: Olivier Saenen

&nbsp;

## Requirements

- Een werkende computer die draait op Windows of Linux
- De computer maakt deel uit van het netwerk waar de Matrix Synapse server op draait
- Element client
- Een Discord account
- Toegang tot een Discord-server waarvan je beheerder bent of de juiste rechten hebt

&nbsp;

## Scope

De bedoeling van dit testplan is om een brug (bridge) op te zetten van onze Matrix server naar onze Discord server. Op die manier worden berichten die we versturen in onze Discord guild (vergelijkbaar met room) ook zichtbaar in een speciale Matrix room die automatisch opgezet wordt.

Indien alles geluk is ziet het eindresultaat er als volgt uit vanuit de command prompt doormiddel van commando `curl localhost` of in de GUI:

- ![Matrix view](/opdracht%20Matrix.org/imgs/bericht-discord.png)
- ![Discord view](/opdracht%20Matrix.org/imgs/bericht-element.png)

> **Opmerking**: Vanuit de Vagrantfile werd reeds een script discord-bridge-setup.sh opgeroepen dat de nodige dependencies installeerde en matrix-discord configureerde om met onze specifieke server te werken.

&nbsp;

## Procedure:

### Stap 1. Een Discord bot account maken (mautrix-discord)

1. Ga naar de [Discord Developer Portal](https://discord.com/developers/applications)
2. Klik op de knop "New Application"
   Niet aanwezig: de pagina doet een redirect naar de login pagina van discord.
3. Geef je applicatie een naam en klik op "Create"

- ![Discord Create Application](/opdracht%20Matrix.org/imgs/matrixtest.PNG)

### Stap 2: Bot Toevoegen en token verkrijgen

1. Klik op het tabblad "Bot" aan de linkerkant van de applicatiepagina
2. Kies een naam voor deze bot en vul deze in onder het deel "USERNAME". Bijvoorbeeld "The Oracle"
3. Onder de username zie je een knop "RESET TOKEN". Klik deze aan en kopieer de code. Dit is het token van de bot. Hou deze goed bij gezien je deze later nodig hebt

- ![Discord reset token](/opdracht%20Matrix.org/imgs/resettoken.PNG)

4. Pas de volgende instellingen onder `Authorization Flow` en `Privileged Gateway Intents` aan:

   - **PUBLIC BOT**: AAN
   - **REQUIRES OAUTH2 CODE GRANT**: UIT
   - **PRESENCE INTENT**: UIT
   - **SERVER MEMBERS INTENT**: AAN
   - **MESSAGE CONTENT INTENT**: AAN

   -> Done

5. Onder "BOT PERMISSIONS" klik je op "Administrator"

- ![Discord bot permissions](/opdracht%20Matrix.org/imgs/discord-bot-permissions.png)

6. Onderaan het scherm krijg je een melding dat er onopgeslagen aanpassingen zijn. Bevestig deze door op "Save Changes" te drukken.

- ![Discord bot creation](/opdracht%20Matrix.org/imgs/discord-create-bot.png)
- ![Discord bot settings](/opdracht%20Matrix.org/imgs/discord-bot-settings.png)

### Stap 3: OAuth URL Generator

1. Klik op het tabblad "OAuth2" -> "URL Generator" aan de linkerkant van de applicatiepagina
2. Selecteer de volgende opties onder `Scopes`:

   - "bot"

3. Selecteer de volgende opties onder `Bot Permissions`:

   - "Administrator"

4. Onderaan de pagina zie je onder "GENERATED URL" een link staan. Kopieer deze en open deze in een nieuw tabblad. Hou deze bij voor later.

- ![Discord url gen](/opdracht%20Matrix.org/imgs/generatedurl.PNG)

### Stap 4: De bot toevoegen aan Matrix

1. Open de Element client
2. Start een nieuwe chat met `@discordbot:theoracle.thematrix.local` door deze op te zoeken en aan te klikken. Bevestig met de knop `Start`.

   - ![Element nieuwe chat](/opdracht%20Matrix.org/imgs/discord-bot-element-nieuwe-chat.png)
   - ![Element nieuwe chat](/opdracht%20Matrix.org/imgs/discord-bot-element-nieuwe-chat-2.png)

3. Schrijf een willekeurig bericht om de bot uit te nodigen aan de chat. Deze zal automatisch de chat accepteren.

4. Stuur in de Element chat nu het volgende bericht (dit is een commando voor de bot).

   - ![Element Discord bot chat](/opdracht%20Matrix.org/imgs/botchat.PNG)

```bash
login-token bot <TOKEN>
```

Hierbij vervang je `<TOKEN>` met het token van de bot. Deze verkreeg je in Stap 2 bij het aanmaken van de Discord bot. De Discord bot zal dit in de Element bevestigen indien het commando correct was.

- ![Element Discord bot gelinkt](/opdracht%20Matrix.org/imgs/discordbridge.PNG)

### Stap 5: Guild ID bekomen

Om een Discord Guild (vergelijkbaar met room in Matrix) te linken met onze Matrix client, dienen we eerst de Guild ID te bekomen. Hiervoor moet je Developer Mode inschakelen in Discord:

1. Open Discord en ga naar "Settings" -> "Advanced" -> "Enable Developer Mode"

- ![Discord developer mode](/opdracht%20Matrix.org/imgs/devmode.PNG)

2. Ga naar het startscherm van jouw Discord omgeving en maak een nieuwe server aan indien gewenst. Rechtsklik op de naam van de server en selecteer "Copy ID"

-> 189397982771281921

### Stap 6: Voeg de Discord bot toe aan de Guild

Neem opnieuw de URL die we in het Discord Developer Portal creëerden en open deze in een nieuwe tab. Hiermee voegen we de Discord bot toe aan onze server. Bevestig de server waaraan je deze wil toevoegen en klik op "Continue".

Druk vervolgens op "Authorize"

- ![Discord bot toegang tot guild](/opdracht%20Matrix.org/imgs/bothelltower.PNG)

In de Discord Guild krijg je hiervan nu een bevestiging "The Oracle hopped into the server".

### Stap 7: De Guild bridgen

Om de Discord Guild te bridgen naar onze Matrix client (Element), openen we Element in onze chat met de Discord Bot en sturen we volgend bericht:

```bash
!discord guilds bridge <GUILD-ID>
```

Hierbij vervang je `<GUILD-ID>` met de ID van de Guild die we in stap 6 kopieerden vanuit Discord. Na uitvoering krijg je een bericht van de Discord Bot in de Element room.

Accepteer de invites op Element.

- ![Discord bridged](/opdracht%20Matrix.org/imgs/discord-bridged.png)

Tot slot voer je volgende commando om de bridging mode in te stellen:

```bash
!discord guilds bridging-mode <GUILD-ID> everything
```

Hierbij vervang je `<GUILD-ID>` met de ID van de Guild die we in stap 6 kopieerden vanuit Discord. Na uitvoering krijg je een bericht van de Discord Bot in de Element room.

- ![Discord bridging mode](/opdracht%20Matrix.org/imgs/discord-bot-bridging-mode.png)

### Stap 8: Verstuur een eerste bericht

Verstuur nu vanuit jouw Discord Guild een bericht. Merk op dat je in Matrix nu een invite zal krijgen met als room-naam de naam van het kanaal in Discord. Accepteer deze invite.

Je kan nu eventueel nog andere mensen toevoegen door andere gebruikers uit te nodigen via Discord.

De bridge is nu volledig af!

- ![Bridge message](/opdracht%20Matrix.org/imgs/bericht-discord.png)
- ![Bridge message](/opdracht%20Matrix.org/imgs/bericht-element.png)

**Verwacht Resultaat**:

- De bridge is opgezet en je kan een chat voeren

-> Werkt volledig
