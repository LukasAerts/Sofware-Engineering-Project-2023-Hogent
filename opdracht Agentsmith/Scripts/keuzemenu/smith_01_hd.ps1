# smith_01_hd.ps1

# MAIN
# Using entire second disk for this ...
Initialize-Disk -number 1 -PartitionStyle MBR
New-Partition -DiskNumber 1 -UseMaximumSize | Format-Volume -FileSystem NTFS -Force -newfilesystemlabel DATA
Get-Partition -DiskNumber  1| set-partition -newdriveletter S

# Creating shared folders
mkdir S:\Shared
mkdir S:\Shared\CAST
mkdir S:\Shared\CREW
mkdir S:\Shared\WALLPAPER
mkdir S:\UserData
mkdir S:\UserData\Folders
mkdir S:\UserData\Profiles

# SMB shares available for Everyone (verkeerderlijk toegewezen aan andere commit in github)
New-SmbShare -Name Cast -Path "S:\Shared\CAST\" -FullAccess "Everyone" -Description "Gedeelde map voor de Cast"
New-SmbShare -Name Crew -Path "S:\Shared\CREW\" -FullAccess "Everyone" -Description "Gedeelde map voor de Crew"
New-SmbShare -Name UserFolders -Path "S:\UserData\Folders\" -FullAccess "Everyone" -Description "Share voor de homefolders voor de gebruikers"
New-SmbShare -Name UserProfiles -Path "S:\UserData\Profiles\" -FullAccess "Everyone" -Description "Share voor de Profile Folders van de gebruikers"
New-SmbShare -Name WALLPAPER -Path "S:\Shared\WALLPAPER" -FullAccess "Everyone" -Description "Share voor waalpapers"

VBoxControl guestproperty set shares_finished y

# new line has a function!