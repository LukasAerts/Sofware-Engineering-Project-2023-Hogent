#### Exchange Part 6 ####

#Sessie aanmaken voor het verkrijgen van Exchange commands
$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://neo.thematrix.local/PowerShell/ -Authentication Kerberos
Import-PSSession $Session -DisableNameChecking

# Values
$driveletter = (Get-Volume -FileSystemLabel EXCHANGESERVER2019-X64-CU12).driveletter

# Management Tools
Enable-WindowsOptionalFeature -Online -FeatureName IIS-IIS6ManagementCompatibility,IIS-Metabase -All 

# EMS Installation
& $env:ExchangeInstallPath\Scripts\Add-PermissionForEMT.ps1

# Enable Spam Filter
& $env:ExchangeInstallPath\Scripts\Install-AntiSpamAgents.ps1

# SMTP Server configuration
Set-TransportConfig -InternalSMTPServers @{Add="192.168.20.3"}

# Anti Malware updates
& $env:ExchangeInstallPath\Scripts\Update-MalwareFilteringServer.ps1 -Identity neo.TheMatrix.local
& $env:ExchangeInstallPath\Scripts\Enable-AntimalwareScanning.ps1

# Restart Exchange Transport Service
Restart-Service MSExchangeTransport

