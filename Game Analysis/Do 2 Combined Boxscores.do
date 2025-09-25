clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 3 Boxscores.dta"

* Generate position groups
gen Group = .

replace Group = 1 if (Pos == "QB" | Pos == "QB/WR" | (Player == "Kendall Hinton" & GameID == "202011290DEN")) & (PassAtt != 0 | Sk != 0 | RushAtt != 0)

replace Group = 2 if (Pos == "C" | Pos == "C/LG" | Pos == "C/RG" | Pos == "DT/FB" | Pos == "FB" | Pos == "FB/DL" | Pos == "G" | Pos == "LG" | Pos == "LG/C" | Pos == "LG/LT" | Pos == "LG/RG" | Pos == "LG/RT" | Pos == "LT" | Pos == "LT/LG" | Pos == "LT/RT" | Pos == "OL" | Pos == "OT" | Pos == "PR" | Pos == "RB" | Pos == "RG" | Pos == "RG/C" | Pos == "RG/LG" | Pos == "RG/LT" | Pos == "RG/RT" | Pos == "RT" | Pos == "RT/LG" | Pos == "RT/LT" | Pos == "T" | Pos == "T-G" | Pos == "TE" | Pos == "TE/QB" | Pos == "TE/T" | Pos == "WR" | Pos == "WR/QB" | Pos == "QB" | Pos == "QB/WR") & Group != 1

replace Group = 3 if Pos == "CB" | Pos == "CB/SS" | Pos == "DB" | Pos == "DB/FS" | Pos == "DB/LCB" | Pos == "DE" | Pos == "DE/DT" | Pos == "DL" | Pos == "DT" | Pos == "DT/DE" | Pos == "DT/LB" | Pos == "FS" | Pos == "FS/RCB" | Pos == "FS/SS" | Pos == "KB" | Pos == "LB" | Pos == "LCB" | Pos == "LCB/DB" | Pos == "LCB/FS" | Pos == "LCB/RCB" | Pos == "LDE" | Pos == "LDE/LDT" | Pos == "LDE/NT" | Pos == "LDE/RDE" | Pos == "LDT" | Pos == "LDT/LDE" | Pos == "LDT/RDT" | Pos == "LILB" | Pos == "LILB/RILB" | Pos == "LLB" | Pos == "LLB/MLB" | Pos == "LLB/RLB" | Pos == "LOLB" | Pos == "LOLB/ROLB" | Pos == "MLB" | Pos == "MLB/RLB" | Pos == "NT" | Pos == "OLB" | Pos == "RCB" | Pos == "RCB/DB" | Pos == "RCB/FS" | Pos == "RCB/LCB" | Pos == "RCB/SS" | Pos == "RDE" | Pos == "RDE/LDE" | Pos == "RDE/LDT" | Pos == "RDE/LOLB" | Pos == "RDE/NT" | Pos == "RDT" | Pos == "RDT/LDE" | Pos == "RDT/LDT" | Pos == "RDT/RDE" | Pos == "RILB" | Pos == "RILB/LILB" | Pos == "RLB" | Pos == "RLB/LDE" | Pos == "RLB/LLB" | Pos == "RLB/MLB" | Pos == "ROLB" | Pos == "ROLB/LILB" | Pos == "ROLB/LOLB" | Pos == "ROLB/RILB" | Pos == "S" | Pos == "SS" | Pos == "SS/FS" | Pos == "SS/LCB" | Pos == "SS/RLB"

replace Group = 4 if Pos == "K" | Pos == "LS" | Pos == "P"

