# Testplan Opdracht: theoracle Matrix.org server installatie

Auteur(s) testplan: Olivier Saenen
&nbsp;

## Requirements

- Een werkende computer die draait op Windows of Linux
- Git staat geïnstalleerd op de computer
- Vagrant software geïnstalleerd op de computer
- VirtualBox software geïnstalleerd op de computer

&nbsp;

## Scope

De bedoeling van dit testplan is om na te gaan dat het uitvoeren van het vagrant script het eindresultaat geeft dat we op http://theoracle.thematrix.local een draaiende Matrix server krijgen die bereikbaar is voor andere hosts op het netwerk.

Indien alles geluk is ziet het eindresultaat er als volgt uit vanuit de command prompt door middel van commando `curl localhost` of in de GUI:

- ![Server installed shell](/opdracht%20Matrix.org/imgs/testplan-server-setup-1.png)
- ![Server installed GUI](/opdracht%20Matrix.org/imgs/testplan-server-setup-2.png)

&nbsp;

## Procedure:

### 1. Download de benodigde files vanuit de repository

De installatie-scripts bestaan uit meerdere bash scripts en files in de provisioning folder zitten van de gedownloade repository folder. Met de volgende stap kan je deze naar een directory naar keuze downloaden.

Deze directory is ook meteen de directory van waaruit we de Vagrantfile zullen draaien in de volgende stap.

1. Open de terminal op je computer.
2. Navigeer naar de directory waar we de repository willen downloaden.
3. Voer volgende commande uit:

   ```
   git clone --depth 1 --filter=blob:none --sparse https://github.com/HoGentTIN/SEP-2223-sep-2223-t01.git
   ```

   Dit commando kloont onze repository met een 'sparse checkout', wat wil zeggen dat we enkel de files downloaden die we nodig hebben, en dus niet de hele repository.

4. Navigeer naar de directory van onze gekloonde repository:

   ```
   cd SEP-2223-sep-2223-t01
   ```

5. Zet sparse checkout aan door volgende commando uit te voeren:

   ```
   git config core.sparsecheckout true
   ```

6. We specifiëren met volgend commando de directory die we willen downloaden:

   ```
   echo opdracht Matrix.org/ >> .git/info/sparse-checkout
   ```

7. Update de repository en download de directory:

   ```
   git checkout main
   ```

   Dit zal de bestanden en folders binnen "opdracht Matrix.org" downloaden naar onze computer.

**Verwacht Resultaat**: Er bestaat een folder opdracht Matrix.org met als inhoud de files die we gekloond hebben uit onze repo

**Bevestiging**: Commando `tree` binnen de directory waar we in kloonde toont dat deze files bestaan

&nbsp;

### 2. Vagrantfile aanpassen

Pas het Vagrantfile bestand aan volgens de instructies onder "Aanpassingen aan het Vagrantfile bestand" in het [procedures.md](procedures.md) bestand.

&nbsp;

### 3. Vagrant script uitvoeren

Nu onze github directory gekloond is hebben we de benodigde files om het Vagrant script uit te voeren dat onze server automatisch zal installeren en voorzien van de benodigde packages en data.

Binnen dezelfde directory `cd SEP-2223-sep-2223-t01` waarin we ons nu bevinden voeren we volgende commando's uit

1. Ga naar de opdracht Matrix.org directory:

   ```
   cd opdracht Matrix.org
   ```

2. Laat de Vagrant provisioner opstarten en uitvoeren (dit kan afhankelijk van jouw systeem +- 15 minuten in beslag nemen):

   ```
   vagrant up
   ```

3. Na de installatie en reboots kijken we de status van onze vagrant VM na en loggen we via de shell in op onze server doormiddel van het volgende commando:

   ```
   vagrant status
   vagrant ssh
   ```

   Bij de prompt om het wachtwoord die daarop volgt, vul je wachtwoord `vagrant` in.

**Verwacht Resultaat**:

- De `Current machine status` voor onze default box is `running`
- We zijn ingelogd op onze webserver via ssh

