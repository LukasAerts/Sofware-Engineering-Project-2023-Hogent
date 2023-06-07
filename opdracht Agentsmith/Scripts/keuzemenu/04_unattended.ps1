#04_unattended.ps1

#sep_fprintfile04
function sep_fprintfile04 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Preparing the unattended setup file                                                     *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

function sep_fprintready04 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setup file ready, press ENTER to start the vm                                           *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}


function sep_fprintinstalling04 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* VM started, VirtualBox GUI will show up so you can follow along...                      *" ${SEP_VERBOSE}
sep_fprint "* Have a coffee, windows is installing unattended (+- 15 minutes)                         *" ${SEP_VERBOSE}
sep_fprint "* VM will boot twice                                                                      *" ${SEP_VERBOSE}
sep_fprint "* Wait for instructions after second boot                                                 *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

function sep_fprintbooting04 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* VM is now rebooting for the second time to correctly install the guest additions.       *" ${SEP_VERBOSE}
sep_fprint "* WAIT for the machine to be fully booted (check the VirtualBox GUI)                      *" ${SEP_VERBOSE}
sep_fprint "* CLI : command prompt (c:\Users\Administrator\) available                                *" ${SEP_VERBOSE}
sep_fprint "* GUI : Server Manager visible                                                            *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#Main
sep_fprintfile04

#preparing the file
if (${SEP_VERBOSE} -eq "1") {
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
    --post-install-command='powershell Set-WinUserLanguageList -LanguageList nl-BE -Force && VBoxControl guestproperty set unattended_finished y && Shutdown /r /t 5'
}
else {
    vBoxManage unattended install ${SEP_VMNAAM} `
    --iso ${SEP_VMISO} `
    --image-index ${SEP_WHAT} `
    --hostname $SEP_VMHOSTNAMEFQDN `
    --user ${SEP_VMUSER} `
    --password ${SEP_VMPASSWORD} `
    --full-user-name ${SEP_VMFULLUSER} `
    --country $SEP_VMCOUNTRY `
    --locale $SEP_VMLOCALE `
    --time-zone CET `
    --install-additions `
    --post-install-command='powershell Set-WinUserLanguageList -LanguageList nl-BE -Force ; VBoxControl guestproperty set unattended_finished y && Shutdown /r /t 5' *>$null
}

sep_fprintready04

## TODO: nog iets voor pauzed?
read-host "..."
sep_fprint "Starting up the virtual machine will take a few seconds, WAIT :)"
VBoxManage startvm ${SEP_vmnaam}

sep_fprintinstalling04

VBoxManage guestproperty wait ${SEP_vmnaam} unattended_finished

sep_fprintbooting04

read-host "Press ENTER when FULLY booted"