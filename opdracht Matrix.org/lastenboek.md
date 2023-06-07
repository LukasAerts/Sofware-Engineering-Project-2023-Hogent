# Lastenboek Opdracht: theoracle Matrix.org server

Auteur(s): Olivier Saenen

## Deliverables

| Deliverable                                                                                      | Deeltaak | Status |
| :----------------------------------------------------------------------------------------------- | :------: | :----: |
| Elke taak kent een KanBan ticket                                                                 |    1     |   V    |
| Opzet Matrix testomgeving op eigen webserver                                                     |    1     |   V    |
| Domain: theoracle.thematrix.local                                                                |    2     |   V    |
| Vast IPv4-adres cfr. IP-adrestabel                                                               |    2     |   V    |
| Hostname: theoracle                                                                              |    2     |   V    |
| (VM met) OS: AlmaLinux                                                                           |    2     |   V    |
| Voorzien Vagrantfile                                                                             |    2     |   V    |
| Opzet Matrix.org server (synapse.service)                                                        |    2     |   V    |
| Scripts met gebruik variabelen                                                                   |    2     |   V    |
| Automatiseren aanmaak users, rooms en invites                                                    |    2     |   V    |
| Script voor versturen van bericht naar room bij het afsluiten van webserver (systemd unit/timer) |    3     |   V    |
| Geëncrypteerd gesprek voeren (tussen minstens twee accounts)                                     |    4     |   V    |
| Automatische installatie van client (Element)                                                    |    4     |   V    |
| Voorzien van bridge met andere dienst (Discord) a.h.v. Discord Bot - manual config               |    5     |   V    |
| Voorzien van GUI                                                                                 |    5     |   V    |
| Documentatie VM                                                                                  |    6     |   V    |
| Instructies voor installatie van VM                                                              |    6     |   V    |
| Testplan met exacte procedures voor installatie van VM                                           |    7     |   V    |
| Testplan met exacte procedures voor bericht naar room wanneer webserver afgesloten is            |    7     |   V    |
| Testplan met exacte procedures voor voeren geëcrypteerd gesprek (tussen minstens twee accounts)  |    7     |   V    |
| Testplan met exacte procedures voor configuratie van bridge naar Discord voorzien                |    7     |   V    |
| Testrapport installatie van VM                                                                   |    7     |   V    |
| Testrapport voor bericht naar room wanneer webserver afgesloten is                               |    7     |   V    |
| Testrapport voor voeren geëncrypteerd gesprek (tussen minstens twee accounts)                    |    7     |   V    |
| Testrapport configuratie van bridge naar Discord voorzien                                        |    7     |   V    |
| Lastenboek                                                                                       |    8     |   V    |
| Federatie uitleggen                                                                              |    9     |   V    |

&nbsp;

## Deeltaken

1. Voorbereiding

- Elke taak kent een KanBan ticket
- Opzet Matrix testomgeving op eigen webserver
- Verantwoordelijke: Olivier Saenen
- Tester: Olivier Saenen
- [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-103)
- [Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding-setup.png)

2. Opzet van webserver

- Domain: theoracle.thematrix.local
- Vast IPv4-adres cfr. IP-adrestabel
- Hostname: theoracle
- (VM met) OS: AlmaLinux
- Voorzien Vagrantfile
- Opzet Matrix.org server (synapse.service)
- Scripts met gebruik variabelen
- Automatiseren aanmaak users, rooms en invites
- Verantwoordelijke: Olivier Saenen
- Tester: Stein Van Driessche
- [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-64)
- [Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding-webserver.png)

3. Schrijven bash script (on server down)

- Script voor versturen van bericht naar room bij het afsluiten van webserver (systemd unit/timer)
- Verantwoordelijke: Olivier Saenen
- Tester: Stein Van Driessche
- [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-72)
- [Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding-bash-script.png)

4. Geencrypteerd gesprek voeren (minstens 2 personen)

- Geëncrypteerd gesprek voeren (tussen minstens twee accounts)
- Automatische installatie van client (Element)
- Verantwoordelijke: Olivier Saenen
- Tester: Stein Van Driessche
- [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-147)
- [Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding-chat.png)

5. Aanmaak bridge naar andere dienst

- Voorzien van bridge met andere dienst (Discord) a.h.v. Discord Bot - manual config
- Voorzien van GUI
- Verantwoordelijke: Olivier Saenen
- Tester: Stein Van Driessche
- [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-144)
- [Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding-bridge.png)

6. Aanmaken documentatie

- Documentatie VM
- Instructies voor installatie van VM
- Verantwoordelijke: Olivier Saenen
- [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-73)
- [Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding-documentatie.png)

7. Schrijven testplannen/testrapporten

- Testplan met exacte procedures voor installatie van VM (testplan-installatie-vm.md)
- Testplan met exacte procedures voor bericht naar room wanneer webserver afgesloten is (testplan-server-down-message.md)
- Testplan met exacte procedures voor voeren geëncrypteerd gesprek (tussen minstens twee accounts) (testplan-gesprek.md)
- Testplan met exacte procedures voor configuratie van bridge naar Discord voorzien (testplan-bridge.md)
- Testrapport installatie van VM (testrapport-installatie-vm.md)
- Testrapport voor bericht naar room wanneer webserver afgesloten is (testrapport-server-down-message.md)
- Testrapport voor voeren geëncrypteerd gesprek (tussen minstens twee accounts) (testrapport-gesprek.md)
- Testrapport configuratie van bridge naar Discord voorzien (testrapport-bridge.md)
- Verantwoordelijke: Olivier Saenen
- [Kanban Testplannen](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-77)
- [Kanban Testrapporten](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-161)
- [Kanban taak Testplannen](/opdracht%20Matrix.org/imgs/tijdbesteding-testplannen.png)
- [Kanban taak Testrapporten](/opdracht%20Matrix.org/imgs/tijdbesteding-testrapporten.png)

8. Schrijven lastenboek

- Lastenboek (deze .md file)
- Verantwoordelijke: Olivier Saenen
- [Kanban](https://sep-2223-t01.atlassian.net/browse/SEP2223T01-150)
- [Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding-lastenboek.png)

9. Federatie uitleggen

- Federatie uitleggen - zie [documentatie.md](documentatie.md)
- Verantwoordelijke: Olivier Saenen

&nbsp;

## Tijdbesteding

| Student             | Geschat | Gerealiseerd |
| :------------------ | :------ | :----------- |
| Naoufal Thabet      |         |              |
| Stein Van Driessche | /       | 6            |
| Lukas Aerts         |         |              |
| Benny Clemmens      |         |              |
| Olivier Saenen      | +-110h  | 139h 30m     |
| **totaal**          |         |              |

![Kanban taak](/opdracht%20Matrix.org/imgs/tijdbesteding.png)
