# 04_unattended.ps1

#sep_fprintfile04
function sep_fprintfile04 () {
sep_fprint "*******************************************************************************************"
sep_fprint "* Preparing the unattended setup file                                                     *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

function sep_fprintready04 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* Setup file ready, press ENTER to start the vm                                           *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}


function sep_fprintinstalling04 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* VM started, VirtualBox GUI will show up so you can follow along...                      *"
sep_fprint "* Have a coffee, windows is installing unattended (+- 15 minutes)                         *"
sep_fprint "* VM will boot twice                                                                      *"
sep_fprint "* Wait for instructions after second boot                                                 *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

function sep_fprintbooting04 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* VM is now rebooting for the second time to correctly install the guest additions.       *"
sep_fprint "* WAIT for the machine to be fully booted (check the VirtualBox GUI)                      *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#Main
sep_fprintfile04

#preparing the file
vBoxManage unattended install ${SEP_VMNAAM} `
    --iso ${SEP_VMISO} `
    --image-index ${SEP_WHAT} `
    --hostname ${SEP_VMHOSTNAMEFQDN} `
    --user ${SEP_VMUSER} `
    --password ${SEP_VMPASSWORD} `
    --full-user-name ${SEP_VMFULLUSER} `
    --country ${SEP_VMCOUNTRY} `
    --locale ${SEP_VMLOCALE} `
    --time-zone CET `
    --install-additions `
    --post-install-command 'powershell Set-WinUserLanguageList -LanguageList nl-BE -Force && powershell Stop-Service -Name wuauserv && powershell Set-Service -Name wuauserv -StartupType Disabled && mkdir "C:\TMP" && VBoxControl guestproperty set unattended_finished y && Shutdown /r /t 5'

sep_fprintready04

#read-host "..."
$null = sep_fcustomread -Prompt ""
sep_fprint "> Starting up the virtual machine will take a few seconds, have some patience"
VBoxManage startvm ${SEP_vmnaam}

sep_fprintinstalling04

VBoxManage guestproperty wait ${SEP_vmnaam} unattended_finished

sep_fprintbooting04

sep_fcontinue "Press ENTER when FULLY booted" "2"