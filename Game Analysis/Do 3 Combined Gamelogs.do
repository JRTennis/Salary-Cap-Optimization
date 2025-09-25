clear all

* Prepare Vegas data for merger
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 6 Vegas.dta"
expand 2
replace SpLine = "0" if SpLine == "PK"
destring SpLine, replace
replace SpLine = -SpLine if _n > _N/2
label variable SpLine "SpLine"
gen Team = Favorite
replace Team = Underdog if _n > _N/2
gen Opp = Underdog
replace Opp = Favorite if _n > _N/2
tempfile Vegas
save `Vegas'

* Merge Vegas data into gamelogs
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 5 Gamelogs.dta", replace
replace Opp = "RAI" if Opp == "LVR"
replace Opp = "SDG" if Opp == "LAC"
replace Opp = "RAM" if Opp == "LAR"
merge 1:1 GameID Team Opp using "`Vegas'", nogen keepusing(SpLine)

replace Team = "Atlanta Falcons"       if Team == "ATL"
replace Team = "Buffalo Bills"         if Team == "BUF"
replace Team = "Carolina Panthers"     if Team == "CAR"
replace Team = "Chicago Bears"         if Team == "CHI"
replace Team = "Cincinnati Bengals"    if Team == "CIN"
replace Team = "Cleveland Browns"      if Team == "CLE"
replace Team = "Indianapolis Colts"    if Team == "CLT"
replace Team = "Arizona Cardinals"     if Team == "CRD"
replace Team = "Dallas Cowboys"        if Team == "DAL"
replace Team = "Denver Broncos"        if Team == "DEN"
replace Team = "Detroit Lions"         if Team == "DET"
replace Team = "Green Bay Packers"     if Team == "GNB"
replace Team = "Houston Texans"        if Team == "HTX"
replace Team = "Jacksonville Jaguars"  if Team == "JAX"
replace Team = "Kansas City Chiefs"    if Team == "KAN"
replace Team = "Miami Dolphins"        if Team == "MIA"
replace Team = "Minnesota Vikings"     if Team == "MIN"
replace Team = "New Orleans Saints"    if Team == "NOR"
replace Team = "New England Patriots"  if Team == "NWE"
replace Team = "New York Giants"       if Team == "NYG"
replace Team = "New York Jets"         if Team == "NYJ"
replace Team = "Tennessee Titans"      if Team == "OTI"
replace Team = "Philadelphia Eagles"   if Team == "PHI"
replace Team = "Pittsburgh Steelers"   if Team == "PIT"
replace Team = "Las Vegas Raiders"     if Team == "RAI"
replace Team = "Los Angeles Rams"      if Team == "RAM"
replace Team = "Baltimore Ravens"      if Team == "RAV"
replace Team = "Los Angeles Chargers"  if Team == "SDG"
replace Team = "Seattle Seahawks"      if Team == "SEA"
replace Team = "San Francisco 49ers"   if Team == "SFO"
replace Team = "Tampa Bay Buccaneers"  if Team == "TAM"
replace Team = "Washington Commanders" if Team == "WAS"

