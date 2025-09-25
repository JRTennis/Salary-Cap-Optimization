clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 4 Season.dta"

*Merge AV Cap Clean with Season
merge 1:1 Season Team using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 10 Season AV Cap Clean.dta"
drop _merge
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 11 Season Merge.dta", replace