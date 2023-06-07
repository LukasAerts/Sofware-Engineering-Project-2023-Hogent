# 00_win10base.ps1
# powershell script to set up fresh virtualbox for windows 2010 pro (for 2023 SEP project)

# to make sure no variables from previous scripts corrupt our script:
Remove-Item variable:sep*
Remove-Item function:sep* 

# global variables which will be set:
[String]$SEP_WHO = ""
[String]$SEP_PATH = $(Split-Path $MyInvocation.MyCommand.Path -Parent)
[String]$SEP_TIMESTAMP = "{0:yyyyMMddHHmmss}" -f (Get-Date)
[String]${SEP_WHAT} = 5 #windows 10 Pro (7 #windows 10 Pro education)

# sep_fprint prints to the screen
function sep_fprint ([String]$message) {
    write-host ${message}
}

#sep_fprintwelkom script hoofding uitprinten op het scherm
function sep_fprintwelkom () {
sep_fprint "*******************************************************************************************"
sep_fprint "* ps script to set up a new windows 2010 pro virtualbox vm base (for 2023 T01 SEP project)*"
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
sep_fprint "* 8) Benny FLABWERK C-schijf                                                              *"
sep_fprint "*******************************************************************************************"
sep_fprint "* 9) Abort script                                                                         *"
sep_fprint "*******************************************************************************************"
sep_fprint "* Give a correct value to indicate what user specific variables we may set for you        *"
sep_fprint "*******************************************************************************************"
}

#sep_fprintgo script letsgo uitprinten op het scherm
function sep_fprintgo () {
sep_fprint "*******************************************************************************************"
sep_fprint "* Let's go: setting up a new windows 2010 pro virtualbox vm (for 2023 T01 SEP project)    *"
sep_fprint "*******************************************************************************************"
sep_fprint ""
}

# sep_fcheckinput controleren of ingevoerde waarde geldig is
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

function sep_fcustomread {
    param($Prompt)

    write-host $Prompt -NoNewLine
    [String]$sep_ingevoerd = $host.UI.ReadLine()
    return ${sep_ingevoerd}
}

function sep_fcontinue([String]$message, [String]$cls="1") {
    sep_fprint ""
    sep_fprint $message
    sep_fprint ""
    $null = sep_fcustomread -Prompt "Press ENTER to continue"
    if ($cls -eq "1") {
        clear-host
    }
} # function sep_fcontinue


# sep_fcheckpost00 checks if all variables and functions were set
function sep_fcheckpost00 () {
    if (-not (Get-Command sep_fprint -errorAction SilentlyContinue)) {
        write-host 'function sep_fprint does not exist'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not ${SEP_WHO}) {
        sep_fprint '$SEP_WHO not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not${SEP_PATH}) {
        sep_fprint '$SEP_PATH not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not${SEP_TIMESTAMP}) {
        sep_fprint '$SEP_TIMESTAMP not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not${SEP_WHAT}) {
        sep_fprint '$SEP_WHAT not set'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not (Get-Command sep_fcustomread -errorAction SilentlyContinue)) {
        write-host 'function sep_fcustomread does not exist'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not (Get-Command sep_fcontinue -errorAction SilentlyContinue)) {
        write-host 'function sep_fcontinue does not exist'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
}

# Main
# Part 01a: Welcome
Clear-Host

sep_fprintwelkom
sep_fprint "Part 01: A question ...."
sep_fprint ""

# Part 01b: who are you?
while (${SEP_WHO} -eq "") {
    sep_fprintwho
    ${SEP_WHO} = sep_fcheckinput @(1,6,7,8,9) # TODO: aanpassen naar @(1,2,3,4,5,6,9)
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

# Part 03: Creating and setting up the VM
sep_fprint "Part 03: Creating and setting up the VM, calling 03_create_vm.ps1"
sep_fprint ""
. "${SEP_PATH}\03_create_vm.ps1"
sep_fcontinue "Part 03 (Creating and setting up the VM) finished"

# Part 04: Unattended installation
sep_fprint "Part 04: Unattended installation, calling 04_unattended.ps1"
sep_fprint ""
. "${SEP_PATH}\04_unattended.ps1"
sep_fcontinue "Part 04 (Unattended installation) finished"

# Part 05: Making the clone
sep_fprint "Part 05: Making clone, calling 05_make_clone_and_snapshot.ps1"
sep_fprint ""
. "${SEP_PATH}\05_make_clone_and_snapshot.ps1"
sep_fcontinue "Part 04 (Making clone) finished"

# Part 99: TODO
sep_fprint "Part 99: The end"
sep_fprint ""
sep_fprint "clone made, script ended succesfully"
sep_fprint ""

#the end
