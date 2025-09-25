clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 1 Report.dta"

rename PLAYER Player
label variable Player Player
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
replace Season = Season + 2000
sort Team Season Player Index
order Index Player Team Season, first

*Distinguish between two different players with same name
replace Player = "Charles Johnson DE" if Player == "Charles Johnson" & Team == "Carolina Panthers" & Season == 2017 & Index == 1302
replace Player = "Charles Johnson WR" if Player == "Charles Johnson" & Team == "Carolina Panthers" & Season == 2017 & Index == 1303
replace Player = "Greg Jones RB" if Player == "Greg Jones" & Team == "Jacksonville Jaguars" & Season == 2012 & Index == 7877
replace Player = "Greg Jones MLB" if Player == "Greg Jones" & Team == "Jacksonville Jaguars" & Season == 2012 & Index == 7878
replace Player = "Jaylon Moore WR" if Player == "Jaylon Moore" & Team == "San Francisco 49ers" & Season == 2024 & Index == 17986
replace Player = "Jaylon Moore OL" if Player == "Jaylon Moore" & Team == "San Francisco 49ers" & Season == 2024 & Index == 17987

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

* Drop playoffs
drop GW18 GW19 GW20 GW21
replace GW17 = "" if Season < 2021
replace GW17 = GW16 if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")
replace GW16 = "" if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")

* Reshape long, and generate injury report dummy
reshape long GW, i(Player Team Season) j(GameNum)
gen Report = GW != ""
order Report, after(GW)
label variable Report Report
label variable GameNum GameNum
drop GW Index
sort Team Season Player GameNum
drop if Season < 2021 & GameNum == 17
drop if Season == 2022 & GameNum == 16 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")

save "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Game Analysis\Data 2 Report Clean.dta", replace