**Bevestiging**:
Uitvoer van `vagrant status` toont dat de default machine `running` is, en de gebruiker van onze user op de server in de shell wordt getoont en we kregen een bericht over onze login:

> Last Login: (date) from (ip)

> vagrant@almalinux ~

&nbsp;

### 4. Correcte installatie bevestigen

In deze stap gaan we na of het script voor de gewenst resultaten gezorgd heeft. Dit doen we doormiddel van enkele commando's die de status van de services nagaan alsook het `curl` commando.

1.  We gaan na dat de nodige services "active (running)" zijn. Binnen onze ssh verbinding met de server, voer je volgende commando's uit::

    ```
    sudo systemctl status nginx
    sudo systemctl status synapse.service
    ```

    **Verwacht Resultaat**: de services zijn `'active (running)'`

    **Bevestiging**: voer het de commando's hierboven uit om te bevestigen

    ![Nginx service](/opdracht%20Matrix.org/imgs/systemctl-nginx.png)

    ![Synapse service](/opdracht%20Matrix.org/imgs/systemctl-synapse-service.png)

2.  Nu we weten dat de diensten goed draaien, is het belangrijk na te gaan dat het user-room-config.sh juist uitgevoerd werd. Dit doen we door de commando's op te roepen die een lijst geven van de aangemaakte users alsook de rooms die er bestaan op onze server:

    Source de nodige variabelen

    ```
    source /home/vagrant/synapse/calculated-environment-vars
    ```

    Geef lijst van alle aangemaakte gebruikers.

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_synapse/admin/v2/users | jq -r '.users[].name'
    ```

    Geef lijst van aangemaakte rooms

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_synapse/admin/v1/rooms/$ROOM_ID | jq '.name'
    ```

    Geef lijst van uitgenodigde gebruikers binnen onze room. Eerst als userid, dan als displayname.

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/members | jq -r '.chunk[].state_key'
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/members | jq -r '.chunk[].content.displayname'

    ```

    Geef lijst van de gebruikers die effectief deel uitmaken van de room (na accepteren invite). Afhankelijk van het aantaal users die de invite geaccepteerd heeft, kan de lijst hier verschillen. Maar de "@bot:theoracle.thematrix.local" is als maker en admin sowieso deel van de room.

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" "$SYNAPSE_SERVER/_synapse/admin/v1/rooms/$ROOM_ID/members" | jq '.members'
    ```

    **Verwacht Resultaat**: De commando's geven een waarde terug voor de aangemaakte gebruikers, rooms en de users die zich in de room bevinden.

    **Bevestiging**: voer het de commando's hierboven uit om te bevestigen

    ![Lijst aangemaakte gebruikers](/opdracht%20Matrix.org/imgs/lijst-aangemaakte-gebruikers.png)

    ![Lijst aangemaakte rooms](/opdracht%20Matrix.org/imgs/lijst-aangemaakte-rooms.png)

    ![Lijst uitgenodigde gebruikers voor room](/opdracht%20Matrix.org/imgs/lijst-uitgenodigde-gebruikers.png)

    ![Lijst geaccepteerde gebruikers voor room](/opdracht%20Matrix.org/imgs/lijst-geaccepteerde-gebruikers-room.png)

3.  Tot slot gaan we na dat onze Matrix Synapse server effectief draait en bereikbaar is doormiddel van het `curl` commando:

    ```
    curl localhost
    ```

    **Verwacht Resultaat**: Volgende output zou zichtbaar moeten zijn in de shell:

         ```
         <html>
             <head>
                 <meta http-equiv="refresh" content="0;URL=/_matrix/static">
             </head>
             <body bgcolor="#FFFFFF" text="#000000">
             <a href="/_matrix/static">click here</a>
             </body>
         </html>
         ```

    **Bevestiging**: voer het bovenstaande `curl` commando uit.

    ![curl localhost](/opdracht%20Matrix.org/imgs/curl-localhost.png)

&nbsp;

## Rapport

- De resultaten van dit testplan zijn na te lezen in het [testrapport](testrapport-installatie-vm.md)
