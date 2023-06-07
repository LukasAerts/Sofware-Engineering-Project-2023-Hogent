:: Start Script

:: inladen virtualbox exe om vboxmanage commandos te kunnen gebruiken

set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"

:Virtualbox Variables

set VM_NAME=DirectorPC
set OS_TYPE=Windows10_64
SET DOMAIN_NAME=TheMatrix.local
SET USER_NAME=Administrator
SET PASSWORD=22Admin23
set /A RAM=7168
set /A VRAM=128
set /A PROCESSOR_CORES=4
set /A DRIVE_SIZE=25000
set NETWORK_ADAPTER1=bridged
set GRAPHICS_CONTROLLER=vboxsvga
set BRIDGED_ADAPTER_NAME="Killer E2500 Gigabit Ethernet Controller"
set ISO_PATH=.\ISO\SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.iso

::Aanmaken Windows 2010 client - Headless

VBoxManage createvm  --name %VM_NAME% --ostype %OS_TYPE% --register

::Veranderen Memory, CPU & Network Connection

VBoxManage modifyvm %VM_NAME% --memory %RAM% --vram %VRAM% --cpus %PROCESSOR_CORES% --graphicscontroller %GRAPHICS_CONTROLLER%
VBoxManage modifyvm %VM_NAME% --nic1 %NETWORK_ADAPTER1% --bridgeadapter1 %BRIDGED_ADAPTER_NAME%


::Toevoegen VDI & ISO, opstartvolgorde Boot drives

vBoxManage createmedium disk --filename .\Drives\%VM_NAME%.vdi --size %DRIVE_SIZE%

vBoxManage storagectl %VM_NAME% --name "SATA Controller" --add sata --controller IntelAHCI
vBoxManage storageattach %VM_NAME% --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium .\Drives\%VM_NAME%.vdi
VBoxManage storageattach %VM_NAME% --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium %ISO_PATH%

vBoxManage modifyvm %VM_NAME% --boot1 dvd --boot2 disk --boot3 none --boot4 none

:: Automatische installatie van OS + guest additions + set powershell execution policy

START /WAIT vBoxManage unattended install %VM_NAME% --iso %ISO_PATH% --hostname %VM_NAME%.%DOMAIN_NAME% --user %USER_NAME% --password %PASSWORD% --country BE --locale nl_BE --install-additions --post-install-command "powershell Set-ExecutionPolicy RemoteSigned -Scope LocalMachine ; Shutdown /r /t 5"

START /WAIT VBoxManage startvm %VM_NAME%

:: Einde script
PAUSE