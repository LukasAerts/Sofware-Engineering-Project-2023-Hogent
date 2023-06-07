# 07_ad.ps1


#sep_fprinthead08
function sep_fprinthead08 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up the AD structure                                                             *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintinstallings08
function sep_fprintinstallings08 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up AD-Structure                                                                 *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}
#sep_fprintinstallingc08
function sep_fprintinstallingc08 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Importing the computers                                                                 *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}
#sep_fprintinstallingu08
function sep_fprintinstallingu08 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Importing the users                                                                     *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintinstallingf08
function sep_fprintinstallingf08 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting permissions for shared directories                                              *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintcheck08
function sep_fprintcheck08 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Verifying (TODO)                                                                        *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#Main
sep_fprinthead08
sep_fprint "> copying smith_03_ad_objecten.ps1 from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\smith_03_ad_objecten.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> copying structuur.csv from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\csv\structuur.csv" --username ${SEP_vmuser} --password ${SEP_vmpassword}
sep_fprint "> copying computers.csv from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\csv\computers.csv" --username ${SEP_vmuser} --password ${SEP_vmpassword}
sep_fprint "> copying users.csv from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\csv\users.csv" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> executing smith_03_ad_objecten.ps1" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_vmnaam} start --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\Users\Administrator\Downloads\smith_03_ad_objecten.ps1"

sep_fprintinstallings08
VBoxManage guestproperty wait ${SEP_vmnaam} ad_objecten_01
sep_fprintinstallingc08
VBoxManage guestproperty wait ${SEP_vmnaam} ad_objecten_02
sep_fprintinstallingu08
VBoxManage guestproperty wait ${SEP_vmnaam} ad_objecten_03
sep_fprintinstallingf08
start-sleep -s 5
#VBoxManage guestproperty wait ${SEP_vmnaam} ad_objecten_finished
#VBoxManage guestproperty wait ${SEP_vmnaam} ad_objecten_04
#fix :
read-host "TMP: wait 20 seconds and press enter"
start-sleep -s 5
sep_fprintcheck08

# new line has a function!