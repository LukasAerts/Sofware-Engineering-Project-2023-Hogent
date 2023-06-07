# Opgave 3.X: Windows10

## Opmerking:

* Hoewel het opzetten van de Windows 2010 machines niet expliciet als opdracht in de originele opgave staat vermeld, is het opzetten ervan toch een hele klus en een opdracht waardig.
* Deze vm's zijn cruciaal om de deliverables uit de andere opdrachten te testen.
* De opgave is dus samengevoegd uit de algemene opdracht en delen van andere opdrachten die van toepassing lijken op de Windows 10 machines.
* Onderstaande  opgave vormt de bron voor de deliverables welke worden beschreven in het [lastenboek](windows10_lastenboek.md) en daarna getest met het [testplan](windows10_testplan.md).

## Opgave

* Installatie en configuratie van de Windows systemen gebeurt deels in de GUI en deels aan de hand van PowerShell scripts
* Zorg ervoor dat alle scripts herbruikbaar zijn (m.b.v. variabelen).
* Schrijf testplannen met excacte procedures die toelaten te valideren of een deeltaak is uitgevoerd volgens de specificaties.
* Een ander teamlid volgt de instructies van de testplannen en schrijft een testrapport over het resultaat.
* De gehele opstelling wordt lokaal uitgevoerd met virtuele machines
* Dynamische, private IPv4-adressen (via DHCP)
* Correcte hostnaam: DirectorPC, PCrew1, ...
* OS: Windows 2010 Pro
* Zorg ervoor dat je de servers via RSAT kan configureren vanop de DirectorPC (tools beschikbaar op de DirectorPC).
* Pc’s en servers hebben geen eigen gewone gebruikers, authenticatie gebeurt telkens via de Domain Controller.
* Gebruikers kunnen met theoracle.thematrix.local inloggen en een geëncrypteerd gesprek voeren
