# 05_make_clonedvm.ps1

#sep_fprintgo script letsgo uitprinten op het scherm
function sep_fprintwelkom05 () {
sep_fprint "*******************************************************************************************"
sep_fprint "* Making a (full) clone                                                                   *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

function sep_fprintcloning05 () {
    sep_fprint "*******************************************************************************************"
    sep_fprint "* Making a FULL clone of win10base                                                        *"
    sep_fprint "* Be patient (+/- 5 minutes)                                                              *"
    sep_fprint "* Wait for script to ask for an ENTER                                                     *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

function sep_fprintcloneready05 () {
    sep_fprint ""
    sep_fprint "*******************************************************************************************"
    sep_fprint "* The clone should now be ready                                                           *"
    sep_fprint "* Press ENTER to start the clone                                                          *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

function sep_fprintcloneadjust05 () {
    sep_fprint ""
    sep_fprint "*******************************************************************************************"
    sep_fprint "* Adjusting some settings before booting up                                               *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

function sep_fprintstarting05 () {
    sep_fprint ""
    sep_fprint "*******************************************************************************************"
    sep_fprint "* The clone is starting (takes a few seconds, be patient)                                 *"
    sep_fprint "* Wait for further instructions                                                           *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}
    
function sep_fprintwaitforfullboot05 () {
    sep_fprint ""
    sep_fprint "*******************************************************************************************"
    sep_fprint "* Fully booting up wil take some time                                                     *"
    sep_fprint "* Check GUI to verify if clone is FULLY booted                                            *"
    sep_fprint "* THEN press ENTER, no sooner                                                             *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

function sep_fprintsetting05 () {
    sep_fprint ""
    sep_fprint "*******************************************************************************************"
    sep_fprint "* Setting up the clone                                                                    *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

# MAIN
sep_fprintwelkom05

sep_fprintcloning05
vboxmanage clonevm "${SEP_vmnaam}" --basefolder "${SEP_vbvmspath}" --name "${SEP_NEWNAME}" --register

sep_fprintcloneready05
$null = fsep_customread ""

sep_fprintcloneadjust05
write-host "> changing nic to ${SEP_VMNICNAME}"
VBoxManage modifyvm ${SEP_NEWNAME} --bridgeadapter1 ${SEP_VMNICNAME}
write-host "> adjusting shared folder to ${SEP_PATH}"
VBoxManage sharedfolder remove ${SEP_NEWNAME} --name "HOST"
VBoxManage sharedfolder add ${SEP_NEWNAME} --name "HOST" --hostpath "${SEP_PATH}" --automount --auto-mount-point "G:"

sep_fprintstarting05
VBoxManage.exe startvm ${SEP_NEWNAME}

sep_fprintwaitforfullboot05
#TODO: een sleep van xx seconden om zeker te zijn?

$null = fsep_customread ""

#TODO: een while lus met een check om te kijken if fully booted?

sep_fprintsetting05
write-host "> setting execution policy"
vboxmanage guestcontrol ${SEP_NEWNAME} run --exe ${SEP_PSURL} --username ${SEP_vmuser} --password ${SEP_vmpassword} -- PowerShell.exe -Command "set-executionpolicy unrestricted"
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5
write-host "> checking execution policy (should be unrestricted)"
vboxmanage guestcontrol ${SEP_NEWNAME} run --exe ${SEP_PSURL} --username ${SEP_vmuser} --password ${SEP_vmpassword} -- PowerShell.exe -Command "get-executionpolicy"
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5
write-host "> making directory C:\TMP on guest"
vboxmanage guestcontrol ${SEP_NEWNAME} start --exe ${SEP_PSURL} --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "mkdir C:\TMP"
write-host ">>> sleeping for 10 seconds"
start-sleep -s 10

write-host "> copying disable.ps1 to guest"
vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\" "${SEP_PATH}\disable.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5

write-host "> copying clone_00_network.ps1 to guest"
vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\TMP\" "${SEP_PATH}\clone_00_network.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5

if (${SEP_WHERE} -eq "6") {
    write-host "> dhcp selected, skipping copying .csv"
}
else {
    write-host "> copying netwerk.csv to guest"
    vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\TMP\" "${SEP_PATH}\csv\${SEP_WHERE}\${SEP_WHICH}\netwerk.csv" --username ${SEP_vmuser} --password ${SEP_vmpassword}
    write-host ">>> sleeping for 5 seconds"
    start-sleep -s 5
}
  
write-host "> running clone_00_network.ps1 on guest"
vboxmanage guestcontrol ${SEP_NEWNAME} start --exe ${SEP_PSURL} --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\TMP\clone_00_network.ps1"
write-host "> waiting for the guest to send the finished-flag"
VBoxManage guestproperty wait ${SEP_NEWNAME} clone_network_finished
write-host ">>> sleeping for 10 seconds"
start-sleep -s 10

write-host "> checking ip-settings"
vboxmanage guestcontrol ${SEP_NEWNAME} run --username ${SEP_vmuser} --password ${SEP_vmpassword} --exe "C:\Windows\System32\ipconfig.exe" /arg0 "/all"
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5

write-host "> renaming and rebooting vm"
vboxmanage guestcontrol ${SEP_NEWNAME} start --exe ${SEP_PSURL} --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "Rename-Computer ${SEP_NEWWINNAME} -restart -force"
write-host ">>> sleeping for 20 seconds"
start-sleep -s 20

write-host "> vm should now be rebooting, check visually"
write-host ">>> sleeping for 60 seconds"
start-sleep -s 60

write-host "press enter ONLY when FULLY booted"
$null = fsep_customread ""

#the end
