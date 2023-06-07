1. Benodigdheden voor installatie:
    - Windows server 2019 ISO installatie
    - Exchange server ISO
    - NAT Connectie + Internal Network met DC (of bridged adapter in labo)

2. Benodigdheden na installatie Windows Server 2019:
    - Mounted Exchange Server ISO
    - Computer joined in het domain TheMatrix.local ( thuis => Internal Network, labo => Bridged Adapter | voor connectie) => Zie 2a.
    - .NET Framework 4.8 Update ( https://download.visualstudio.microsoft.com/download/pr/014120d7-d689-4305-befd-3cb711108212/0fd66638cde16859462a6243a4629a50/ndp48-x86-x64-allos-enu.exe )
    - Visual C++ Redestributable Package for Visual Studio 2013 ( https://support.microsoft.com/help/4032938/update-for-visual-c-2013-redistributable-package )
    - IIS Url Rewrite Module ( https://www.iis.net/downloads/microsoft/url-rewrite )
    - Unified Communications Managed API 4.0 ( https://www.microsoft.com/en-us/download/details.aspx?id=34992 )

    Terug te vinden op https://learn.microsoft.com/en-us/exchange/plan-and-deploy/prerequisites?view=exchserver-2019 inclusief powershell code

    2a. Handleiding server op domain aansluiten (ZEER BELANGRIJK):
        - Computer in het domein toevoegen doe je via zoeken => control panel => System and security => System => Rename computer (Advanced) => change => Computername
        - Pas de computernaam aan naar neo
        - Herstart de server en log in als een andere gebruiker met credentials ("TheMatrix\Administrator" "22Admin23")
        - Ga terug naar hetzelfde menu om de computernaam aan te passen, maar kies deze keer voor Domain en gebruik "TheMatrix.local"
        - Geef dezelfde credentials in als 2 stappen hiervoor

3. Installatie Exchange Server
    - Open het bestand Setup in de mounted exchange server Drive
    - Installatie Tutorial = https://www.youtube.com/watch?v=h7E2xeKZ1Vs&ab_channel=MSFTWebCast

4. Post-Installatie
    - Herstart het systeem
    - Navigeer naar Https://localhost/ecp voor admin center
        - Voeg de mailboxen van de users uit de AD toe (recipients => mailboxes => + teken => existing user => browse user => users uit AD zouden moeten verschijnen)
    - Navigeer naar Https://localhost/owa voor mailbox
        - Probeer als eerste in te loggen als Administrator (TheMatrix.local\Administrator - 22Admin23)
        - Probeer als tweede in te loggen als een user (TheMatrix.local\lan_wac - 22user23)
        - Verstuur een mail naar administrator@thematrix.local of lanawachowski@thematrix.local
        - Bevestig dat je die ontvangen hebt. Zit je mail vast in draft?
            - (Gemakkelijkste manier) Zet de VM uit en disable de NAT Adapter, start de VM en nu zou de mail moeten versturen
            - (Alternatieve manier) Pas de C:\Windows\System32\drivers\etc\hosts aan zoals uitgelegd in https://www.youtube.com/watch?v=uHYOG9b8RYE&ab_channel=BonGuides of de geschreven guide https://bonguides.com/how-to-fix-exchange-server-emails-stuck-in-draft-folder/

5. Done!
    - Je kan ook op een client die verbonden is met het domein de mailbox bereiken door het IP van de exchange server gevolgd door /owa in te geven.
        Voorbeeld: Https://192.168.20.100/OWA


    

