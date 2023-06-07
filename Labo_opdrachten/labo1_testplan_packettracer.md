# Testplan Cisco Labo 1, versie Packet Tracer

Auteur : Clemmens Benny

## Benodigdheden:
* Cisco Packet Tracer 8.2.0
* Het [.pkt-bestand](pkt/labo1_09_na_reloads.pkt) waarin de gevraagde [opgave](labo1_opgave.md) werd voorbereid met de uitgeschreven [instructies](labo1_instructies.md)

## Handelingen:  
### Opzet:
* Open het [.pkt-bestand](pkt/labo1_09_na_reloads.pkt)
* Wacht enkele ogenblikken tot de devices opgestart en geconnecteerd zijn. Dit is zichtbaar wanneer de driehoeken op de kabels tussen de devices een groene kleur hebben. Dit proces kan worden versneld door links onderaan enkele malen 'Fast Forward Time (Alt-D)' aan te klikken.

### Ping:

* Open PC-A door erop te klikken
* Klik onder het tabblad Desktop op het icoon 'Command Prompt' en voer volgende commando's uit, ter controle van de ipv6 instellingen en de connectiviteit binnen het eigen subnet:
  ```code
  ipcongfig
  ping 2001:db8:acad:a::3
  ping 2001:db8:acad:a::a
  ping 2001:db8:acad:a::1
  ping fe80::1
  ```
  ***verwacht***: PC-A heeft ipv6 addres `2001:db8:acad:a::3` en fe80::1 als default gateway. Een link local adres werd automatisch gegenereerd. De devices in het eigen subnet gaven een ping reply terug.

* Volgende commando's controleren de connectiviteit van PC-A naar de netwerken welke rechtstreeks aan R1 zijn verbonden:
  ```code
  ping 2001:db8:acad:b::1
  ping 2001:db8:acad:b::a
  ping 2001:db8:acad:b::3
  ping 2001:db8:aaaa:1::1
  ping 2001:db8:aaaa:1::2
  ping 2001:db8:aaaa:3::1
  ping 2001:db8:aaaa:3::2
  ```
  ***verwacht***: alle devices waren bereikbaar en retourneerden ping replies

* Volgende commando's controleren de connectiviteit van PC-A naar netwerken welke R1 via OSPF heeft aangeleerd:
  ```code
  ping 2001:db8:aaaa:2::1
  ping 2001:db8:aaaa:2::2
  ping 2001:db8:acad:c::1
  ping 2001:db8:acad:c::a
  ping 2001:db8:acad:c::3
  ping 2001:db8:aaaa:4::1
  ```
  ***verwacht*** : alle devices waren bereikbaar en retourneerden ping replies

De connectiviteitstest voor PC-A werd onderverdeeld in verschillende tests om eventuele troubleshooting makkelijker te maken. Voor de andere PC's zijn de commando's gelijkaardig

* Open PC-B door erop te klikken
* Klik onder het tabblad Desktop op het icoon 'Command Prompt' en voer onderstaande commando's uit:
  ```code
  ipconfig
  ping 2001:db8:acad:b::3
  ping 2001:db8:acad:b::a
  ping 2001:db8:acad:b::1
  ping fe80::1
  ping 2001:db8:aaaa:1::1
  ping 2001:db8:aaaa:1::2
  ping 2001:db8:aaaa:3::1
  ping 2001:db8:aaaa:3::2
  ping 2001:db8:acad:a::1
  ping 2001:db8:acad:a::a
  ping 2001:db8:acad:a::3
  ping 2001:db8:aaaa:2::1
  ping 2001:db8:aaaa:2::2
  ping 2001:db8:acad:c::1
  ping 2001:db8:acad:c::a
  ping 2001:db8:acad:c::3
  ping 2001:db8:aaaa:4::1
  ```
  ***verwacht***: PC-B kreeg het ipv6 addres `2001:db8:acad:b::3` en fe80::1 als default gateway. Een link local adres werd automatisch gegenereerd. Alle pings waren succesvol

