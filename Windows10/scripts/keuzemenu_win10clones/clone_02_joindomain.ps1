$domainName = "thematrix.local"
$adminUser = "THEMATRIX\Administrator"
$SEP_VMPASSWORD = "22Admin23"
$adminPassword = ConvertTo-SecureString ${SEP_VMPASSWORD} -AsPlainText -Force
$adminCredential = New-Object System.Management.Automation.PSCredential ($adminUser, $adminPassword)

#MAIN
#After joining the domain, no longer automaticly login to local Administrator
write-host "disabling auto-logon for local Administrator"
set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" -Name "AutoAdminLogon" -Value "0"

#join the domain and restart
write-host "trying to join ${domainName}" 
Add-Computer -DomainName $domainName -Credential $adminCredential -Restart

#last line