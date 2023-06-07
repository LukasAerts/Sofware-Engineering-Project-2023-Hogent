#### Exchange Part 2 #####

cmd.exe /c Timeout /T 10

# Values
$Servername = "neo"
$username = "TheMatrix\Administrator"
$SecurePass = (ConvertTo-SecureString -String "22Admin23" -AsPlainText -Force)
$Credentials = New-Object System.Management.Automation.PSCredential($username,$SecurePass)
$NextScript = "C:\Users\Administrator\Downloads\Features_domain_3"

# Prepare registry key to run the next script on reboot
Write-Host "Preparing next script Features_domain_3... on reboot"
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name "Features_domain_3" -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "C:\Users\Administrator\Downloads\Features_domain_3.ps1"'

# WindowsFeature
Write-Host "Installing ADDS..."
Install-WindowsFeature RSAT-ADDS

# Add PC to domain
Write-Host "Connecting PC with domain..."
Add-Computer -Computername $Servername -DomainName TheMatrix.local -OUPath "OU=Servers,OU=DomainWorkStations,DC=TheMatrix,DC=local" -Credential $Credentials

# Buffer time
Write-Host "Restarting in 10 seconds!"
cmd.exe /c Timeout /T 10

# Reboot
Restart-Computer -Force