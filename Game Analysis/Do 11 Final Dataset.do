clear all
local Flag = 1

* Merge Team Dataset with Opp Dataset
if `Flag' == 1 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 17 Team Dataset.dta"
	merge 1:1 Game using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 20 Opp Dataset.dta"
}
else if `Flag' == 2 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 18 Team Dataset Vet.dta"
	merge 1:1 Game using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 21 Opp Dataset Vet.dta"
}
else if `Flag' == 3 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 19 Team Dataset Four.dta"
	merge 1:1 Game using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 22 Opp Dataset Four.dta"
}

* Dropping counterpart necessary for vet and four
drop if _merge != 3
drop _merge

* Drop ties and generate Loss
drop if Win == 0.5
gen Loss = (Win == 0)
label variable Loss "Loss"

* Sort and order the variables
sort Game
order FE OppFE Game Season Week GameID Team Opp Win Loss Home OppHome logIM OpplogIM logWB OpplogWB SGini OppSGini SNSRatio OppSNSRatio AvgReport OppAvgReport NonQBFantPt OppNonQBFantPt OffNonQBFantPt OppOffNonQBFantPt DefSTFantPt OppDefSTFantPt RestDays OppRestDays SpLine OppSpLine LagWinPct OppLagWinPct PriorWinPct OppPriorWinPct SB OppSB Player OppPlayer MultiFlag OppMultiFlag ///
GameRate SeasonRate OppGameRate OppSeasonRate GameANYA SeasonANYA OppGameANYA OppSeasonANYA GameTANYA SeasonTANYA OppGameTANYA OppSeasonTANYA GameFPA SeasonFPA OppGameFPA OppSeasonFPA ///
SeasonRateNoQ4 OppSeasonRateNoQ4 SeasonANYANoQ4 OppSeasonANYANoQ4 SeasonTANYANoQ4 OppSeasonTANYANoQ4 SeasonFPANoQ4 OppSeasonFPANoQ4

* Drop the 2017 Cleveland Browns and their FEs because they went 0-16
levelsof FE if Team == "Cleveland Browns" & Season == 2017, local(DropFE)
drop if FE == `DropFE' | OppFE == `DropFE'

* Generate Team-Opp FE
sum FE
local MaxFE = r(max)
forvalues i = 1/`MaxFE' {
	quietly gen FE`i' = 0
}
forvalues i = 1/`MaxFE' {
	quietly gen OppFE`i' = 0
}
forvalues i = 1/`MaxFE' {
	quietly gen DiffFE`i' = 0
}
local NObs = _N
forvalues i = 1/`NObs' {
	forvalues j = 1/`MaxFE' {
		quietly replace FE`j' = 1 in `i' if FE == `j'
		quietly replace OppFE`j' = 1 in `i' if OppFE == `j'
	}
}
forvalues j = 1/`MaxFE' {
	quietly replace DiffFE`j' = FE`j'-OppFE`j'
	quietly label variable DiffFE`j' "DiffFE`j'"
}
drop FE`DropFE' OppFE`DropFE' DiffFE`DropFE'
rename FE Indicator
rename OppFE OppIndicator
drop FE* OppFE*
rename Indicator FE
rename OppIndicator OppFE

* Generate deviation variables (Game-Season)
foreach x in Rate ANYA TANYA FPA {
	gen Dev`x' = Game`x'-Season`x'
	label variable Dev`x' "Dev`x'"
	order Dev`x', after(Season`x')
}

* Generate opponent deviation variables
local Variable DevRate DevANYA DevTANYA DevFPA
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
foreach x in Rate ANYA TANYA FPA {
	order OppDev`x', after(OppSeason`x')
}

* Generate Team-Opp variables
foreach x in Home logIM logWB SGini SNSRatio AvgReport NonQBFantPt OffNonQBFantPt DefSTFantPt RestDays SpLine LagWinPct GameRate SeasonRate DevRate GameANYA SeasonANYA DevANYA GameTANYA SeasonTANYA DevTANYA GameFPA SeasonFPA DevFPA SeasonRateNoQ4 SeasonANYANoQ4 SeasonTANYANoQ4 SeasonFPANoQ4 {
	gen Diff`x' = `x'-Opp`x'
	label variable Diff`x' "Diff`x'"
}

quietly recol, full
if `Flag' == 1 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 23 Final Dataset.dta", replace
}
else if `Flag' == 2 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 24 Final Dataset Vet.dta", replace
}
else if `Flag' == 3 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 25 Final Dataset Four.dta", replace
}