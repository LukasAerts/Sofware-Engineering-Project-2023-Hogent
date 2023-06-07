# Instructies Opdracht 3.X: Windows10

## Opmerking
  * De instructies zorgen ervoor dat U de VM's met Windows 10 Pro sussesvol kan opzetten.
  * Voor het testen van de deliverables volgt U het [testplan](windows10_testplan.md).
  * Meer achtergrondinformatie is te verkrijgen in de [documentie](windows10_documentatie.md).
  * Onderstaande instructies zijn gebaseerd op het einddoel welke tijdens de demo dient te worden behaald.
  * Voor testsituaties op andere locaties dienen in de interactieve menu's meestal andere keuzes worden gemaakt. In het bijzonder is het niet aan te raden de VMS aan te sluiten aan een netwerk met een dhcpserver die andere info dan deze van het netwerk doorstuurt, dit maakt het zeer moeilijk de netwerkkaart correct geconfigureerd te krijgen.
  * De instructies zijn onderverdeeld in deze voor het opzetten van een basis vm en deze voor het opzetten van een specifieke kloon van deze basis.

## Prerequisites
  * Oracle VM VirtualBox met Guest Additions
  * De folder keuzemenu_win10base met alle bestanden en subfolders.
  * De folder keuzemenu_win10clones met alle bestanden en subfolders.
  * Zorg dat de voor U van toepassing zijde variabelen en opties beschibaar zijn:
    * in scripts/keuzemenu_win10base/00_win10base.ps1 en scripts/keuzemenu_win10clones/00_win10clones.ps1
      * in de functie sep_fprintwho cheken of uw naam beschikbaar is
      * in de controle ${SEP_WHO} = sep_fcheckinput @(1,6,7,8,9) checken of het nummer naast uw naam een toegelaten optie is 
    * in 02_set_variables.ps1:
      * bij de switch($SEP_WHO) checken of uw waarden correct zijn:
        * $SEP_vbpath: de locatie van VirtualBox
        * $SEP_vbvmspath: de locaie van de VM's
        * $SEP_vmiso: de locaie van de .iso van Windows Pro 2010
        * $SEP_VMNICNAME: de naam van de te bridgen netwerkadapter
        * $SEP_msupath: de locatie van de rsat-update
        * $SEP_chatpath: de locatie van de synapse chat client chat.exe
  * Volgende bestanden op uw systeem
    * $SEP_vmiso : SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO, te bekomen via [Academic Software](https://downloads.academicsoftware.eu/Windows10/Windows10_64-Bits/SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO)
    * SEP_msupath: WindowsTH-KB2693643-x64.msu, te bekomen via [Microsoft](https://download.microsoft.com/download/1/D/8/1D8B5022-5477-4B9A-8104-6A71FF9D98AB/WindowsTH-KB2693643-x64.msu)
    * $SEP_chatpath: neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe, van [KDE](https://download.kde.org/stable/release-service/23.04.0/windows/neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe)

## Instructies

  * Maak een basis vm SEP_win10base door met powershell scripts/keuzemenu_win10base/00_win10base.ps1 uit te voeren. Een interactief menu zou deze stap plug en play moeten maken. Merk op dat dit script niet voorziet dat een machine met deze naam reeds bestaat, dus bij meerdere keren uitvoeren eerst de VM met dezelfde naam verwijderen in VirtualBox
  * Eens deze basis vm klaar is kan met behulp van scripts/keuzemenu_win10clones/00_win10clones.ps1 een gelijkaardig menu doorlopen worden om de volgende PC's op te zetten:
    * DirectorPC
    * PCCrew1
    * PCCrew2
    * PCCast1
    * PCCast2
  * Inien de machines ook de nameserver (op agentsmith) kunnen bereiken zal op het einde van het script een poging worden gedaan het domein te joinen.
  * Indien de machine pas later aan het correcte netwerk wordt gehangen dient in windows 10 met de GUI het domein worden gejoined of het powershell script C:\TMP\clone_02_joindomain.ps1 te worden uitgevoerd
