# Testrapport Opdracht Matrix.org: theoracle Matrix.org server installatie

## Test

Uitvoerder(s) test: Van Driessche Stein
Uitgevoerd op: 24/05/2023
Github commit: COMMIT HASH

## Requirements

- Een werkende computer die draait op Windows of Linux
- Git staat geïnstalleerd op de computer
- Vagrant software geïnstalleerd op de computer
- VirtualBox software geïnstalleerd op de computer

&nbsp;

## Procedure:

### 1. Download de benodigde files vanuit de repository

De installatie-scripts bestaan uit meerdere bash scripts en files in de provisioning folder zitten van de gedownloade repository folder. Met de volgende stap kan je deze naar een directory naar keuze downloaden.

Deze directory is ook meteen de directory van waaruit we de Vagrantfile zullen draaien in de volgende stap.

1. Open de terminal op je computer.
2. Navigeer naar de directory waar we de repository willen downloaden.
3. Voer volgende commands uit:

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

**Verslag**: Aangezien ik de installatie op een windows computer heb uitgevoerd heb ik voor het verdere verslag de Matrix.org directory afzonderlijk geplaatst.
Alles werkt zoals beschreven in het testplan.

&nbsp;

### 2. Vagrantfile aanpassen

Pas het Vagrantfile bestand aan volgens de instructies onder "Aanpassingen aan het Vagrantfile bestand" in het [procedures.md](procedures.md) bestand.

Aangepast: nic: "Qualcomm Atheros QCA9377 Wireless Network Adapter"
laten staan: vg.gui = true

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
  -> Klopt:

Current machine states:

default running (virtualbox)

The VM is running. To stop this VM, you can run `vagrant halt` to
shut it down forcefully, or you can run `vagrant suspend` to simply
suspend the virtual machine. In either case, to restart it again,
simply run `vagrant up`.

- We zijn ingelogd op onze webserver via ssh
  -> werkt
  Last login: Wed May 24 05:08:53 2023
  **Bevestiging**:
  Uitvoer van `vagrant status` toont dat de default machine `running` is, en de gebruiker van onze user op de server in de shell wordt getoont en we kregen een bericht over onze login:

> Last Login: (date) from (ip)
> Last login: Wed May 24 05:08:53 2023
> vagrant@almalinux ~
> -> Correct
> &nbsp;

### 4. Correcte installatie bevestigen

In deze stap gaan we na of het script voor de gewenst resultaten gezorgd heeft. Dit doen we doormiddel van enkele commando's die de status van de services nagaan alsook het `curl` commando.

1.  We gaan na dat de nodige services "active (running)" zijn. Binnen onze ssh verbinding met de server, voer je volgende commando's uit::

    ```
    sudo systemctl status nginx
    sudo systemctl status synapse.service
    ```

    **Verwacht Resultaat**: de services zijn `'active (running)'`

    **Bevestiging**: voer het de commando's hierboven uit om te bevestigen

