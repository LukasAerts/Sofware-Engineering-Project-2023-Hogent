# 00_winserver2019.ps1
# powershell script to set up fresh virtualbox for windows 2019 server (for 2023 SEP project)

# to make sure no variables from previous scripts corrupt our script:
Remove-Item variable:sep*
Remove-Item function:sep* 

# global variables (also used in called scripts) which will be set:
[String]$SEP_VERBOSE= 1
[String]$SEP_WHO = ""
[String]$SEP_WHAT = ""
[String]$SEP_WHERE = ""
[String]$SEP_PAUSED = ""
[String]$SEP_PATH = $(Split-Path $MyInvocation.MyCommand.Path -Parent)
[String]$SEP_TIMESTAMP = "{0:yyyyMMddHHmmss}" -f (Get-Date)

# sep_ftimestamp creates a timestamp for later use perhaps TODO
function sep_ftimestamp {
    return "[{0:yyyy/MM/dd} {0:HH:mm:ss}]" -f (Get-Date)  
}

#sep_fprint for now prints to the screen (TODO: zou ook voor install.log of zo kunnen worden gebruikt)
function sep_fprint ([String]$message, [String]$verbose="1") {
    if ($verbose -eq "1") {
        write-host ${message}
    }
}

#sep_fcheckpost00 checks if all variables and functions were set
function sep_fcheckpost00 () {
    if (-not (Get-Command sep_fprint -errorAction SilentlyContinue)) {
        write-host 'function sep_fprint does not exist'
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not ${SEP_VERBOSE}) {
        sep_fprint '$SEP_VERBOSE not set' "1"
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not ${SEP_WHO}) {
        sep_fprint '$SEP_WHO not set' ${SEP_VERBOSE}
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not ${SEP_WHAT}) {
        sep_fprint '$SEP_WHAT not set' ${SEP_VERBOSE}
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not ${SEP_WHERE}) {
        sep_fprint '$SEP_WHERE not set' ${SEP_VERBOSE}
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }    
    if (-not${SEP_PAUSED}) {
        sep_fprint '$SEP_PAUSED not set' ${SEP_VERBOSE}
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not${SEP_PATH}) {
        sep_fprint '$SEP_PATH not set' ${SEP_VERBOSE}
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
    if (-not${SEP_TIMESTAMP}) {
        sep_fprint '$SEP_TIMESTAMP not set' ${SEP_VERBOSE}
        Write-Error 'something went wrong in sep_fcheckpost00' -ErrorAction Stop
    }
}

#sep_fprintwelkom script hoofding uitprinten op het scherm
function sep_fprintwelkom () {
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* ps script to set up a new windows 2019 server virtualbox vm (for 2023 T01 SEP project)  *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}
}

#sep_fprintwho keuzemenu uitvoerder uitprinten op het scherm
function sep_fprintwho () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Who are you?                                                                            *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 1) Benny FLAB2021 C-Schijf                                                              *" ${SEP_VERBOSE}
#sep_fprint "* 2) Lukas                                                                                *" ${SEP_VERBOSE}
sep_fprint "* 7) Benny FLAB2021 E-schijf                                                              *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 9) Abort script                                                                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Give a value [1-6] to indicate what user specific variables we may set for you          *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
}

#sep_fprintwhat keuzemenu uitvoerder uitprinten op het scherm
function sep_fprintwhat () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* What do you want?                                                                       *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 1) CLI                                                                                  *" ${SEP_VERBOSE}
sep_fprint "* 2) GUI                                                                                  *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 9) Abort script                                                                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Give a value [1-2] to indicate what version of Windows Server 2019 you want to install. *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
}

#sep_fprintwhere keuzemenu LAN uitprinten op het scherm
function sep_fprintwhere () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Where do you want to install this server?                                               *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 1) 192.168.0.0/24                                                                       *" ${SEP_VERBOSE}
sep_fprint "* 2) 192.168.1.0/24                                                                       *" ${SEP_VERBOSE}
sep_fprint "* 3) 192.168.20.0/24                                                                      *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 9) Abort script                                                                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Give a value [1-3] to indicate the LAN where you want to install this server            *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
}

