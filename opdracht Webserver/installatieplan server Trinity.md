#  installatieplan / deployment guide van server Trinity

## Requirements

* laatste versie van Virtualbox
* laatste versie van Vagrant
* cmd.exe of powershell voor een deployment van uit een windows computer en voor deployment van uit een linux systeem een terminal
* Repo https://github.com/HoGentTIN/SEP-2223-sep-2223-t01 op jouw computer.
  
Een Deployed server Agentsmith voor DNS services en een netwerk is niet noodzaaklijk maar maakt server Trinity functioneel compleet.
 

## Stappenplan

In de lokale repo SEP-2223-sep-2223-t01 ga naar:
* sub folder Scripts onder folder opdracht Webserver
* (Kopieer de inhoud van folder Scripts naar een andere plaats op computer indien gewenst)
* Open de vagrantfile om te editeren en pas de waarde "Killer E2500 Gigabit Ethernet Controller" op lijn 43 naar de naam van je Ethernet netwerk adapter en sla het bestand op
(Indien onveranderd valt de VM's netwerk adapter naar NAT)
* open cmd,powershell of een terminal in de locatie waar je inhoud van folder SEP-2223-sep-2223-t01/opdracht Webserver/Scripts hebt geplaats of gelaten
* Geef het commando `vagrant` up in 

in het command line venster waar je `vagrant up` hebt ingegeven zal je de output van de installatie zien, bij sucesvol deployment krijg je als laatste zin:"Vagrant has completed building server trinity successfully!"
