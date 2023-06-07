# 05_make_clone_and_snapshot.ps1

#nieuw
[String]$SEP_PSURL = "c:\windows\system32\windowspowershell\v1.0\powershell.exe"

function sep_fprintwait05 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* VM is shutting down                                                                     *"
sep_fprint "* added a sleep of 30 seconds, check visually if machine is shutting down!                *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

function sep_fprintsnap05 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* taking a snapshot                                                                       *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

function sep_fprintcontrolesnap05 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* visual check if snapshot is taken                                                       *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}


#MAIN
#shut down SEP_director_base
vboxmanage guestcontrol ${SEP_vmnaam} start --exe ${SEP_PSURL} --username ${SEP_VMUSER} --password ${SEP_VMPASSWORD} -- -command "Stop-Computer -Force"
sep_fprintwait05
start-sleep -s 20
sep_fcontinue "Verify if the machine is actually powered off before continuing" "2" # 2=> no cls


#TODO when time: fancy heading
write-host ""
write-host "> clearing unattended floppy"
write-host "> setting cpus for future clones to 1"
VBoxManage modifyvm ${SEP_VMNAAM} --cpus 1
write-host "> setting ram for future clones to 2048"
VBoxManage modifyvm ${SEP_VMNAAM} --memory 2048
write-host "> clearing unattended floppy"
vboxmanage storageattach ${SEP_VMNAAM} --storagectl "Floppy" --device 0 --medium none
write-host "> clearing unattended dvd"
vboxmanage storageattach ${SEP_VMNAAM} --storagectl "SATA Controller" --port 2 --device 0 --type dvddrive --medium none
write-host "> emptying dvd-drive"
vboxmanage storageattach ${SEP_VMNAAM} --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium emptydrive

#the end
