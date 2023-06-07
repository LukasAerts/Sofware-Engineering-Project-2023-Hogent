# 01_main_calling_script.ps1
# powershell script to set up fresh virtualbox for windows 2019 server (for 2023 SEP project)
# must be called from 00_winserver2019.ps1

# sep_fcheckpre checking if all necessary variables are present TODO : kan misschien compacter
function sep_fcheckpre01 () {
    if (-not (Get-Command sep_fcheckpost00 -errorAction SilentlyContinue)) {
        write-host 'function sep_fcheckpost00 does not exist'
        Write-Error 'something went wrong in sep_fcheckpre01' -ErrorAction Stop
    }
    sep_fcheckpost00
}

function sep_fcontinue([String]$message) {
    sep_fprint "" ${SEP_VERBOSE}
    if (${SEP_PAUSED} -eq "1") {
        sep_fprint $message ${SEP_VERBOSE}
        sep_fprint "" ${SEP_VERBOSE}
        read-host "Press ENTER to continue ..."
        clear-host
    }
}

# Main
# Part xx: Checking prerequirements: Questions in 00_Server2019.ps1 answered
sep_fcheckpre01

# Part 02: Setting the needed variables, calling 02_set_variables.ps1
sep_fprint "Part 02: Setting the needed variables, calling 02_set_variables.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\02_set_variables.ps1"
sep_fcontinue "Part 02 (Setting the needed variables) finished"

# Part 03: Creating and setting up the VM
sep_fprint "Part 03: Creating and setting up the VM, calling 03_create_vm.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\03_create_vm.ps1"
sep_fcontinue "Part 03 (Creating and setting up the VM) finished"

# Part 04: Unattended installation
sep_fprint "Part 04: Unattended installation, calling 04_unattended.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\04_unattended.ps1"
sep_fcontinue "Part 04 (Unattended installation) finished"

# Part 05: Network settings
sep_fprint "Part 05: Network settings, calling 05_network.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\05_network.ps1"
sep_fcontinue "Part 05 (Network settings) finished"

# Part 06: Shares
sep_fprint "Part 06: Shares, calling 06_hd.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\06_hd.ps1"
sep_fcontinue "Part 06 (Shares) finished"

#Part 07: Setting up AD
sep_fprint "Part 7: Setting up AD, calling 07_ad.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\07_ad_feature.ps1"
sep_fcontinue "Part 07 (Setting up AD) finished. Hope you waited for the full reboot :)"

#Part 08: Creating AD Structure
sep_fprint "Part 8: Creating AD Structure, calling 08_ad_objecten.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\08_ad_objecten.ps1"
sep_fcontinue "Part 08 (Creating AD Structure) finished"

#Part 09: Dns
sep_fprint "Part 9: Setting up DNS, calling 09_dns.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\09_dns.ps1"
sep_fcontinue "Part 09 (DNS) finished"

#Part : GPO
sep_fprint "Part 10: Setting up GPO, calling 10_gpo.ps1" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
. "${SEP_PATH}\10_gpo.ps1"

#sep_fcontinue "Part 10 (GPO) finished"

# Part 99: TODO
sep_fprint ""
write-host -ForegroundColor Green "Script ended succesfully. Have a nice day."
write-host ""
write-host "P.S.: Don't forget to configure some extra deliverables using RSAT/LDAP on the DirectorPC"
write-host ""

#the end