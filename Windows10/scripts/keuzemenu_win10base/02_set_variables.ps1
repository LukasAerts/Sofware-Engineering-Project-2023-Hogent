## 02_set_variables.ps1
# TO SET VARIABLES: check Part 03 en Part 04

# user specific global variables (also used in called scripts) which will be set:
[String]$SEP_VBPATH = ""
[String]$SEP_VBVMSPATH = "" 
[String]$SEP_VMISO = ""

# global variables (also used in called scripts) which will be set:
[String]$SEP_VMNAAM = ""
[String]$SEP_VMINSTALLDIR = ""
[String]$SEP_VMUSER = ""
[String]$SEP_VMFULLUSER = "" # TODO: here allready?
[String]$SEP_VMPASSWORD = ""
[int32]$SEP_VMDRIVESIZEA = 0
[int32]$SEP_VMRAM = 0
[int32]$SEP_VMVRAM = 0
[int32]$SEP_VMCPUS = 0
[String]$SEP_VMOSTYPE = ""
[String]$SEP_WINHOSTNAME = "" # TODO: here allready?
[String]$SEP_VMNICMODE=""
[String]$SEP_VMNICNAME=""
[String]$SEP_VMHOSTNAMEFQDN = ""
[String]$SEP_VMCOUNTRY=""
[String]$SEP_VMLOCALE=""

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
    if (-not (test-path ${SEP_VMISO})) {
        sep_fprint "${SEP_VMISO} does not exist"
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
    if (-not ${SEP_VMISO}) {
        sep_fprint '$SEP_VMISO not set'
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
    if (-not ${SEP_VMINSTALLDIR}) {
        sep_fprint '$SEP_VMINSTALLDIR not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMUSER}) {
        sep_fprint '$SEP_VMUSER not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMFULLUSER}) {
        sep_fprint '$SEP_VMFULLUSER not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMPASSWORD}) {
        sep_fprint '$SEP_VMPASSWORD not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (${SEP_VMDRIVESIZEA} -eq 0) {
        sep_fprint '$SEP_VMDRIVESIZEA not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (${SEP_VMRAM} -eq 0) {
        sep_fprint '$SEP_VMRAM not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (${SEP_VMVRAM} -eq 0) {
        sep_fprint '$SEP_VMVRAM not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (${SEP_CPUS} -eq 0) {
        sep_fprint '$SEP_CPUS not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMOSTYPE}) {
        sep_fprint '$SEP_VMOSTYPE not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_WINHOSTNAME}) {
        sep_fprint '$SEP_WINHOSTNAME not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMNICMODE}) {
        sep_fprint '$SEP_VMNICMODE not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMNICNAME}) {
        sep_fprint '$SEP_VMNICNAME not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMHOSTNAMEFQDN}) {
        sep_fprint '$SEP_VMHOSTNAMEFQDN not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMCOUNTRY}) {
        sep_fprint '$SEP_VMCOUNTRY not set'
        Write-Error 'something went wrong in sep_fcheckpost02' -ErrorAction Stop
    }
    if (-not ${SEP_VMLOCALE}) {
        sep_fprint '$SEP_VMLOCALE not set'
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
sep_fprint "> SEP_VBPATH = ${SEP_vbpath}"
sep_fprint "> SEP_VBVMSPATH = ${SEP_vbvmspath}"
sep_fprint "> SEP_VMISO = ${SEP_vmiso}"
sep_fprint "> SEP_VMNAAM = ${SEP_vmnaam}"
sep_fprint "> SEP_vminstalldir = ${SEP_vminstalldir}"
sep_fprint "> SEP_vmuser = ${SEP_vmuser}"
sep_fprint "> SEP_vmfulluser = ${SEP_vmfulluser}"
sep_fprint "> SEP_vmpassword = ${SEP_vmpassword}"
sep_fprint "> SEP_vmdrivesizeA = ${SEP_vmdrivesizeA}"
sep_fprint "> SEP_vmram = ${SEP_vmram}"
sep_fprint "> SEP_vmvram = ${SEP_vmvram}"
sep_fprint "> SEP_vmcpus = ${SEP_vmcpus}"
sep_fprint "> SEP_vmostype = ${SEP_vmostype}"
sep_fprint "> SEP_winhostname = ${SEP_winhostname}"
sep_fprint "> SEP_vmnicmode = ${SEP_vmnicmode}"
sep_fprint "> SEP_VMNICNAME = ${SEP_VMNICNAME}"
sep_fprint "> SEP_VMHOSTNAMEFQDN = ${SEP_VMHOSTNAMEFQDN}"
sep_fprint "> SEP_VMCOUNTRY = ${SEP_VMCOUNTRY}"
sep_fprint "> SEP_VMLOCALE = ${SEP_VMLOCALE}"
# sep_fprint "> SEP_VMADDITIONS = ${SEP_VMADDITIONS}"
}

# MAIN
# Part 01: Check prerequirements
sep_fcheckpre02

# Part 02: Print hoofding
sep_fprintwelkom02

# Part 03: determine user specific variables
switch($SEP_WHO){
    "1" { # Benny FLAB2021
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "C:\DATA\VMS"
        $SEP_vmiso = "C:\DATA\SOFTWARE\SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO"
        $SEP_VMNICNAME='ASIX AX88179 USB 3.0 to Gigabit Ethernet Adapter'
        break
    }
    "6" { # Benny FLABTOP
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "C:\DATA\VMS"
        $SEP_vmiso = "C:\DATA\SOFTWARE\SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO"
        $SEP_VMNICNAME='Realtek PCIe GbE Family Controller'
        break
    }
    "7" { # Benny FLAB2021 andere harddisk
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "E:\DATA\VMS"
        $SEP_vmiso = "C:\DATA\SOFTWARE\SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO"
        $SEP_VMNICNAME='ASIX AX88179 USB 3.0 to Gigabit Ethernet Adapter'
        break
    }
    "8" { # Benny FLABWERK
        $SEP_vbpath = "C:\Program Files\Oracle\VirtualBox"
        $SEP_vbvmspath = "C:\DATA\VMS"
        $SEP_vmiso = "C:\DATA\SOFTWARE\SW_DVD9_Win_Pro_10_20H2.10_64BIT_English_Pro_Ent_EDU_N_MLF_X22-76585.ISO"
        $SEP_VMNICNAME='Intel(R) Ethernet Connection I217-V'
        break
    }
    default {
        Write-Error 'TODO: andere user specific values achterhalen' -ErrorAction Stop
    }
}

# Part 04: Test validity of user specific variables (overkill?)
sep_fcheckspecific

# Part 05: Set variables for windows server 2019
$SEP_winhostname = "win10base"
$SEP_vmnaam = "SEP_${SEP_winhostname}"
$SEP_vminstalldir = "${SEP_vbvmspath}\${SEP_vmnaam}"
$SEP_vmuser = "Administrator" #beter dan Student om remote te kunnen uitvoeren als admin later!
$SEP_vmfulluser = "user Administrator password 22Admin23"
$SEP_vmpassword = "22Admin23"
$SEP_vmdrivesizeA = 20480
$SEP_vmram = 4096
$SEP_vmvram = 128
$SEP_vmcpus = 2
$SEP_vmostype = "Windows10_64"
$SEP_vmnicmode = "bridged"
$SEP_VMHOSTNAMEFQDN = "${SEP_winhostname}.thematrix.local"
$SEP_VMCOUNTRY = "BE"
$SEP_VMLOCALE = "nl_BE"


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