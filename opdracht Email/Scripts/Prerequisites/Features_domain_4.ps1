#### Exchange Part 4 ####

cmd.exe /c Timeout /T 10

# Values
$driveletter = (Get-Volume -FileSystemLabel EXCHANGESERVER2019-X64-CU12).driveletter

# Install IIS Rewrite Module prerequisite
Write-Host "Installing IIS Rewrite module..."
cmd.exe /c C:\Users\Administrator\Downloads\rewrite_amd64_en-US.msi /q /norestart | Out-Null
Write-Host "IIS Rewrite module installed!"
# Install UCMARedist prerequisite
Write-Host "Installing UCMARedist prerequisite"
cmd.exe /c ""$driveletter":\UCMARedist\setup.exe" /q /norestart | Out-Null
Write-host "UCMARedist installed!"
# Buffer time
Write-Host "Restarting in 30 seconds!"
cmd.exe /c Timeout /T 30

# Restart computer
Restart-Computer -Force