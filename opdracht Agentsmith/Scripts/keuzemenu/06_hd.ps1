# 05_network.ps1


#sep_fprinthead05
function sep_fprinthead06 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up shared folders on seperate partition                                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprinthead05
function sep_fprintcheck06 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Verifying shares                                                                        *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#Main
sep_fprinthead06
sep_fprint "> copying smith_01_hd.ps1 from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\smith_01_hd.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> executing smith_01_hd.ps1" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_vmnaam} start --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\Users\Administrator\Downloads\smith_01_hd.ps1"

VBoxManage guestproperty wait ${SEP_vmnaam} shares_finished

#sep_fprintcheck06