* Open PC-C door erop te klikken
* Klik onder het tabblad Desktop op het icoon 'Command Prompt' en voer onderstaande commando's uit:
  ```code
  ipconfig
  ping 2001:db8:acad:c::3
  ping 2001:db8:acad:c::a
  ping 2001:db8:acad:c::1
  ping fe80::3
  ping 2001:db8:aaaa:2::1
  ping 2001:db8:aaaa:2::2
  ping 2001:db8:aaaa:3::1
  ping 2001:db8:aaaa:3::2
  ping 2001:db8:aaaa:1::1
  ping 2001:db8:aaaa:1::2
  ping 2001:db8:aaaa:4::1
  ping 2001:db8:acad:a::1
  ping 2001:db8:acad:a::a
  ping 2001:db8:acad:a::3
  ping 2001:db8:acad:b::1
  ping 2001:db8:acad:b::a
  ping 2001:db8:acad:b::3
  ```
  ***verwacht***: PC-C kreeg het ipv6 addres 2001:db8:acad:C::3 en fe80::3 als default gateway. Een link local adres werd automatisch gegenereerd. Alle pings waren succesvol


### Remote access (Voer volgende stappen uit vanop alle PC's in de topologie):
* Open de PC door erop te klikken
* Klik onder het tabblad Desktop op het icoon 'Telnet/SSH Client'. Indien de 'command prompt' uit de eerdere tests nog open staat kan deze worden gesloten met 'X'  
  
Telnet naar R1:
* Selecteer Telnet als 'Connection Type'
* Vul `2001:db8:acad:a::1` in in het veld 'Host Name (IP address)' en klik op connect  
  ***verwacht***: er is connectie naar R1, er wordt een waarschuwing (motd) getoond en een Username/Password gevraagd 
* Geef als username ***admin*** en als password ***classadm*** in  
  ***verwacht***: er kon succesvol op R1 worden ingelogd en de prompt 'R1>' is beschikbaar om commando's in te geven
* Typ exit op de prompt en antwoord nee op de vraag of je opnieuw wil connecteren  
    
SSH naar R1:
* Selecteer SSH als 'Connection Type'
* Vul `2001:db8:acad:a::1` in in het veld 'Host Name (IP address)'
* Vul admin in in het veld 'Username' en klik op connect  
  ***verwacht***: er is connectie naar R1 en er wordt om een Password gevraagd
* Geef ***classadm*** als password in  
  ***verwacht***: Een waarschuwing (motd) wordt getoond. Er kon succesvol op R1 worden ingelogd. Een prompt 'R1>' is beschikbaar om commando's in te geven
* Typ exit op de prompt en antwoord nee op de vraag of je opnieuw wil connecteren  
    
Telnet naar S1:
* Selecteer Telnet als 'Connection Type'
* Vul `2001:db8:acad:a::a` in in het veld 'Host Name (IP address)' en klik op connect  
  ***verwacht***: er is connectie naar de S1, er wordt een waarschuwing (motd) getoond en een Username/Password gevraagd 
* Geef als username ***admin*** en als password ***classadm*** in  
  ***verwacht***: er kon succesvol op S1 worden ingelogd en de prompt 'S1>' is beschikbaar om commando's in te geven
* Typ exit op de prompt en antwoord nee op de vraag of je opnieuw wil connecteren  
    
SSH naar S1:
* Selecteer SSH als 'Connection Type'
* Vul `2001:db8:acad:a::a` in in het veld 'Host Name (IP address)'
* Vul admin in in het veld 'Username' en klik op connect  
  ***verwacht***: er is connectie naar de Router en er wordt om een Password gevraagd
* geef ***classadm*** als password in  
  ***verwacht***: Een waarschuwing (motd) wordt getoond. Er kon succesvol op S1 worden ingelogd. Een prompt 'S1>' is beschikbaar om commando's in te geven
* typ exit op de prompt en antwoord nee op de vraag of je opnieuw wil connecteren  
    
Opmerking:  
* remote access is ook te controleren met behulp van volgende commando's in de 'Command Prompt':
  ```code
  telnet 2001:db8:acad:a::1
  ssh -l admin 2001:db8:acad:a::1
  ```
  ***verwacht***: dezelfde vragen/waarschuwingen als bij de voorgaande methode



### Rapport:
* De resultaten van dit testplan zijn na te lezen in volgend [rapport](labo1_testrapport.md).
