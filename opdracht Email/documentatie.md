Het script gaat er van uit dat je virtualbox hebt geïnstalleerd op de default locatie! (Dit is belangrijk voor VboxGuestAdditions te automatiseren voor iedereen). Als dat niet het geval is zal je in ./Exchange.bat een wijziging van het pad moeten aanbrengen bij de vboxmanage unattended install --additions-iso lijn.

_Als het commando cd plots niet meer werkt kan je het commando pushd gebruiken. In plaats van cd Downloads gebruik je dan pushd Downloads_

** De Domeincontroller moet aanstaan tijdens het volledige installatieproces **

1. Voor het succesvol installeren van de Exchange Server "neo" moet je beschikken over volgende structuur:
**_ Map Prerequisites _**
./Prerequisites/
                Features_domain_1.ps1
                Features_domain_2.ps1
                Features_domain_3.ps1
                Features_domain_4.ps1
                Features_domain_5.ps1
                Features_domain_6.ps1
                Features_domain_7.ps1
                users.csv


**_ Software _**
./Prerequisites/
                ndp48-x86-x64-allos-enu.exe
                rewrite_amd64_en-US.msi
                vcredist_x64.exe

ndp48-x86-x64-allos-enu.exe - .NET Framework 4.8
https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0fd66638cde16859462a6243a4629a50/ndp48-x86-x64-allos-enu.exe

vcredist_x64 - Visual C++ 2013
https://aka.ms/highdpimfc2013x64enu

rewrite_amd64_en-US.msi - URL Rewrite Module
https://download.microsoft.com/download/1/2/8/128E2E22-C1B9-44A4-BE2A-5859ED1D4592/rewrite_amd64_en-US.msi

UCMARedist zit verwerkt in de ISO van Exchange. Deze hoeft dus niet op voorhand geïnstalleerd te worden.

**_ MAP ISO _**
./ISO/
       en_windows_server_2019_x64_dvd_4cb967d8.iso
       mul_exchange_server_2019_cumulative_update_12_x64_dvd_52bf3153.iso
    

Windows Server 2019 ISO kan je halen van AcademicSoftware.
Exchange Server 2019 ISO kan je halen van chamilo in een geplaatste aankondiging van het vak.


2. Voer het bestand "Exchange.bat" uit.
=> Dit bestand maakt een nieuwe virtuele machine aan met de nodige instellingen. Het is belangrijk om deze instellingen aan te passen waar nodig (GB RAM, processorkernen)
=> De ISO voor Exchange moet nog handmatig worden toegevoegd aan de VM
=> On campus = bridged network instellen

3. Start de VM en wacht tot deze volledig is opgestart (en daarna automatisch is reboot!)

4. Voer het bestand "Transfer.ps1" uit.
=> Dit bestand zet alle benodigde scripts over naar de folder C:\Users\Administrator\Downloads
=> Werkt dit niet, herstart dan de machine. Guest Additions heeft een restart nodig voordat het werkt!

5. Navigeer naar de map Downloads met het commando "cd Downloads"
=> Gebruik het DIR commando om de transfer files te controleren

-------
Voor de volgende stappen is het belangrijk om volgende dingen te weten:
- Het script zal automatisch het volgende script laten runnen bij een computer reboot. Dit voor het volledige proces.
- Herstart na het uitvoeren van een script zelf de computer indien dat nodig is (als het bijvoorbeeld op één of andere manier toch niet automatisch is verlopen) - Powershell Reboot-Computer OF cmdprompt shutdown /r /t 5

6. Run het "Domain_Features_1.ps1" bestand met het commando "powershell .\Domain_Features_1.ps1"
=> Computer restart automatisch + Domain_Features_2.ps1 wordt uitgevoerd
=> Computer restart automatisch + Domain_Features_3.ps1 wordt uitgevoerd
=> Computer restart automatisch + Domain_Features_4.ps1 wordt uitgevoerd

7. Log in als administrator van het Matrix Domein op de Neo VM.
=> Verander van gebruiker op de VM (ctrl + delete, switch user)
=> Gebruiker: TheMatrix\Administrator | Password: 22Admin23


8. Voer het bestand "Domain_Features_5.ps1" (duurt zeer lang) uit om Exchange te installeren.

9. Controleer of je de mailbox systemen kan bereiken
=> Log in op een client met GUI en navigeer via een internetbrowser naar https://192.168.20.3/ECP voor toegang tot het administrator panel met gegevens (Gebruikersnaam: TheMatrix\Administrator | Password: 22Admin23)
=> Voeg de mailboxen van de AD gebruikers toe die één nodig hebben.
=> Navigeer naar https://192.168.20.3/OWA voor toegang tot de mailbox van een gebruiker. Je kan inloggen met de gegevens (Gebruikersnaam: TheMatrix\kea_ree | Password: 22User23) in het geval dat je Keanu Reeves toevoegde als mailboxbezitter. 

10. Voer het bestand "Domain_Features_6.ps1" uit om de anti-spam filter te installeren.
=> Zorg dat je nog steeds ingelogd bent als administrator van het Matrix domein! (TheMatrix\Administrator account!)

11. Voer het bestand "Domain_Features_7.ps1" uit om elke gebruiker in de Active Directory een mailbox te geven

12. Installatie voltooid!
