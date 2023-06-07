# 06_msu.ps1

function sep_fprintwelkom06 () {
    sep_fprint "*******************************************************************************************"
    sep_fprint "* Installing additional software on guest                                                 *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

function sep_fprintcastcrew06 () {
    sep_fprint "*******************************************************************************************"
    sep_fprint "* Installing NeoChat                                                                      *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

function sep_fprintdirector06 () {
    sep_fprint "*******************************************************************************************"
    sep_fprint "* DirectorPC/morpheus: Installing NeoChat & RSAT                                          *"
    sep_fprint "*******************************************************************************************"
    sep_fprint ""
}

# MAIN
if ((${SEP_NEWWINNAME} -eq "DirectorPC") -or (${SEP_NEWWINNAME} -eq "morpheus")) {
    sep_fprintdirector06
}
else {
    sep_fprintcastcrew06
}

write-host "> copying clone_01_msu.ps1 to guest"
vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\TMP\" "${SEP_PATH}\clone_01_msu.ps1" --username ${SEP_vmuser} --password ${SEP_vmpassword}
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5

write-host "> copying neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe"
vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\TMP\" $SEP_chatpath --username ${SEP_vmuser} --password ${SEP_vmpassword}
write-host ">>> sleeping for 20 seconds"
start-sleep -s 20


if ((${SEP_NEWWINNAME} -eq "DirectorPC") -or (${SEP_NEWWINNAME} -eq "morpheus")) {
    write-host "> copying WindowsTH-KB2693643-x64.msu to guest"
    vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\TMP\" $SEP_msupath --username ${SEP_vmuser} --password ${SEP_vmpassword}
    write-host "> copying gpo.txt to guest"
    vboxmanage guestcontrol ${SEP_NEWNAME} copyto --target-directory "C:\TMP\" ${SEP_PATH}\gpo.txt --username ${SEP_vmuser} --password ${SEP_vmpassword}
    write-host ">>> sleeping for 20 seconds"
    start-sleep -s 20

}

write-host "> running clone_01_msu.ps1 on guest"
vboxmanage guestcontrol ${SEP_NEWNAME} start --exe ${SEP_PSURL} --username ${SEP_vmuser} --password ${SEP_vmpassword} /arg0 "C:\TMP\clone_01_msu.ps1"
write-host "> waiting for the guest to send the finished-flag, this can take a while!"
VBoxManage guestproperty wait ${SEP_NEWNAME} clone_msu_finished
write-host ">>> sleeping for 5 seconds"
start-sleep -s 5

#last line
