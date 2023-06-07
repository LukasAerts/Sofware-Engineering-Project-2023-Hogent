#### Exchange Part 3 ####

cmd.exe /c Timeout /T 10

# Values
$driveletter = (Get-Volume -FileSystemLabel EXCHANGESERVER2019-X64-CU12).driveletter

# Install Windows Components
Write-host "Installing windows Features"

Install-WindowsFeature `
    Server-Media-Foundation,`
    NET-Framework-45-Features,`
    RPC-over-HTTP-proxy,`
    RSAT-Clustering,`
    RSAT-Clustering-CmdInterface,`
    RSAT-Clustering-PowerShell,`
    WAS-Process-Model,`
    Web-Asp-Net45,`
    Web-Basic-Auth,`
    Web-Client-Auth,`
    Web-Digest-Auth,`
    Web-Dir-Browsing,`
    Web-Dyn-Compression,`
    Web-Http-Errors,`
    Web-Http-Logging,`
    Web-Http-Redirect,`
    Web-Http-Tracing,`
    Web-ISAPI-Ext,`
    Web-ISAPI-Filter,`
    Web-Metabase,`
    Web-Mgmt-Service,`
    Web-Net-Ext45,`
    Web-Request-Monitor,`
    Web-Server,`
    Web-Stat-Compression,`
    Web-Static-Content,`
    Web-Windows-Auth,`
    Web-WMI

# Prepare registry key to run the next script on reboot
Write-Host "Preparing next script Features_domain_4... on reboot"
Set-Location -Path 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce'
Set-ItemProperty -Path . -Name "Features_domain_4" -Value 'C:\WINDOWS\system32\WindowsPowerShell\v1.0\powershell.exe "C:\Users\Administrator\Downloads\Features_domain_4.ps1"'

# Buffer Time
Write-Host "Restarting in 30 seconds!"
cmd.exe /c Timeout /T 30

# Reboot
Restart-Computer -Force