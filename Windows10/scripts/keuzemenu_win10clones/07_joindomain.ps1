# 06_msu.ps1

function sep_fprintwelkom07 () {
sep_fprint "*******************************************************************************************"
sep_fprint "* Trying to join the domain                                                               *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

# MAIN
sep_fprintwelkom07

write-host "copying clone_02_joindomain.ps1"
vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\TMP\" "${SEP_PATH}\clone_02_joindomain.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}
write-host "sleeping for 5 seconds"
start-sleep -s 5

write-host "running clone_02_joindomain.ps1"
vboxmanage guestcontrol ${SEP_NEWNAME} start --exe ${SEP_PSURL} --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\TMP\clone_02_joindomain.ps1"
write-host "sleeping for 20 seconds"
start-sleep -s 20

write-host "checking (visually) if the vm is rebooting"
write-host "sleeping for 60 seconds"
start-sleep -s 60

#the end
