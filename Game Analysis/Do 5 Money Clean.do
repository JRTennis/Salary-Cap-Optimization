clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 9 Money.dta"

* Rename and label Season
rename Year Season
label variable Season "Season"

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

* Clean Team variable
gen Index = _n
label variable Index "Index"
replace Team = "Atlanta Falcons"        if Team == "ATL"
replace Team = "Buffalo Bills"          if Team == "BUF"
replace Team = "Carolina Panthers"      if Team == "CAR"
replace Team = "Chicago Bears"          if Team == "CHI"
replace Team = "Cincinnati Bengals"     if Team == "CIN"
replace Team = "Cleveland Browns"       if Team == "CLE"
replace Team = "Indianapolis Colts"     if Team == "CLT"
replace Team = "Arizona Cardinals"      if Team == "CRD"
replace Team = "Dallas Cowboys"         if Team == "DAL"
replace Team = "Denver Broncos"         if Team == "DEN"
replace Team = "Detroit Lions"          if Team == "DET"
replace Team = "Green Bay Packers"      if Team == "GNB"
replace Team = "Houston Texans"         if Team == "HTX"
replace Team = "Jacksonville Jaguars"   if Team == "JAX"
replace Team = "Kansas City Chiefs"     if Team == "KAN"
replace Team = "Miami Dolphins"         if Team == "MIA"
replace Team = "Minnesota Vikings"      if Team == "MIN"
replace Team = "New Orleans Saints"     if Team == "NOR"
replace Team = "New England Patriots"   if Team == "NWE"
replace Team = "New York Giants"        if Team == "NYG"
replace Team = "New York Jets"          if Team == "NYJ"
replace Team = "Tennessee Titans"       if Team == "OTI"
replace Team = "Philadelphia Eagles"    if Team == "PHI"
replace Team = "Pittsburgh Steelers"    if Team == "PIT"
replace Team = "Las Vegas Raiders"      if Team == "RAI"
replace Team = "Los Angeles Rams"       if Team == "RAM"
replace Team = "Baltimore Ravens"       if Team == "RAV"
replace Team = "Los Angeles Chargers"   if Team == "SDG"
replace Team = "Seattle Seahawks"       if Team == "SEA"
replace Team = "San Francisco 49ers"    if Team == "SFO"
replace Team = "Tampa Bay Buccaneers"   if Team == "TAM"
replace Team = "Washington Commanders"  if Team == "WAS"
sort Team Season Player Index
order Index Player Team Season Age Pos Status, first

* Distinguish between two different players with same name
replace Player = "Charles Johnson DE" if Player == "Charles Johnson" & Team == "Carolina Panthers" & Season == 2017 & Pos == "DE"
replace Player = "Charles Johnson WR" if Player == "Charles Johnson" & Team == "Carolina Panthers" & Season == 2017 & Pos == "WR"
replace Player = "Greg Jones RB" if Player == "Greg Jones" & Team == "Jacksonville Jaguars" & Season == 2012 & Pos == "FB"
replace Player = "Greg Jones MLB" if Player == "Greg Jones" & Team == "Jacksonville Jaguars" & Season == 2012 & Pos == "ILB"
replace Player = "Jaylon Moore OL" if Player == "Jaylon Moore" & Team == "San Francisco 49ers" & Season == 2024 & Pos == "LT"

* Add CapHit across duplicates for Team Season Player before dropping duplicates
egen long TotalCapHit = total(CapHit), by(Team Season Player)
label variable TotalCapHit "Total Cap Hit"
order TotalCapHit, after(CapHit)
duplicates drop Team Season Player, force

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

save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 10 Money Clean.dta", replace