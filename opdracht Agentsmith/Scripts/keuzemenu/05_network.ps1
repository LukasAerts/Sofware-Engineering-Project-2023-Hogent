# 05_network.ps1


#sep_fprinthead05
function sep_fprinthead05 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up the network                                                                  *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprinthead05
function sep_fprintcheck05 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Verifying network settings                                                              *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#Main
sep_fprinthead05
sep_fprint "> copying smith_00_netwerk.ps1 from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\smith_00_network.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> copying netwerk.csv from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_vmnaam} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\csv\${SEP_WHERE}\netwerk.csv" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> executing smith_00_netwerk.ps1" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_vmnaam} start --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\Users\Administrator\Downloads\smith_00_network.ps1"

VBoxManage guestproperty wait ${SEP_vmnaam} network_finished
write-host ">>> sleeping for 10 seconds"
start-sleep -s 10

sep_fprintcheck05
vboxmanage guestcontrol ${SEP_vmnaam} run --username ${SEP_vmuser} --password ${SEP_vmpassword} --exe "C:\Windows\System32\ipconfig.exe" /arg0 "/all"

# new line has a function!