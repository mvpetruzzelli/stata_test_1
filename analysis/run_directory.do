clear all
clear mata
set more off
cap log close

//Remove folder if exists:
foreach folder in output input temp {
	cd "$repository/analysis/"
	cap !rm `folder'
	!mkdir `folder'
}

//run all files in folder
foreach file in get_input Michael_01_summary_stats Michael_02_regression ///
Michael_03_graphs {
	cd "$repository//analysis/src/"
	do "`file'".do
}
