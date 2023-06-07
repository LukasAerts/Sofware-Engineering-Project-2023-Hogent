### Procedures Exchange Server Neo

**_ Folderstructuur _**
./Scripts/
    Exchange.bat
    Transfer.ps1

./Scripts/ISO
    en_windows_server_2019_x64_dvd_4cb967d8.iso
    mul_exchange_server_2019_cumulative_update_12_x64_dvd_52bf3153.iso

./Scripts/Prerequisites/
    ndp48-x86-x64-allos-enu.exe
    vcredist_x64.exe
    rewrite_amd64_en-US.msi
    Features_domain_1.ps1
    Features_domain_2.ps1
    Features_domain_3.ps1
    Features_domain_4.ps1
    Features_domain_5.ps1
    Features_domain_6.ps1
    Features_domain_7.ps1
    users.csv

**_ Exchange Installer _**
Pas indien nodig de variabelen aan bovenaan het bestand (geheugen, processorkernen, adapter, ...)

**_ Na Exchange Installer _**
Controleer de instellingen van de aangemaakte VM in Virtualbox.

-> Voeg zelf de Exchange ISO toe aan de controller.
-> Kijk zeker de netwerkinstellingen na (adapters)

**_ Login _**
Username = Administrator
Password = 22Admin23
