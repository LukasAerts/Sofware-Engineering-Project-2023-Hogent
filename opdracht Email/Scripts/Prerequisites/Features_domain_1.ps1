#### Exchange Part 1 ####

#Values
$SecurePass = (ConvertTo-SecureString -String "22Admin23" -AsPlainText -Force)
$IP = "192.168.20.3"
$GW = "192.168.20.1"
$DNS = "192.168.20.1"
$NextScript = "C:\Users\Administrator\Downloads\Features_domain_2"

# Keyboard layout
Write-Host "Changing keyboard language to nl-BE azerty"
Set-WinUserLanguageList -LanguageList nl-BE -Force

# Disable firewall
Write-Host "Doing some bad practice by disabling firewall..."
cmd.exe /c netsh advfirewall set allprofiles state off

# Assign static IP
Write-Host "Configuring static IP for server..."
New-NetIPAddress -InterfaceAlias Ethernet -IPAddress $IP -AddressFamily IPv4 -PrefixLength 24 -DefaultGateway $GW
Set-DnsClientServerAddress -InterfaceAlias Ethernet -ServerAddresses $DNS

# Prepare registry key to run the next script on reboot
Write-Host "Preparing next script Features_domain_2... on reboot"
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name "Features_domain_2" -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "C:\Users\Administrator\Downloads\Features_domain_2.ps1"'

# Install .NET Framework 4.8 and Visual C++ Redistributable
Write-Host "Installing .NET Framework 4.8..."
cmd.exe /c C:\Users\Administrator\Downloads\ndp48-x86-x64-allos-enu.exe /q /norestart /install | Out-Null
Write-Host ".NET Framework 4.8 Installed!"
Write-Host "Installing Visual C++ Redistributable..."
cmd.exe /c C:\Users\Administrator\Downloads\vcredist_x64.exe /q /norestart | Out-Null
Write-Host "Visual C++ Redistributable installed!"

# Buffer time
Write-Host "Restarting in 30 Seconds!"
cmd.exe /c Timeout /T 30

# Reboot
Restart-Computer -Force