replace Opp = "Atlanta Falcons"       if Opp == "ATL"
replace Opp = "Buffalo Bills"         if Opp == "BUF"
replace Opp = "Carolina Panthers"     if Opp == "CAR"
replace Opp = "Chicago Bears"         if Opp == "CHI"
replace Opp = "Cincinnati Bengals"    if Opp == "CIN"
replace Opp = "Cleveland Browns"      if Opp == "CLE"
replace Opp = "Indianapolis Colts"    if Opp == "CLT"
replace Opp = "Arizona Cardinals"     if Opp == "CRD"
replace Opp = "Dallas Cowboys"        if Opp == "DAL"
replace Opp = "Denver Broncos"        if Opp == "DEN"
replace Opp = "Detroit Lions"         if Opp == "DET"
replace Opp = "Green Bay Packers"     if Opp == "GNB"
replace Opp = "Houston Texans"        if Opp == "HTX"
replace Opp = "Jacksonville Jaguars"  if Opp == "JAX"
replace Opp = "Kansas City Chiefs"    if Opp == "KAN"
replace Opp = "Miami Dolphins"        if Opp == "MIA"
replace Opp = "Minnesota Vikings"     if Opp == "MIN"
replace Opp = "New Orleans Saints"    if Opp == "NOR"
replace Opp = "New England Patriots"  if Opp == "NWE"
replace Opp = "New York Giants"       if Opp == "NYG"
replace Opp = "New York Jets"         if Opp == "NYJ"
replace Opp = "Tennessee Titans"      if Opp == "OTI"
replace Opp = "Philadelphia Eagles"   if Opp == "PHI"
replace Opp = "Pittsburgh Steelers"   if Opp == "PIT"
replace Opp = "Las Vegas Raiders"     if Opp == "RAI"
replace Opp = "Los Angeles Rams"      if Opp == "RAM"
replace Opp = "Baltimore Ravens"      if Opp == "RAV"
replace Opp = "Los Angeles Chargers"  if Opp == "SDG"
replace Opp = "Seattle Seahawks"      if Opp == "SEA"
replace Opp = "San Francisco 49ers"   if Opp == "SFO"
replace Opp = "Tampa Bay Buccaneers"  if Opp == "TAM"
replace Opp = "Washington Commanders" if Opp == "WAS"

sort Team Season Week
gen Game = _n
label variable Game "Game"
format GameID %17s
replace Venue = abs(1-Venue)
rename Venue Home
label variable Home "Home"
gen Win = 0
replace Win = 1 if Result == "W"
replace Win = 0.5 if Result == "T"
label variable Win "Win"
drop Result
order Game GameID Team Season Week Date Day Opp OT PtsFor PtsOpp Home Win SpLine, first
rename (Int SackYds PuntYds DConv DAtt AJ AK) (PassInt SkYds PntYds ThirdDConv ThirdDAtt FourthDConv FourthDAtt)

* 1. Split ToP into minutes and seconds
gen str2 MinStr = substr(ToP, 1, strpos(ToP, ":") - 1)
gen str2 SecStr = substr(ToP, strpos(ToP, ":") + 1, .)

* 2. Convert strings to numeric
destring MinStr, gen(MinNum)
destring SecStr, gen(SecNum)

* 3. Create numeric total seconds
gen ToPSeconds = 60 * MinNum + SecNum

* 4. Drop temp vars
drop MinStr SecStr MinNum SecNum
drop ToP
rename ToPSeconds ToP

* Generate opponent variables
local Variable Home Win SpLine PassCmp PassAtt PassYds PassTD PassInt Sk SkYds PassYA PassNYA PassPct Rate RushAtt RushYds RushYA RushTD FGM FGA XPM XPA Pnt PntYds ThirdDConv ThirdDAtt FourthDConv FourthDAtt ToP
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

* Fix time of possession variables
gen str5 ToPMmss = string(floor(ToP/60), "%02.0f") + ":" + string(mod(ToP,60), "%02.0f")
gen str5 OppToPMmss = string(floor(OppToP/60), "%02.0f") + ":" + string(mod(OppToP,60), "%02.0f")
drop ToP OppToP
rename (ToPMmss OppToPMmss) (ToP OppToP)
order ToP, after(FourthDAtt)
label variable ToP "ToP"
label variable OppToP "OppToP"

* Extract month and day from Date
gen MonthDate = month(Date)
gen DayDate   = day(Date)

* Adjust year based on whether the month is January
gen YearFixed = Season
replace YearFixed = Season + 1 if Month == 1

* Create new date with adjusted year
gen DateNew = mdy(MonthDate, DayDate, YearFixed)
format DateNew %td
order DateNew, after(Date)

* Overwrite original Date and clean up
replace Date = DateNew
drop DateNew MonthDate DayDate YearFixed

* Generate Team-Season fixed effects
egen FE = group(Team Season)
label variable FE "FE"
order FE, first

save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 11 Combined Gamelogs.dta", replace