[vagrant@almalinux ~]$ sudo systemctl status nginx
● nginx.service - The nginx HTTP and reverse proxy server
Loaded: loaded (/usr/lib/systemd/system/nginx.service; enabled; preset: disabled)
Drop-In: /etc/systemd/system/nginx.service.d
└─override.conf
Active: active (running) since Wed 2023-05-24 05:29:06 -03; 26min ago
Process: 2444 ExecStartPre=/usr/bin/rm -f /run/nginx.pid (code=exited, status=0/SUCCESS)
Process: 2468 ExecStartPre=/usr/sbin/nginx -t (code=exited, status=0/SUCCESS)
Process: 2508 ExecStart=/usr/sbin/nginx (code=exited, status=0/SUCCESS)
Process: 2534 ExecStartPost=/bin/bash /home/vagrant/synapse/send_synapse_message.sh Nginx up and running again! (co>
Main PID: 2525 (nginx)
Tasks: 5 (limit: 24707)
Memory: 7.4M
CPU: 144ms
CGroup: /system.slice/nginx.service
├─2525 "nginx: master process /usr/sbin/nginx"
├─2527 "nginx: worker process"
├─2529 "nginx: worker process"
├─2530 "nginx: worker process"
└─2531 "nginx: worker process"

    [vagrant@almalinux ~]$ sudo systemctl status synapse.service

● synapse.service - Synapse Matrix Server
Loaded: loaded (/etc/systemd/system/synapse.service; enabled; preset: disabled)
Active: active (running) since Wed 2023-05-24 05:29:03 -03; 31min ago
Main PID: 1190 (python)
Tasks: 9 (limit: 24707)
Memory: 142.0M
CPU: 16.153s
CGroup: /system.slice/synapse.service
└─1190 /home/vagrant/synapse/env/bin/python -m synapse.app.homeserver --config-path=/home/vagrant/synapse/>

May 24 05:29:03 almalinux systemd[1]: Started Synapse Matrix Server.
May 24 05:29:03 almalinux sudo[1197]: root : PWD=/home/vagrant/synapse ; USER=root ; COMMAND=/bin/chown -R root:roo>
May 24 05:29:20 almalinux bash[1190]: This server is configured to use 'matrix.org' as its trusted key server via the
May 24 05:29:20 almalinux bash[1190]: 'trusted_key_servers' config option. 'matrix.org' is a good choice for a key
May 24 05:29:20 almalinux bash[1190]: server since it is long-lived, stable and trusted. However, some admins may
May 24 05:29:20 almalinux bash[1190]: wish to use another server for this purpose.
May 24 05:29:20 almalinux bash[1190]: To suppress this warning and continue using 'matrix.org', admins should set
May 24 05:29:20 almalinux bash[1190]: 'suppress_key_server_warning' to 'true' in homeserver.yaml.
May 24 05:29:20 almalinux bash[1190]: --------------------------------------------------------------------------------

2.  Nu we weten dat de diensten goed draaien, is het belangrijk na te gaan dat het user-room-config.sh juist uitgevoerd werd. Dit doen we door de commando's op te roepen die een lijst geven van de aangemaakte users alsook de rooms die er bestaan op onze server:

    Source de nodige variabelen

    ```
    source /home/vagrant/synapse/calculated-environment-vars
    ```

    Geef lijst van alle aangemaakte gebruikers.

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_synapse/admin/v2/users | jq -r '.users[].name'
    ```

    @admin:theoracle.thematrix.local
    @benny:theoracle.thematrix.local
    @bot:theoracle.thematrix.local
    @discordbot:theoracle.thematrix.local
    @lukas:theoracle.thematrix.local
    @naoufal:theoracle.thematrix.local
    @olivier:theoracle.thematrix.local
    @stein:theoracle.thematrix.local
    @user:theoracle.thematrix.local

    Geef lijst van aangemaakte rooms

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_synapse/admin/v1/rooms/$ROOM_ID | jq '.name'

    "WE ARE HOGENT"


    ```

    Geef lijst van uitgenodigde gebruikers binnen onze room. Eerst als userid, dan als displayname.

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/members | jq -r '.chunk[].state_key'
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" $SYNAPSE_SERVER/_matrix/client/r0/rooms/$ROOM_ID/members | jq -r '.chunk[].content.displayname'

    @benny:theoracle.thematrix.local
    @bot:theoracle.thematrix.local
    @lukas:theoracle.thematrix.local
    @naoufal:theoracle.thematrix.local
    @olivier:theoracle.thematrix.local
    @stein:theoracle.thematrix.local
    @user:theoracle.thematrix.local

    benny
    bot
    lukas
    naoufal
    olivier
    stein
    user

    ```

    Geef lijst van de gebruikers die effectief deel uitmaken van de room (na accepteren invite). Afhankelijk van het aantaal users die de invite geaccepteerd heeft, kan de lijst hier verschillen. Maar de "@bot:theoracle.thematrix.local" is als maker en admin sowieso deel van de room.

    ```
    curl -s -XGET -H "Authorization: Bearer $ACCESS_TOKEN_bot" "$SYNAPSE_SERVER/_synapse/admin/v1/rooms/$ROOM_ID/members" | jq '.members'

      "@bot:theoracle.thematrix.local"


    ```

    **Verwacht Resultaat**: De commando's geven een waarde terug voor de aangemaakte gebruikers, rooms en de users die zich in de room bevinden.

    **Bevestiging**: voer het de commando's hierboven uit om te bevestigen

    Alles werkt zoals voorzien.
    Resultaten staan hierboven onder de commando's.

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
