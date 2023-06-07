# Matrix Synapse documentatie

Auteur(s): Olivier Saenen

## Specificaties virtuele machine

Hieronder volgen de tabellen met daaronder de hoeveelheid geheugen en het aantal CPU-kernen dat de virtuele machines zullen gebruiken:

**De Matrix Synapse VM (theoracle):**
| Component | Grootte |
| --------- | ------- |
| Geheugen | 2048 MB |
| CPU's | 2 |

**De extra VM (tank)** met client voor gebruik van de Matrix clients (met GUI). Deze zal ook dienen voor de configuratie van de bridge met Discord:
| Component | Grootte |
| --------- | ------- |
| Geheugen | 2048 MB |
| CPU's | 2 |

&nbsp;

Het netwerk is als volgt opgesteld:

| De Matrix Synapse VM (theoracle): |                |
| --------------------------------- | -------------- |
| IP-adres                          | 192.168.20.4   |
| Default gateway                   | 192.168.20.254 |
| DNS server                        | 192.168.20.1   |
| VLAN                              | VLAN 20        |

| De Extra VM (tank): |                |
| ------------------- | -------------- |
| IP-adres            | 192.168.20.6   |
| Default gateway     | 192.168.20.254 |
| DNS server          | 192.168.20.1   |
| VLAN                | VLAN 20        |

**Opmerking**: Bovenstaande waarden kunnen aangepast worden door het Vargrantfile bestand in de directory '/opdracht Matrix.org' aan te passen.

&nbsp;

De gegevens van het besturingssysteem zijn de volgende:

| De Matrix Synapse VM (theoracle): |                |
| --------------------------------- | -------------- |
| Besturingssysteem                 | AlmaLinux OS 9 |
| Login                             | vagrant        |
| Wachtwoord                        | vagrant        |

| De Extra VM (tank): |           |
| ------------------- | --------- |
| Besturingssysteem   | Debian 11 |
| Login               | vagrant   |
| Wachtwoord          | vagrant   |

Het installatie-script gaat ervan uit dat VirtualBox en Vagrant, alsook een terminal geïnstalleerd zijn op de machine. Verder dient de gebruiker van het script de waarde van 'nic:' aan te passen naar de nic van het toestel.

&nbsp;

De gegevens van de Matrix server:

| Gebruiker | Wachtwoord | Homeserver                       |
| --------- | ---------- | -------------------------------- |
| olivier   | olivier    | http://theoracle.thematrix.local |
| stein     | stein      | http://theoracle.thematrix.local |
| naoufal   | naoufal    | http://theoracle.thematrix.local |
| lukas     | lukas      | http://theoracle.thematrix.local |
| benny     | benny      | http://theoracle.thematrix.local |

Naast deze gebruikers bestaat er ook nog een user, admin en bot account. Gebruikers user en admin dienen ter illustratie, terwijl gebruiker bot een admin account is waarmee bepaalde administratieve taken worden uitgevoerd, zoals het aanmaken van gebruikers en rooms, enz.

&nbsp;

## Bestandstructuur

Volgende bestanden dien je terug te vinden in de 'opdracht Matrix.org' directory. Hieronder volgt ook een beknopte uitleg van de functie van deze bestanden.

- opdracht Matrix.org
  - provisioning
    - discord-bridge-setup.sh
    - firewall.sh
    - gui.sh
    - lang-pyt.sh
    - matrix.conf
    - override.conf
    - send_synapse_message.sh
    - synapse.service
    - theoracle.sh
    - user-room-config.sh
  - documentatie.md
  - lastenboek.md
  - procedures.md
  - testplan-bridge.md
  - testplan-gesprek.md
  - testplan-installatie-vm.md
  - testplan-server-down-message.md
  - testrapport-bridge.md
  - testrapport-gesprek.md
  - testrapport-server-down-message.md
  - testrapport-installatie-vm.md
  - Vagrantfile
  - imgs
  - matrix-chat-os
    - provisioning
      - firewall.sh
      - gui.sh
      - os.sh
    - Vagrantfile

&nbsp;

### Vagrantfile

Dit Vagrant-bestand dient als een configuratie voor het opzetten van een virtuele machine met behulp van Vagrant en VirtualBox. Hier is een beknopte uitleg van wat elke sectie van het bestand doet:

1. **config.vm.box = "boxomatic/almalinux-9"**: Specificeert de basisimage (box) die voor de virtuele machine wordt gebruikt. In dit geval wordt "boxomatic/almalinux-9" gebruikt, dat een AlmaLinux 9 image is.

2. **config.vm.network "public_network"**: Dit stelt een netwerkinterface in voor de VM, die is geconfigureerd om te bruggen met "eth1" op de host en een specifiek IP-adres, gateway en DNS-servers gebruikt.

