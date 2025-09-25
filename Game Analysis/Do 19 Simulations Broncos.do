clear all
scalar t1 = c(current_time)
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 23 Final Dataset.dta"
local NObs = _N

* Regression (Set x to "Game" or "Season")
local x = "Game"
logit Win Diff`x'Rate DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio DiffFE*, vce(cluster GameID)
matrix `x'RateCoef = e(b)
margins, dydx(Diff`x'Rate DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio)
predict `x'Ratexb, xb
gen `x'RatePredict = exp(`x'Ratexb)/(exp(`x'Ratexb)+1)
gen `x'RateME = `x'RatePredict*(1-`x'RatePredict)*`x'RateCoef[1,1]
summarize `x'RateME

* Experiments
gen ExperOn = 0
gen ExperTeam = "Denver Broncos"
gen ExperSeason = 2015

* 2020 Tom Brady on the 2019 Buccaneers and Redskins
if (ExperTeam == "Tampa Bay Buccaneers" | ExperTeam == "Washington Commanders") & ExperSeason == 2019 {
	gen a = (401/610-.3)*5
	gen b = (4633/610-3)*0.25
	gen c = (40/610)*20
	gen d = 2.375-(12/610*25)
}
* 2014 Peyton Manning on the 2015 Broncos
else if ExperTeam == "Denver Broncos" & ExperSeason == 2015 {
	gen a = (395/597-.3)*5
	gen b = (4727/597-3)*0.25
	gen c = (39/597)*20
	gen d = 2.375-(15/597*25)
}
* 2014 Cardinals but Carson Palmer starts every game
else if ExperTeam == "Arizona Cardinals" & ExperSeason == 2014 {
	gen a = (141/224-.3)*5
	gen b = (1626/224-3)*0.25
	gen c = (11/224)*20
	gen d = 2.375-(3/224*25)
}

replace a = 0 if a < 0
replace a = 2.375 if a > 2.375
replace b = 0 if b < 0
replace b = 2.375 if b > 2.375
replace c = 0 if c < 0
replace c = 2.375 if c > 2.375
replace d = 0 if d < 0
replace d = 2.375 if d > 2.375
gen ExperRate = (a+b+c+d)/6*100
drop a b c d

gen Exper`x'Rate = `x'Rate
replace Exper`x'Rate = ExperRate if Team == ExperTeam & Season == ExperSeason & ExperOn == 1
gen ExperOpp`x'Rate = Opp`x'Rate
replace ExperOpp`x'Rate = ExperRate if Opp == ExperTeam & Season == ExperSeason & ExperOn == 1
gen ExperDiff`x'Rate = Exper`x'Rate-ExperOpp`x'Rate
replace `x'Ratexb = `x'Ratexb+`x'RateCoef[1,1]*(ExperDiff`x'Rate-Diff`x'Rate) if Season == ExperSeason & (Team == ExperTeam | Opp == ExperTeam)
replace `x'RatePredict = exp(`x'Ratexb)/(exp(`x'Ratexb)+1) if Season == ExperSeason & (Team == ExperTeam | Opp == ExperTeam)

* Number of simulations
set seed 72
local state = c(rngstate)
local NSim = 10000
gen NSim = `NSim'
if `NSim' > _N {
	set obs `NSim'
}

* Declare variables for simulations
gen ones = 1
gen Order = _n
gen Winner = Team
replace Winner = Opp if Win == 0
replace Winner = "Z" if Winner == ""
gen Loser = Team
replace Loser = Opp if Win == 1
replace Loser = "Z" if Loser == ""
gsort Winner Loser Season Week -Win Order
egen Total = total(ones), by(Team Season)
gen MeanSimWinTotal = 0
gen SDSimWinTotal = 0
gen MinSimWinTotal = 17
gen MaxSimWinTotal = 0

* For histogram
egen FirstTime = min(cond(Team == ExperTeam & Season == ExperSeason, Order, .))
gen Histo = .

* Run NSim simulations
forvalues i = 1/`NSim' {
	* Pick winner using random number
	quietly gen Sim`i' = runiform()
	quietly gen SimWin`i' = .
	quietly replace SimWin`i' = 0 if Win == 1 & Sim`i' > `x'RatePredict
	quietly replace SimWin`i' = 1 if Win == 1 & Sim`i' <= `x'RatePredict

	* Match winner with loser
	forvalues j = 2/`NObs' {
		quietly replace SimWin`i' in `j' = abs(SimWin`i'[`j'-1]-1) if SimWin`i'[`j'] == .
	}

	* Calculate simulated win total
	quietly egen SimWinCount`i' = total(SimWin`i'), by(Team Season)
	quietly gen SimWinPct`i' = SimWinCount`i'/Total
	quietly gen SimWinTotal`i' = .
	quietly replace SimWinTotal`i' = SimWinPct`i'*16 if Season <= 2020
	quietly replace SimWinTotal`i' = SimWinPct`i'*17 if Season >= 2021
	quietly replace SimWinTotal`i' = SimWinPct`i'*16 if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")
	
	* Compute mean, min, and max of simulated win totals
	quietly replace MeanSimWinTotal = MeanSimWinTotal+SimWinTotal`i'
	quietly replace MinSimWinTotal = SimWinTotal`i' if SimWinTotal`i' < MinSimWinTotal
	quietly replace MaxSimWinTotal = SimWinTotal`i' if SimWinTotal`i' > MaxSimWinTotal
	
	* For histogram
	sort Order
	quietly replace Histo in `i' = SimWinTotal`i'[FirstTime]
	gsort Winner Loser Season Week -Win Order
	
	drop Sim`i' SimWin`i' SimWinCount`i' SimWinPct`i' SimWinTotal`i'
}
replace MeanSimWinTotal = MeanSimWinTotal/NSim

