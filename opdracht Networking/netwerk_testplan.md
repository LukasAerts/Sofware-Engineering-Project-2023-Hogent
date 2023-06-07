# Testplan Opgave 3.2: Netwerk

## Opmerking
Een testplan voor het gedeelte Netwerk is wat moeilijker voor ons als afstandsstudent, althans het uitvoeren ervan. De weinige tijd die we in het netwerklokaal konden doorbrengen en effectief al onze machines samen brengen hebben we ten volle benut aan het oplossen van andere deliverables. Bovendien kroop ook behoorlijk wat tijd in het voorbereiden van de Cisco Labo's. Al snel bleek trouwens dat het concept van ons netwerk wel goed was uitgewerkt en we de verschillende virtuele machines over de verschillende subnetten konden bereiken. Zodoende is het testplan en bijhorend -rapport wel voorzien, maar de uitwerking ervan kon niet in het netwerklokaal worden getest. De demo zal als lakmoesproef dienst doen. In de [instructies](netwerk_instructies.md) en [documentatie](netwerk_documentatie.md) van het netwerk zou overigens al moeten naar voren komen dat de deliverables zijn opgeleverd.
## Deliverables

* Domein = <strong>thematrix.local</strong>
* IP-adrestabel voor alle componenten, verdeeld in subnetten
* Het netwerk en alle servers worden (enkel) uitgewerkt met IPv4
* De opstelling wordt uitgevoerd met virtuele machines en in het netwerklokaal aanwezige apparatuur
* Gebruik VLAN's cfr. de [opgave](netwerk_opgave.md)
* Inter-VLAN routing via router-on-a-stick configuratie
* Internettoegang via NAT
* Restricties m.b.v. ACL
* Simulatie m.b.v Packet Tracer
* Testplan met exacte procedures
* Testrapport
* Demo op 25/5/2023: De opstelling lokaal uitvoeren met virtuele machines (op de laptops van de studenten) en de aanwezige apparatuur in het netwerklokaal

## Instructies

* Domein = <strong>thematrix.local</strong>
  * CMD DirectorPC ```C:\ ipconfig /all```
  * PS C:\Users\Adminstrator> ``` (Get-WmiObject Win32_ComputerSystem).Domain ```

  ***verwacht***:  thematrix.local / "DC=thematrix,DC=local"


* IP-adrestabel voor alle componenten, verdeeld in subnetten
  * CMD DirectorPC ```C:\ ipconfig /all```
  * CMD PCCast1 ```C:\ ipconfig /all```
  * ...

  ***verwacht***:  
    * IP 192.168.20.101, GW 192.168.20.254, DNS 192.168.20.1
    * IP 192.168.40.101, GW 192.168.40.254, DNS 192.168.20.1 
    * ...


* Het netwerk en alle servers worden (enkel) uitgewerkt met IPv4
  * CMD DirectorPC ```C:\ ipconfig /all```

  ***verwacht***: enkel IPv4 adressen



* De opstelling wordt uitgevoerd met virtuele machines en in het netwerklokaal aanwezige apparatuur
  * Bekijk of er virtuele machines op uw computer staan

  ***verwacht***: VM's



* Gebruik VLAN's cfr. de [opgave](netwerk_opgave.md)
  * R-TO1# show run
  * S-TO1# show ip vlan

  ***verwacht***: vlan's en subnetten volgens de routing table



* Inter-VLAN routing via router-on-a-stick configuratie
  * R-TO1# show run

  ***verwacht***: configuratie met dot1q encapsulation


* Internettoegang via NAT
  * R-TO1# show run

  ***verwacht***: commandos ip nat inside en outside op de correcte interfaces


* Restricties m.b.v. ACL
 * probeer vanop een Cast pc het internet te bereiken

  ***verwacht***: onbereikbaar



* Simulatie m.b.v Packet Tracer
  * zie github

  ***verwacht***: een .pkt bestand op github


* Testplan met exacte procedures
  * dit bestand


* Testrapport
  * [testrapport](netwerk_testrapport.md)

* Demo op 25/5/2023: De opstelling lokaal uitvoeren met virtuele machines (op de laptops van de studenten) en de aanwezige apparatuur in het netwerklokaal
  * valt pas na het indienen van het finaal dossier dus niet meer gedocumenteerd