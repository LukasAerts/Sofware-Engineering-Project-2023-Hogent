#MAIN
#TODO: perhaps iets op te checken of de path bestaat
#remote moet aanstaan om server manager te doen werken ...
Set-Service -Name WinRM -StartupType Automatic
Start-Service -Name WinRM

get-service | Where-Object {$_.Name -eq 'wuauserv'} | Set-Service -StartupType Manual

$msuPath = "C:\TMP\WindowsTH-KB2693643-x64.msu"

$testje = "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\WindowsTH-KB2693643-x64.msu"
if (-not (Test-Path  ${testje})) {
    write-host 'WindowsTH-KB2693643-x64.msu not found, skipping'
    write-host ""
}
else {
    $process = Start-Process -FilePath "wusa.exe" -ArgumentList $msuPath,"/quiet","/norestart" -PassThru -Wait
    if ($process.ExitCode -eq 0) {
        Write-Host "The installation completed successfully."
    } else {
        Write-Host "An error occurred during the installation."
    }
}


$process = Start-Process -FilePath "$(Split-Path $MyInvocation.MyCommand.Path -Parent)\Neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe" -ArgumentList "/S" -PassThru -Wait
if ($process.ExitCode -eq 0) {
    Write-Host "The installation completed successfully."
} else {
    Write-Host "An error occurred during the installation."
}

get-service | Where-Object {$_.Name -eq 'wuauserv'} | Stop-Service
get-service | Where-Object {$_.Name -eq 'wuauserv'} | Set-Service -StartupType Disabled

#signaal voor oproepend script om verder te gaan ...
write-host "Sending signal to host"
VBoxControl guestproperty set clone_msu_finished y

# new line has a function!
