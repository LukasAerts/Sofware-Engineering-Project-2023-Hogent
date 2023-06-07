# smith_02_ad_feature.ps1

[String]$SMITH_pass = "22Admin23"
[SecureString]$SMITH_SECUREPASS = (ConvertTo-SecureString -String ${SMITH_pass} -AsPlainText -Force)
[String]$SMITH_VERBOSE= 1
[String]$SMITH_DOM="thematrix.local"
[String]$SMITH_OLDDOM="THEMATRIX"

# smith_fprint for now prints to the screen, only visible when running on guest
function smith_fprint ([String]$message, [String]$verbose="1") {
    if ($verbose -eq "1") {
        write-host ${message}
    }
}

# AD Feature Installatie
smith_fprint "installing the windows feature" $SMITH_VERBOSE
install-WindowsFeature AD-Domain-Services -IncludeManagementTools -verbose

# install-WindowsFeature -configurationFilePath S:\Shared\CAST\DeploymentConfigTemplateADDS.xml

# alerting the calling script on the host
VBoxControl guestproperty set feature_finished y


# Windows PowerShell script for AD DS Deployment
smith_fprint "installing the forest" $SMITH_VERBOSE

Import-Module ADDSDeployment

Install-ADDSForest `
-CreateDnsDelegation:$false `
-DatabasePath "C:\Windows\NTDS" `
-DomainMode "WinThreshold" `
-DomainName ${SMITH_DOM} `
-DomainNetbiosName ${SMITH_OLDDOM} `
-ForestMode "WinThreshold" `
-InstallDns:$true `
-LogPath "C:\Windows\NTDS" `
-NoRebootOnCompletion:$false `
-SysvolPath "C:\Windows\SYSVOL" `
-Force:$true `
-SafeModeAdministratorPassword ${SMITH_SECUREPASS}

# alerting the calling script on the host
VBoxControl guestproperty set ad_finished y

# server will be rebooting now ...

#last line
