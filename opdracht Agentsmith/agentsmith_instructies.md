# Instructies Opdracht 3.3: Domain Controller

## Opmerking
  * De instructies zorgen ervoor dat U (dit deel van) het project sussesvol kan opzetten.
  * Voor het testen van de deliverables volgt U het [testplan](agentsmith_testplan.md).
  * Meer achtergrondinformatie is te verkrijgen in de [documentatie](agentsmith_documentatie.md).
  * Onderstaande instructies zijn gebaseerd op het einddoel welke tijdens de demo dient te worden behaald.
  * Voor testsituaties op andere locaties dienen in de interactieve menu's meestal andere keuzes worden gemaakt en is het doorgaans aangeraden geen conflicterende dhcpservers op het netwerk toe te laten.

## Prerequisites
  * Oracle VM VirtualBox met Guest Additions
  * De folder scripts/keuzemenu met alle bestanden en subfolders.
  * Zorg dat de voor U van toepassing zijnde variabelen en opties beschibaar zijn:
    * in 00_winserver2019.ps1
      * in de functie sep_fprintwho cheken of uw naam beschikbaar is
      * in de controle ${SEP_WHO} = sep_fcheckinput @(1,2,7,9) checken of het nummer naast uw naam een toegelaten optie is 
    * in 02_set_variables.ps1:
      * bij de switch($SEP_WHO) checken of uw waarden correct zijn:
        * $SEP_vbpath: de locatie van VirtualBox
        * $SEP_vbvmspath: de locaie van de VM's
        * $SEP_vmiso: de locaie van de .iso van windows server 2019
        * $SEP_VMNICNAME: de naam van de te bridgen netwerkadapter
  * Volgend bestand op uw systeem
    * en_windows_server_2019_x64_dvd_4cb967d8.iso, te bekomen via [Academic Software](https://downloads.academicsoftware.eu/windowsserver2019/en_windows_server_2019_x64_dvd_4cb967d8.iso)

## Instructies
Run in powershell scripts/keuzemenu/00_winserver2019.ps1 en maak volgende keuzes:
  * Who: 1) Benny
  * What: 1) CLI
  * Where: 3) 192.168.20.0/24
  * Progress: 1) Yes
  * Pauze: 1) Yes
  * Druk ENTER na het nalezen van de variabelen welke zullen worden gebruikt
  * Druk ENTER nadat de virtuele machine werd aangemaakt en de nodige instellingen ervan werden gedaan
  * Druk ENTER na het bekijken van de unattended setup file
  * Wacht tot de VM volledig is opgestart met inbegrip van een extra reboot. Deze stap duurt behoorlijk lang en kan gevolgd worden in de VirtualBox GUI.
  * Druk ENTER wanneer de unattended installation volledig is afgerond
  * Druk ENTER na controle van de netwerkinstellingen
  * Druk ENTER na instellen van de extra harde schijf en de mappen erop
  * Wacht tot de Active Directory Domain Services worden geïnstalleerd en geconfigureerd. Deze stap duurt wederom en tijdje en wordt gevolgd door een reboot waarna wederom moet worden gewacht op een volledige configuratie.
  * Druk ENTER nadat in de VirtulBox GUI kon worden vastgesteld dat de machine volledig is gereboot ('Applying computer settings' verdwenen)
  * Wacht tot de .csv files worden ingeladen en de structuur, computers, gebruikers en gedeelde mappen werden geconfigureerd
  * Wacht een twintigtal seconden na de laatste boodschap alvorens op ENTER te drukken
  * Druk ENTER nadat de DNS-instellingen werden opgeladen
  * Druk ENTER nadat de (namen en links van de) group policies werden opgeladen

Na het uitvoeren van dit powershell script zijn de meeste deliverables uit het [lastenboek](agentsmith_lastenboek.md) reeds af te vinken. Volgende zaken dienen nog in de GUI op de DirectorPC te worden geconfigureerd. Indien nodig volg de instructies voor het opzetten van de DirectorPC [hier](../OpdrachtWindows10/windows10_instructies.md).

* log in op de DirectorPc als THEMATRIX\Administrator
* Start Server Manager
  * Manage > add server > agentsmith