3. **config.vm.synced_folder ".", "/provisioning", type: "virtualbox"**: Hiermee wordt een gedeelde map tussen de host en de VM gemaakt. Dit is nuttig voor het delen van onze bestanden tussen de host en VM.

4. **config.vm.provider "virtualbox" do |vb|**: Hier wordt de configuratie voor de VirtualBox-provider gespecificeerd. Het stelt het geheugen, CPU's, VRAM en andere instellingen van de VM in.

5. Het volgende deel controleert of bepaalde Vagrant-plugins zijn geïnstalleerd en installeert deze zo nodig.

6. De **"config.vm.provision"** regels worden gebruikt om verschillende shell-scripts uit te voeren als onderdeel van het provisioningproces. Deze scripts dienen voor het installeren en configureren van de GUI, firewall, Matrix Synapse, en de Matrix-Discord bridge.

7. De **config.vm.provision :reload** regels worden gebruikt om de VM te herstarten na bepaalde stappen van het provisioningproces. Deze zijn nodig om uitgevoerde wijzigingen effectief te maken.

&nbsp;

### Provisioning bestanden

Onderstaande bestanden worden door de Vagrantfile of door de scripts die door de Vagrantfile opgeroepen gebruikt. Hier is een beknopte uitleg van wat deze bestanden doen:

- **discord-bridge-setup.sh**: Dit script dienst voor het opzetten van een bridge tussen Matrix en Discord.

- **firewall.sh**: Dit script dient voor de configuratie van de firewall op de virtuele machine. Het stelt regels in en opent of sluit bepaalde poorten om verkeer toe te staan of te blokkeren op deze.

- **gui.sh**: Dit script installeert en de nodige zaken om de grafische gebruikersinterface (GUI) op de virtuele machine te installeren en te configureren.

- **matrix.conf**: Dit configuratiebestand wordt gekopieerd naar de VM om de instellingen van de server te definiëren.

- **override.conf**: Dit configuratiebestand wordt gekopieerd naar de VM om de instellingen van de nginx server te definiëren zodat deze het gepaste bericht doorgeeft aan het send_synapse_message.sh script.

- **send_synapse_message.sh**: Dit script dient voor het versturen van een bericht indien de Nginx server uitgeschakeld, herstart of opgestart wordt (met het gepaste bericht).

- **synapse.service**: Het systemd servicebestand voor de Matrix Synapse server. Het definieert hoe de server gestart wordt door het systemd systeembeheer.

- **theoracle.sh**: Dit is het algemene script dat afhankelijkheden zal installeren, de virtuele omgeving voor Python opzet, de Matrix server installeert en configureert, en ook andere side-scripts zal oproepen. Dit script is ook verantwoordelijk voor het kopiëren van de .conf en .synapse bestanden naar de juiste locatie.

- **user-room-config.sh**: Dit script kan worden gebruikt om gebruikers en rooms op de Matrix Synapse server te configureren. Het wordt gebruikt om nieuwe gebruikers aan te maken, gebruikers aan rooms toe te voegen, en variabelen te exporteren die later gebruikt worden.

&nbsp;

### Markdown bestanden

Deze bestanden bevatten de nodige uitleg en informatie voor de installatie en gebruik van de Matrix server.

&nbsp;

## Federatie

Matrix hanteert het concept van decentralisatie. In tegenstelling tot gecentraliseerde communicatie (waarbij alle communicatie via één centraal punt verloopt), bevindt in een systeem als Matrix de communicatie zich op verschillende servers, genaamd 'homeservers'.

Federatie in de context van Matrix betekent dat verschillende Matrix-homeservers met elkaar kunnen communiceren. Een voorbeeld hiervan zou zijn dat twee gebruikers Olivier en Benny zich op twee verschillende homeservers bevinden. Als Olivier dan een bericht naar Benny stuurt, dan gaat het bericht van zijn server naar Benny's server. In dat geval is dat mogelijk omdat Matrix een federatief protocol heeft dat bepaalt hoe die servers met elkaar kunnen communiceren en informatie met elkaar kunnen uitwisselen.

Voor dit project is er geen behoefte aan federatie omdat we werken vanuit een lokaal netwerk op de campus. Als alle gebruikers zich op hetzelfde lokale netwerk bevinden en allemaal gebruik maken van dezelfde homeserver, dan hoeft federatie niet. Dit omdat er in dat geval geen informatie hoeft uitgewisseld te worden met andere Matrix-servers. De communicatie blijft binnen onze eigen server.

&nbsp;

## Gebruik

- http://theoracle.thematrix.local
