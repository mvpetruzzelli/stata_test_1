clear all
clear mata
set more off
cap log close

//Remove folder if exists:
foreach folder in output input temp {
	cd "$repository/cleaning/"
	cap !rm `folder'
	!mkdir `folder'
}

//run all files in folder
foreach file in get_input Michael_01_append Michael_02_clean {
	cd "$repository//cleaning/src/"
	do "`file'".do
}
 
