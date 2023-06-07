## 02_set_variables.ps1
# TO SET VARIABLES: check Part 03 en Part 04

# variables:
[String]$SEP_VBPATH = ""
[String]$SEP_VBVMSPATH = ""
[String]$SEP_msupath=""
[String]$SEP_chatpath="" 
[String]$SEP_VMNAAM = ""
[String]$SEP_VMUSER = ""
[String]$SEP_VMPASSWORD = ""
[String]$SEP_NEWWINNAME = "" #determined by answering $sep_which

# sep_fcheckpre checking if all necessary variables are present
function sep_fcheckpre02 () {
    if (-not (Get-Command sep_fcheckpost00 -errorAction SilentlyContinue)) {
        write-host 'function sep_fcheckpost00 does not exist'
        Write-Error 'something went wrong in sep_fcheckpre02' -ErrorAction Stop
    }
    sep_fcheckpost00
}

# sep_fcheckspecific checking if the user specific variables are set correctly
function sep_fcheckspecific () {
    if (-not (test-path ${SEP_VBPATH})) {
        sep_fprint "${SEP_VBPATH} does not exist"
        Write-Error 'credential not valid, check 02_set_variables.ps1' -ErrorAction Stop
    }
    if (-not (test-path ${SEP_VBVMSPATH})) {
        sep_fprint "${SEP_VBVMSPATH} does not exist"
        Write-Error 'credential not valid, check 02_set_variables.ps1' -ErrorAction Stop
    }
    if (-not (test-path ${SEP_msupath})) {
        sep_fprint "${SEP_msupath} does not exist"
        Write-Error 'credential not valid, check 02_set_variables.ps1' -ErrorAction Stop
    }
    if (-not (test-path ${SEP_chatpath})) {
        sep_fprint "${SEP_chatpath} does not exist"
        Write-Error 'credential not valid, check 02_set_variables.ps1' -ErrorAction Stop
    }
}

