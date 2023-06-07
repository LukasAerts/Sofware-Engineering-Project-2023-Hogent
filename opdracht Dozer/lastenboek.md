### Lastenboek Opdracht Dozer: (Vagrantscript,Emscripten,QuakeJS,Shorturl)


## Deliverables


* VM Almalinux moet draaien
* QuakeJS moet lokaal beschikbaar zijn
* QuakeJS moet beschikbaar zijn voor iedereen in het netwerk (thematrix.local)
* Shorturl toepassing moet beschikbaar zijn voor iedereen in het netwerk (thematrix.local)
* Een shorturl moet beschikbaar zijn voor de QuakeJS toepassing.

## Deeltaken

# Voorbereiding

- Elke taak kent een KanBan ticket
- Opzet van Dozer windows test VM voor QuakeJS
- Verantwoordelijke: Van Driessche Stein
- Tester: Aerts Lukas

1. Vagrantscript
- Schrijven van vangrantscript voor het aanmaken van een Almalinux server
- Toevoegen van provisioning scripts voor het automatisch uitrollen van QuakeJS en ShortURL

    - Verantwoordelijke: Van Driessche Stein
    - Tester: Aerts Lukas

2. Dozerscript
- SELinux inschakelen
- Nano installeren
- Git installeren
- systemd-resolved package
- Extra utils

    - Verantwoordelijke: Van Driessche Stein
    - Tester: Aerts Lukas

3. Emscriptenscript:
- Clonen van emscripten repo en vervolgs installeren
- Opzetten van emscripten environment variables voor het uitvoeren van QuakeJS script

    - Verantwoordelijke: Van Driessche Stein
    - Tester: Aerts Lukas

4. QuakeJSscript:
- Clonen van inolen quakejs repo en installeren van ws
- Configuratie van QuakeJS
- Installeren van submodules + update
- Installeren van dependencies
- Configureren van QuakeJS server

    - Verantwoordelijke: Van Driessche Stein
    - Tester: Aerts Lukas

5. Shorturlscript:
- Clonen van rice en shorturl repo + instaleren
- Installeren van shortuuid en bitcask
- Opbouwen van ShortURL app en opstarten

    - Verantwoordelijke: Van Driessche Stein
    - Tester: Aerts Lukas

## Tijdbesteding

| Student             | Geschat | Gerealiseerd |
| :------------------ | :------ | :----------- |
| Naoufal Thabet      |         |              |
| Wim Meirlaen        |         |              |
| Stein Van Driessche |   60H   |     70H      |
| Lukas Aerts         |   3H    |     4,5H     |
| Benny Clemmens      |         |              |
| Olivier Saenen      |         |              |
| **totaal**          |         |              |
