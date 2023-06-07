## 03_create_vm.ps1

# sep_fcheckpre03 checking if all necessary variables from previous scripts were set
function sep_fcheckpre03 () {
    if (-not (Get-Command sep_fcheckpost02 -errorAction SilentlyContinue)) {
        write-host 'function sep_fcheckpost02 does not exist'
        Write-Error 'something went wrong in sep_fcheckpre03' -ErrorAction Stop
    }
    sep_fcheckpost02
}

function sep_fcheckpost03 () {
    if (-not (Get-Command sep_fcheckpre03 -errorAction SilentlyContinue)) {
        write-host 'function sep_fcheckpre03 does not exist'
        Write-Error 'something went wrong in sep_fcheckpost03' -ErrorAction Stop
    }
    sep_fcheckpre03

    if ((vboxmanage list vms | select-string -Pattern "^""${SEP_VMNAAM}""").count -le 0) {
        sep_fprint "geen vm met naam ${SEP_VMNAAM} gevonden ..."
        Write-Error 'something went wrong in sep_fcheckpost03'-ErrorAction Stop
    }
}

#sep_fprintdeleting03
function sep_fprintdeleting03 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Powering off and removing existing vm with same name if necessary                       *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintcreating03 
function sep_fprintcreating03 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Creating the new vm (and registring it in VirtualBox)                                   *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintdeleting03
function sep_fprintdisks03 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Creating the .vdi's and registring them                                                 *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintsata03
function sep_fprintsata03 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Creating SATA Controller and attaching the .vdi's dvd to it                             *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintsata03
function sep_fprintmisc03 () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Various vm settings based on set variables in 02_set_variables.ps1                      *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}


# Main
# Part 01: Check prerequirements
sep_fcheckpre03

# Part 02: Remove vm with same name
sep_fprintdeleting03
if ((vboxmanage list vms | select-string -Pattern "^""${SEP_VMNAAM}""").count -gt 0) {
    while ((vboxmanage list runningvms | select-string -Pattern "^""${SEP_VMNAAM}""").count -gt 0) {
        if (${SEP_VERBOSE} -eq "1") {
            sep_fprint "Powering off ${SEP_VMNAAM}" ${SEP_VERBOSE}
            VBoxManage controlvm ${SEP_VMNAAM} poweroff
        }
        else {
            VBoxManage controlvm ${SEP_VMNAAM} poweroff *>$null
        }
        sep_fprint "Sleeping for 5 seconds to give the pc the change to follow :)" ${SEP_VERBOSE}
        start-sleep -s 5
    }
    while ((vboxmanage list vms | select-string -Pattern "^""${SEP_VMNAAM}""").count -gt 0) {
        if (${SEP_VERBOSE} -eq "1") {
            sep_fprint "Deleting ${SEP_VMNAAM}" ${SEP_VERBOSE}
            VBoxManage unregistervm ${SEP_VMNAAM} --delete        
        }
        else {
            VBoxManage unregistervm ${SEP_VMNAAM} --delete *>$null
        }
    sep_fprint "Sleeping for 5 seconds to give the pc the change to follow :)" ${SEP_VERBOSE}
    start-sleep -s 5
    }
}

# Part xx: creating and registring
sep_fprintcreating03
sep_fprint "Creating the new vm ${SEP_VMNAAM}" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
if (${SEP_VERBOSE} -eq "1") {
    VBoxManage.exe createvm --name ${SEP_VMNAAM} --basefolder=${SEP_VBVMSPATH} --ostype ${SEP_VMOSTYPE} --register        
}
else {
    VBoxManage.exe createvm --name ${SEP_VMNAAM} --basefolder=${SEP_VBVMSPATH} --ostype ${SEP_VMOSTYPE} --register *>$null
}

# Part xx: Creating the .vdi's and registring them
sep_fprintdisks03
if (${SEP_VERBOSE} -eq "1") {
    VBoxManage createmedium --filename ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}A_${SEP_TIMESTAMP}.vdi --size $SEP_vmdrivesizeA
    VBoxManage createmedium --filename ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}B_${SEP_TIMESTAMP}.vdi --size $SEP_vmdrivesizeB        
}
else {
    VBoxManage createmedium --filename ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}A_${SEP_TIMESTAMP}.vdi --size $SEP_vmdrivesizeA *>$null
    VBoxManage createmedium --filename ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}B_${SEP_TIMESTAMP}.vdi --size $SEP_vmdrivesizeB *>$null
}

# Part xx: Create SATA Controller, attacht disks and dvddrive
sep_fprintsata03
vboxmanage storagectl ${SEP_VMNAAM} --name 'SATA Controller' --add sata --controller IntelAhci
sep_fprint "> SATA Controller created" ${SEP_VERBOSE}
VBoxManage storageattach ${SEP_VMNAAM} --storagectl 'SATA Controller' --port 0 --device 0 --type hdd --medium ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}A_${SEP_TIMESTAMP}.vdi
sep_fprint "> ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}A_${SEP_TIMESTAMP}.vdi attached" ${SEP_VERBOSE}
VBoxManage storageattach ${SEP_VMNAAM} --storagectl 'SATA Controller' --port 1 --device 0 --type hdd --medium ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}B_${SEP_TIMESTAMP}.vdi
sep_fprint "> ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}B_${SEP_TIMESTAMP}.vdi attached" ${SEP_VERBOSE}
VBoxManage storageattach ${SEP_VMNAAM} --storagectl "SATA Controller" --port 2 --device 0 --type dvddrive --medium emptydrive
sep_fprint "> Empty dvddrive created" ${SEP_VERBOSE}

# Part xx Some misc. settings
sep_fprintmisc03
VBoxManage modifyvm ${SEP_VMNAAM} --ioapic on
sep_fprint "> I/O-APIC enabled" ${SEP_VERBOSE}
VBoxManage modifyvm  ${SEP_VMNAAM} --boot1 dvd --boot2 disk --boot3 none --boot4 none
sep_fprint "> boot order set" ${SEP_VERBOSE}
VBoxManage modifyvm ${SEP_VMNAAM} --memory ${SEP_VMRAM}
sep_fprint "> ${SEP_VMRAM} MB RAM" ${SEP_VERBOSE}
VBoxManage modifyvm ${SEP_VMNAAM} --vram ${SEP_VMVRAM}
sep_fprint "> ${SEP_VMVRAM} MB VRAM" ${SEP_VERBOSE}
VBoxManage sharedfolder add ${SEP_VMNAAM} --name host --hostpath "${SEP_PATH}" --automount
sep_fprint "> Shared folder: guest: \\VBOXSRV\host host:${SEP_PATH} " ${SEP_VERBOSE}
VBoxManage modifyvm ${SEP_VMNAAM} --clipboard-mode bidirectional
sep_fprint "> bidirectional clipboard set" ${SEP_VERBOSE}
VBoxManage modifyvm ${SEP_VMNAAM} --graphicscontroller vboxsvga
sep_fprint "> vboxsvga graphicscontroller" ${SEP_VERBOSE}
VBoxManage modifyvm ${SEP_VMNAAM} --cpus ${SEP_VMCPUS}
sep_fprint "> ${SEP_vmcpus} CPU core(s)" ${SEP_VERBOSE}
VBoxManage modifyvm ${SEP_VMNAAM} --nic1 ${SEP_VMNICMODE} --bridgeadapter1 ${SEP_VMNICNAME}
sep_fprint "> Nic1 (${SEP_VMNICNAME}) in ${SEP_VMNICMODE} mode" ${SEP_VERBOSE}


sep_fcheckpost03
