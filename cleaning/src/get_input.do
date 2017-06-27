clear all
clear mata
set more off

*************************
//Get files in input_dir*
*************************

//copy data
cd "$repository/Data/"

local Data : dir . files "*.csv"

foreach file in `Data' {
	copy `file' "$repository/cleaning/input/", replace
}
