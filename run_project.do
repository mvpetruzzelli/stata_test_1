clear all
clear mata
set more off

**********************IMPORTANT**************************
*Change the paths to match path on your computer locally*
*********************************************************
//Path of repository
/*global repository "C:/Users/reuben_bauer/Desktop/server_example"*/
//global repository "C:/Users/chongan/Desktop/server_example"
global repository "/Users/Michael/Desktop/Michael Stata Practice"

***********************************************
//Run all code in all folders in correct order*
***********************************************
foreach folder in cleaning analysis {
	cd "$repository/`folder'"
	do "run_directory".do
}

di "KLAAR"
