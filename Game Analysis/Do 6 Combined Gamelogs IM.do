clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 8 Injuries Clean.dta"

* Merge Injuries with Money
merge 1:1 Player Team Season using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 10 Money Clean.dta"

* Copy observations where _merge = 1 into "2 Injured Money.xlsx", and add code to "Do 3 Injuries Clean" to fix names that don't match Money dataset
drop if _merge != 3
sort Team Season Player

* Drop extra variables
drop Index OldPlayer Age Status CapHit CapHitPctLeagueCap DeadCap BaseP5Salary SigningBonusProration PerGameBonus RosterBonus OptionBonus WorkoutBonus RestructureProration IncentivesLikely SpotID DeadMoney _merge

* Drop quarterbacks
drop if Pos == "QB"
drop Pos Player

* Replace injured indicator with injured money
forvalues i = 1/21 {
	replace GW`i' = GW`i'*TotalCapHit
}
drop TotalCapHit

* Drop playoffs
drop GW18 GW19 GW20 GW21
replace GW17 = 0 if Season < 2021
replace GW17 = GW16 if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")
replace GW16 = 0 if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")

* Generate FEs
local NObs = _N
gen FE = 1
forvalues i = 2/`NObs' {
	quietly replace FE in `i' = FE[`i'-1] if (Team[`i'] == Team[`i'-1]) | (Season[`i'] == Season[`i'-1])
	quietly replace FE in `i' = FE[`i'-1]+1 if (Team[`i'] != Team[`i'-1]) | (Season[`i'] != Season[`i'-1])
}
drop Team Season
order FE, first
sum FE
local FEMax = r(max)

* Change blank values to 0
forvalues i = 1/17 {
	quietly replace GW`i' = 0 if GW`i' == .
}

* To generate log(Injured Money variable), start by creating unique ID
gen id = _n

* Step 1: Reshape to long format
reshape long GW, i(id) j(GW_week)

* Step 2: Collapse across players: sum within FE × week
collapse (sum) GW, by(FE GW_week)

* Step 3: Sort by FE (outer loop) then GW_week (inner loop) — matches MATLAB stacking
sort FE GW_week

* Step 4: Drop zeros, take log
drop if GW == 0
gen logIM = log(GW)

* Step 5: Keep only logIM
keep logIM

* Save logIM before clearing memory
gen obs_id = _n
tempfile logdata
save `logdata'

* Now load the target dataset
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 11 Combined Gamelogs.dta", clear

* Match and merge
gen obs_id = _n
merge 1:1 obs_id using `logdata', nogenerate
drop obs_id
order logIM, after(PtsOpp)

* Generate OpplogIM
quietly gen OpplogIM = .
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
			matrix Matrix[`j',`i'] = logIM[`Obs']
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
			quietly replace OpplogIM = Matrix[`j',`i'] in `Obs'
			local Obs = `Obs'+1
		}
	}
}

order OpplogIM, after(ToP)
label variable logIM "logIM"
label variable OpplogIM "OpplogIM"
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 12 Combined Gamelogs IM.dta", replace