* Start Group Policiy Management op (via Tools in Server Manager of via Windows Administrative Tools)
  * Beleidsregel op gebruikersniveau: Enkel directors hebben toegang tot het control panel
    * De GPO sep_01_controlpanel_domainusers_denied is reeds aangemaakt en gelinkt aan OU DomainUsers
    * Edit en enable de GPO onder Group Policy Objects: User Configuration > Policies > Administrative templates > Control Panel > Prohibit access to Control Panel and PC settings
    * De GPO sep_02_controlpanel_directors_allowed is reeds aangemaakt en gelinkt aan OU Directors
    * Edit en **disable** de GPO onder Group Policy Objects: User Configuration > Policies > Administrative templates > Control Panel > Prohibit access to Control Panel and PC settings


  * Beleidsregel op gebruikersniveau: Niemand kan werkbalken (toolbars) toevoegen aan de taakbalk
    * De GPO sep_03_disable_toolbars is reeds aangemaakt en gelinkt aan OU DomainUsers
    * Edit en enable de GPO onder Group Policy Objects: User Configuration > Policies > Administrative templates > Start Menu and Taskbar > Prevent users from adding or removing toolbars


  * Beleidsregel op gebruikersniveau: De cast heeft geen toegang tot de eigenschappen van de netwerkadapters
    * Wegens een eerdere GPO (geen toegang tot control panel) reeds onmogelijk te bereiken, maar voor de volledigheid ...
    * De GPO sep_04_cast_no_networkadapters is reeds aangemaakt en gelinkt aan OU Cast
    * Edit en enable de GPO onder Group Policy Objects: User Configuration > Policies > Administrative templates > Network > Network Connections > Prohibit access to properties of a LAN connection


  * Volgende deliverables reeds ok via een fix maar mooier op te lossen via group policies:
    * Cast kan enkel inloggen in de cast-Pc’s
      * De GPO sep_05_cast_inloggen_op_castpcs is reeds aangemaakt en gelinkt aan de PC's van OU Cast
      * Edit en Define de GPO onder Group Policy Objects: Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment > Allow log on locally
      * Voeg Administrators, THEMATRIX\DirectorsSG en THEMATRIX\CastSG toe
    * Crew kan enkel inloggen op de crew-Pc’s
      * De GPO sep_06_crew_inloggen_op_crewpcs is reeds aangemaakt en gelinkt aan de PC's van OU Crew
      * Edit en enable de GPO onder Group Policy Objects: Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment > Allow log on locally
      * Voeg Administrators en THEMATRIX\CrewSG toe
    * Directors kunnen overal inloggen
      * De GPO sep_07_directors_inloggen_op_directorpcs is reeds aangemaakt en gelinkt aan de PC's van OU Directors
      * Edit en enable de GPO onder Group Policy Objects: Computer Configuration > Policies > Windows Settings > Security Settings > Local Policies > User Rights Assignment > Allow log on locally
      * Voeg Administrators en THEMATRIX\DirectorsSG toe
  
  
  * Een leuk extraatje:
    * Cast heeft een eigen wallpaper
      * De GPO sep_08_cast_wallpaper is reeds aangemaakt en gelinkt aan OU Cast
      * Edit en enable de GPO onder Group Policy Objects: User Configuration > Policies > Administrative Templates > Desktop > Desktop > Desktop Wallpaper
        * Wallpaper name: \\agentsmith\WALLPAPER\cast.jpg
        * Style: Span
    * Crew heeft een eigen wallpaper
      * De GPO sep_09_crew_wallpaper is reeds aangemaakt en gelinkt aan OU Crew
      * Edit en enable de GPO onder Group Policy Objects: User Configuration > Policies > Administrative Templates > Desktop > Desktop > Desktop Wallpaper
        * Wallpaper name: \\agentsmith\WALLPAPER\crew.jpg
        * Style: Fill
    * Directors hebben een eigen wallpaper
      * De GPO sep_10_directors_wallpaper is reeds aangemaakt en gelinkt aan OU Directors
      * Edit en enable de GPO onder Group Policy Objects: User Configuration > Policies > Administrative Templates > Desktop > Desktop > Desktop Wallpaper
        * Wallpaper name: \\agentsmith\WALLPAPER\directors.jpeg
        * Style: Fit

* Nog manueel te doen in DNS:
  * zet A record voor thematrix.local naar 192.168.20.2
  * voeg een MX record toe voor neo.thematrix.local


### Testplan & -rapport

Na opzetten volgens deze instructies kan het [tesplan](agentsmith_testplan.md) worden uitgevoerd en een [testrapport](agentsmith_testrapport.md) worden aangemaakt