#sep_fcheckpost02 checks if all variables and functions were set
function sep_fcheckpost02 () {
    if (-not (Get-Command sep_fcheckpre02 -errorAction SilentlyContinue)) {
        write-host 'function sep_fcheckpre02 does not exist'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    sep_fcheckpre02
    if (-not ${SEP_VBPATH}) {
        sep_fprint '$SEP_VBPATH not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VBVMSPATH}) {
        sep_fprint '$SEP_VBVMSPATH not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_msupath}) {
        sep_fprint '$SEP_msupath not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_chatpath}) {
        sep_fprint '$SEP_chatpath not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not (Get-Command sep_fcheckspecific -errorAction SilentlyContinue)) {
        write-host 'function sep_fcheckspecific does not exist'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    sep_fcheckspecific
    if (-not ${SEP_VMNAAM}) {
        sep_fprint '$SEP_VMNAAM not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMUSER}) {
        sep_fprint '$SEP_VMUSER not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMPASSWORD}) {
        sep_fprint '$SEP_VMPASSWORD not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if ( $null -eq (get-command VBoxManage.exe -errorAction silentlyContinue)) {
        sep_fprint "VBoxManage.exe not found on this computer"
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
}

#sep_fprintwelkom02 script hoofding uitprinten op het scherm
function sep_fprintwelkom02 () {
sep_fprint "*******************************************************************************************"
sep_fprint "* Setting the needed variables & environment                                              *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#sep_fprintvariables02 de variables uitprinten (TODO)
function sep_fprintvariables02 () {
# sep_fprint "> SEP_VBVMSPATH = ${SEP_vbvmspath}" # to make vboxmanage path work
sep_fprint "> SEP_VMNAAM = ${SEP_vmnaam}" #the vm to clone
sep_fprint "> SEP_VBPATH = ${SEP_vbpath}" #the basedir to save vms in
sep_fprint "> SEP_msupath = ${SEP_msupath}"
sep_fprint "> SEP_chatpath = ${SEP_chatpath}"
sep_fprint "> SEP_NEWWINNAME = ${SEP_NEWWINNAME}"
sep_fprint "> SEP_NEWNAME = ${SEP_NEWNAME}"
sep_fprint "> SEP_PSURL = ${SEP_PSURL}"
sep_fprint "> SEP_vmuser = ${SEP_vmuser}"
sep_fprint "> SEP_vmpassword = ${SEP_vmpassword}"

}

# MAIN
# Part 01: Check prerequirements
sep_fcheckpre02

# Part 02: Print hoofding
sep_fprintwelkom02

# Part 03: determine user specific variables
switch($SEP_WHO){
    "1" { # Benny
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "C:\DATA\VMS"
        $SEP_VMNICNAME='ASIX AX88179 USB 3.0 to Gigabit Ethernet Adapter'
        $SEP_msupath="C:\DATA\SOFTWARE\WindowsTH-KB2693643-x64.msu"
        $SEP_chatpath="C:\DATA\SOFTWARE\neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe"
        break
    }
    "6" { # Benny Flabtop
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "C:\DATA\VMS"
        $SEP_VMNICNAME='Realtek PCIe GbE Family Controller'
        $SEP_msupath="C:\DATA\SOFTWARE\WindowsTH-KB2693643-x64.msu"
        $SEP_chatpath="C:\DATA\SOFTWARE\neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe"
        break
    }
    "7" { # Benny andere harddisk
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "E:\DATA\VMS"
        $SEP_VMNICNAME='ASIX AX88179 USB 3.0 to Gigabit Ethernet Adapter'
        $SEP_msupath="C:\DATA\SOFTWARE\WindowsTH-KB2693643-x64.msu"
        $SEP_chatpath="C:\DATA\SOFTWARE\neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe"
        break
    }
    "8" { # Benny werk
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "C:\DATA\VMS"
        $SEP_VMNICNAME='Intel(R) Ethernet Connection I217-V'
        $SEP_msupath="C:\DATA\SOFTWARE\WindowsTH-KB2693643-x64.msu"
        $SEP_chatpath="C:\DATA\SOFTWARE\neochat-23.04.0-512-windows-cl-msvc2019-x86_64.exe"
        break
    }
    default {
        Write-Error 'TODO: andere user specific values achterhalen' -ErrorAction Stop
    }
}

# Part 04: Test validity of user specific variables (overkill?)
sep_fcheckspecific
switch($SEP_WHICH){
    "1" { # DirectorPC
        ${SEP_NEWWINNAME}="DirectorPC"
        break
    }
    "2" { # PCCrew1
        ${SEP_NEWWINNAME}="PCCrew1"
        break
    }
    "3" { # PCCrew2
        ${SEP_NEWWINNAME}="PCCrew2"
        break
    }
    "4" { # PCCast1
        ${SEP_NEWWINNAME}="PCCast1"
        break
    }
    "5" { # PCCast2
        ${SEP_NEWWINNAME}="PCCast2"
        break
    }
    "6" { # morpheus
        ${SEP_NEWWINNAME}="morpheus"
        break
    }
    default {
        Write-Error 'TODO: andere user specific values achterhalen' -ErrorAction Stop
    }
}

# Part 05: Set variables for clone
$SEP_vmnaam = "SEP_win10base" #the vm to clone
${SEP_NEWNAME} = "SEP_${SEP_NEWWINNAME}"
$SEP_PSURL = "c:\windows\system32\windowspowershell\v1.0\powershell.exe"
$SEP_vmuser = "Administrator"
$SEP_vmpassword = "22Admin23"

# Part 06: Print set variables
sep_fprintvariables02

# Part 07: Add Virtual Box bin-path to PATH environment variable if necessary:
if ( $null -eq (get-command VBoxManage.exe -errorAction silentlyContinue)) {
    sep_fprint "> Adding $SEP_VBPATH to Env:Path"
    $env:path="${SEP_VBPATH};$env:path"
}
else {
    sep_fprint "> VirtualBox allready found in Env:Path, no action taken"
}

# Part 08: Checks if all variables are set
sep_fcheckpost02