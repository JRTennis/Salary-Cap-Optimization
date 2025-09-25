clear all
set more off
timer clear 1
timer on 1
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 23 Final Dataset.dta", clear

* Count observations
count
local Reps = 500
local Progress = 50
set seed 72

* First half
matrix SeasonAMEs1 = J(`Reps', 4, .)

forvalues i = 1/`Reps' {
    preserve
    bsample, cluster(GameID)
    local col = 1
    foreach x in Rate ANYA TANYA FPA {
        capture {
            quietly logit Win DiffSeason`x' DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio DiffFE* if Season >= 2018, vce(cluster GameID)
            quietly margins, dydx(DiffSeason`x') post
        }
        if _rc == 0 {
            matrix b = e(b)
            matrix SeasonAMEs1[`i', `col'] = b[1,1]
        }
        else {
            display as error "Warning: logit failed on rep `i' for DiffSeason`x'"
        }
        local ++col
    }
    restore
    if mod(`i', `Progress') == 0 display as text "First matrix: Completed rep `i' of `Reps'"
}
matrix colnames SeasonAMEs1 = Rate ANYA TANYA FPA

* Second half
matrix SeasonAMEs2 = J(`Reps', 4, .)

forvalues i = 1/`Reps' {
    preserve
    bsample, cluster(GameID)
    local col = 1
    foreach x in Rate ANYA TANYA FPA {
        capture {
            quietly logit Win DiffSeason`x' DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio DiffFE* if Season >= 2018, vce(cluster GameID)
            quietly margins, dydx(DiffSeason`x') post
        }
        if _rc == 0 {
            matrix b = e(b)
            matrix SeasonAMEs2[`i', `col'] = b[1,1]
        }
        else {
            display as error "Warning: logit failed on rep `i' for DiffSeason`x'"
        }
        local ++col
    }
    restore
    if mod(`i', `Progress') == 0 display as text "Second matrix: Completed rep `i' of `Reps'"
}
matrix colnames SeasonAMEs2 = Rate ANYA TANYA FPA

* Convert and save SeasonAMEs1
svmat SeasonAMEs1, names(col)
gen rep = _n
tempfile boot1
save `boot1', replace

* Clear memory to prepare for second matrix
clear

* Convert and save SeasonAMEs2
svmat SeasonAMEs2, names(col)
gen rep = _n + `Reps'
tempfile boot2
save `boot2', replace

* Append and save final combined dataset
use `boot1', clear
append using `boot2'
drop if Rate == .
keep Rate ANYA TANYA FPA

save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 19 Game Bootstrap Post-2018.dta", replace
timer off 1
timer list 1
display "Runtime: " r(t1)/60 " minutes"