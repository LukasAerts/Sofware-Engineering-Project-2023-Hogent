# 10_gpo.ps1

#sep_fprinthead09
function sep_fprinthead09 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Setting up GPO's                                                                        *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#Main
sep_fprinthead09


sep_fprint "> copying smith_05_gpo.ps1 from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\smith_05_gpo.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> copying cast.jpg from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "S:\Shared\WALLPAPER\" "${SEP_PATH}\jpg\cast.jpg" --username ${SEP_vmuser} --password ${SEP_vmpassword}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\jpg\cast.jpg" --username ${SEP_vmuser} --password ${SEP_vmpassword}
sep_fprint "> copying crew.jpg from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "S:\Shared\WALLPAPER\" "${SEP_PATH}\jpg\crew.jpg" --username ${SEP_vmuser} --password ${SEP_vmpassword}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\jpg\crew.jpg" --username ${SEP_vmuser} --password ${SEP_vmpassword}
sep_fprint "> copying directors.jepg from host > guest" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "S:\Shared\WALLPAPER\" "${SEP_PATH}\jpg\directors.jpeg" --username ${SEP_vmuser} --password ${SEP_vmpassword}
vboxmanage guestcontrol ${SEP_VMNAAM} copyto --target-directory "C:\Users\Administrator\Downloads\" "${SEP_PATH}\jpg\directors.jpeg" --username ${SEP_vmuser} --password ${SEP_vmpassword}

sep_fprint "> executing smith_05_gpo.ps1" ${SEP_VERBOSE}
vboxmanage guestcontrol ${SEP_vmnaam} start --exe "C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe " --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\Users\Administrator\Downloads\smith_05_gpo.ps1"

VBoxManage guestproperty wait ${SEP_vmnaam} gpo_finished


# new line has a purpose!