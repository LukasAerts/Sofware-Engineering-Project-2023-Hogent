## Test Cisco Labo 2

* Uitvoerder(s) test: Van Driessche Stein
* Uitgevoerd op: 01/04/2023
* Github commit:  Test Labo 2 PKT 01/04/2023

## Ping

* vanop  PC1 & PC2 : Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10 

  ***verwacht***: De PC's hebben via SLAAC een ipv6 addres aangemaakt in 2001:db8:a:2::/64 en hebben fe80::1 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn in packet tracer gelijk met die van het gua adres. De pings lukken.

  ***resultaat***:

  ![PC1 ipconfig /all & ping naar 2001:db8:1000::10 ](/Labo_opdrachten/img/pc1ipconfig.PNG)

  *PC1 heeft geen ipv6 adres :  IPv6 Address....................: ::*

  ![PC2 ipconfig /all & ping naar 2001:db8:1000::10 ](/Labo_opdrachten/img/pc2ipconfig.PNG)

  *PC2 OK*

* vanop PC3 & PC4 : Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10
  * surf naar Systemengineeringproject.org

  ***verwacht***: De PC's hebben via SLAAC een ipv6 addres aangemaakt in 2001:db8:b:2::/64 en hebben fe80::1 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn in packet tracer gelijk met die van het gua adres. De pings lukken. Via DHCP: De DNS-server is 2001:DB8:1000::10 en het DNS-achtervoegsel is SystemEngineeringProject. De website is (in PT) bereikbaar.

  ***resultaat***:
  
  ![PC3 ipconfig /all & ping naar 2001:db8:1000::10 ](/Labo_opdrachten/img/pc3ipconfig.PNG)
  ![PC3 surf naar Systemengineeringproject.org geslaagd ](/Labo_opdrachten/img/pc3web.PNG)
  
  *PC3 OK*

  ![PC4 ipconfig /all & ping naar 2001:db8:1000::10 ](/Labo_opdrachten/img/pc4ipconfig.PNG)
  ![PC4 surf naar Systemengineeringproject.org geslaagd ](/Labo_opdrachten/img/pc4web.PNG)

  *PC4 OK*

* vanop PC5: Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10
  * surf naar Systemengineeringproject.org 

  ***verwacht***: De PC heeft via DHCP een ipv6 addres aangemaakt in 2001:db8:c:2::/64 en heeft fe80::2 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn verschillend van het gua adres. De pings lukken. De DNS-server is 2001:DB8:1000::10 en het DNS-achtervoegsel is SystemEngineeringProject. Op de router is in het netwerklokaal met show ipv6 dhcp binding de reservatie zichtbaar. De website is (in PT) bereikbaar.

  ***resultaat***:

  ![PC5 ipconfig /all & ping naar 2001:db8:1000::10 ](/Labo_opdrachten/img/pc5ipconfig.PNG)
  ![PC5 surf naar Systemengineeringproject.org geslaagd ](/Labo_opdrachten/img/pc5web.PNG)

  *PC5 OK*

* vanop PC6 : Open een command prompt en voer uit:
  * ipconfig /all
  * ping 2001:db8:1000::10
  * surf naar Systemengineeringproject.org 

  ***verwacht***: De PC heeft via DHCP een ipv6 addres aangemaakt in 2001:db8:d:2::/64 en heeft fe80::2 als default gateway. Een link-local adres werd automatisch gegenereerd en de laatste 64 bits zijn verschillend van het gua adres. De pings lukken. De DNS-server is 2001:DB8:1000::10 en het DNS-achtervoegsel is SystemEngineeringProject. Op de router is in het netwerklokaal met show ipv6 dhcp binding de reservatie zichtbaar. De website is bereikbaar.

  ***resultaat***:

  ![PC6 ipconfig /all & ping naar 2001:db8:1000::10 ](/Labo_opdrachten/img/pc6ipconfig.PNG)
  ![PC6 surf naar Systemengineeringproject.org geslaagd ](/Labo_opdrachten/img/pc6web.PNG)

  *PC6 OK*