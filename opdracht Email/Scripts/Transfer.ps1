#### Exchange Transfer ####

# Values
$serverName = "Neo"
$username = "Administrator"
$SecurePass = (ConvertTo-SecureString -String "22Admin23" -AsPlainText -Force)
$firstScript = "& C:\Users\Administrator\Downloads\Features_domain_1.ps1"

# Set Vbox Path
cmd.exe /c set PATH=%PATH%;"C:\Program Files\Oracle\VirtualBox"

# Transfer Files
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\ndp48-x86-x64-allos-enu.exe" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\rewrite_amd64_en-US.msi" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\vcredist_x64.exe" --username "Administrator" --password "22Admin23"

cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\Features_domain_1.ps1" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\Features_domain_2.ps1" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\Features_domain_3.ps1" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\Features_domain_4.ps1" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\Features_domain_5.ps1" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\Features_domain_6.ps1" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\Features_domain_7.ps1" --username "Administrator" --password "22Admin23"
cmd.exe /c vboxmanage guestcontrol $serverName copyto --target-directory "C:\Users\Administrator\Downloads" ".\Prerequisites\users.csv" --username "Administrator" --password "22Admin23"

# Execute the first script on Neo VM (Not working yet)
#cmd.exe /c vboxmanage guestcontrol "$serverName" run --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" --username Administrator --password 22Admin23 -- -Command $firstScript
cmd.exe /c vboxmanage guestcontrol Neo run --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username "Administrator" --password "22Admin23" -- {powershell}/arg0 C:\Users\Administrator\Downloads\Features_domain_1.ps1
#Restart-Computer : Failed to restart the computer Neo with the following error message: The system shutdown cannot be initiated because there are other users logged on to the computer.

# Troubleshooting Purposes
cmd.exe /c PAUSE