#### Exchange Part 5 ####

# Values
$driveletter = (Get-Volume -FileSystemLabel EXCHANGESERVER2019-X64-CU12).driveletter

# Exchange Extend AD
write-host "Preparing Schema ..."
cmd.exe /c ""$driveletter":\setup.exe" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareSchema | Out-Null
write-host "Schema ready!"
write-host "Preparing AD..."
cmd.exe /c ""$driveletter":\setup.exe" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareAD /OrganizationName:"TheMatrix" | Out-Null
write-host "AD ready!"
write-host "Preparing all domains..."
cmd.exe /c ""$driveletter":\setup.exe" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /PrepareAllDomains | Out-Null
write-host "All domains ready!"

# Exchange Intall Mailbox
write-host "Preparing Mailbox installation..."
cmd.exe /c ""$driveletter":\setup.exe" /IAcceptExchangeServerLicenseTerms_DiagnosticDataOFF /mode:install /Role:Mailbox | Out-Null
write-host "Mailbox role installed and ready for use!"
