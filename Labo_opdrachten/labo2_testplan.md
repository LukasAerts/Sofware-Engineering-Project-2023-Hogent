## Testplan Cisco Labo 2

Auteur : Clemmens Benny

## Benodigdheden:
* Cisco Packet Tracer 8.2.0
* Het [.pkt-bestand](pkt/labo2_01_packettracer_afgewerkt.pkt) waarin de gevraagde [opgave](labo2_opgave.md) werd voorbereid met de uitgeschreven [instructies](labo2_instructies.md), startende vanaf het opgegeven [bestand](pkt/labo2_00_chamilo.pkt)
* Alternatief : Het [.pkt-bestand](pkt/labo2_01_netwerklokaal_afgewerkt.pkt) waarin de gevraagde [opgave](labo2_opgave.md) werd voorbereid met de uitgeschreven [copypaste instructies](labo2_copypaste_instructies.md), maar dan in een versie welke ook in het netwerklokaal zal kunnen worden gebruikt, met andere woorden startende vanaf een [alternatief](pkt/labo2_00_netwerklokaal.pkt) bestand.

## Opmerking:
* Op de echte opstelling is geen DNS-server en geen webserver beschikbaar dus kan ter controle enkel worden gepinged.
* Er wordt van uitgegaan dat basishandelingen zoals pingen en ipconfig gekend zijn

## Handelingen:

### Opzetten testomgeving:
* Open het bestand waarin alle instructies reeds werden uitgevoerd
* Wacht enkele ogenblikken tot de devices opgestart en geconnecteerd zijn. Dit is zichtbaar wanneer de driehoeken op de kabels tussen de devices een groene kleur hebben. Dit proces kan worden versneld door links onderaan enkele malen 'Fast Forward Time (Alt-D)' aan te klikken.

### Ping

* vanop  PC1 & PC2 : Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10

  ***verwacht***: De PC's hebben via SLAAC een ipv6 addres aangemaakt in 2001:db8:a:2::/64 en hebben fe80::1 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn in packet tracer gelijk met die van het gua adres. De pings lukken.

* vanop PC3 & PC4 : Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10
  * surf naar Systemengineeringproject.org

  ***verwacht***: De PC's hebben via SLAAC een ipv6 addres aangemaakt in 2001:db8:b:2::/64 en hebben fe80::1 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn in packet tracer gelijk met die van het gua adres. De pings lukken. Via DHCP: De DNS-server is 2001:DB8:1000::10 en het DNS-achtervoegsel is SystemEngineeringProject. De website is (in PT) bereikbaar.

* vanop PC5: Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10
  * surf naar Systemengineeringproject.org 

  ***verwacht***: De PC heeft via DHCP een ipv6 addres aangemaakt in 2001:db8:c:2::/64 en heeft fe80::2 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn verschillend van het gua adres. De pings lukken. De DNS-server is 2001:DB8:1000::10 en het DNS-achtervoegsel is SystemEngineeringProject. Op de router is in het netwerklokaal met show ipv6 dhcp binding de reservatie zichtbaar. De website is (in PT) bereikbaar.

* vanop PC6 : Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10
  * surf naar Systemengineeringproject.org 

  ***verwacht***: De PC heeft via DHCP een ipv6 addres aangemaakt in 2001:db8:d:2::/64 en heeft fe80::2 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn verschillend van het gua adres. De pings lukken. De DNS-server is 2001:DB8:1000::10 en het DNS-achtervoegsel is SystemEngineeringProject. Op de router is in het netwerklokaal met show ipv6 dhcp binding de reservatie zichtbaar. De website is bereikbaar.

### Rapport:
* De resultaten van dit testplan zijn na te lezen in volgend [rapport](labo2_testrapport.md).