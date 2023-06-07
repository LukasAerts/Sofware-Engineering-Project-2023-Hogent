# 07_ad.ps1


#sep_fprinthead07
function sep_fprinthead07 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up ad                                                                           *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

function sep_fprintfeat07 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Installing the Windows-Feature                                                          *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

function sep_fprintforest07 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up the forest                                                                   *" ${SEP_VERBOSE}
sep_fprint "* This will take some time                                                                *" ${SEP_VERBOSE}
sep_fprint "* VM will reboot when finished                                                            *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

function sep_fprintboot07 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Windows is now rebooting to complete the installation                                   *" ${SEP_VERBOSE}
sep_fprint "* Check the VirtualBox GUI to see when the reboot is complete                             *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#Main
sep_fprinthead07
sep_fprint "> copying smith_02_ad.ps1 from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\smith_02_ad_feature.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> executing smith_02_ad.ps1" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_vmnaam} start --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\Users\Administrator\Downloads\smith_02_ad_feature.ps1"

sep_fprintfeat07
VBoxManage guestproperty wait ${SEP_vmnaam} feature_finished

sep_fprintforest07

VBoxManage guestproperty wait ${SEP_vmnaam} ad_finished

sep_fprintboot07
read-host "Press ENTER when fully booted"