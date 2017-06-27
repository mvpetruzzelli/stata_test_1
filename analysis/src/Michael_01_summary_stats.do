/*******************************************************************************
*	File name:		Michael_01_summary_stats.do
*  	Author(s):		Michael Petruzzelli
*  	Written:       	06/22/2017 (of latest version)
*
*	Inputs:			cleaned_data.dta, Appended_Data.dta
*	Outputs:		CleanedFile.dta, MainResults.log, FinalPaper.pdf
*	
*	Description: 
*
*  	1. This is a template for your Do-file. Just "Save as" your new Do-file, 
*	then write over the relevant fields! 
*
*	2. The description should say what the goal of the Do-file is. 
*
*	3. Make your code legible, not just functional. 
*		a) Indent your loops, conditionals, preserve/restores, other code chunks
*		b) Line up your punctuation: braces ("{" and "}"), equal signs ("="), 
		colons (":"), quote marks (`" "'), etc.
*		c) Use "///" to break up lines of code that extend beyond the line break
*		d) Make clear section headers
*		e) Comment on everything that is not inherently clear to a first-time 
*		reader! Comments should explain why not how. 
*
*	3. Don't over-abbreviate commands and variable names, e.g. "summarize" = 
*	"summ" (ok), "sum" (ok), "su" (not ok)!
*
*	4. Avoid spaces in file names! Use underscore instead, e.g. "new_file".
* 
*******************************************************************************/
 
/********************** Section 1: Preliminaries ******************************/

version 14.1
clear all
clear mata
set more off
cap log close

local input_dir  "/Users/Michael/Desktop/Michael Stata Practice/analysis/input"
local temp_dir   "/Users/Michael/Desktop/Michael Stata Practice/analysis/temp"
local output_dir "/Users/Michael/Desktop/Michael Stata Practice/analysis/output"

local name_of_this_file Michael_01_summary_stats
log using "`temp_dir'/`name_of_this_file'", text replace
/********************** Section 1: Import raw data ****************************/

/********************** Section 2: Clean data *********************************/

cd "`input_dir'"
use cleaned_data
//***************** Subsection 1: Keeping what we want ************************/

ttest points, by(has_hill)

/**************** Subsection 2: Outputting particpants by state ***************/

tabstat count_state, by(home_state) statistics(count)
collapse count_state, by(home_state)
save "count_by_state", replace

/************ Subsection 3: Outputting 10 most common cities by year **********/
clear
use cleaned_data
keep home_city competition_year
duplicates tag home_city competition_year, generate(number_entrants)
duplicates drop home_city competition_year, force
gsort competition_year -number_entrants

levelsof competition_year
foreach lev in `r(levels)' {
	preserve
	keep if competition_year==`lev'
	list competition_year home_city number_entrants in 1/10
	keep in 1/10
	table home_city
	restore
}
/*************** Subsection 4: Wide Form for Section Appearances **************/
clear
use cleaned_data
duplicates tag home_city competition_year, generate(number_entrants)
keep home_city competition_year home_section number_entrants
duplicates drop home_section competition_year number_entrants, force
keep number_entrants home_section competition_year
duplicates drop home_section competition_year, force
reshape wide `competition_year' number_entrants, i(home_section) j(competition_year)
/********************** Section 2: Save and Close *****************************/
save "home_section_data", replace
log close
