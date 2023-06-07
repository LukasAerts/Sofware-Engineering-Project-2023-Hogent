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
sep_fprint "*******************************************************************************************"
sep_fprint "* Powering off and removing existing vm with same name if necessary                       *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#sep_fprintcreating03 
function sep_fprintcreating03 () {
sep_fprint "*******************************************************************************************"
sep_fprint "* Creating the new vm (and registring it in VirtualBox)                                   *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#sep_fprintdeleting03
function sep_fprintdisks03 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* Creating the .vdi and registring it                                                     *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#sep_fprintsata03
function sep_fprintsata03 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* Creating SATA Controller and attaching the .vdi and dvd to it                           *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#sep_fprintmisc03
function sep_fprintmisc03 () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* Various vm settings based on set variables in 02_set_variables.ps1                      *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}


# Main
# Part 01: Check prerequirements
sep_fcheckpre03

# Part 02: Remove vm with same name
sep_fprintdeleting03
if ((vboxmanage list vms | select-string -Pattern "^""${SEP_VMNAAM}""").count -gt 0) {
    #if ((vboxmanage list runningvms | select-string -Pattern "^""${SEP_VMNAAM}""").count -gt 0) {
    while ((vboxmanage list runningvms | select-string -Pattern "^""${SEP_VMNAAM}""").count -gt 0) {
        sep_fprint "> Powering off ${SEP_VMNAAM}"
        VBoxManage controlvm ${SEP_VMNAAM} poweroff
        sep_fprint ">>> Sleeping for 10 seconds to give the vm the time to poweroff"
        start-sleep -s 10
    }
    while ((vboxmanage list vms | select-string -Pattern "^""${SEP_VMNAAM}""").count -gt 0) {
        sep_fprint "> Deleting ${SEP_VMNAAM}"
        VBoxManage unregistervm ${SEP_VMNAAM} --delete        
    sep_fprint ">>> Sleeping for 10 seconds to give the delete command the chance to follow the script speed :)"
    start-sleep -s 10
    }
}

# Part xx: creating and registring
sep_fprintcreating03
VBoxManage.exe createvm --name ${SEP_VMNAAM} --basefolder=${SEP_VBVMSPATH} --ostype ${SEP_VMOSTYPE} --register        

# Part xx: Creating the .vdi's and registring them
sep_fprintdisks03
VBoxManage createmedium --filename ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}A_${SEP_TIMESTAMP}.vdi --size $SEP_vmdrivesizeA

# Part xx: Create SATA Controller, attacht disk and empty dvddrive
sep_fprintsata03
vboxmanage storagectl ${SEP_VMNAAM} --name 'SATA Controller' --add sata --controller IntelAhci
sep_fprint "> SATA Controller created"
VBoxManage storageattach ${SEP_VMNAAM} --storagectl 'SATA Controller' --port 0 --device 0 --type hdd --medium ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}A_${SEP_TIMESTAMP}.vdi
sep_fprint "> ${SEP_VMINSTALLDIR}\${SEP_VMNAAM}A_${SEP_TIMESTAMP}.vdi attached"
VBoxManage storageattach ${SEP_VMNAAM} --storagectl "SATA Controller" --port 1 --device 0 --type dvddrive --medium emptydrive
sep_fprint "> Empty dvddrive created"

# Part xx Some misc. settings
sep_fprintmisc03
VBoxManage modifyvm ${SEP_VMNAAM} --ioapic on
sep_fprint "> I/O-APIC enabled"
VBoxManage modifyvm  ${SEP_VMNAAM} --boot1 dvd --boot2 disk --boot3 none --boot4 none
sep_fprint "> boot order set (dvd, disk, none, none)"
VBoxManage modifyvm ${SEP_VMNAAM} --memory ${SEP_VMRAM}
sep_fprint "> ${SEP_VMRAM} MB RAM"
VBoxManage modifyvm ${SEP_VMNAAM} --vram ${SEP_VMVRAM}
sep_fprint "> ${SEP_VMVRAM} MB VRAM"
VBoxManage sharedfolder add ${SEP_VMNAAM} --name "HOST" --hostpath "${SEP_PATH}" --automount --auto-mount-point "G:"
sep_fprint "> shared folder G: (\\VBOXSRV\HOST) <=> ${SEP_PATH}"
VBoxManage modifyvm ${SEP_VMNAAM} --clipboard-mode bidirectional
sep_fprint "> bidirectional clipboard set"
VBoxManage modifyvm ${SEP_VMNAAM} --graphicscontroller vboxsvga
sep_fprint "> vboxsvga graphicscontroller"
VBoxManage modifyvm ${SEP_VMNAAM} --cpus ${SEP_VMCPUS}
sep_fprint "> ${SEP_vmcpus} CPU core(s)"
VBoxManage modifyvm ${SEP_VMNAAM} --nic1 ${SEP_VMNICMODE} --bridgeadapter1 ${SEP_VMNICNAME}
sep_fprint "> nic1 (${SEP_VMNICNAME}) in ${SEP_VMNICMODE} mode"
vboxmanage modifyvm "SEP_win10base" --audio-out=on
sep_fprint "> audio output enabled"

sep_fcheckpost03

#the end
