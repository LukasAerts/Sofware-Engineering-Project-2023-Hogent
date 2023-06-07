# 09_dns.ps1

#sep_fprinthead09
function sep_fprinthead09 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up DNS                                                                          *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprinthead09
function sep_fprintcheck09 () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Verifying DNS (TODO)                                                                    *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#Main
sep_fprinthead09
sep_fprint "> copying smith_04_dns.ps1 from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\smith_04_dns.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> copying dnsstatic.csv from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\csv\dnsstatic.csv" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> copying dnscname.csv from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\csv\dnscname.csv" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> executing smith_04_dns.ps1" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_vmnaam} start --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\Users\Administrator\Downloads\smith_04_dns.ps1"

VBoxManage guestproperty wait ${SEP_vmnaam} dns_finished

# sep_fprintcheck09

# new line has a purpose!