* Rerun NSim simulations to get SD, restoring initial random-number generator state
set rngstate `state'
forvalues i = 1/`NSim' {
	* Pick winner using random number
	quietly gen Sim`i' = runiform()
	quietly gen SimWin`i' = .
	quietly replace SimWin`i' = 0 if Win == 1 & Sim`i' > `x'RatePredict
	quietly replace SimWin`i' = 1 if Win == 1 & Sim`i' <= `x'RatePredict

	* Match winner with loser
	forvalues j = 2/`NObs' {
		quietly replace SimWin`i' in `j' = abs(SimWin`i'[`j'-1]-1) if SimWin`i'[`j'] == .
	}

	* Calculate simulated win total
	quietly egen SimWinCount`i' = total(SimWin`i'), by(Team Season)
	quietly gen SimWinPct`i' = SimWinCount`i'/Total
	quietly gen SimWinTotal`i' = .
	quietly replace SimWinTotal`i' = SimWinPct`i'*16 if Season <= 2020
	quietly replace SimWinTotal`i' = SimWinPct`i'*17 if Season >= 2021
	quietly replace SimWinTotal`i' = SimWinPct`i'*16 if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")
	
	* Compute SD of simulated win totals
	quietly replace SDSimWinTotal = SDSimWinTotal+(SimWinTotal`i'-MeanSimWinTotal)^2
	
	drop Sim`i' SimWin`i' SimWinCount`i' SimWinPct`i' SimWinTotal`i'
}
replace SDSimWinTotal = sqrt(SDSimWinTotal/(NSim-1))

order Histo MeanSimWinTotal SDSimWinTotal MinSimWinTotal MaxSimWinTotal, first
sort Order

* Calculate runtime in minutes
scalar t2 = c(current_time)
gen runtime = cond(clock(t2,"hms")>=clock(t1,"hms"), (clock(t2,"hms")-clock(t1,"hms"))/60000, (clock(t2,"hms")+24*60*60*1000-clock(t1,"hms"))/60000)

* Save under a different name if running a different experiment
if ExperOn == 0 & ExperTeam == "Tampa Bay Buccaneers" & ExperSeason == 2019 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 26 game_simulations_Buccaneers_2019_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Tampa Bay Buccaneers" & ExperSeason == 2019 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 27 game_simulations_Buccaneers_2019_experiment.dta", replace
}
else if ExperOn == 0 & ExperTeam == "Washington Commanders" & ExperSeason == 2019 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 28 game_simulations_Redskins_2019_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Washington Commanders" & ExperSeason == 2019 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 29 game_simulations_Redskins_2019_experiment.dta", replace
}
else if ExperOn == 0 & ExperTeam == "Denver Broncos" & ExperSeason == 2015 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 30 game_simulations_Broncos_2015_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Denver Broncos" & ExperSeason == 2015 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 31 game_simulations_Broncos_2015_experiment.dta", replace
}
else if ExperOn == 0 & ExperTeam == "Arizona Cardinals" & ExperSeason == 2014 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 32 game_simulations_Cardinals_2014_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Arizona Cardinals" & ExperSeason == 2014 & "`x'" == "Game" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 33 game_simulations_Cardinals_2014_experiment.dta", replace
}

else if ExperOn == 0 & ExperTeam == "Tampa Bay Buccaneers" & ExperSeason == 2019 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 34 season_simulations_Buccaneers_2019_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Tampa Bay Buccaneers" & ExperSeason == 2019 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 35 season_simulations_Buccaneers_2019_experiment.dta", replace
}
else if ExperOn == 0 & ExperTeam == "Washington Commanders" & ExperSeason == 2019 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 36 season_simulations_Redskins_2019_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Washington Commanders" & ExperSeason == 2019 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 37 season_simulations_Redskins_2019_experiment.dta", replace
}
else if ExperOn == 0 & ExperTeam == "Denver Broncos" & ExperSeason == 2015 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 38 season_simulations_Broncos_2015_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Denver Broncos" & ExperSeason == 2015 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 39 season_simulations_Broncos_2015_experiment.dta", replace
}
else if ExperOn == 0 & ExperTeam == "Arizona Cardinals" & ExperSeason == 2014 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 40 season_simulations_Cardinals_2014_baseline.dta", replace
}
else if ExperOn == 1 & ExperTeam == "Arizona Cardinals" & ExperSeason == 2014 & "`x'" == "Season" {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 41 season_simulations_Cardinals_2014_experiment.dta", replace
}