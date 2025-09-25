clear all

* Combined Boxscores from Game Analysis
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 15 Combined Boxscores.dta", replace
* Drop opponents
drop if TeamID != Team

* Generate season variables
foreach i in "QBPassCmp" "QBPassAtt" "QBPassYds" "QBPassTD" "QBPassInt" "QBSk" "QBSkYds" "QBRushAtt" "QBRushYds" "QBRushTD" "QBFL"{
	egen Season`i' = total(`i'), by(TeamID Season)
}

* Generate season stats
gen a = (SeasonQBPassCmp/SeasonQBPassAtt-.3)*5
gen b = (SeasonQBPassYds/SeasonQBPassAtt-3)*0.25
gen c = (SeasonQBPassTD/SeasonQBPassAtt)*20
gen d = 2.375-(SeasonQBPassInt/SeasonQBPassAtt*25)
replace a = 0 if a < 0
replace a = 2.375 if a > 2.375
replace b = 0 if b < 0
replace b = 2.375 if b > 2.375
replace c = 0 if c < 0
replace c = 2.375 if c > 2.375
replace d = 0 if d < 0
replace d = 2.375 if d > 2.375
gen Rate = (a+b+c+d)/6*100
drop a b c d

gen ANYA = (SeasonQBPassYds-SeasonQBSkYds+20*SeasonQBPassTD-45*SeasonQBPassInt)/(SeasonQBPassAtt+SeasonQBSk)
gen TANYA = (SeasonQBPassYds-SeasonQBSkYds+SeasonQBRushYds+20*(SeasonQBPassTD+SeasonQBRushTD)-45*(SeasonQBPassInt+SeasonQBFL))/(SeasonQBPassAtt+SeasonQBSk+SeasonQBRushAtt)
gen FPA = (.04*SeasonQBPassYds+4*SeasonQBPassTD-2*SeasonQBPassInt+.1*SeasonQBRushYds+6*SeasonQBRushTD-2*SeasonQBFL)/(SeasonQBPassAtt+SeasonQBRushAtt)

label variable Rate Rate
label variable ANYA ANYA
label variable TANYA TANYA
label variable FPA FPA

* Reduce observations to season-level
local NObs = _N
gen count = 1
forvalues i = 2/`NObs'{
	quietly replace count = count[`i'-1]+1 in `i' if TeamID[`i'-1] == TeamID[`i'] & Season[`i'-1] == Season[`i']
	quietly replace count = 1 in `i' if TeamID[`i'-1] != TeamID[`i'] | Season[`i'-1] != Season[`i']
}
drop if count != 1

* Sort the dataset to get Rate, ANY/A, TANY/A, and FP/A in order
sort Season Team
keep Season Team Rate ANYA TANYA FPA
merge 1:1 Season Team using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 1 Manual.dta", nogen
order Season, first
order Rate ANYA TANYA FPA, last
tempfile Season
save `Season'

* CoY data
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 3 CoY.dta", replace
rename (Tm stPlace) (Team FirstPlace)
label variable Team Team
label variable FirstPlace FirstPlace
replace Team = "Las Vegas Raiders" if Team == "Oakland Raiders"
replace Team = "Los Angeles Chargers" if Team == "San Diego Chargers"
replace Team = "Los Angeles Rams" if Team == "St. Louis Rams"
replace Team = "Washington Commanders" if Team == "Washington Redskins" | Team == "Washington Football Team"
drop G W L T Gplyf Wplyf Lplyf

* From 2022-2024, only count coaches who received 1st place votes
drop if FirstPlace == 0
tempfile CoY
save `CoY'

