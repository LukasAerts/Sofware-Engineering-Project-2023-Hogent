# smith_05_gpo.ps1
# alles hard coded hier voor thematrix.local, aangezien het toch niet volledig in powershell lukt

# MAIN
write-host "> Making several Group Policy Objects..."


write-host "> Beleidsregel op gebruikersniveau: Enkel directors hebben toegang tot het control panel"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou's, de rest gebeurt in gui via DirectorPc, zie instructies
$tmp_gponame = "sep_01_controlpanel_domainusers_denied"
new-gpo -name ${tmp_gponame}
$tmp_ou_denied = "OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_ou_denied}
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
$tmp_gponame = "sep_02_controlpanel_directors_allowed"
new-gpo -name ${tmp_gponame}
$tmp_allowed = "OU=Directors,OU=Crew,OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_allowed}


write-host "> Beleidsregel op gebruikersniveau: Niemand kan werkbalken (toolbars) toevoegen aan de taakbalk"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
$tmp_gponame = "sep_03_disable_toolbars"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target $tmp_ou


write-host "> Beleidsregel op gebruikersniveau: De cast heeft geen toegang tot de eigenschappen van de netwerkadapters"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
$tmp_gponame = "sep_04_cast_no_networkadapters"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=CAST,OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target $tmp_ou


write-host ">>> Cast kan enkel inloggen in de cast-Pcs"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
# mind you, via de user settings is deze deliverable ook reeds afgevinkt
$tmp_gponame = "sep_05_cast_inloggen_op_castpcs"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=Cast,DomainWorkstations,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_ou}


write-host "> Crew kan enkel inloggen op de crew-Pcs"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
# mind you, via de user settings is deze deliverable ook reeds afgevinkt
$tmp_gponame = "sep_06_crew_inloggen_op_crewpcs"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=Crew,OU=DomainWorkstations,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_ou}


write-host "> Directors kunnen overal inloggen"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
# mind you, via de user settings is deze deliverable ook reeds afgevinkt
$tmp_gponame = "sep_07_directors_inloggen_op_directorpcs"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=Directors,OU=Crew,OU=DomainWorkstations,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target ${tmp_ou}


write-host "> Extra: wallpapers for specific users :)"
# de gpo wordt enkel aangemaakt en gelinkt aan de goede ou, de rest gebeurt in gui via DirectorPc, zie instructies
$tmp_gponame = "sep_08_cast_wallpaper"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=Cast,OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target $tmp_ou

$tmp_gponame = "sep_09_crew_wallpaper"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=Crew,OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target $tmp_ou

$tmp_gponame = "sep_10_directors_wallpaper"
new-gpo -name ${tmp_gponame}
$tmp_ou = "OU=Directors,OU=Crew,OU=DomainUsers,DC=thematrix,DC=local"
New-GPLink -name ${tmp_gponame} -target $tmp_ou


#signaal voor oproepend script om verder te gaan ...
write-host "> sending host a signal"
VBoxControl guestproperty set gpo_finished y

# new line has a function