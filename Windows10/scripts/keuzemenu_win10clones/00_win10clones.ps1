# 00_win2010clones.ps1

# to make sure no variables from previous scripts corrupt our script:
Remove-Item variable:sep*
Remove-Item function:sep* 

# global variables
[String]$SEP_WHO = ""
[String]$SEP_WHICH = ""
[String]$SEP_WHERE = ""
[String]$SEP_PATH = $(Split-Path $MyInvocation.MyCommand.Path -Parent)

# sep_fprint prints to the screen
function sep_fprint ([String]$message) {
    write-host ${message}
}

# fsep_customread fixes the arbitrary ':' at the end of the standard 'read-host'
function fsep_customread {
    param($Prompt)

    write-host $Prompt -NoNewLine
    [String]$sep_ingevoerd = $host.UI.ReadLine()
    return ${sep_ingevoerd}
}

function sep_fcontinue([String]$message, [String]$cls="1") {
    sep_fprint ""
    sep_fprint $message
    sep_fprint ""
    #read-host "Press ENTER to continue ..."
    $null = fsep_customread -Prompt "Press ENTER to continue"
    if ($cls -eq "1") {
        clear-host
    }
} # function sep_fcontinue

#sep_fcheckpost00 checks if all variables and functions were set
function sep_fcheckpost00 () {
    if (-not (Get-Command sep_fprint -errorAction SilentlyContinue)) {
        write-host 'function sep_fprint does not exist'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not ${SEP_WHO}) {
        sep_fprint '$SEP_WHO not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not ${SEP_WHICH}) {
        sep_fprint '$SEP_WHO not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not${SEP_WHERE}) {
        sep_fprint '$SEP_WHERE not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not${SEP_PATH}) {
        sep_fprint '$SEP_PATH not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
}

#sep_fprintwelkom script hoofding uitprinten op het scherm
function sep_fprintwelkom () {
sep_fprint "*******************************************************************************************"
sep_fprint "* ps script to set up windows 2010 pro virtualbox vm based on an available base snapshot  *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#sep_fprintwho keuzemenu uitvoerder uitprinten op het scherm
function sep_fprintwho () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* Who are you?                                                                            *"
sep_fprint "*******************************************************************************************"
sep_fprint "* 1) Benny FLAB2021 C-schijf                                                              *"
sep_fprint "* 6) Benny FLABTOP C-schijf                                                               *"
sep_fprint "* 7) Benny FLAB2021 D-schijf                                                              *"
sep_fprint "* 8) Benny DOHZ75142 C-schijf                                                             *"
sep_fprint "*******************************************************************************************"
sep_fprint "* 9) Abort script                                                                         *"
sep_fprint "*******************************************************************************************"
sep_fprint "* Give a correct value to indicate what user specific variables we may set for you        *"
sep_fprint "*******************************************************************************************"
}

#sep_fprintwho keuzemenu te maken clone op het scherm
function sep_fprintwhich () {
sep_fprint ""
sep_fprint "*******************************************************************************************"
sep_fprint "* Which PC are you preparing                                                              *"
sep_fprint "*******************************************************************************************"
sep_fprint "* 1) DirectorPC                                                                           *"
sep_fprint "* 2) PCCrew1                                                                              *"
sep_fprint "* 3) PCCrew2                                                                              *"
sep_fprint "* 4) PCCast1                                                                              *"
sep_fprint "* 5) PCCast2                                                                              *"
sep_fprint "* 6) morpheus (backup admin)                                                              *"
sep_fprint "*******************************************************************************************"
sep_fprint "* 9) Abort script                                                                         *"
sep_fprint "*******************************************************************************************"
sep_fprint "* Give a correct value                                                                    *"
sep_fprint "*******************************************************************************************"
}

#sep_fprintgo script letsgo uitprinten op het scherm
function sep_fprintgo () {
sep_fprint "*******************************************************************************************"
sep_fprint "* Let's go: cloning windows 2010 pro virtualbox vm                                        *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

#sep_fprintwhere keuzemenu netwerk van clonepc
function sep_fprintwhere () {
    sep_fprint ""
    sep_fprint "*******************************************************************************************"
    sep_fprint "* On which network do you want to install this clone                                      *"
    sep_fprint "*******************************************************************************************"
    sep_fprint "* 1) Give me a fixed IP in 192.168.0.0/24                                                 *"
    sep_fprint "* 2) Give me a fixed IP in 192.168.1.0/24                                                 *"
    sep_fprint "* 3) Give me a fixed IP in 192.168.20.0/24                                                *"
    sep_fprint "* 4) Give me a fixed IP in 192.168.30.0/24                                                *"
    sep_fprint "* 5) Give me a fixed IP in 192.168.40.0/24                                                *"
    sep_fprint "* 6) Let DHCP give me the needed settings                                                 *"
    sep_fprint "*******************************************************************************************"
    sep_fprint "* 9) Abort script                                                                         *"
    sep_fprint "*******************************************************************************************"
    sep_fprint "* Give a correct value                                                                    *"
    sep_fprint "*******************************************************************************************"
    }

#sep_fcheckinput controleren of ingevoerde waarde geldig is
function sep_fcheckinput ([String[]]$SEP_temp_keuzes) {
    $SEP_temp_ingevoerd = Read-Host "> Your choice: "
    if (${sep_temp_ingevoerd} -in ${SEP_temp_keuzes}) {
        if (${sep_temp_ingevoerd} -eq "9") {
            sep_fprint "Have a nice day..."
            Write-Error 'The end' -ErrorAction Stop
        }
        return ${sep_temp_ingevoerd}
    }
    return "" # indien geen geldig ingevoerde waarde: resetten naar "" zodat ze opnieuw wordt gevraagd
} # function sep_fcheckinput



# MAIN
# Part 01a: Welcome
Clear-Host

sep_fprintwelkom
sep_fprint "Part 01: Some questions ...."
sep_fprint ""

# Part 01b: who are you?
while (${SEP_WHO} -eq "") {
    sep_fprintwho
    ${SEP_WHO} = sep_fcheckinput @(1,6,7,8,9)
}

# Part 01b: which pc to clone to
while (${SEP_WHICH} -eq "") {
    sep_fprintwhich
    ${SEP_WHICH} = sep_fcheckinput @(1,2,3,4,5,6,9)
}

# Part 01c: where, on what network?
while (${SEP_WHERE} -eq "") {
    sep_fprintwhere
    ${SEP_WHERE} = sep_fcheckinput @(1,2,3,4,5,6,9)
}

# Part 01f: lets go!
Clear-Host
sep_fcheckpost00
sep_fprintgo

# Part 02: Setting the needed variables, calling 02_set_variables.ps1
sep_fprint "Part 02: Setting the needed variables, calling 02_set_variables.ps1"
sep_fprint ""
. "${SEP_PATH}\02_set_variables.ps1"
sep_fcontinue "Part 02 (Setting the needed variables) finished"

# Part 05: Making the clone
sep_fprint "Part 05: Making the clone, calling 05_make_clonedvm.ps1"
sep_fprint ""
. "${SEP_PATH}\05_make_clonedvm.ps1"
sep_fcontinue "Part 05 (Making the clone) finished" "1"

# Part X: installing RSAT
sep_fprint "Part 06: Installing additional software, calling 06_msu.ps1"
sep_fprint ""
. "${SEP_PATH}\06_msu.ps1"
sep_fcontinue "Part 06 (installing additional software) finished" "1"

# Part X: join the domain
sep_fprint "Part 07: join the domain, calling 07_joindomain.ps1"
sep_fprint ""
. "${SEP_PATH}\07_joindomain.ps1"
sep_fcontinue "Part 07 (join the domain) finished" "2"

# Part 99: the end
sep_fprint ""
sep_fprint "CLONE ... CLONED"
sep_fprint "the end."
sep_fprint ""

# last line