# Opgave 3.2: Netwerk

## Herwerkte opgave

* Het domein zal de volgende naam hebben: “thematrix.local”.
* Leg eerst en vooral een IP-adrestabel vast voor alle componenten in het netwerk die dit nodig hebben. Plan vooraf de nodige subnetten.
* Schrijf testplannen met excacte procedures die toelaten te valideren of een deeltaak is uitgevoerd volgens de specificaties.
* Een ander teamlid volgt de instructies van de testplannen en schrijft een testrapport over het resultaat.
* Het netwerk en alle servers worden enkel uitgewerkt met IPv4.
* De gehele opstelling wordt lokaal uitgevoerd met virtuele machines en de aanwezige apparatuur in het netwerklokaal.
* Simuleer de netwerkinfrastructuur voor zover mogelijk met Packet Tracer.
* Voorzie volgende VLAN's:
  * VLAN 20 Interne servers
    * Vaste, private IP-adressen
    * De IP-adressen corresponderen met de adressering van de servers.
  * VLAN 30 Werkstations crew
    * Dynamische, private IP-adressen (via DHCP)
    * Kunnen interne servers en Internet bereiken
  * VLAN 40 Werkstations cast
    * Dynamische, private IP-adressen (via DHCP)
    * Kunnen enkel op het lokale netwerk, niet op het Internet.
* Inter-VLAN routing wordt uitgevoerd met een router-on-a-stick configuration.
* Toegang tot internet gebeurt via configuratie van NAT.
* Na succesvolle simulatie worden dezelfde configuraties geïmporteerd op de apparatuur in het netwerklokaal en worden de (virtuele) servers aangesloten tot één werkend geheel. De virtuele machines draaien op de laptops van de studenten. Er zullen soms meerdere VM’s op een enkele laptop moeten draaien, denk goed op voorhand na over deze verdeling om performantiebottlenecks en andere problemen te vermijden.
## Opmerking:

* Ten opzichte van de originele opgave uit de [brochure](pdf/brochure-sep-2223.pdf) zijn hierboven enkele wijzigingen aangebracht. Deze wijzigingen zijn ter illustratie hierander in de orignele opgave <del>doorstreept</del> en/of <ins>onderlijnd</ins>, met de reden/verantwoording van wijziging erbij in <strong>vet</strong>.
* De onderdelen uit Opdracht 3.1 Algemeen die van toepassing zijn voor deze opgave zijn ook toegevoegd

## Opgave (Origineel, met aanpassingen)

* <ins>Het domein zal de volgende naam hebben: “thematrix.local”.</ins>
<br><strong>Deliverable uit opgave 3.1 Algemeen</strong>

* <ins>Leg eerst en vooral een IP-adrestabel vast voor alle componenten in het netwerk die dit nodig hebben. Plan vooraf de nodige subnetten en <del>verspil geen IP-adressen</del>.<ins>
<br><strong>Deliverable uit opgave 3.1 Algemeen</strong>
<br><strong>Aangezien met NAT wordt gewerkt is het nutteloos de subnetten via VLSM nodeloos kleiner te maken. Hier kiezen we bewust voor /24 subnetten omdat we dan de ip-adrestabel overzichtelijk en logisch kunnen houden</strong>

* <ins>Schrijf testplannen met excacte procedures die toelaten te valideren of een deeltaak is uitgevoerd volgens de specificaties.</ins>
<br><strong>Deliverable uit opgave 3.1 Algemeen</strong>

* <ins>Een ander teamlid volgt de instructies van de testplannen en schrijft een testrapport over het resultaat.</ins>
<br><strong>Deliverable uit opgave 3.1 Algemeen</strong>

* Het netwerk en alle servers worden <ins>enkel</ins> uitgewerkt met IPv4. <del>IPv6 wordt nog niet uitgerold op de apparatuur maar wordt wel al voorzien op de DNS-server (zie verder)</del>
<br><strong>Maakt deel uit van opgave 3.3 Domein Controller</strong>.

* De gehele opstelling wordt lokaal uitgevoerd met virtuele machines en de aanwezige apparatuur in het netwerklokaal.

* Simuleer de netwerkinfrastructuur <ins>voor zover mogelijk</ins> met Packet Tracer.
<br><strong>Niet alle functionaliteit is te simuleren in Packet Tracer</strong>

* Voorzie <ins>volgende</ins> VLAN's <del>voor de cast en de crew</del>:
  * VLAN 20 Interne servers
    * Vaste, private IP-adressen
    * De IP-adressen corresponderen met de adressering van de servers.
  * VLAN 30 Werkstations crew
    * Dynamische, private IP-adressen (via DHCP)
    * Kunnen interne servers en Internet bereiken
  * VLAN 40 Werkstations cast
    * Dynamische, private IP-adressen (via DHCP)
    * <del>Kunnen enkel op Internet, interne servers zijn niet bereikbaar met uitzondering van de AD.</del> <br><strong>Wijziging door lectoren via chamilo en door ons aangepast:</strong>
    * <ins>Kunnen enkel op het lokale netwerk, niet op het Internet.</ins>
    <br><strong>Wijziging i.f.v. logica en besproken met docent</strong>
  * <del>VLAN 50 Verbinding naar routernetwerk en buitenwereld</del>
  <br><strong>Wijziging door lectoren via chamilo</strong>
  
* Inter-VLAN routing wordt uitgevoerd met een router-on-a-stick configuration.

* Toegang tot internet gebeurt via configuratie van NAT.

* Na succesvolle simulatie worden dezelfde configuraties geïmporteerd op de apparatuur in het netwerklokaal<del>,</del> en worden de (virtuele) servers aangesloten tot één werkend geheel. De virtuele machines draaien op de laptops van de studenten. Er zullen soms meerdere VM’s op een enkele laptop moeten draaien, denk goed op voorhand na over deze verdeling <del>voor</del> om performantiebottlenecks en andere problemen te vermijden.
