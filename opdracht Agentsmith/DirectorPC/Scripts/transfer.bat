:: Variables
set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"

SET VM_NAME=DirectorPC
SET CMD_PATH=C:\Windows\System32\cmd.exe
SET POWERSHELL_PATH=C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe
SET USER_NAME=Administrator
SET PASSWORD=22Admin23
SET NAME_PC_CONFIG_SCRIPT=workstationConfiguration.ps1
SET TARGET_PATH=C:\Windows\Temp

:: Copy files from Host machine to guest machine

vboxmanage guestcontrol %VM_NAME% copyto --target-directory %TARGET_PATH% ".\%NAME_PC_CONFIG_SCRIPT%"--username %USER_NAME% --password %PASSWORD%

:: recursive file transfer useful for if a lot of files need to be transferd, downside host paht needs can't be relative. 
:: vboxmanage guestcontrol %VM_NAME% --username %USER_NAME% --password %PASSWORD% copyto --recursive 'D:/VirtualBox VMs/cybsecVirtPE/script' --target-directory %TARGET_PATH%
 

:: Execute copied files 

vboxmanage guestcontrol "%VM_NAME%" run --exe %POWERSHELL_PATH% --username %USER_NAME% --password %PASSWORD% -- {powershell}/arg0 "%TARGET_PATH%\%NAME_PC_CONFIG_SCRIPT%"
PAUSE