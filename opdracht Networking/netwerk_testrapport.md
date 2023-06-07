# Testrapport Opgave 3.2: Netwerk

* Uitvoerder(s) test: Benny Clemmens (rapport), allen tijdens de contactmomenten
* Uitgevoerd op: 23/5/2023

## Opmerking
Niet alles kan worden getest zonder de apparatuur in het netwerklokaal (TIAO)

## Tests

* Domein = thematrix.local
  * CMD DirectorPC ```C:\ ipconfig /all```
  * PS C:\Users\Adminstrator> ``` (Get-WmiObject Win32_ComputerSystem).Domain ```

  ***verwacht***:  thematrix.local / "DC=thematrix,DC=local"

  ***resultaat***: de search domains werden via dhcp verkregen, ook voor de hosts

* IP-adrestabel voor alle componenten, verdeeld in subnetten
  * CMD DirectorPC ```C:\ ipconfig /all```
  * CMD PCCast1 ```C:\ ipconfig /all```
  * ...

  ***verwacht***:  
    * IP 192.168.20.101, GW 192.168.20.254, DNS 192.168.20.1
    * IP 192.168.40.101, GW 192.168.40.254, DNS 192.168.20.1 
    * ...

  ***resultaat***: elke workstation kreeg een ip in het juiste subnet

* Het netwerk en alle servers worden (enkel) uitgewerkt met IPv4
  * CMD DirectorPC ```C:\ ipconfig /all```

  ***verwacht***: enkel IPv4 adressen

  ***resultaat***: geen ipv6, enkel ipv4


* De opstelling wordt uitgevoerd met virtuele machines en in het netwerklokaal aanwezige apparatuur
  * Bekijk of er virtuele machines op uw computer staan

  ***verwacht***: VM's

  ***resultaat***: uiteraard VM's in Oracle


* Gebruik VLAN's cfr. de [opgave](netwerk_opgave.md)
  * R-TO1# show run
  * S-TO1# show ip vlan

  ***verwacht***: vlan's en subnetten volgens de routing table

  ***resultaat***: vlans 20,30 en 40 cfr opgave


* Inter-VLAN routing via router-on-a-stick configuratie
  * R-TO1# show run

  ***verwacht***: configuratie met dot1q encapsulation

  ***resultaat***: aanwezig

* Internettoegang via NAT
  * R-TO1# show run

  ***verwacht***: commandos ip nat inside en outside op de correcte interfaces

  ***resultaat***: het internet is bereikbaar via nat

* Restricties m.b.v. ACL
 * probeer vanop een Cast pc het internet te bereiken

  ***verwacht***: onbereikbaar

  ***resultaat***: inderdaad onbereikbaar, maar wel vanop de host pc


* Simulatie m.b.v Packet Tracer
  * zie github

  ***verwacht***: een .pkt bestand op github

  ***resultaat***: is aanwezig in github en schets voor zover mogelijk het netwerk


* Testplan met exacte procedures
  * Wordt hier gevolgd en gerapporteerd


* Testrapport
  * Dit bestand
