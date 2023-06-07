set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"
vboxmanage guestcontrol DomainController copyto --target-directory "C:\Users\Administrator\Downloads" ".\Features.ps1" --username "Administrator" --password "22Admin23"
vboxmanage guestcontrol DomainController copyto --target-directory "C:\Users\Administrator\Downloads" ".\AD.ps1" --username "Administrator" --password "22Admin23"
vboxmanage guestcontrol DomainController copyto --target-directory "C:\Windows\Temp" ".\csv\users.csv" --username "Administrator" --password "22Admin23"
vboxmanage guestcontrol DomainController run --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username "Administrator" --password "22Admin23" -- {powershell}/arg0 C:\Users\Administrator\Downloads\Features.ps1
PAUSE