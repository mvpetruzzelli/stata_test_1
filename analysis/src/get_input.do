clear all
clear mata
set more off

*************************
//Get files in input_dir*
*************************

//copy data
cd "/Users/Michael/Desktop/Michael Stata Practice/cleaning/output" 
copy cleaned_data.dta "$repository/analysis/input/", replace

