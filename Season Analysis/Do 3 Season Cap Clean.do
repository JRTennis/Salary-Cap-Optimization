clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 7 Season Cap.dta"

* Save separate dataset for DID analysis
local DIDFlag = 0

* Rename and label variables
drop A
rename (Year DATE1 DATE2 TEAM1 TEAM2 DRAFT OPTION ROOKIE TRIGGER) (Season Contract1 Contract2 Team1 Team2 Draft Option Rookie Trigger)
label variable Season "Season"
label variable Contract1 "Contract 1"
label variable Contract2 "Contract 2"
label variable Team1 "Team 1"
label variable Team2 "Team 2"
label variable Draft "Draft"
label variable Option "Option"
label variable Rookie "Rookie"
label variable Trigger "Trigger"

* Drop if Player is blank, and add Frank Ragnow, Jason Taylor, and Solomon Thomas
drop if Player == ""

local Ragnow = 20156
insobs 1, before(`Ragnow')
replace Player = "Frank Ragnow" if _n == `Ragnow'
replace Pos = "C" if _n == `Ragnow'
replace Age = 28 if _n == `Ragnow'
replace CapHit = 12800000 if _n == `Ragnow'
replace CapHitPctLeagueCap = 5.01 if _n == `Ragnow'
replace DeadCap = -13200000 if _n == `Ragnow'
replace BaseP5Salary = 7900000 if _n == `Ragnow'
replace SigningBonusProration = 1200000 if _n == `Ragnow'
replace PerGameBonus = . if _n == `Ragnow'
replace RosterBonus = . if _n == `Ragnow'
replace OptionBonus = 3600000 if _n == `Ragnow'
replace WorkoutBonus = 100000 if _n == `Ragnow'
replace RestructureProration = . if _n == `Ragnow'
replace IncentivesLikely = . if _n == `Ragnow'
replace SpotID = 25115 if _n == `Ragnow'
replace Team = "DET" if _n == `Ragnow'
replace Season = 2024 if _n == `Ragnow'
replace Status = "active" if _n == `Ragnow'
replace DeadMoney = 0 if _n == `Ragnow'
replace Cutoff = td(15feb2025) if _n == `Ragnow'
replace Team1 = "DET" if _n == `Ragnow'
replace Contract1 = td(26apr2018) if _n == `Ragnow'
replace Team2 = "DET" if _n == `Ragnow'
replace Contract2 = td(6may2021) if _n == `Ragnow'
replace Draft = 1 if _n == `Ragnow'
replace Option = td(28apr2021) if _n == `Ragnow'
replace Rookie = 0 if _n == `Ragnow'
replace Trigger = 1 if _n == `Ragnow'

local Taylor = 34869
insobs 1, before(`Taylor')
replace Player = "Jason Taylor" if _n == `Taylor'
replace Pos = "DE" if _n == `Taylor'
replace Age = 37 if _n == `Taylor'
replace CapHit = 1350000 if _n == `Taylor'
replace CapHitPctLeagueCap = 1.12 if _n == `Taylor'
replace DeadCap = . if _n == `Taylor'
replace BaseP5Salary = 950000 if _n == `Taylor'
replace SigningBonusProration = 50000 if _n == `Taylor'
replace PerGameBonus = 350000 if _n == `Taylor'
replace RosterBonus = . if _n == `Taylor'
replace OptionBonus = . if _n == `Taylor'
replace WorkoutBonus = . if _n == `Taylor'
replace RestructureProration = . if _n == `Taylor'
replace IncentivesLikely = . if _n == `Taylor'
replace SpotID = 5135 if _n == `Taylor'
replace Team = "MIA" if _n == `Taylor'
replace Season = 2011 if _n == `Taylor'
replace Status = "active" if _n == `Taylor'
replace DeadMoney = 0 if _n == `Taylor'
replace Cutoff = td(15feb2012) if _n == `Taylor'
replace Team1 = "MIA" if _n == `Taylor'
replace Contract1 = td(19apr1997) if _n == `Taylor'
replace Team2 = "MIA" if _n == `Taylor'
replace Contract2 = td(15apr2000) if _n == `Taylor'
replace Draft = 1 if _n == `Taylor'
replace Option = . if _n == `Taylor'
replace Rookie = 0 if _n == `Taylor'
replace Trigger = 0 if _n == `Taylor'

local Thomas = 46069
insobs 1, before(`Thomas')
replace Player = "Solomon Thomas" if _n == `Thomas'
replace Pos = "DT" if _n == `Thomas'
replace Age = 29 if _n == `Thomas'
replace CapHit = 2630000 if _n == `Thomas'
replace CapHitPctLeagueCap = 1.03 if _n == `Thomas'
replace DeadCap = -2490000 if _n == `Thomas'
replace BaseP5Salary = 1750000 if _n == `Thomas'
replace SigningBonusProration = 370000 if _n == `Thomas'
replace PerGameBonus = 510000 if _n == `Thomas'
replace RosterBonus = . if _n == `Thomas'
replace OptionBonus = . if _n == `Thomas'
replace WorkoutBonus = . if _n == `Thomas'
replace RestructureProration = . if _n == `Thomas'
replace IncentivesLikely = . if _n == `Thomas'
replace SpotID = 21744 if _n == `Thomas'
replace Team = "NYJ" if _n == `Thomas'
replace Season = 2024 if _n == `Thomas'
replace Status = "active" if _n == `Thomas'
replace DeadMoney = 0 if _n == `Thomas'
replace Cutoff = td(15feb2025) if _n == `Thomas'
replace Team1 = "SF" if _n == `Thomas'
replace Contract1 = td(27apr2017) if _n == `Thomas'
replace Team2 = "" if _n == `Thomas'
replace Contract2 = td(17mar2021) if _n == `Thomas'
replace Draft = 1 if _n == `Thomas'
replace Option = . if _n == `Thomas'
replace Rookie = 0 if _n == `Thomas'
replace Trigger = 0 if _n == `Thomas'

* Clean Team variable
gen Index = _n
label variable Index "Index"
foreach x in "" "1" {
	replace Team`x' = "Atlanta Falcons"        if Team`x' == "ATL"
	replace Team`x' = "Buffalo Bills"          if Team`x' == "BUF"
	replace Team`x' = "Carolina Panthers"      if Team`x' == "CAR"
	replace Team`x' = "Chicago Bears"          if Team`x' == "CHI"
	replace Team`x' = "Cincinnati Bengals"     if Team`x' == "CIN" | Team`x' == "CN"
	replace Team`x' = "Cleveland Browns"       if Team`x' == "CLE"
	replace Team`x' = "Indianapolis Colts"     if Team`x' == "CLT" | Team`x' == "IND"
	replace Team`x' = "Arizona Cardinals"      if Team`x' == "CRD" | Team`x' == "ARI" | Team`x' == "AZ"
	replace Team`x' = "Dallas Cowboys"         if Team`x' == "DAL"
	replace Team`x' = "Denver Broncos"         if Team`x' == "DEN"
	replace Team`x' = "Detroit Lions"          if Team`x' == "DET"
	replace Team`x' = "Green Bay Packers"      if Team`x' == "GNB" | Team`x' == "GB"
	replace Team`x' = "Houston Texans"         if Team`x' == "HTX" | Team`x' == "HOU"
	replace Team`x' = "Jacksonville Jaguars"   if Team`x' == "JAX" | Team`x' == "JAC"
	replace Team`x' = "Kansas City Chiefs"     if Team`x' == "KAN" | Team`x' == "KC"
	replace Team`x' = "Miami Dolphins"         if Team`x' == "MIA"
	replace Team`x' = "Minnesota Vikings"      if Team`x' == "MIN"
	replace Team`x' = "New Orleans Saints"     if Team`x' == "NOR" | Team`x' == "NO"
	replace Team`x' = "New England Patriots"   if Team`x' == "NWE" | Team`x' == "NE"
	replace Team`x' = "New York Giants"        if Team`x' == "NYG"
	replace Team`x' = "New York Jets"          if Team`x' == "NYJ"
	replace Team`x' = "Tennessee Titans"       if Team`x' == "OTI" | Team`x' == "TEN"
	replace Team`x' = "Philadelphia Eagles"    if Team`x' == "PHI"
	replace Team`x' = "Pittsburgh Steelers"    if Team`x' == "PIT"
	replace Team`x' = "Las Vegas Raiders"      if Team`x' == "RAI" | Team`x' == "LV" | Team`x' == "LVR" | Team`x' == "OAK"
	replace Team`x' = "Los Angeles Rams"       if Team`x' == "RAM" | Team`x' == "LA" | Team`x' == "LAR" | Team`x' == "STL"
	replace Team`x' = "Baltimore Ravens"       if Team`x' == "RAV" | Team`x' == "BAL"
	replace Team`x' = "Los Angeles Chargers"   if Team`x' == "SDG" | Team`x' == "LAC" | Team`x' == "SD"
	replace Team`x' = "Seattle Seahawks"       if Team`x' == "SEA" | Team`x' == "SE"
	replace Team`x' = "San Francisco 49ers"    if Team`x' == "SFO" | Team`x' == "SF"
	replace Team`x' = "Tampa Bay Buccaneers"   if Team`x' == "TAM" | Team`x' == "TB"
	replace Team`x' = "Washington Commanders"  if Team`x' == "WAS"
}
sort Team Season Status Player Index

* Dannell Ellerbe, Evan Smith, Mario Butler, and Matt Kaskey have Rookie = 1 despite missing Contract1
replace Rookie = 0 if Contract1 == .
gen RookieSeason = year(Contract1)
label variable RookieSeason "Rookie Season"
drop SpotID DeadMoney Cutoff Team1 Contract1 Team2 Contract2 Draft Option Trigger
order Index Team Season Status Player RookieSeason Rookie Age Pos, first

* Fix corrupted apostrophes
replace Player = subinstr(Player, "â€™", "'", .)

* Fix accented characters
replace Player = subinstr(Player, "Ã¡", "á", .)
replace Player = subinstr(Player, "Ã©", "é", .)
replace Player = subinstr(Player, "Ã¨", "è", .)
replace Player = subinstr(Player, "Ã­", "í", .)
replace Player = subinstr(Player, "Ã³", "ó", .)
replace Player = subinstr(Player, "Ãº", "ú", .)
replace Player = subinstr(Player, "Ã±", "ñ", .)
replace Player = subinstr(Player, "Ãœ", "Ü", .)
replace Player = subinstr(Player, "Ã‰", "É", .)
* replace Player = subinstr(Player, "Ã", "Á", .) // Often appears as standalone corruption

* Fix miscellaneous corruptions
replace Player = subinstr(Player, "Â", "", .)
replace Player = regexr(Player, " {2,}", " ")

* Impute RookieSeason for players with missing RookieSeason (see "2 Season Corrections.xlsx")
* Devin Lucien, Ikaika Alama-Francis, and Jaleel Scott have correct RookieSeason but incorrect Contract2
quietly replace RookieSeason = 2011 if Player == "Aaron Bates" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Aaron Bates" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Aaron Lavarias" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Abasi Salimu" & Season == 2014 & Team == "Los Angeles Rams" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Abasi Salimu" & Season == 2015 & Team == "Los Angeles Rams" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Adam Mims" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Adam Mims" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Adam Nissley" & Season == 2012 & Team == "Atlanta Falcons" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Adam Nissley" & Season == 2013 & Team == "Atlanta Falcons" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Adam Nissley" & Season == 2014 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Adrian Davis" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Adrian Davis" & Season == 2013 & Team == "New Orleans Saints" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Adrian Davis" & Season == 2014 & Team == "New Orleans Saints" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Adrian Moten" & Season == 2011 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Adrian Moten" & Season == 2011 & Team == "Seattle Seahawks" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Adrian Moten" & Season == 2012 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Adrian Moten" & Season == 2012 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Adrian Moten" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Alex Albright" & Season == 2011 & Team == "Dallas Cowboys" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Alex Albright" & Season == 2012 & Team == "Dallas Cowboys" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Alex Albright" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Alex Silvestro" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Alex Silvestro" & Season == 2011 & Team == "New England Patriots" & Status == "practice-squad"
quietly replace RookieSeason = 2011 if Player == "Alex Silvestro" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Andre Smith" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Andre Smith" & Season == 2013 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Andre Smith" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Andre Smith" & Season == 2014 & Team == "Cleveland Browns" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Andrew Rich" & Season == 2011 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Andrew Rich" & Season == 2012 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Andrew Szczerba" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Andrew Szczerba" & Season == 2013 & Team == "Atlanta Falcons" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Andrew Szczerba" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Anthony Gray" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Anthony Gray" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Anthony Mosley" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Anthony Mosley" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2013 if Player == "Anthony Rashad White" & Season == 2013 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Armand Robinson" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Armand Robinson" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Armond Smith" & Season == 2011 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Armond Smith" & Season == 2012 & Team == "Carolina Panthers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Armond Smith" & Season == 2013 & Team == "Carolina Panthers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Armond Smith" & Season == 2013 & Team == "Carolina Panthers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Aston Whiteside" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Aston Whiteside" & Season == 2013 & Team == "Chicago Bears" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Aston Whiteside" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Aston Whiteside" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Austin Wells" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Austin Wells" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Auston English" & Season == 2012 & Team == "Cleveland Browns" & Status == "injured"
quietly replace RookieSeason = 2023 if Player == "B.J. Thompson" & Season == 2023 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2023 if Player == "B.J. Thompson" & Season == 2024 & Team == "Kansas City Chiefs" & Status == "reserve-pup"
quietly replace RookieSeason = 2012 if Player == "Ben Bass" & Season == 2012 & Team == "Dallas Cowboys" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Ben Bass" & Season == 2013 & Team == "Dallas Cowboys" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Ben Bass" & Season == 2014 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Ben Bass" & Season == 2014 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2017 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2018 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2018 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2019 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2019 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2019 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2020 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2020 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2021 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2021 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2017 if Player == "Benjamin Braden" & Season == 2021 & Team == "Green Bay Packers" & Status == "practice-squad"
quietly replace RookieSeason = 2012 if Player == "Blake DeChristopher" & Season == 2012 & Team == "Arizona Cardinals" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Brad Thorson" & Season == 2011 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Bradley Vierling" & Season == 2011 & Team == "Jacksonville Jaguars" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Bradley Vierling" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Brandon Joiner" & Season == 2012 & Team == "Cincinnati Bengals" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Brandon Joiner" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Brandon Kinnie" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Brandon Kinnie" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Brandon McCray" & Season == 2014 & Team == "New Orleans Saints" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brandon Peguese" & Season == 2012 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Brandon Saine" & Season == 2011 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Brandon Saine" & Season == 2011 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brandon Saine" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brandon Saine" & Season == 2012 & Team == "Green Bay Packers" & Status == "injured"
quietly replace RookieSeason = 2024 if Player == "Brenden Rice" & Season == 2024 & Team == "Los Angeles Chargers" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Brett Greenwood" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brett Greenwood" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brett Hartmann" & Season == 2011 & Team == "Houston Texans" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brett Hartmann" & Season == 2011 & Team == "Houston Texans" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Brett Hartmann" & Season == 2012 & Team == "Houston Texans" & Status == "dead"
quietly replace RookieSeason = 2003 if Player == "Brett Romberg" & Season == 2011 & Team == "Atlanta Falcons" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Brett Roy" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Brett Roy" & Season == 2013 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brian Smith" & Season == 2011 & Team == "Cleveland Browns" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Brian Smith" & Season == 2012 & Team == "Cleveland Browns" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Bruce Figgins" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Bryan Mattison" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Bryan Mattison" & Season == 2011 & Team == "Los Angeles Rams" & Status == "active"
quietly replace RookieSeason = 2008 if Player == "Bryan Mattison" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2007 if Player == "Buster Davis" & Season == 2011 & Team == "Los Angeles Chargers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Byron Landor" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2016 if Player == "Caleb Benenoch" & Season == 2021 & Team == "New Orleans Saints" & Status == "practice-squad"
quietly replace RookieSeason = 2011 if Player == "Caleb King" & Season == 2011 & Team == "Minnesota Vikings" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Caleb King" & Season == 2011 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Caleb King" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Cam Holland" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Cam Holland" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Cameron Bell" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Cameron Bell" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Cameron Fuller" & Season == 2014 & Team == "San Francisco 49ers" & Status == "active"
quietly replace RookieSeason = 2014 if Player == "Cameron Fuller" & Season == 2014 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Carmen Messina" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Carmen Messina" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Cecil Newton" & Season == 2011 & Team == "Baltimore Ravens" & Status == "practice-squad"
quietly replace RookieSeason = 2009 if Player == "Cecil Newton" & Season == 2011 & Team == "Green Bay Packers" & Status == "practice-squad"
quietly replace RookieSeason = 2009 if Player == "Chad Faulcon" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Chad Faulcon" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Charly Martin" & Season == 2012 & Team == "Seattle Seahawks" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Chase Baker" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Chase Baker" & Season == 2012 & Team == "Minnesota Vikings" & Status == "practice-squad"
quietly replace RookieSeason = 2012 if Player == "Chase Baker" & Season == 2013 & Team == "Minnesota Vikings" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Chase Baker" & Season == 2013 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Chase Beeler" & Season == 2011 & Team == "San Francisco 49ers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Chase Beeler" & Season == 2011 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Chase Beeler" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Chase Beeler" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Chase Minnifield" & Season == 2012 & Team == "Washington Commanders" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Chase Minnifield" & Season == 2013 & Team == "Washington Commanders" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Chase Minnifield" & Season == 2013 & Team == "Washington Commanders" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Chase Minnifield" & Season == 2014 & Team == "Washington Commanders" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Chase Minnifield" & Season == 2014 & Team == "Washington Commanders" & Status == "injured"
quietly replace RookieSeason = 2010 if Player == "Chastin West" & Season == 2011 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Chastin West" & Season == 2011 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Chip Vaughn" & Season == 2011 & Team == "New Orleans Saints" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Chris Boyd" & Season == 2014 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Chris Boyd" & Season == 2014 & Team == "Dallas Cowboys" & Status == "practice-squad"
quietly replace RookieSeason = 2014 if Player == "Chris Boyd" & Season == 2015 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Chris Bryan" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Chris Dieker" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Chris Dieker" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Chris Givens" & Season == 2012 & Team == "New Orleans Saints" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Chris Givens" & Season == 2013 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Chris Givens" & Season == 2014 & Team == "New Orleans Saints" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Chris Riley" & Season == 2011 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Chris Riley" & Season == 2012 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2001 if Player == "Chukky Okobi" & Season == 2013 & Team == "Los Angeles Chargers" & Status == "dead"
quietly replace RookieSeason = 2001 if Player == "Chukky Okobi" & Season == 2014 & Team == "Los Angeles Chargers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Clay Nurse" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Clay Nurse" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Cliff Harris" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Cliff Harris" & Season == 2013 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Cody Johnson" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Colin Baxter" & Season == 2012 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Colin Cochart" & Season == 2011 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Corey Paredes" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Corey Woods" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Corey Woods" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Courtney Smith" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Craig Bills" & Season == 2015 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Curtis Gatewood" & Season == 2011 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace RookieSeason = 2013 if Player == "D'Andre Goodwin" & Season == 2011 & Team == "Denver Broncos" & Status == "active"
quietly replace RookieSeason = 2013 if Player == "D'Anton Lynn" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "D'Anton Lynn" & Season == 2013 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "D.J. Harper" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "D.J. Harper" & Season == 2014 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "DaMarcus Ganaway" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Damik Scafe" & Season == 2012 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Damik Scafe" & Season == 2013 & Team == "Los Angeles Chargers" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Damik Scafe" & Season == 2014 & Team == "Los Angeles Chargers" & Status == "injured"
quietly replace RookieSeason = 2009 if Player == "Dannell Ellerbe" & Season == 2011 & Team == "Baltimore Ravens" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Dannell Ellerbe" & Season == 2012 & Team == "Baltimore Ravens" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Dannell Ellerbe" & Season == 2013 & Team == "Miami Dolphins" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Dannell Ellerbe" & Season == 2014 & Team == "Miami Dolphins" & Status == "injured"
quietly replace RookieSeason = 2009 if Player == "Dannell Ellerbe" & Season == 2015 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Dannell Ellerbe" & Season == 2015 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Dannell Ellerbe" & Season == 2016 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Dannell Ellerbe" & Season == 2017 & Team == "New Orleans Saints" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Dannell Ellerbe" & Season == 2017 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Danny Noble" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Danny Noble" & Season == 2013 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Danny Noble" & Season == 2013 & Team == "Jacksonville Jaguars" & Status == "practice-squad"
quietly replace RookieSeason = 2012 if Player == "Danny Noble" & Season == 2013 & Team == "Tampa Bay Buccaneers" & Status == "practice-squad"
quietly replace RookieSeason = 2012 if Player == "Darrell Scott" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Darrell Scott" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Darren Evans" & Season == 2012 & Team == "Tennessee Titans" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Darryl Gamble" & Season == 2011 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Darvin Adams" & Season == 2011 & Team == "Carolina Panthers" & Status == "active"
quietly replace RookieSeason = 2014 if Player == "Darwin Cook" & Season == 2014 & Team == "Cleveland Browns" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Darwin Cook" & Season == 2015 & Team == "Cleveland Browns" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "David Douglas" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "David Douglas" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "David Douglas" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "David Gonzales" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "David Snow" & Season == 2012 & Team == "Buffalo Bills" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "David Snow" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "David Snow" & Season == 2013 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "David Snow" & Season == 2014 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Dawson Zimmerman" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Dawson Zimmerman" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "DeAndre McDaniel" & Season == 2012 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "DeQuin Evans" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Dennis Landolt" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Dennis Landolt" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Derek Chard" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Derek Chard" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Derek Hall" & Season == 2011 & Team == "San Francisco 49ers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Derrick Jones" & Season == 2011 & Team == "Las Vegas Raiders" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Desmond Morrow" & Season == 2012 & Team == "Houston Texans" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Desmond Morrow" & Season == 2013 & Team == "Houston Texans" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Devin Goda" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Devin Goda" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Devin Holland" & Season == 2011 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Devin Holland" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Dexter Heyman" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Dexter Heyman" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Dominique Curry" & Season == 2011 & Team == "Los Angeles Rams" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Domonique Johnson" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Dorian Graham" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Dorian Graham" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Dorson Boyce" & Season == 2012 & Team == "Washington Commanders" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Dustin Waldron" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Dustin Waldron" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Dustin Waldron" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Eddie Jones" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Eddie Williams" & Season == 2012 & Team == "Cleveland Browns" & Status == "injured"
quietly replace RookieSeason = 2009 if Player == "Edwin Williams" & Season == 2011 & Team == "Chicago Bears" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Edwin Williams" & Season == 2012 & Team == "Chicago Bears" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Elliott Henigan" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Elliott Henigan" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2013 if Player == "Emeka Onyenekwu" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2013 if Player == "Emeka Onyenekwu" & Season == 2014 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Emmanuel Stephens" & Season == 2011 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Emmanuel Stephens" & Season == 2012 & Team == "Cleveland Browns" & Status == "injured"
quietly replace RookieSeason = 2008 if Player == "Eric Bakhtiari" & Season == 2012 & Team == "San Francisco 49ers" & Status == "active"
quietly replace RookieSeason = 2008 if Player == "Eric Bakhtiari" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Eric Greenwood" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Eric Greenwood" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Erik Clanton" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Erik Clanton" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Eron Riley" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2011 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2012 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2013 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2014 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2015 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2016 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2017 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Evan Smith" & Season == 2018 & Team == "Tampa Bay Buccaneers" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "George Bryan" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "George Bryan" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Graig Cooper" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Greg Gatson" & Season == 2012 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Greg Gatson" & Season == 2013 & Team == "Carolina Panthers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Hayworth Hicks" & Season == 2012 & Team == "Carolina Panthers" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Hayworth Hicks" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Ian Johnson" & Season == 2011 & Team == "San Francisco 49ers" & Status == "active"
quietly replace RookieSeason = 2014 if Player == "Ike Ariguzo" & Season == 2014 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Isa Abdul-Quddus" & Season == 2011 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Isa Abdul-Quddus" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Isa Abdul-Quddus" & Season == 2013 & Team == "New Orleans Saints" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Isa Abdul-Quddus" & Season == 2014 & Team == "Detroit Lions" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Isa Abdul-Quddus" & Season == 2015 & Team == "Detroit Lions" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Isa Abdul-Quddus" & Season == 2016 & Team == "Miami Dolphins" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Isa Abdul-Quddus" & Season == 2017 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Isaac Madison" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Isaac Madison" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "J.C. Oram" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "J.C. Oram" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "J.K. Schaffer" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "J.K. Schaffer" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "J.K. Schaffer" & Season == 2014 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jake Kirkpatrick" & Season == 2012 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Jake Vermiglio" & Season == 2011 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Jake Vermiglio" & Season == 2012 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace RookieSeason = 2024 if Player == "Jalen Sundell" & Season == 2024 & Team == "Seattle Seahawks" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "James Kirkendoll" & Season == 2011 & Team == "Tennessee Titans" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "James Kirkendoll" & Season == 2012 & Team == "Tennessee Titans" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "James Rodgers" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "James Rodgers" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Jamie Cumbie" & Season == 2012 & Team == "Las Vegas Raiders" & Status == "injured"
quietly replace RookieSeason = 2010 if Player == "Jamie McCoy" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Janzen Jackson" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Janzen Jackson" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jared Karstetter" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jared Karstetter" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jarrell Root" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jarrell Root" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Jay Ross" & Season == 2012 & Team == "Buffalo Bills" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Jay Ross" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Jay Ross" & Season == 2013 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jaymes Brooks" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jaymes Brooks" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2013 if Player == "Jeff Olson" & Season == 2013 & Team == "Dallas Cowboys" & Status == "injured"
quietly replace RookieSeason = 2013 if Player == "Jeremy Wright" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jerico Nelson" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Jesse Somsel" & Season == 2015 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Joe Holland" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Joe Holland" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Joe Long" & Season == 2013 & Team == "Chicago Bears" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Joe Long" & Season == 2013 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Joe Martinek" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2006 if Player == "John Chick" & Season == 2011 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2006 if Player == "John Chick" & Season == 2012 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "John Clay" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "John Clay" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "John Cullen" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "John Gill" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "John Griffin" & Season == 2012 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "John Griffin" & Season == 2013 & Team == "New York Jets" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Johnny Jones" & Season == 2012 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Johsua Nesbitt" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jojo Nicolas" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Jojo Nicolas" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2007 if Player == "Jon Corto" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2003 if Player == "Jordan Black" & Season == 2012 & Team == "Washington Commanders" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Jordan Ford" & Season == 2013 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Jordan Miller" & Season == 2012 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Jordan Miller" & Season == 2013 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Jordan Miller" & Season == 2013 & Team == "Jacksonville Jaguars" & Status == "practice-squad"
quietly replace RookieSeason = 2011 if Player == "Jordan Miller" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "practice-squad"
quietly replace RookieSeason = 2013 if Player == "Jose Maltos" & Season == 2013 & Team == "New Orleans Saints" & Status == "dead"
quietly replace RookieSeason = 2013 if Player == "Jose Maltos" & Season == 2014 & Team == "New Orleans Saints" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Josh Brent" & Season == 2011 & Team == "Dallas Cowboys" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Josh Brent" & Season == 2012 & Team == "Dallas Cowboys" & Status == "exempt"
quietly replace RookieSeason = 2010 if Player == "Josh Brent" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Josh Brent" & Season == 2014 & Team == "Dallas Cowboys" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Josh Harrison" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Josh Harrison" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2015 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2015 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2015 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2016 & Team == "Atlanta Falcons" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2016 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2016 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2017 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2017 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2017 & Team == "Los Angeles Chargers" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2018 & Team == "Houston Texans" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2018 & Team == "Houston Texans" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Josh Keyes" & Season == 2018 & Team == "Washington Commanders" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Josh Samuda" & Season == 2012 & Team == "Miami Dolphins" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Josh Samuda" & Season == 2014 & Team == "Minnesota Vikings" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Julian Posey" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Julian Posey" & Season == 2012 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Julian Posey" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Julian Posey" & Season == 2013 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Julian Posey" & Season == 2013 & Team == "Cleveland Browns" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Justin Cheadle" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Justin Cheadle" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Justin Cheadle" & Season == 2013 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Justin Cheadle" & Season == 2014 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Justin Francis" & Season == 2012 & Team == "New England Patriots" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Justin Francis" & Season == 2013 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Justin Francis" & Season == 2014 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Justin Taplin-Ross" & Season == 2012 & Team == "Dallas Cowboys" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Justin Worley" & Season == 2015 & Team == "Chicago Bears" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Kameron Jackson" & Season == 2014 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Kameron Jackson" & Season == 2015 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Kareem Huggins" & Season == 2013 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2016 if Player == "Keith Marshall" & Season == 2016 & Team == "Washington Commanders" & Status == "injured"
quietly replace RookieSeason = 2016 if Player == "Keith Marshall" & Season == 2017 & Team == "Washington Commanders" & Status == "injured"
quietly replace RookieSeason = 2016 if Player == "Keith Marshall" & Season == 2018 & Team == "Washington Commanders" & Status == "dead"
quietly replace RookieSeason = 2016 if Player == "Keith Marshall" & Season == 2019 & Team == "Washington Commanders" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Kendric Burney" & Season == 2011 & Team == "Los Angeles Rams" & Status == "practice-squad"
quietly replace RookieSeason = 2012 if Player == "Kevin Elliott" & Season == 2012 & Team == "Buffalo Bills" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Kevin Elliott" & Season == 2012 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Kevin Elliott" & Season == 2013 & Team == "Buffalo Bills" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Kevin Malast" & Season == 2011 & Team == "Tennessee Titans" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Kevin Malast" & Season == 2012 & Team == "Tennessee Titans" & Status == "injured"
quietly replace RookieSeason = 2014 if Player == "Kevin Perry" & Season == 2014 & Team == "Washington Commanders" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Kevyn Scott" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Kevyn Scott" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Kregg Lumpkin" & Season == 2012 & Team == "New York Giants" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Kyle Adams" & Season == 2011 & Team == "Chicago Bears" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Kyle Adams" & Season == 2012 & Team == "Chicago Bears" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Kyle Adams" & Season == 2013 & Team == "Chicago Bears" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Kyle Adams" & Season == 2013 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2003 if Player == "Kyle Boller" & Season == 2011 & Team == "Las Vegas Raiders" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Kyle Hix" & Season == 2011 & Team == "New England Patriots" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Kyle Hix" & Season == 2012 & Team == "New England Patriots" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Kyle Hix" & Season == 2013 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Kyle McCarthy" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Lamark Brown" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Levi Horn" & Season == 2011 & Team == "Chicago Bears" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Lionel Smith" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Lionel Smith" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2007 if Player == "Logan Payne" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2024 if Player == "Lorenzo Lingard" & Season == 2024 & Team == "Jacksonville Jaguars" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Lucas Patterson" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Malcolm Sheppard" & Season == 2011 & Team == "Tennessee Titans" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Mana Silva" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mana Silva" & Season == 2011 & Team == "Baltimore Ravens" & Status == "practice-squad"
quietly replace RookieSeason = 2011 if Player == "Mana Silva" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mana Silva" & Season == 2012 & Team == "Buffalo Bills" & Status == "active"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2014 & Team == "Jacksonville Jaguars" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2014 & Team == "Jacksonville Jaguars" & Status == "practice-squad"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2015 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2015 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2015 & Team == "Jacksonville Jaguars" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2015 & Team == "Washington Commanders" & Status == "active"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2016 & Team == "Chicago Bears" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Marcel Jensen" & Season == 2016 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mario Butler" & Season == 2011 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mario Butler" & Season == 2011 & Team == "Dallas Cowboys" & Status == "practice-squad"
quietly replace RookieSeason = 2011 if Player == "Mario Butler" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mario Butler" & Season == 2014 & Team == "Buffalo Bills" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Mario Butler" & Season == 2015 & Team == "Buffalo Bills" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Mario Kurn" & Season == 2012 & Team == "Las Vegas Raiders" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Mario Kurn" & Season == 2013 & Team == "Las Vegas Raiders" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Mario Kurn" & Season == 2014 & Team == "Las Vegas Raiders" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mark Dell" & Season == 2011 & Team == "Denver Broncos" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Marshay Green" & Season == 2011 & Team == "Arizona Cardinals" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Marshay Green" & Season == 2012 & Team == "Arizona Cardinals" & Status == "active"
quietly replace RookieSeason = 2018 if Player == "Martinas Rankin" & Season == 2018 & Team == "Houston Texans" & Status == "active"
quietly replace RookieSeason = 2018 if Player == "Martinas Rankin" & Season == 2019 & Team == "Houston Texans" & Status == "dead"
quietly replace RookieSeason = 2018 if Player == "Martinas Rankin" & Season == 2019 & Team == "Kansas City Chiefs" & Status == "injured"
quietly replace RookieSeason = 2018 if Player == "Martinas Rankin" & Season == 2020 & Team == "Houston Texans" & Status == "dead"
quietly replace RookieSeason = 2018 if Player == "Martinas Rankin" & Season == 2020 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Marty Markett" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Marty Markett" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Matt Broha" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Matt Broha" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Matt Camilli" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Matt Camilli" & Season == 2013 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Matt Hansen" & Season == 2012 & Team == "Atlanta Falcons" & Status == "active"
quietly replace RookieSeason = 2019 if Player == "Matt Kaskey" & Season == 2019 & Team == "Carolina Panthers" & Status == "active"
quietly replace RookieSeason = 2019 if Player == "Matt Kaskey" & Season == 2019 & Team == "Carolina Panthers" & Status == "dead"
quietly replace RookieSeason = 2019 if Player == "Matt Kaskey" & Season == 2020 & Team == "Carolina Panthers" & Status == "active"
quietly replace RookieSeason = 2019 if Player == "Matt Kaskey" & Season == 2020 & Team == "Carolina Panthers" & Status == "dead"
quietly replace RookieSeason = 2019 if Player == "Matt Kaskey" & Season == 2021 & Team == "Carolina Panthers" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Matt Kopa" & Season == 2011 & Team == "Miami Dolphins" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Matt Kopa" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Matt Kopa" & Season == 2013 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Matt Kopa" & Season == 2014 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Matthias Berning" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Maurice Fountain" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Max Gruder" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Max Gruder" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Michael Cosgrove" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Michael Cosgrove" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Miguel Chavis" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Miguel Chavis" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mike Berry" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mike Berry" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Mike Hartline" & Season == 2012 & Team == "New England Patriots" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Mike Holmes" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Mike McCabe" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Mike McCabe" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Monte Simmons" & Season == 2011 & Team == "San Francisco 49ers" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Mortty Ivy" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Nate Eachus" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Nate Eachus" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Nate Hughes" & Season == 2011 & Team == "Detroit Lions" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Nate Menkin" & Season == 2012 & Team == "Houston Texans" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Nate Menkin" & Season == 2014 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2007 if Player == "Nevin McCaskill" & Season == 2011 & Team == "Washington Commanders" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Nic Cooper" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Nic Cooper" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Nick Hixon" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Nick Miller" & Season == 2011 & Team == "Las Vegas Raiders" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Nick Pieschel" & Season == 2012 & Team == "Chicago Bears" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Niles Brinkley" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Niles Brinkley" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Nnadmi Obukwelu" & Season == 2014 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Nnamdi Onukwelu" & Season == 2014 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Pat Boyle" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Pat Boyle" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Patrick Butrym" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Patrick Butrym" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Patrick Trahan" & Season == 2012 & Team == "Chicago Bears" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Phillip Livas" & Season == 2011 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Phillip Livas" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Prince Miller" & Season == 2012 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Quan Cosby" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Quan Cosby" & Season == 2012 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Quentin Saulsberry" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Quinn Barham" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Quinn Barham" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2015 if Player == "Randall Telfer" & Season == 2015 & Team == "Cleveland Browns" & Status == "reserve-pup"
quietly replace RookieSeason = 2015 if Player == "Randall Telfer" & Season == 2016 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Randall Telfer" & Season == 2017 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2015 if Player == "Randall Telfer" & Season == 2018 & Team == "Cleveland Browns" & Status == "dead"
quietly replace RookieSeason = 1999 if Player == "Randy Thomas" & Season == 2011 & Team == "Washington Commanders" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Rashawn Jackson" & Season == 2012 & Team == "Las Vegas Raiders" & Status == "active"
quietly replace RookieSeason = 2005 if Player == "Ray Willis" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Reshard Langford" & Season == 2011 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Ricardo Silva" & Season == 2011 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Ricardo Silva" & Season == 2012 & Team == "Detroit Lions" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Ricardo Silva" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Rich Ranglin" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Richard Dickson" & Season == 2011 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2010 if Player == "Richard Dickson" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Richard Murphy" & Season == 2011 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Richard Murphy" & Season == 2012 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2012 & Team == "Seattle Seahawks" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "practice-squad"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2014 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2014 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2014 & Team == "New York Giants" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2014 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Rishaw Johnson" & Season == 2014 & Team == "Washington Commanders" & Status == "active"
quietly replace RookieSeason = 2010 if Player == "Rob Callaway" & Season == 2012 & Team == "Dallas Cowboys" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Rob Myers" & Season == 2012 & Team == "Washington Commanders" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Robbie Frey" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Robbie Frey" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Robert Eddins" & Season == 2011 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2007 if Player == "Robert Turner" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2007 if Player == "Robert Turner" & Season == 2012 & Team == "Los Angeles Rams" & Status == "active"
quietly replace RookieSeason = 2007 if Player == "Robert Turner" & Season == 2013 & Team == "Tennessee Titans" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Rodney Austin" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Rodney Austin" & Season == 2013 & Team == "Detroit Lions" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Rodney Austin" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Rodney Austin" & Season == 2014 & Team == "Detroit Lions" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Rodney Austin" & Season == 2014 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Rodney Bradley" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Rodney Bradley" & Season == 2011 & Team == "Baltimore Ravens" & Status == "practice-squad"
quietly replace RookieSeason = 2011 if Player == "Rodney Bradley" & Season == 2012 & Team == "Baltimore Ravens" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Rodney Bradley" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2009 if Player == "Roger Allen" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Ronnie Cameron" & Season == 2012 & Team == "Cleveland Browns" & Status == "active"
quietly replace RookieSeason = 2012 if Player == "Ronnie Sneed" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Ronnie Sneed" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Royce Pollard" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Ryan Bartholomew" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Ryan Bartholomew" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Ryan Coulson" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Ryan Coulson" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Ryan Rau" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace RookieSeason = 2013 if Player == "Saeed Lee" & Season == 2013 & Team == "Atlanta Falcons" & Status == "injured"
quietly replace RookieSeason = 2003 if Player == "Scott Kooistra" & Season == 2011 & Team == "Minnesota Vikings" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Scott Lutrus" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Scott Lutrus" & Season == 2011 & Team == "Los Angeles Rams" & Status == "practice-squad"
quietly replace RookieSeason = 2011 if Player == "Scott Lutrus" & Season == 2012 & Team == "Indianapolis Colts" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Scott Lutrus" & Season == 2013 & Team == "Indianapolis Colts" & Status == "injured"
quietly replace RookieSeason = 2017 if Player == "Sean Culkin" & Season == 2017 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace RookieSeason = 2017 if Player == "Sean Culkin" & Season == 2018 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace RookieSeason = 2017 if Player == "Sean Culkin" & Season == 2019 & Team == "Los Angeles Chargers" & Status == "injured"
quietly replace RookieSeason = 2017 if Player == "Sean Culkin" & Season == 2020 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Shaky Smithson" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Shaky Smithson" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Shelly Lyons" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Shelly Lyons" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2013 if Player == "Skyler Allen" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Stephfon Green" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Stephfon Green" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2004 if Player == "Steve Baggs" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2001 if Player == "T.J. Houshmandzadeh" & Season == 2011 & Team == "Seattle Seahawks" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Taveon Rogers" & Season == 2012 & Team == "Cincinnati Bengals" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Taveon Rogers" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Taveon Rogers" & Season == 2014 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Taylor Dever" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Taylor Dever" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Taylor Gentry" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Terence Brown" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Terrance Moore" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Terrance Moore" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Terrence McCrae" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Terrence McCrae" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Thomas Williams" & Season == 2011 & Team == "Carolina Panthers" & Status == "active"
quietly replace RookieSeason = 2021 if Player == "Tommy Doyle" & Season == 2021 & Team == "Buffalo Bills" & Status == "active"
quietly replace RookieSeason = 2021 if Player == "Tommy Doyle" & Season == 2022 & Team == "Buffalo Bills" & Status == "injured"
quietly replace RookieSeason = 2021 if Player == "Tommy Doyle" & Season == 2023 & Team == "Buffalo Bills" & Status == "injured"
quietly replace RookieSeason = 2021 if Player == "Tommy Doyle" & Season == 2024 & Team == "Buffalo Bills" & Status == "reserve-pup"
quietly replace RookieSeason = 2011 if Player == "Tracy Wilson" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Tracy Wilson" & Season == 2012 & Team == "Tennessee Titans" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Travis Baltz" & Season == 2012 & Team == "New York Jets" & Status == "active"
quietly replace RookieSeason = 2014 if Player == "Travis Partridge" & Season == 2014 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2014 if Player == "Travis Partridge" & Season == 2015 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Trenton Hughes" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Trevis Turner" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Trevor Vittatoe" & Season == 2012 & Team == "Indianapolis Colts" & Status == "active"
quietly replace RookieSeason = 2009 if Player == "Tristan Davis" & Season == 2012 & Team == "Washington Commanders" & Status == "injured"
quietly replace RookieSeason = 2012 if Player == "Troy Burrell" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Troy Burrell" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Ty Boyle" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Ty Boyle" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Tydreke Powell" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Tyler Nielsen" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Tyrone Novikoff" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Tyrone Novikoff" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace RookieSeason = 2012 if Player == "Tysyn Hartman" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Vai Taua" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Vaughn Charlton" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Vaughn Charlton" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Vernon Gholston" & Season == 2011 & Team == "Chicago Bears" & Status == "dead"
quietly replace RookieSeason = 2008 if Player == "Vernon Gholston" & Season == 2011 & Team == "New York Jets" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Victor Aiyewa" & Season == 2013 & Team == "Green Bay Packers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Victor Aiyewa" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace RookieSeason = 2011 if Player == "Vidal Hazelton" & Season == 2013 & Team == "New York Jets" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Wes Lyons" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace RookieSeason = 2011 if Player == "Zach Hurd" & Season == 2012 & Team == "Las Vegas Raiders" & Status == "injured"
quietly replace RookieSeason = 2011 if Player == "Zane Taylor" & Season == 2012 & Team == "New York Jets" & Status == "dead"

* Fix Rookie for players with missing RookieSeason (Rookie originally equals 0; see "2 Season Corrections.xlsx")
quietly replace Rookie = 1 if Player == "Aaron Bates" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Aaron Bates" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Aaron Lavarias" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Abasi Salimu" & Season == 2014 & Team == "Los Angeles Rams" & Status == "dead"
quietly replace Rookie = 1 if Player == "Abasi Salimu" & Season == 2015 & Team == "Los Angeles Rams" & Status == "dead"
quietly replace Rookie = 1 if Player == "Adam Mims" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Adam Mims" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Adam Nissley" & Season == 2012 & Team == "Atlanta Falcons" & Status == "injured"
quietly replace Rookie = 1 if Player == "Adam Nissley" & Season == 2013 & Team == "Atlanta Falcons" & Status == "injured"
quietly replace Rookie = 1 if Player == "Adam Nissley" & Season == 2014 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Adrian Davis" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace Rookie = 1 if Player == "Adrian Davis" & Season == 2013 & Team == "New Orleans Saints" & Status == "injured"
quietly replace Rookie = 1 if Player == "Adrian Davis" & Season == 2014 & Team == "New Orleans Saints" & Status == "injured"
quietly replace Rookie = 1 if Player == "Adrian Moten" & Season == 2011 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace Rookie = 1 if Player == "Adrian Moten" & Season == 2011 & Team == "Seattle Seahawks" & Status == "active"
quietly replace Rookie = 1 if Player == "Adrian Moten" & Season == 2012 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace Rookie = 1 if Player == "Alex Albright" & Season == 2011 & Team == "Dallas Cowboys" & Status == "active"
quietly replace Rookie = 1 if Player == "Alex Albright" & Season == 2012 & Team == "Dallas Cowboys" & Status == "active"
quietly replace Rookie = 1 if Player == "Alex Albright" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Alex Silvestro" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Alex Silvestro" & Season == 2011 & Team == "New England Patriots" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Alex Silvestro" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Andre Smith" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace Rookie = 1 if Player == "Andrew Rich" & Season == 2011 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Andrew Rich" & Season == 2012 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Andrew Szczerba" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Andrew Szczerba" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Anthony Gray" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Anthony Gray" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Anthony Mosley" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Anthony Mosley" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Anthony Rashad White" & Season == 2013 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Armand Robinson" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Armand Robinson" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Armond Smith" & Season == 2011 & Team == "Cleveland Browns" & Status == "active"
quietly replace Rookie = 1 if Player == "Aston Whiteside" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Aston Whiteside" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Austin Wells" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Austin Wells" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "B.J. Thompson" & Season == 2023 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace Rookie = 1 if Player == "B.J. Thompson" & Season == 2024 & Team == "Kansas City Chiefs" & Status == "reserve-pup"
quietly replace Rookie = 1 if Player == "Ben Bass" & Season == 2012 & Team == "Dallas Cowboys" & Status == "injured"
quietly replace Rookie = 1 if Player == "Ben Bass" & Season == 2013 & Team == "Dallas Cowboys" & Status == "injured"
quietly replace Rookie = 1 if Player == "Ben Bass" & Season == 2014 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ben Bass" & Season == 2014 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Benjamin Braden" & Season == 2017 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Benjamin Braden" & Season == 2018 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Benjamin Braden" & Season == 2019 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Blake DeChristopher" & Season == 2012 & Team == "Arizona Cardinals" & Status == "injured"
quietly replace Rookie = 1 if Player == "Brad Thorson" & Season == 2011 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Bradley Vierling" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brandon Joiner" & Season == 2012 & Team == "Cincinnati Bengals" & Status == "active"
quietly replace Rookie = 1 if Player == "Brandon Joiner" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "injured"
quietly replace Rookie = 1 if Player == "Brandon Kinnie" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brandon Kinnie" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brandon McCray" & Season == 2014 & Team == "New Orleans Saints" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brandon Saine" & Season == 2011 & Team == "Green Bay Packers" & Status == "active"
quietly replace Rookie = 1 if Player == "Brandon Saine" & Season == 2011 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brandon Saine" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brandon Saine" & Season == 2012 & Team == "Green Bay Packers" & Status == "injured"
quietly replace Rookie = 1 if Player == "Brenden Rice" & Season == 2024 & Team == "Los Angeles Chargers" & Status == "injured"
quietly replace Rookie = 1 if Player == "Brett Greenwood" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brett Greenwood" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brett Hartmann" & Season == 2011 & Team == "Houston Texans" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brett Hartmann" & Season == 2011 & Team == "Houston Texans" & Status == "injured"
quietly replace Rookie = 1 if Player == "Brett Hartmann" & Season == 2012 & Team == "Houston Texans" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brett Roy" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brett Roy" & Season == 2013 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brian Smith" & Season == 2011 & Team == "Cleveland Browns" & Status == "dead"
quietly replace Rookie = 1 if Player == "Brian Smith" & Season == 2012 & Team == "Cleveland Browns" & Status == "dead"
quietly replace Rookie = 1 if Player == "Bruce Figgins" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Bryan Mattison" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Byron Landor" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Caleb King" & Season == 2011 & Team == "Minnesota Vikings" & Status == "active"
quietly replace Rookie = 1 if Player == "Caleb King" & Season == 2011 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Caleb King" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cam Holland" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cam Holland" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cameron Bell" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cameron Bell" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cameron Fuller" & Season == 2014 & Team == "San Francisco 49ers" & Status == "active"
quietly replace Rookie = 1 if Player == "Cameron Fuller" & Season == 2014 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Carmen Messina" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Carmen Messina" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chad Faulcon" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chase Baker" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chase Baker" & Season == 2012 & Team == "Minnesota Vikings" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Chase Baker" & Season == 2013 & Team == "Minnesota Vikings" & Status == "active"
quietly replace Rookie = 1 if Player == "Chase Baker" & Season == 2013 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chase Beeler" & Season == 2011 & Team == "San Francisco 49ers" & Status == "active"
quietly replace Rookie = 1 if Player == "Chase Beeler" & Season == 2011 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chase Beeler" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chase Minnifield" & Season == 2012 & Team == "Washington Commanders" & Status == "injured"
quietly replace Rookie = 1 if Player == "Chase Minnifield" & Season == 2013 & Team == "Washington Commanders" & Status == "active"
quietly replace Rookie = 1 if Player == "Chase Minnifield" & Season == 2013 & Team == "Washington Commanders" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chase Minnifield" & Season == 2014 & Team == "Washington Commanders" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chase Minnifield" & Season == 2014 & Team == "Washington Commanders" & Status == "injured"
quietly replace Rookie = 1 if Player == "Chastin West" & Season == 2011 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chip Vaughn" & Season == 2011 & Team == "New Orleans Saints" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chris Boyd" & Season == 2014 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chris Boyd" & Season == 2014 & Team == "Dallas Cowboys" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Chris Boyd" & Season == 2015 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chris Dieker" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chris Dieker" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chris Givens" & Season == 2012 & Team == "New Orleans Saints" & Status == "injured"
quietly replace Rookie = 1 if Player == "Chris Givens" & Season == 2013 & Team == "New Orleans Saints" & Status == "active"
quietly replace Rookie = 1 if Player == "Chris Givens" & Season == 2014 & Team == "New Orleans Saints" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chris Riley" & Season == 2011 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Chris Riley" & Season == 2012 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Clay Nurse" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Clay Nurse" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cliff Harris" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cliff Harris" & Season == 2013 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace Rookie = 1 if Player == "Cody Johnson" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Colin Baxter" & Season == 2012 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace Rookie = 1 if Player == "Colin Cochart" & Season == 2011 & Team == "Cleveland Browns" & Status == "active"
quietly replace Rookie = 1 if Player == "Corey Paredes" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Corey Woods" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Corey Woods" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Courtney Smith" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Craig Bills" & Season == 2015 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace Rookie = 1 if Player == "D'Andre Goodwin" & Season == 2011 & Team == "Denver Broncos" & Status == "active"
quietly replace Rookie = 1 if Player == "D'Anton Lynn" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "D'Anton Lynn" & Season == 2013 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "D.J. Harper" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "D.J. Harper" & Season == 2014 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Damik Scafe" & Season == 2012 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace Rookie = 1 if Player == "Dannell Ellerbe" & Season == 2017 & Team == "New Orleans Saints" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dannell Ellerbe" & Season == 2017 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace Rookie = 1 if Player == "Danny Noble" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "injured"
quietly replace Rookie = 1 if Player == "Danny Noble" & Season == 2013 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace Rookie = 1 if Player == "Danny Noble" & Season == 2013 & Team == "Jacksonville Jaguars" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Danny Noble" & Season == 2013 & Team == "Tampa Bay Buccaneers" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Darrell Scott" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Darrell Scott" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Darryl Gamble" & Season == 2011 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace Rookie = 1 if Player == "Darvin Adams" & Season == 2011 & Team == "Carolina Panthers" & Status == "active"
quietly replace Rookie = 1 if Player == "Darwin Cook" & Season == 2014 & Team == "Cleveland Browns" & Status == "dead"
quietly replace Rookie = 1 if Player == "Darwin Cook" & Season == 2015 & Team == "Cleveland Browns" & Status == "dead"
quietly replace Rookie = 1 if Player == "David Douglas" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "David Douglas" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace Rookie = 1 if Player == "David Douglas" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "David Gonzales" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "David Snow" & Season == 2012 & Team == "Buffalo Bills" & Status == "active"
quietly replace Rookie = 1 if Player == "David Snow" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace Rookie = 1 if Player == "David Snow" & Season == 2013 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "David Snow" & Season == 2014 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dawson Zimmerman" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dawson Zimmerman" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Derek Chard" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Derek Chard" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Derek Hall" & Season == 2011 & Team == "San Francisco 49ers" & Status == "active"
quietly replace Rookie = 1 if Player == "Derrick Jones" & Season == 2011 & Team == "Las Vegas Raiders" & Status == "active"
quietly replace Rookie = 1 if Player == "Desmond Morrow" & Season == 2012 & Team == "Houston Texans" & Status == "dead"
quietly replace Rookie = 1 if Player == "Desmond Morrow" & Season == 2013 & Team == "Houston Texans" & Status == "dead"
quietly replace Rookie = 1 if Player == "Devin Goda" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Devin Goda" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Devin Holland" & Season == 2011 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace Rookie = 1 if Player == "Devin Holland" & Season == 2012 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dexter Heyman" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace Rookie = 1 if Player == "Dexter Heyman" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dominique Curry" & Season == 2011 & Team == "Los Angeles Rams" & Status == "active"
quietly replace Rookie = 1 if Player == "Dorian Graham" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dorian Graham" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dustin Waldron" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Dustin Waldron" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Elliott Henigan" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Elliott Henigan" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Emeka Onyenekwu" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Emeka Onyenekwu" & Season == 2014 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Eric Greenwood" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Eric Greenwood" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Erik Clanton" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Erik Clanton" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Evan Smith" & Season == 2011 & Team == "Green Bay Packers" & Status == "active"
quietly replace Rookie = 1 if Player == "Evan Smith" & Season == 2012 & Team == "Green Bay Packers" & Status == "active"
quietly replace Rookie = 1 if Player == "George Bryan" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "George Bryan" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Greg Gatson" & Season == 2012 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace Rookie = 1 if Player == "Hayworth Hicks" & Season == 2012 & Team == "Carolina Panthers" & Status == "active"
quietly replace Rookie = 1 if Player == "Hayworth Hicks" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace Rookie = 1 if Player == "Ike Ariguzo" & Season == 2014 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Isa Abdul-Quddus" & Season == 2011 & Team == "New Orleans Saints" & Status == "active"
quietly replace Rookie = 1 if Player == "Isa Abdul-Quddus" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace Rookie = 1 if Player == "Isa Abdul-Quddus" & Season == 2013 & Team == "New Orleans Saints" & Status == "dead"
quietly replace Rookie = 1 if Player == "Isaac Madison" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Isaac Madison" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "J.C. Oram" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "J.C. Oram" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jake Kirkpatrick" & Season == 2012 & Team == "Indianapolis Colts" & Status == "active"
quietly replace Rookie = 1 if Player == "Jake Vermiglio" & Season == 2011 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jake Vermiglio" & Season == 2012 & Team == "Arizona Cardinals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jalen Sundell" & Season == 2024 & Team == "Seattle Seahawks" & Status == "active"
quietly replace Rookie = 1 if Player == "James Kirkendoll" & Season == 2011 & Team == "Tennessee Titans" & Status == "active"
quietly replace Rookie = 1 if Player == "James Kirkendoll" & Season == 2012 & Team == "Tennessee Titans" & Status == "dead"
quietly replace Rookie = 1 if Player == "James Rodgers" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "James Rodgers" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Janzen Jackson" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "Janzen Jackson" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jared Karstetter" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jared Karstetter" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jarrell Root" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jarrell Root" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jaymes Brooks" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jaymes Brooks" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jeff Olson" & Season == 2013 & Team == "Dallas Cowboys" & Status == "injured"
quietly replace Rookie = 1 if Player == "Jeremy Wright" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jerico Nelson" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace Rookie = 1 if Player == "Jesse Somsel" & Season == 2015 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Joe Holland" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Joe Holland" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Joe Martinek" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "John Clay" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "John Clay" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "John Cullen" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Johsua Nesbitt" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jojo Nicolas" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jojo Nicolas" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jordan Ford" & Season == 2013 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jose Maltos" & Season == 2013 & Team == "New Orleans Saints" & Status == "dead"
quietly replace Rookie = 1 if Player == "Jose Maltos" & Season == 2014 & Team == "New Orleans Saints" & Status == "dead"
quietly replace Rookie = 1 if Player == "Josh Brent" & Season == 2011 & Team == "Dallas Cowboys" & Status == "active"
quietly replace Rookie = 1 if Player == "Josh Brent" & Season == 2012 & Team == "Dallas Cowboys" & Status == "exempt"
quietly replace Rookie = 1 if Player == "Josh Brent" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Josh Harrison" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Josh Harrison" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Josh Keyes" & Season == 2015 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Josh Keyes" & Season == 2015 & Team == "Tampa Bay Buccaneers" & Status == "active"
quietly replace Rookie = 1 if Player == "Josh Keyes" & Season == 2015 & Team == "Tampa Bay Buccaneers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Josh Samuda" & Season == 2012 & Team == "Miami Dolphins" & Status == "active"
quietly replace Rookie = 1 if Player == "Julian Posey" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace Rookie = 1 if Player == "Julian Posey" & Season == 2012 & Team == "New York Jets" & Status == "active"
quietly replace Rookie = 1 if Player == "Julian Posey" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Justin Cheadle" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Justin Cheadle" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Justin Francis" & Season == 2012 & Team == "New England Patriots" & Status == "active"
quietly replace Rookie = 1 if Player == "Justin Francis" & Season == 2013 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Justin Francis" & Season == 2014 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Justin Taplin-Ross" & Season == 2012 & Team == "Dallas Cowboys" & Status == "active"
quietly replace Rookie = 1 if Player == "Justin Worley" & Season == 2015 & Team == "Chicago Bears" & Status == "dead"
quietly replace Rookie = 1 if Player == "Kameron Jackson" & Season == 2014 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace Rookie = 1 if Player == "Kameron Jackson" & Season == 2015 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace Rookie = 1 if Player == "Keith Marshall" & Season == 2016 & Team == "Washington Commanders" & Status == "injured"
quietly replace Rookie = 1 if Player == "Keith Marshall" & Season == 2017 & Team == "Washington Commanders" & Status == "injured"
quietly replace Rookie = 1 if Player == "Keith Marshall" & Season == 2018 & Team == "Washington Commanders" & Status == "dead"
quietly replace Rookie = 1 if Player == "Keith Marshall" & Season == 2019 & Team == "Washington Commanders" & Status == "dead"
quietly replace Rookie = 1 if Player == "Kendric Burney" & Season == 2011 & Team == "Los Angeles Rams" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Kevin Elliott" & Season == 2012 & Team == "Buffalo Bills" & Status == "active"
quietly replace Rookie = 1 if Player == "Kevin Elliott" & Season == 2012 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace Rookie = 1 if Player == "Kevin Perry" & Season == 2014 & Team == "Washington Commanders" & Status == "dead"
quietly replace Rookie = 1 if Player == "Kevyn Scott" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Kevyn Scott" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Kyle Adams" & Season == 2011 & Team == "Chicago Bears" & Status == "active"
quietly replace Rookie = 1 if Player == "Kyle Adams" & Season == 2012 & Team == "Chicago Bears" & Status == "active"
quietly replace Rookie = 1 if Player == "Kyle Adams" & Season == 2013 & Team == "Chicago Bears" & Status == "dead"
quietly replace Rookie = 1 if Player == "Kyle Hix" & Season == 2011 & Team == "New England Patriots" & Status == "active"
quietly replace Rookie = 1 if Player == "Kyle Hix" & Season == 2012 & Team == "New England Patriots" & Status == "injured"
quietly replace Rookie = 1 if Player == "Kyle Hix" & Season == 2013 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Lamark Brown" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace Rookie = 1 if Player == "Levi Horn" & Season == 2011 & Team == "Chicago Bears" & Status == "active"
quietly replace Rookie = 1 if Player == "Lionel Smith" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Lionel Smith" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Lorenzo Lingard" & Season == 2024 & Team == "Jacksonville Jaguars" & Status == "dead"
quietly replace Rookie = 1 if Player == "Lucas Patterson" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mana Silva" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mana Silva" & Season == 2011 & Team == "Baltimore Ravens" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Mana Silva" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Marcel Jensen" & Season == 2014 & Team == "Jacksonville Jaguars" & Status == "dead"
quietly replace Rookie = 1 if Player == "Marcel Jensen" & Season == 2014 & Team == "Jacksonville Jaguars" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Marcel Jensen" & Season == 2015 & Team == "Jacksonville Jaguars" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mario Butler" & Season == 2011 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mario Butler" & Season == 2011 & Team == "Dallas Cowboys" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Mario Butler" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mario Kurn" & Season == 2012 & Team == "Las Vegas Raiders" & Status == "injured"
quietly replace Rookie = 1 if Player == "Mario Kurn" & Season == 2013 & Team == "Las Vegas Raiders" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mario Kurn" & Season == 2014 & Team == "Las Vegas Raiders" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mark Dell" & Season == 2011 & Team == "Denver Broncos" & Status == "active"
quietly replace Rookie = 1 if Player == "Marshay Green" & Season == 2011 & Team == "Arizona Cardinals" & Status == "active"
quietly replace Rookie = 1 if Player == "Marshay Green" & Season == 2012 & Team == "Arizona Cardinals" & Status == "active"
quietly replace Rookie = 1 if Player == "Martinas Rankin" & Season == 2018 & Team == "Houston Texans" & Status == "active"
quietly replace Rookie = 1 if Player == "Martinas Rankin" & Season == 2019 & Team == "Houston Texans" & Status == "dead"
quietly replace Rookie = 1 if Player == "Martinas Rankin" & Season == 2019 & Team == "Kansas City Chiefs" & Status == "injured"
quietly replace Rookie = 1 if Player == "Martinas Rankin" & Season == 2020 & Team == "Houston Texans" & Status == "dead"
quietly replace Rookie = 1 if Player == "Martinas Rankin" & Season == 2020 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace Rookie = 1 if Player == "Marty Markett" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Marty Markett" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Matt Broha" & Season == 2012 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "Matt Broha" & Season == 2013 & Team == "New York Giants" & Status == "dead"
quietly replace Rookie = 1 if Player == "Matt Camilli" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace Rookie = 1 if Player == "Matt Camilli" & Season == 2013 & Team == "Philadelphia Eagles" & Status == "dead"
quietly replace Rookie = 1 if Player == "Matt Hansen" & Season == 2012 & Team == "Atlanta Falcons" & Status == "active"
quietly replace Rookie = 1 if Player == "Matt Kaskey" & Season == 2019 & Team == "Carolina Panthers" & Status == "active"
quietly replace Rookie = 1 if Player == "Matt Kaskey" & Season == 2019 & Team == "Carolina Panthers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Matthias Berning" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Max Gruder" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Max Gruder" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Michael Cosgrove" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Michael Cosgrove" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Miguel Chavis" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Miguel Chavis" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mike Berry" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mike Berry" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mike Holmes" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace Rookie = 1 if Player == "Mike McCabe" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Mike McCabe" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Monte Simmons" & Season == 2011 & Team == "San Francisco 49ers" & Status == "active"
quietly replace Rookie = 1 if Player == "Nate Eachus" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace Rookie = 1 if Player == "Nate Eachus" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Nate Menkin" & Season == 2012 & Team == "Houston Texans" & Status == "active"
quietly replace Rookie = 1 if Player == "Nic Cooper" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Nic Cooper" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Nick Hixon" & Season == 2012 & Team == "New Orleans Saints" & Status == "active"
quietly replace Rookie = 1 if Player == "Nick Miller" & Season == 2011 & Team == "Las Vegas Raiders" & Status == "active"
quietly replace Rookie = 1 if Player == "Nick Pieschel" & Season == 2012 & Team == "Chicago Bears" & Status == "injured"
quietly replace Rookie = 1 if Player == "Niles Brinkley" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Niles Brinkley" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Nnadmi Obukwelu" & Season == 2014 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace Rookie = 1 if Player == "Nnamdi Onukwelu" & Season == 2014 & Team == "Indianapolis Colts" & Status == "dead"
quietly replace Rookie = 1 if Player == "Pat Boyle" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Pat Boyle" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Patrick Butrym" & Season == 2012 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Patrick Butrym" & Season == 2013 & Team == "San Francisco 49ers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Patrick Trahan" & Season == 2012 & Team == "Chicago Bears" & Status == "injured"
quietly replace Rookie = 1 if Player == "Phillip Livas" & Season == 2011 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Phillip Livas" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Quentin Saulsberry" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Quinn Barham" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Quinn Barham" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Randall Telfer" & Season == 2015 & Team == "Cleveland Browns" & Status == "reserve-pup"
quietly replace Rookie = 1 if Player == "Randall Telfer" & Season == 2016 & Team == "Cleveland Browns" & Status == "active"
quietly replace Rookie = 1 if Player == "Randall Telfer" & Season == 2017 & Team == "Cleveland Browns" & Status == "active"
quietly replace Rookie = 1 if Player == "Randall Telfer" & Season == 2018 & Team == "Cleveland Browns" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ricardo Silva" & Season == 2011 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ricardo Silva" & Season == 2012 & Team == "Detroit Lions" & Status == "active"
quietly replace Rookie = 1 if Player == "Ricardo Silva" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Rich Ranglin" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace Rookie = 1 if Player == "Richard Dickson" & Season == 2011 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Richard Dickson" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Richard Murphy" & Season == 2011 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace Rookie = 1 if Player == "Richard Murphy" & Season == 2012 & Team == "Jacksonville Jaguars" & Status == "active"
quietly replace Rookie = 1 if Player == "Rishaw Johnson" & Season == 2012 & Team == "Seattle Seahawks" & Status == "active"
quietly replace Rookie = 1 if Player == "Robbie Frey" & Season == 2012 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Robbie Frey" & Season == 2013 & Team == "Atlanta Falcons" & Status == "dead"
quietly replace Rookie = 1 if Player == "Robert Eddins" & Season == 2011 & Team == "Buffalo Bills" & Status == "dead"
quietly replace Rookie = 1 if Player == "Rodney Austin" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Rodney Austin" & Season == 2013 & Team == "Detroit Lions" & Status == "active"
quietly replace Rookie = 1 if Player == "Rodney Austin" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Rodney Austin" & Season == 2014 & Team == "Detroit Lions" & Status == "active"
quietly replace Rookie = 1 if Player == "Rodney Austin" & Season == 2014 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Rodney Bradley" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Rodney Bradley" & Season == 2011 & Team == "Baltimore Ravens" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Rodney Bradley" & Season == 2012 & Team == "Baltimore Ravens" & Status == "active"
quietly replace Rookie = 1 if Player == "Rodney Bradley" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ronnie Cameron" & Season == 2012 & Team == "Cleveland Browns" & Status == "active"
quietly replace Rookie = 1 if Player == "Ronnie Sneed" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ronnie Sneed" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Royce Pollard" & Season == 2012 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ryan Bartholomew" & Season == 2011 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ryan Bartholomew" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ryan Coulson" & Season == 2011 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ryan Coulson" & Season == 2012 & Team == "New England Patriots" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ryan Rau" & Season == 2012 & Team == "Philadelphia Eagles" & Status == "active"
quietly replace Rookie = 1 if Player == "Saeed Lee" & Season == 2013 & Team == "Atlanta Falcons" & Status == "injured"
quietly replace Rookie = 1 if Player == "Scott Lutrus" & Season == 2011 & Team == "Indianapolis Colts" & Status == "active"
quietly replace Rookie = 1 if Player == "Scott Lutrus" & Season == 2011 & Team == "Los Angeles Rams" & Status == "practice-squad"
quietly replace Rookie = 1 if Player == "Scott Lutrus" & Season == 2012 & Team == "Indianapolis Colts" & Status == "injured"
quietly replace Rookie = 1 if Player == "Scott Lutrus" & Season == 2013 & Team == "Indianapolis Colts" & Status == "injured"
quietly replace Rookie = 1 if Player == "Sean Culkin" & Season == 2017 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace Rookie = 1 if Player == "Sean Culkin" & Season == 2018 & Team == "Los Angeles Chargers" & Status == "active"
quietly replace Rookie = 1 if Player == "Sean Culkin" & Season == 2019 & Team == "Los Angeles Chargers" & Status == "injured"
quietly replace Rookie = 1 if Player == "Shaky Smithson" & Season == 2012 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Shaky Smithson" & Season == 2013 & Team == "Green Bay Packers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Shelly Lyons" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Shelly Lyons" & Season == 2013 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Skyler Allen" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Stephfon Green" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Stephfon Green" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Taveon Rogers" & Season == 2012 & Team == "Cincinnati Bengals" & Status == "injured"
quietly replace Rookie = 1 if Player == "Taveon Rogers" & Season == 2013 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Taveon Rogers" & Season == 2014 & Team == "Cincinnati Bengals" & Status == "dead"
quietly replace Rookie = 1 if Player == "Taylor Dever" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Taylor Dever" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Taylor Gentry" & Season == 2013 & Team == "Kansas City Chiefs" & Status == "dead"
quietly replace Rookie = 1 if Player == "Terence Brown" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Terrance Moore" & Season == 2012 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Terrance Moore" & Season == 2013 & Team == "Baltimore Ravens" & Status == "dead"
quietly replace Rookie = 1 if Player == "Terrence McCrae" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Terrence McCrae" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Tommy Doyle" & Season == 2021 & Team == "Buffalo Bills" & Status == "active"
quietly replace Rookie = 1 if Player == "Tommy Doyle" & Season == 2022 & Team == "Buffalo Bills" & Status == "injured"
quietly replace Rookie = 1 if Player == "Tommy Doyle" & Season == 2023 & Team == "Buffalo Bills" & Status == "injured"
quietly replace Rookie = 1 if Player == "Tommy Doyle" & Season == 2024 & Team == "Buffalo Bills" & Status == "reserve-pup"
quietly replace Rookie = 1 if Player == "Tracy Wilson" & Season == 2011 & Team == "New York Jets" & Status == "active"
quietly replace Rookie = 1 if Player == "Travis Partridge" & Season == 2014 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Travis Partridge" & Season == 2015 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Trenton Hughes" & Season == 2012 & Team == "Miami Dolphins" & Status == "dead"
quietly replace Rookie = 1 if Player == "Trevis Turner" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Trevor Vittatoe" & Season == 2012 & Team == "Indianapolis Colts" & Status == "active"
quietly replace Rookie = 1 if Player == "Troy Burrell" & Season == 2012 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Troy Burrell" & Season == 2013 & Team == "Detroit Lions" & Status == "dead"
quietly replace Rookie = 1 if Player == "Ty Boyle" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Ty Boyle" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Tydreke Powell" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Tyler Nielsen" & Season == 2012 & Team == "Minnesota Vikings" & Status == "dead"
quietly replace Rookie = 1 if Player == "Tyrone Novikoff" & Season == 2012 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Tyrone Novikoff" & Season == 2013 & Team == "Dallas Cowboys" & Status == "dead"
quietly replace Rookie = 1 if Player == "Tysyn Hartman" & Season == 2012 & Team == "Kansas City Chiefs" & Status == "active"
quietly replace Rookie = 1 if Player == "Vai Taua" & Season == 2012 & Team == "Buffalo Bills" & Status == "dead"
quietly replace Rookie = 1 if Player == "Vaughn Charlton" & Season == 2011 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Vaughn Charlton" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "dead"
quietly replace Rookie = 1 if Player == "Vernon Gholston" & Season == 2011 & Team == "New York Jets" & Status == "dead"
quietly replace Rookie = 1 if Player == "Wes Lyons" & Season == 2012 & Team == "Pittsburgh Steelers" & Status == "active"
quietly replace Rookie = 1 if Player == "Zane Taylor" & Season == 2012 & Team == "New York Jets" & Status == "dead"

* Fix RookieSeason for players with RookieSeason > Season (see "2 Season Corrections.xlsx")
quietly replace RookieSeason = 2010 if Player == "A.J. Jefferson" & RookieSeason == 2013
quietly replace RookieSeason = 2001 if Player == "Adrian Wilson" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "William Powell" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Kerry Taylor" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Tommy Gallarda" & RookieSeason == 2012
quietly replace RookieSeason = 2012 if Player == "Phillip Manley" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Marcus Jackson" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Pat Schiller" & RookieSeason == 2014
quietly replace RookieSeason = 2010 if Player == "Terrence Johnson" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Tyler Horn" & RookieSeason == 2013
quietly replace RookieSeason = 2009 if Player == "Danny Gorrer" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "LaQuan Williams" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Bryan Hall" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Damien Berry" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Michael McAdoo" & RookieSeason == 2016
quietly replace RookieSeason = 2012 if Player == "Adrian Hamilton" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Howard Barbieri" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Omar Brown" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Chyl Quarles" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Jack Cornell" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Nick Jean-Baptiste" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Nick Provo" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Nigel Carr" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "T.J. Heath" & RookieSeason == 2013
quietly replace RookieSeason = 2013 if Player == "Vernon Kearney" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Zack Pianalto" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Bryant Browning" & RookieSeason == 2014
quietly replace RookieSeason = 2009 if Player == "Josh Vaughan" & RookieSeason == 2013
quietly replace RookieSeason = 2010 if Player == "Kion Wilson" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Thomas Keiser" & RookieSeason == 2013
quietly replace RookieSeason = 2009 if Player == "C.J. Davis" & RookieSeason == 2012
quietly replace RookieSeason = 1991 if Player == "John Kasay" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Anthony Walters" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Dom DeCicco" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Cory Brandon" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Joseph Anderson" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Dane Sanzenbacher" & RookieSeason == 2014
quietly replace RookieSeason = 2008 if Player == "Chris Williams" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Sean Cattouse" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Tracy Robertson" & RookieSeason == 2014
quietly replace RookieSeason = 2009 if Player == "Chris Pressley" & RookieSeason == 2012
quietly replace RookieSeason = 2010 if Player == "Jeromy Miles" & RookieSeason == 2012
quietly replace RookieSeason = 2010 if Player == "Andrew Mitchell" & RookieSeason == 2012
quietly replace RookieSeason = 2012 if Player == "Tony Dye" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Bryce Davis" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Quinton Spears" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Jarrod Shaw" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Dominic Alford" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Josh Cooper" & RookieSeason == 2014
quietly replace RookieSeason = 2014 if Player == "Anthony Dima" & RookieSeason == 2015
quietly replace RookieSeason = 2011 if Player == "Kevin Kowalski" & RookieSeason == 2014
quietly replace RookieSeason = 2009 if Player == "Kevin Ogletree" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Phillip Tanner" & RookieSeason == 2014
quietly replace RookieSeason = 2010 if Player == "Lonyae Miller" & RookieSeason == 2013
quietly replace RookieSeason = 2013 if Player == "Taylor Reed" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Donavon Kemp" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Davin Meggett" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Jamar Newsome" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Ray Dominguez" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "D'Andre Goodwin" & RookieSeason == 2013
quietly replace RookieSeason = 2008 if Player == "Lance Ball" & RookieSeason == 2013
quietly replace RookieSeason = 2009 if Player == "Lee Robinson" & RookieSeason == 2013
quietly replace RookieSeason = 2007 if Player == "Matt Willis" & RookieSeason == 2012
quietly replace RookieSeason = 2009 if Player == "Ashlee Palmer" & RookieSeason == 2012
quietly replace RookieSeason = 2010 if Player == "Jimmy Saddler-McQueen" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Alex Gottlieb" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Derek Dimke" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Edmon McClam" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Patrick Edwards" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Martell Webb" & RookieSeason == 2014
quietly replace RookieSeason = 2013 if Player == "Michael Brooks" & RookieSeason == 2014
quietly replace RookieSeason = 2015 if Player == "Kendrick Ings" & RookieSeason == 2016
quietly replace RookieSeason = 2011 if Player == "M.D. Jennings" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Vic So'oto" & RookieSeason == 2013
quietly replace RookieSeason = 2015 if Player == "Jamel Johnson" & RookieSeason == 2016
quietly replace RookieSeason = 2011 if Player == "Lestar Jean" & RookieSeason == 2014
quietly replace RookieSeason = 2006 if Player == "Mike Brisiel" & RookieSeason == 2012
quietly replace RookieSeason = 2010 if Player == "Steve Maneri" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Cameron Collins" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Phillip Supernaw" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "David Hunter" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Logan Brock" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Josh Victorian" & RookieSeason == 2014
quietly replace RookieSeason = 2015 if Player == "J.J. Worton" & RookieSeason == 2016
quietly replace RookieSeason = 2011 if Player == "Joe Lefeged" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Ryan Mahaffey" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Kris Adams" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Mike McNeill" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Griff Whalen" & RookieSeason == 2016
quietly replace RookieSeason = 2007 if Player == "Justin Hickman" & RookieSeason == 2014
quietly replace RookieSeason = 2007 if Player == "Griff Whalen" & RookieSeason == 2016
quietly replace RookieSeason = 2012 if Player == "Jeff Demps" & RookieSeason == 2015
quietly replace RookieSeason = 2009 if Player == "Brock Bolen" & RookieSeason == 2013
quietly replace RookieSeason = 2009 if Player == "Colin Cloherty" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Kevin Rutland" & RookieSeason == 2012
quietly replace RookieSeason = 2009 if Player == "Russell Allen" & RookieSeason == 2012
quietly replace RookieSeason = 2009 if Player == "Zach Potter" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Jerrell Jackson" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Matt Veldman" & RookieSeason == 2013
quietly replace RookieSeason = 2013 if Player == "Jordan Rodgers" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Kyle Knox" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Brandon Barden" & RookieSeason == 2014
quietly replace RookieSeason = 2019 if Player == "Brandon Rusnak" & RookieSeason == 2021
quietly replace RookieSeason = 2010 if Player == "Jeremy Horne" & RookieSeason == 2013
quietly replace RookieSeason = 2010 if Player == "Justin Cole" & RookieSeason == 2013
quietly replace RookieSeason = 2007 if Player == "Jackie Battle" & RookieSeason == 2012
quietly replace RookieSeason = 2012 if Player == "Sean McGrath" & RookieSeason == 2015
quietly replace RookieSeason = 2013 if Player == "Ridge Wilson" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Chandler Burden" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Corbin Louks" & RookieSeason == 2015
quietly replace RookieSeason = 2011 if Player == "Willie Smith" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Jason Foster" & RookieSeason == 2014
quietly replace RookieSeason = 2014 if Player == "Erle Ladson" & RookieSeason == 2015
quietly replace RookieSeason = 2016 if Player == "Jimmy Bean" & RookieSeason == 2017
quietly replace RookieSeason = 2008 if Player == "Brandyn Dombrowski" & RookieSeason == 2012
quietly replace RookieSeason = 2009 if Player == "Curtis Brinkley" & RookieSeason == 2013
quietly replace RookieSeason = 2010 if Player == "Richard Goodman" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Michael Willie" & RookieSeason == 2014
quietly replace RookieSeason = 2014 if Player == "Brelan Chancellor" & RookieSeason == 2015
quietly replace RookieSeason = 2009 if Player == "Brit Miller" & RookieSeason == 2012
quietly replace RookieSeason = 2010 if Player == "Keith Toston" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Ben Guidugli" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Mason Brodine" & RookieSeason == 2014
quietly replace RookieSeason = 2010 if Player == "Jeron Mastrud" & RookieSeason == 2013
quietly replace RookieSeason = 2009 if Player == "Ray Feinga" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Garrett Chisolm" & RookieSeason == 2013
quietly replace RookieSeason = 2010 if Player == "Jonathon Amaya" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Isaako Aaitui" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Jeff Fuller" & RookieSeason == 2016
quietly replace RookieSeason = 2012 if Player == "Derek Dennis" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Derek Moye" & RookieSeason == 2013
quietly replace RookieSeason = 2013 if Player == "Ina Liaina" & RookieSeason == 2014
quietly replace RookieSeason = 2013 if Player == "Tristan Okpalaugo" & RookieSeason == 2014
quietly replace RookieSeason = 2010 if Player == "Marcus Sherels" & RookieSeason == 2014
quietly replace RookieSeason = 2009 if Player == "Patrick Brown" & RookieSeason == 2012
quietly replace RookieSeason = 2012 if Player == "Kamar Jorden" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Bobby Felder" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Kevin Murphy" & RookieSeason == 2013
quietly replace RookieSeason = 2010 if Player == "Thomas Austin" & RookieSeason == 2012
quietly replace RookieSeason = 2009 if Player == "Eric Kettani" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Chyl Quarles" & RookieSeason == 2013
quietly replace RookieSeason = 2013 if Player == "Patrick Ford" & RookieSeason == 2014
quietly replace RookieSeason = 2020 if Player == "Michael Barnett" & RookieSeason == 2021
quietly replace RookieSeason = 2008 if Player == "Jed Collins" & RookieSeason == 2014
quietly replace RookieSeason = 2008 if Player == "Brian De La Puente" & RookieSeason == 2013
quietly replace RookieSeason = 2009 if Player == "Bruce Johnson" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Martin Parker" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Adewale Ojomo" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Martin Parker" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Stephen Goodin" & RookieSeason == 2014
quietly replace RookieSeason = 2006 if Player == "Garrett McIntyre" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Josh Baker" & RookieSeason == 2014
quietly replace RookieSeason = 2009 if Player == "Matt Kroul" & RookieSeason == 2012
quietly replace RookieSeason = 2009 if Player == "T.J. Conley" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "DeMarco Cosby" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Royce Adams" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "D'Anton Lynn" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Davon Morgan" & RookieSeason == 2014
quietly replace RookieSeason = 2009 if Player == "Tom Nelson" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Colin Miller" & RookieSeason == 2012
quietly replace RookieSeason = 2012 if Player == "Adrian Robinson" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "David Gilreath" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Hebron Fangupo" & RookieSeason == 2014
quietly replace RookieSeason = 2015 if Player == "Shakim Phillips" & RookieSeason == 2016
quietly replace RookieSeason = 2011 if Player == "Joe Hastings" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Jewel Hampton" & RookieSeason == 2014
quietly replace RookieSeason = 2012 if Player == "Al Netter" & RookieSeason == 2014
quietly replace RookieSeason = 2013 if Player == "Tyrone Walker" & RookieSeason == 2014
quietly replace RookieSeason = 2013 if Player == "Zach Allen" & RookieSeason == 2014
quietly replace RookieSeason = 2013 if Player == "Mike Taylor" & RookieSeason == 2014
quietly replace RookieSeason = 2011 if Player == "Mossis Madu" & RookieSeason == 2013
quietly replace RookieSeason = 2011 if Player == "Armando Allen" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Michael VanDerMeulen" & RookieSeason == 2012
quietly replace RookieSeason = 2011 if Player == "Jake Rogers" & RookieSeason == 2013
quietly replace RookieSeason = 2012 if Player == "Bobby Felder" & RookieSeason == 2014
quietly replace RookieSeason = 2014 if Player == "Varmah Sonie" & RookieSeason == 2015
quietly replace RookieSeason = 2008 if Player == "Fernando Velasco" & RookieSeason == 2012
quietly replace RookieSeason = 2009 if Player == "Pannel Egboh" & RookieSeason == 2013
quietly replace RookieSeason = 2009 if Player == "Domonique Johnson" & RookieSeason == 2013
quietly replace RookieSeason = 2015 if Player == "Derrick Mathews" & RookieSeason == 2016

* Fix Rookie for players with RookieSeason > Season (Rookie originally equals 1; see "2 Season Corrections.xlsx")
quietly replace Rookie = 0 if Player == "Adrian Wilson" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Danny Gorrer" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Howard Barbieri" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "T.J. Heath" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Bryant Browning" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Josh Vaughan" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Kion Wilson" & RookieSeason == 2014 & Season >= 2011
quietly replace Rookie = 0 if Player == "John Kasay" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Cory Brandon" & RookieSeason == 2014 & Season >= 2012
quietly replace Rookie = 0 if Player == "Chris Williams" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Sean Cattouse" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Tracy Robertson" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Chris Pressley" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Dane Sanzenbacher" & RookieSeason == 2014 & Season >= 2012
quietly replace Rookie = 0 if Player == "Davin Meggett" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Phillip Manley" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Ray Dominguez" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Michael McAdoo" & RookieSeason == 2016 & Season >= 2015
quietly replace Rookie = 0 if Player == "Lance Ball" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Lee Robinson" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Matt Willis" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Ashlee Palmer" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Jimmy Saddler-McQueen" & RookieSeason == 2014 & Season >= 2012
quietly replace Rookie = 0 if Player == "Martell Webb" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Mike Brisiel" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Josh Victorian" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Terrence Johnson" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Kris Adams" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Justin Hickman" & RookieSeason == 2014 & Season >= 2012
quietly replace Rookie = 0 if Player == "Griff Whalen" & RookieSeason == 2016 & Season >= 2013
quietly replace Rookie = 0 if Player == "Jeff Demps" & RookieSeason == 2015 & Season >= 2014
quietly replace Rookie = 0 if Player == "Colin Cloherty" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Zach Potter" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Kyle Knox" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Brandon Barden" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Jackie Battle" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Jamar Newsome" & RookieSeason == 2014 & Season >= 2012
quietly replace Rookie = 0 if Player == "Sean McGrath" & RookieSeason == 2015 & Season >= 2013
quietly replace Rookie = 0 if Player == "Chandler Burden" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Corbin Louks" & RookieSeason == 2015 & Season >= 2014
quietly replace Rookie = 0 if Player == "Lonyae Miller" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Vic So'oto" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Willie Smith" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Jason Foster" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Brandyn Dombrowski" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Curtis Brinkley" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Richard Goodman" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Brit Miller" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Justin Cole" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Mike McNeill" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Mason Brodine" & RookieSeason == 2014 & Season >= 2012
quietly replace Rookie = 0 if Player == "Jeron Mastrud" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Ray Feinga" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Patrick Brown" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "Kerry Taylor" & RookieSeason == 2014 & Season >= 2011
quietly replace Rookie = 0 if Player == "A.J. Jefferson" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Marcus Sherels" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Steve Maneri" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "Thomas Austin" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "LaQuan Williams" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Jed Collins" & RookieSeason == 2014 & Season >= 2011
quietly replace Rookie = 0 if Player == "Brian De La Puente" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Stephen Goodin" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Garrett McIntyre" & RookieSeason == 2014 & Season >= 2011
quietly replace Rookie = 0 if Player == "Matt Kroul" & RookieSeason == 2012 & Season >= 2011
quietly replace Rookie = 0 if Player == "T.J. Conley" & RookieSeason == 2013 & Season >= 2011
quietly replace Rookie = 0 if Player == "DeMarco Cosby" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Tom Nelson" & RookieSeason == 2014 & Season >= 2011
quietly replace Rookie = 0 if Player == "David Gilreath" & RookieSeason == 2014 & Season >= 2012
quietly replace Rookie = 0 if Player == "Hebron Fangupo" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Jake Rogers" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Bobby Felder" & RookieSeason == 2014 & Season >= 2013
quietly replace Rookie = 0 if Player == "Pannel Egboh" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Domonique Johnson" & RookieSeason == 2013 & Season >= 2012
quietly replace Rookie = 0 if Player == "Eric Kettani" & RookieSeason == 2014 & Season >= 2012

* For consistency, fix RookieSeason and Rookie for players who are missing in Cap data for other Team-Season combinations (see "2 Season Corrections.xlsx")
quietly replace RookieSeason = 2011 if Player == "Armando Allen"
quietly replace RookieSeason = 2006 if Player == "Brandon Rusnak"
quietly replace RookieSeason = 2004 if Player == "Brian De La Puente"
quietly replace RookieSeason = 2010 if Player == "Brian Sanford"
quietly replace RookieSeason = 2008 if Player == "Brian Schaefering"
quietly replace RookieSeason = 2008 if Player == "Chad Spann"
quietly replace RookieSeason = 2011 if Player == "Colin Cloherty"
quietly replace RookieSeason = 2011 if Player == "Dane Sanzenbacher"
quietly replace RookieSeason = 2008 if Player == "Emanuel Cook"
quietly replace RookieSeason = 2011 if Player == "Evan Moore"
quietly replace RookieSeason = 2008 if Player == "Hebron Fangupo"
quietly replace RookieSeason = 2011 if Player == "Jamar Newsome"
quietly replace RookieSeason = 2011 if Player == "Josh Victorian"
quietly replace RookieSeason = 2005 if Player == "Justin Bannan"
quietly replace RookieSeason = 2009 if Player == "Kenny Onatolu"
quietly replace RookieSeason = 2007 if Player == "Kyle DeVan"
quietly replace RookieSeason = 2004 if Player == "Lousaka Polite"
quietly replace RookieSeason = 2002 if Player == "Mark LeVoir"
quietly replace RookieSeason = 2009 if Player == "Marquice Cole"
quietly replace RookieSeason = 2010 if Player == "Mason Brodine"
quietly replace RookieSeason = 2008 if Player == "Matt Katula"
quietly replace RookieSeason = 2009 if Player == "Micheal Spurlock"
quietly replace RookieSeason = 2010 if Player == "Mike McNeill"
quietly replace RookieSeason = 2006 if Player == "Mike Rivera"
quietly replace RookieSeason = 2006 if Player == "Nate Livings"
quietly replace RookieSeason = 2010 if Player == "Patrick Trahan"
quietly replace RookieSeason = 2019 if Player == "Steve Maneri"
quietly replace RookieSeason = 2011 if Player == "T.J. Heath"
quietly replace RookieSeason = 2009 if Player == "Thomas Austin"

quietly replace Rookie = 0 if Player == "Brian De La Puente" | Player == "Brian Schaefering" | Player == "Chad Spann" | Player == "Colin Cloherty" | Player == "Emanuel Cook" | Player == "Evan Moore" | Player == "Hebron Fangpuo" | Player == "Jamar Newsome" | Player == "Josh Victorian" | Player == "Justin Bannan" | Player == "Kenny Onatolu" | Player == "Kyle DeVan" | Player == "Lousaka Polite" | Player == "Mason Brodine" | Player == "Matt Katula" | Player == "Mike Rivera" | Player == "Steve Maneri" | Player == "T.J. Heath"
quietly replace Rookie = 0 if Player == "Patrick Trahan" & Team == "Chicago Bears"
quietly replace Rookie = 0 if Player == "Thomas Austin" & Team == "New England Patriots"
quietly replace Rookie = 0 if Player == "Dane Sanzenbacher" & Team == "Cincinnati Bengals" & (Season == 2012 | Season == 2013 | Season == 2014)
quietly replace Rookie = 0 if Player == "Mike McNeill" & Team == "Los Angeles Rams" & (Season == 2012 | Season == 2013)
*/
* Make sure RookieSeason <= Season (Vernon Kearney, Taylor Reed, and Michael VanDerMeulen), and Rookie = 1 if RookieSeason = Season
replace RookieSeason = Season if RookieSeason > Season
replace Rookie = 1 if RookieSeason == Season

* Distinguish between two different players with same name
replace Player = "Greg Jones RB" if Player == "Greg Jones" & Team == "Jacksonville Jaguars" & Season == 2012 & Pos == "FB"
replace Player = "Greg Jones MLB" if Player == "Greg Jones" & Team == "Jacksonville Jaguars" & Season == 2012 & Pos == "ILB"
replace Player = "T.J. Carter CB" if Player == "T.J. Carter" & Team == "Los Angeles Rams" & Season == 2022 & Pos == "CB"
replace Player = "T.J. Carter DE" if Player == "T.J. Carter" & Team == "Los Angeles Rams" & Season == 2022 & Pos == "DT"
rename Pos PosCap
label variable PosCap "PosCap"

if `DIDFlag' == 1 {
	duplicates drop Team Season Player CapHit, force
	quietly recol, full
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 8 Cap Tables.dta", replace
}

else {
	* Add CapHit across duplicates for Team Season Player before dropping duplicates
	egen long TotalCapHit = total(CapHit), by(Team Season Player)
	label variable TotalCapHit "Total Cap Hit"
	order TotalCapHit, after(CapHit)
	duplicates drop Team Season Player, force

	quietly recol, full
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 8 Season Cap Clean.dta", replace
}