#sep_fprintwhere keuzemenu verbose/quiet uitprinten op het scherm
function sep_fprinthow () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Do you want to see progress on the srceen? (recommended)                                *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 1) Yes: Verbose                                                                         *" ${SEP_VERBOSE}
sep_fprint "* 2) No: Quiet                                                                            *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 9) Abort script                                                                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Give a value [1-2] to indicate if you want output to the screen                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
}

#sep_fprintwhere keuzemenu paused/automatic uitprinten op het scherm
function sep_fprintpaused () {
sep_fprint "" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Do you want to pause between parts?                                                     *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 1) Yes, press ENTER to oversee installation regularly (recommended for debugging)       *" ${SEP_VERBOSE}
sep_fprint "* 2) No, only pause for necessary boots (fullautomatic for demo)                          *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* 9) Abort script                                                                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
sep_fprint "* Give a value [1-2] to indicate if you want output to the screen                         *" ${SEP_VERBOSE}
sep_fprint "*******************************************************************************************" ${SEP_VERBOSE}
}

#sep_fprintgo script letsgo uitprinten op het scherm
function sep_fprintgo () {
sep_fprint "*******************************************************************************************" "1"
sep_fprint "* Let's go: setting up a new windows 2019 server virtualbox vm (for 2023 T01 SEP project) *" "1"
sep_fprint "*******************************************************************************************" "1"
sep_fprint "" "1"
}


#sep_fcheckinput controleren of ingevoerde waarde geldig is
function sep_fcheckinput ([String[]]$SEP_temp_keuzes) {
    $SEP_temp_ingevoerd = Read-Host "> Your choice: "
    
    if (${sep_temp_ingevoerd} -in ${SEP_temp_keuzes}) {
        if (${sep_temp_ingevoerd} -eq "9") {
            sep_fprint "Have a nice day..." ${SEP_VERBOSE}
            Write-Error 'The end' -ErrorAction Stop
        }
        return ${sep_temp_ingevoerd}
    }
    return "" # indien geen geldig ingevoerde waarde: resetten naar "" zodat ze opnieuw wordt gevraagd
} # function sep_fcheckinput

# Main
# Part 01a: Welcome
Clear-Host

sep_fprintwelkom
sep_fprint "Part 01: Some questions ...." ${SEP_VERBOSE}
sep_fprint "" ${SEP_VERBOSE}

# Part 01b: who are you?
while (${SEP_WHO} -eq "") {
    sep_fprintwho
    ${SEP_WHO} = sep_fcheckinput @(1,7,9)
}

# Part 01c: what do you want?
Clear-Host
while (${SEP_WHAT} -eq "") {
    sep_fprintwhat
    ${SEP_WHAT} = sep_fcheckinput @(1,2,9)
}

# Part 01d: which LAN do you want to bridge?
Clear-Host
while (${SEP_WHERE} -eq "") {
    sep_fprintwhere
    ${SEP_WHERE} = sep_fcheckinput @(1,2,3,9)
}

# Part 01e: how do you want it?
Clear-Host
[String]$SEP_HOW = ""
while (${SEP_HOW} -eq "") {
    sep_fprinthow
    ${SEP_HOW} = sep_fcheckinput @(1,2,9)
    $SEP_VERBOSE = ${SEP_HOW}
    if (${SEP_VERBOSE} -eq "1") { # in verbose output mode is het mogelijk na ieder deel te pauzeren om het overzicht te houden
        Clear-Host
        while (${SEP_PAUSED} -eq "") {
            sep_fprintpaused
            ${SEP_PAUSED} = sep_fcheckinput @(1,2,9)
        }   
    }
    else {
        $SEP_PAUSED = "2" # in quiet mode geen pauzes, full automatic
    }
}
Remove-Item variable:SEP_HOW

# Part 01f: lets go!
Clear-Host
sep_fcheckpost00
sep_fprintgo

. "${SEP_PATH}\01_main_calling_script.ps1"