* FtyPts formula (https://help.yahoo.com/kb/SLN6489.html)
replace FtyPts = .5*PassCmp + .04*PassYds + 4*PassTD - PassInt + .1*RushYds + 6*RushTD + .5*ReceRec + .1*ReceYds + 6*ReceTD - 2*FumbFL + /// 
				2*DefInteInt + 6*DefInteTD + Sk + 2*FumbFR + 6*FumbTD + 6*KickRetuTD + 6*PuntRetuTD

* FantPt formula (https://support.nfl.com/hc/en-us/articles/35869730981140-Scoring)
gen FantPt = .
* QB: No data for 2-Point Conversion (Weight = 2)
replace FantPt = .04*PassYds + 4*PassTD - 2*PassInt + .1*RushYds + 6*RushTD - 2*FumbFL if Group == 1
* Offense (.5*PPR): No data for 2-Point Conversion (Weight = 2)
replace FantPt = .1*RushYds + 6*RushTD + .5*ReceRec + .1*ReceYds + 6*ReceTD + 6*KickRetuTD + 6*PuntRetuTD + 6*FumbTD - 2*FumbFL if Group == 2
* Defense: No data for Safety (Weight = 2), omit Points Allowed
replace FantPt = Sk + 2*DefInteInt + 2*FumbFR + 6*DefInteTD + 6*FumbTD + 6*KickRetuTD + 6*PuntRetuTD if Group == 3
* Special Teams: No data for FGM 50+ Yds (Weight = 5)
replace FantPt = ScorXPM + 3*ScorFGM if Group == 4

* Merge with NonQ4 QB stats
gen Index = _n
merge 1:1 GameID PlayID using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 4 NoQ4.dta"
replace SackYdsNoQ4 = abs(SackYdsNoQ4)
drop if _merge == 2
sort Index
drop _merge Index

* Generate date variable
format Date %td

* Keep relevant variables and rename them
keep GameID Team Season Date Venue Player PassCmp PassAtt PassYds PassTD PassInt PassSk SackYds PassLng PassRate RushAtt RushYds RushTD RushLng ReceTgt ReceRec ReceYds ReceTD ReceLng FumbFmb FumbFL Pos PassAttNoQ4 PassCmpNoQ4 PassTDNoQ4 PassIntNoQ4 PassYdsNoQ4 PassSkNoQ4 SackYdsNoQ4 RushAttNoQ4 RushYdsNoQ4 RushTDNoQ4 FumbFmbNoQ4 FumbFLNoQ4 Group FantPt

rename (PassCmp PassAtt PassYds PassTD PassInt PassSk SackYds PassLng PassRate RushAtt RushYds RushTD RushLng ReceTgt ReceRec ReceYds ReceTD ReceLng FumbFmb FumbFL PassAttNoQ4 PassCmpNoQ4 PassTDNoQ4 PassIntNoQ4 PassYdsNoQ4 PassSkNoQ4 SackYdsNoQ4 RushAttNoQ4 RushYdsNoQ4 RushTDNoQ4 FumbFmbNoQ4 FumbFLNoQ4) ///
(QBPassCmp QBPassAtt QBPassYds QBPassTD QBPassInt QBSk QBSkYds QBPassLng QBRate QBRushAtt QBRushYds QBRushTD QBRushLng QBTgt QBRec QBRecYds QBRecTD QBRecLng QBFmb QBFL QBPassAttNoQ4 QBPassCmpNoQ4 QBPassTDNoQ4 QBPassIntNoQ4 QBPassYdsNoQ4 QBSkNoQ4 QBSkYdsNoQ4 QBRushAttNoQ4 QBRushYdsNoQ4 QBRushTDNoQ4 QBFmbNoQ4 QBFLNoQ4)

* Drop duplicate observations for players who changed teams midseason
duplicates drop

* Generate temporary Game
gen TempGame = 1
replace TempGame = TempGame[_n-1] + (Venue != Venue[_n-1] | Date != Date[_n-1]) if _n > 1

* Update team and venue names
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

replace Venue = "Arizona Cardinals"     if Venue == "CRD"
replace Venue = "Atlanta Falcons"       if Venue == "ATL"
replace Venue = "Baltimore Ravens"      if Venue == "RAV"
replace Venue = "Buffalo Bills"         if Venue == "BUF"
replace Venue = "Carolina Panthers"     if Venue == "CAR"
replace Venue = "Chicago Bears"         if Venue == "CHI"
replace Venue = "Cincinnati Bengals"    if Venue == "CIN"
replace Venue = "Cleveland Browns"      if Venue == "CLE"
replace Venue = "Dallas Cowboys"        if Venue == "DAL"
replace Venue = "Denver Broncos"        if Venue == "DEN"
replace Venue = "Detroit Lions"         if Venue == "DET"
replace Venue = "Green Bay Packers"     if Venue == "GNB"
replace Venue = "Houston Texans"        if Venue == "HTX"
replace Venue = "Indianapolis Colts"    if Venue == "CLT"
replace Venue = "Jacksonville Jaguars"  if Venue == "JAX"
replace Venue = "Kansas City Chiefs"    if Venue == "KAN"
replace Venue = "Las Vegas Raiders"     if Venue == "RAI"
replace Venue = "Los Angeles Chargers"  if Venue == "SDG"
replace Venue = "Los Angeles Rams"      if Venue == "RAM"
replace Venue = "Miami Dolphins"        if Venue == "MIA"
replace Venue = "Minnesota Vikings"     if Venue == "MIN"
replace Venue = "New Orleans Saints"    if Venue == "NOR"
replace Venue = "New England Patriots"  if Venue == "NWE"
replace Venue = "New York Giants"       if Venue == "NYG"
replace Venue = "New York Jets"         if Venue == "NYJ"
replace Venue = "Philadelphia Eagles"   if Venue == "PHI"
replace Venue = "Pittsburgh Steelers"   if Venue == "PIT"
replace Venue = "Seattle Seahawks"      if Venue == "SEA"
replace Venue = "San Francisco 49ers"   if Venue == "SFO"
replace Venue = "Tampa Bay Buccaneers"  if Venue == "TAM"
replace Venue = "Tennessee Titans"      if Venue == "OTI"
replace Venue = "Washington Commanders" if Venue == "WAS"

* Top is away, bottom is HomeBox
gen HomeBox = .
replace HomeBox = 0 if Team != Venue
replace HomeBox = 1 if Team == Venue
label variable HomeBox "HomeBox"

* Generate opponent variable
preserve
keep TempGame Team
bysort TempGame Team: keep if _n == 1
rename Team Opp
tempfile teams
save `teams'
restore
joinby TempGame using `teams'
drop if Opp == Team

* Restructure dataset to game-level formatting
sort Team Season Date
expand 2
gen Change = 0
replace Change = 1 if _n > _N/2
gen Temp = Team
replace Team = Opp if _n >_N/2
replace Opp = Temp if _n > _N/2
drop Temp
gsort Team Season Date HomeBox -QBPassAtt -QBPassCmp

* Generate remaining necessary variables
gen TeamID = Team
label variable TeamID "TeamID"
replace Team = Opp if Change == 1
gen Game = 1
replace Game = Game[_n-1] + (TempGame != TempGame[_n-1]) if _n > 1
label variable Game "Game"
drop TempGame Change Date Venue Opp

* Generate OffNonQBFantPt and DefSTFantPt
egen TotalFantPt = total(FantPt), by (GameID Team Group)
replace TotalFantPt = TotalFantPt/2
gen OffNonQBTemp1 = TotalFantPt if Group == 2
gen DefSTTemp1 = TotalFantPt if Group == 3 | Group == 4

foreach x in OffNonQB DefST {
	egen `x'Temp2 = max(`x'Temp1), by(GameID Team)
	replace `x'Temp2 = 0 if Team != TeamID
	egen `x'FantPt = max(`x'Temp2), by(GameID Game)
	label variable `x'FantPt "`x'FantPt"
}
drop Group TotalFantPt OffNonQBTemp* DefSTTemp*
gen NonQBFantPt = OffNonQBFantPt + DefSTFantPt
label variable NonQBFantPt "NonQBFantPt"

* Generate GameNum variable (due to bye week, same Game can have 2 different GameNum)
local NObs = _N
gen GameNumTemp = 1
forvalues i = 2/`NObs' {
	quietly replace GameNumTemp in `i' = GameNumTemp[`i'-1] if Game[`i'] == Game[`i'-1]
 	quietly replace GameNumTemp in `i' = GameNumTemp[`i'-1] + 1 if Game[`i'] != Game[`i'-1] & Season[`i'] == Season[`i'-1]
	quietly replace GameNumTemp in `i' = 1 if Game[`i'] != Game[`i'-1] & Season[`i'] != Season[`i'-1]
}
replace GameNumTemp = 17 if GameNumTemp == 16 & Season == 2022 & (TeamID == "Buffalo Bills" | TeamID == "Cincinnati Bengals")
replace GameNumTemp = 0 if Team != TeamID
egen GameNum = max(GameNumTemp), by(GameID Team)
drop GameNumTemp

* Merge in injury report data
gen Index = _n
merge m:1 Team Season Player GameNum using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Game Analysis\Data 2 Report Clean.dta"
drop if _merge == 2
replace Report = 0 if _merge == 1
sort Index
drop GameNum Index _merge
order Report, after(Player)

* Drop players who are not quarterbacks, and replace missing NoQ4 with 0
keep if (Pos == "QB" | Pos == "QB/WR" | (Player == "Kendall Hinton" & GameID == "202011290DEN")) & (QBPassAtt != 0 | QBSk != 0 | QBRushAtt != 0)
drop Pos
foreach x in PassAtt PassCmp PassTD PassInt PassYds Sk SkYds RushAtt RushYds RushTD Fmb FL {
	replace QB`x'NoQ4 = 0 if QB`x'NoQ4 == .
}

order Game GameID Team TeamID Season HomeBox Player, first
format GameID %17s
quietly recol, full
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 15 Combined Boxscores.dta", replace