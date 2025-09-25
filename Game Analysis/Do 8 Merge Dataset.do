clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 14 Combined Gamelogs SNS.dta"
merge 1:m Game using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 15 Combined Boxscores.dta", nogen

* Correct issue with passing yards in gamelogs
replace PassYds = PassYds+SkYds
replace OppPassYds = OppPassYds+OppSkYds

* Determine if observation is for team or opponent
gen TeamDum = 0
replace TeamDum = 1 if Home == HomeBox
label variable TeamDum "TeamDum"
drop HomeBox
order TeamDum, first

* Generate opponent fantasy points
local Variable NonQBFantPt OffNonQBFantPt DefSTFantPt
foreach x in `Variable' {
	quietly gen Opp`x' = .
	local NRows = 800
	local NObs = _N
	local NCols = ceil(`NObs'/`NRows')

	*Sort dataset by Opp and store Variable as a matrix
	sort Opp Season Week
	matrix Matrix = J(`NRows',`NCols',.)
	forvalues i = 1/`NCols' {
		local Start = (`i'-1)*`NRows'+1
		
		forvalues j = 1/`NRows' {
			local Obs = `Start'+`j'-1
			if `Obs' <= `NObs' {
				matrix Matrix[`j',`i'] = `x'[`Obs']
			}
		}
	}

	*Sort dataset by Team and restore matrix as OppVariable
	sort Team Season Week
	local Obs = 1
	forvalues i = 1/`NCols' {
		forvalues j = 1/`NRows' {
			if `Obs' <= `NObs' {
				*Extract value from matrix and store it in OppVariable
				quietly replace Opp`x' = Matrix[`j',`i'] in `Obs'
				local Obs = `Obs'+1
			}
		}
	}
	label variable Opp`x' "Opp`x'"
}
order NonQBFantPt OffNonQBFantPt DefSTFantPt, before(logIM)
order OppNonQBFantPt OppOffNonQBFantPt OppDefSTFantPt, before(OpplogIM)

gsort Game -TeamDum -QBPassAtt -QBPassCmp -QBRushAtt
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 16 Merge Dataset.dta", replace