* Coaches data
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 2 Coaches.dta", replace
rename Tm Team
label variable Team Team
replace Team = "Arizona Cardinals"      if Team == "ARI"
replace Team = "Atlanta Falcons"        if Team == "ATL"
replace Team = "Baltimore Ravens"       if Team == "BAL"
replace Team = "Buffalo Bills"          if Team == "BUF"
replace Team = "Carolina Panthers"      if Team == "CAR"
replace Team = "Chicago Bears"          if Team == "CHI"
replace Team = "Cincinnati Bengals"     if Team == "CIN"
replace Team = "Cleveland Browns"       if Team == "CLE"
replace Team = "Dallas Cowboys"         if Team == "DAL"
replace Team = "Denver Broncos"         if Team == "DEN"
replace Team = "Detroit Lions"          if Team == "DET"
replace Team = "Green Bay Packers"      if Team == "GNB"
replace Team = "Houston Texans"         if Team == "HOU"
replace Team = "Indianapolis Colts"     if Team == "IND"
replace Team = "Jacksonville Jaguars"   if Team == "JAX"
replace Team = "Kansas City Chiefs"     if Team == "KAN"
replace Team = "Las Vegas Raiders"      if Team == "LVR" | Team == "OAK"
replace Team = "Los Angeles Chargers"   if Team == "LAC" | Team == "SDG"
replace Team = "Los Angeles Rams"       if Team == "LAR" | Team == "STL"
replace Team = "Miami Dolphins"         if Team == "MIA"
replace Team = "Minnesota Vikings"      if Team == "MIN"
replace Team = "New Orleans Saints"     if Team == "NOR"
replace Team = "New England Patriots"   if Team == "NWE"
replace Team = "New York Giants"        if Team == "NYG"
replace Team = "New York Jets"          if Team == "NYJ"
replace Team = "Philadelphia Eagles"    if Team == "PHI"
replace Team = "Pittsburgh Steelers"    if Team == "PIT"
replace Team = "Seattle Seahawks"       if Team == "SEA"
replace Team = "San Francisco 49ers"    if Team == "SFO"
replace Team = "Tampa Bay Buccaneers"   if Team == "TAM"
replace Team = "Tennessee Titans"       if Team == "TEN"
replace Team = "Washington Commanders"  if Team == "WAS"

* Merge Coaches data with CoY data
merge 1:1 Coach Team Season using `CoY'
sort Season Team Coach
gen CoY = _merge != 1
label variable CoY CoY
keep Season Team Coach CoY SeasonG SeasonW SeasonT
order Season Team Coach CoY SeasonG SeasonW SeasonT, first
tempfile CoachesCoY
save `CoachesCoY'

* Merge Season data with Coaches Data
use `Season', replace
merge 1:m Season Team using `CoachesCoY', nogen
sort Season Team Coach
rename SeasonG CoachGames
label variable CoachGames CoachGames
gen CoachWins = SeasonW + .5*SeasonT
label variable CoachWins CoachWins
drop SeasonW SeasonT
replace CoachGames = 12 if Coach == "Bruce Arians" & Team == "Indianapolis Colts" & Season == 2012
replace CoachGames = 4 if Coach == "Chuck Pagano" & Team == "Indianapolis Colts" & Season == 2012
replace CoachWins = 9 if Coach == "Bruce Arians" & Team == "Indianapolis Colts" & Season == 2012
replace CoachWins = 2 if Coach == "Chuck Pagano" & Team == "Indianapolis Colts" & Season == 2012

* Create LagCoY and LagNoCoY
sort Coach Season

* Generate both lag variables in one pass
by Coach (Season): gen LagCoY   = CoY[_n-1]   if Season == Season[_n-1] + 1
by Coach (Season): gen LagNoCoY = (Season[_n-1] == Season - 1 & CoY[_n-1] == 0)

* Replace missing values with 0
replace LagCoY   = 0 if missing(LagCoY)
replace LagNoCoY = 0 if missing(LagNoCoY)
sort Season Team Coach

* Now take weighted averages within Team-Season cross-sections
sort Team Season
bys Team Season: egen sum_w_CoY       = total(CoY      * CoachGames)
bys Team Season: egen sum_w_LagCoY    = total(LagCoY   * CoachGames)
bys Team Season: egen sum_w_LagNoCoY  = total(LagNoCoY * CoachGames)
bys Team Season: egen sum_w_games     = total(CoachGames)

gen AvgCoY      = sum_w_CoY      / sum_w_games
gen AvgLagCoY   = sum_w_LagCoY   / sum_w_games
gen AvgLagNoCoY = sum_w_LagNoCoY / sum_w_games
drop sum_w_*

* Collapse dataset to the original number of observations
drop if Season == 2010
drop Coach CoY CoachGames CoachWins LagCoY LagNoCoY
duplicates drop
sort Season Team

rename (AvgCoY AvgLagCoY AvgLagNoCoY) (CoY LagCoY LagNoCoY)
label variable CoY CoY
label variable LagCoY LagCoY
label variable LagNoCoY LagNoCoY

quietly recol, full
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 4 Season.dta", replace