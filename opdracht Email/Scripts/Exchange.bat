::Virtualbox Variables

set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"
set vmnaam=neo
set ostype="Windows2019_64"
set /A geheugen=16384
set /A vram=128
set /A processorkernen=4
set netwerkadapter1="bridged"
set bridgeadapterName=vboxmanage list bridgedifs | findstr /n Name | findstr "^[1]:"
set /A drivesize=75000

::Aanmaken Windows Server 2019 - Headless

VBoxManage createvm  --name "%vmnaam%" --ostype %ostype% --register


::Veranderen Memory, CPU & Network Connection

VBoxManage modifyvm %vmnaam% --memory %geheugen% --vram %vram%
VBoxManage modifyvm %vmnaam% --cpus %processorkernen%
VBoxManage modifyvm %vmnaam% --nic1 intnet 
VBoxManage modifyvm %vmnaam% --intnet1 servers
VBoxManage modifyvm %vmnaam% --nic2 nat

::Toevoegen VDI & ISO, opstartvolgorde Boot drives

vBoxManage createmedium --filename ".\Drives\%vmnaam%Drive.vdi" --size %drivesize%

vBoxManage storagectl %vmnaam% --name "SATA Controller" --add sata --controller IntelAHCI
vBoxManage storageattach %vmnaam% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium ".\Drives\%vmnaam%Drive.vdi"
VBoxManage storageattach %vmnaam% --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium ".\ISO\mul_exchange_server_2019_cumulative_update_12_x64_dvd_52bf3153.iso"
vBoxManage storagectl %vmnaam% --name "IDE Controller" --add ide
VBoxManage storageattach %vmnaam% --storagectl "IDE Controller" --port 0 --device 0 --type dvddrive --medium ".\ISO\en_windows_server_2019_x64_dvd_4cb967d8.iso"

vBoxManage modifyvm %vmnaam% --boot1 dvd --boot2 disk --boot3 none --boot4 none

:: Automatische installatie van OS

vBoxManage unattended install %vmnaam% --iso ".\ISO\en_windows_server_2019_x64_dvd_4cb967d8.iso" --hostname "%vmnaam%.TheMatrix.local" --user "Administrator" --password "22Admin23" --country "BE" --locale "nl_BE" --install-additions --post-install-command "Shutdown /r /t 1"

PAUSE
