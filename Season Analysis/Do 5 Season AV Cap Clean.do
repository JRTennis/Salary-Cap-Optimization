clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 9 Season AV Cap.dta"

rename Rookie OldRookie
gen Rookie = "Rook"
replace Rookie = "Vet" if OldRookie == 0
label variable Rookie "Rookie"
order Rookie, after(OldRookie)
drop OldRookie

* Mulholland's positions
gen MulPos = ""
replace MulPos = "QB" if PosCap == "QB"
replace MulPos = "RB" if PosCap == "RB"
replace MulPos = "FB" if PosCap == "FB"
replace MulPos = "WR" if PosCap == "WR" | (PosCap == "KR" & Player == "Trindon Holliday")
replace MulPos = "TE" if PosCap == "TE" | (PosCap == "WLB" & Player == "Rodney Williams")
replace MulPos = "LT" if PosCap == "LT"
replace MulPos = "G" if PosCap == "G"
replace MulPos = "C" if PosCap == "C" | (PosCap == "OL" & Player == "Brenden Jaimes")
replace MulPos = "RT" if PosCap == "RT"
replace MulPos = "DE" if PosCap == "DE"
replace MulPos = "DT" if PosCap == "DT"
replace MulPos = "ILB" if PosCap == "ILB"
replace MulPos = "OLB" if PosCap == "OLB"
replace MulPos = "CB" if PosCap == "CB" | (PosCap == "KR" & Player == "Scotty McGee")
replace MulPos = "FS" if PosCap == "FS"
replace MulPos = "SS" if PosCap == "SS"
replace MulPos = "K" if PosCap == "K"
replace MulPos = "P" if PosCap == "P" | (PosCap == "PR" & Player == "Travis Baltz") | (PosCap == "KR" & Player == "Spencer Benton")
replace MulPos = "LS" if PosCap == "LS"

* These are not part of the 19 positions
replace MulPos = "T" if PosCap == "T" | (PosCap == "OL" & (Player == "Isaac Alarcon" | Player == "Teton Saltes"))
replace MulPos = "LB" if PosCap == "LB"
replace MulPos = "S" if PosCap == "S"

* For ambiguous Spotrac positions, use Pro Football Reference before splitting 50/50
replace MulPos = "LT" if MulPos == "T" & PosAV == "LT"
replace MulPos = "RT" if MulPos == "T" & PosAV == "RT"
replace MulPos = "ILB" if MulPos == "LB" & (PosAV == "LILB" | PosAV == "MLB" | PosAV == "RILB" | PosAV == "RILB/LILB")
replace MulPos = "OLB" if MulPos == "LB" & (PosAV == "LOLB" | PosAV == "OLB" | PosAV == "ROLB")
replace MulPos = "FS" if MulPos == "S" & PosAV == "FS"
replace MulPos = "SS" if MulPos == "S" & PosAV == "SS"

* Calculate Mulholland's positional AVs
foreach i in "Vet" "Rook" {
	foreach j in "QB" "RB" "FB" "WR" "TE" "G" "C" "DE" "DT" "CB" "K" "P" "LS" {
		quietly egen `i'`j'Temp = sum(AV) if MulPos == "`j'" & Rookie == "`i'", by(Season Team MulPos Rookie)
		quietly egen `i'`j'AV = mean(`i'`j'Temp), by(Season Team)
		quietly replace `i'`j'AV = 0 if `i'`j'AV == .
		quietly drop `i'`j'Temp
	}
}

foreach i in "Vet" "Rook" {
	quietly egen `i'LTTemp1 = sum(AV) if MulPos == "LT" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly egen `i'LTTemp2 = sum(AV) if MulPos == "T" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly replace `i'LTTemp2 = `i'LTTemp2/2
	quietly egen `i'LTAV1 = mean(`i'LTTemp1), by(Season Team)
	quietly egen `i'LTAV2 = mean(`i'LTTemp2), by(Season Team)
	quietly replace `i'LTAV1 = 0 if `i'LTAV1 == .
	quietly replace `i'LTAV2 = 0 if `i'LTAV2 == .
	quietly gen `i'LTAV = `i'LTAV1+`i'LTAV2

	quietly egen `i'RTTemp1 = sum(AV) if MulPos == "RT" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly egen `i'RTTemp2 = sum(AV) if MulPos == "T" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly replace `i'RTTemp2 = `i'RTTemp2/2
	quietly egen `i'RTAV1 = mean(`i'RTTemp1), by(Season Team)
	quietly egen `i'RTAV2 = mean(`i'RTTemp2), by(Season Team)
	quietly replace `i'RTAV1 = 0 if `i'RTAV1 == .
	quietly replace `i'RTAV2 = 0 if `i'RTAV2 == .
	quietly gen `i'RTAV = `i'RTAV1+`i'RTAV2

	quietly egen `i'ILBTemp1 = sum(AV) if MulPos == "ILB" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly egen `i'ILBTemp2 = sum(AV) if MulPos == "LB" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly replace `i'ILBTemp2 = `i'ILBTemp2/2
	quietly egen `i'ILBAV1 = mean(`i'ILBTemp1), by(Season Team)
	quietly egen `i'ILBAV2 = mean(`i'ILBTemp2), by(Season Team)
	quietly replace `i'ILBAV1 = 0 if `i'ILBAV1 == .
	quietly replace `i'ILBAV2 = 0 if `i'ILBAV2 == .
	quietly gen `i'ILBAV = `i'ILBAV1+`i'ILBAV2

	quietly egen `i'OLBTemp1 = sum(AV) if MulPos == "OLB" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly egen `i'OLBTemp2 = sum(AV) if MulPos == "LB" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly replace `i'OLBTemp2 = `i'OLBTemp2/2
	quietly egen `i'OLBAV1 = mean(`i'OLBTemp1), by(Season Team)
	quietly egen `i'OLBAV2 = mean(`i'OLBTemp2), by(Season Team)
	quietly replace `i'OLBAV1 = 0 if `i'OLBAV1 == .
	quietly replace `i'OLBAV2 = 0 if `i'OLBAV2 == .
	quietly gen `i'OLBAV = `i'OLBAV1+`i'OLBAV2

	quietly egen `i'FSTemp1 = sum(AV) if MulPos == "FS" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly egen `i'FSTemp2 = sum(AV) if MulPos == "S" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly replace `i'FSTemp2 = `i'FSTemp2/2
	quietly egen `i'FSAV1 = mean(`i'FSTemp1), by(Season Team)
	quietly egen `i'FSAV2 = mean(`i'FSTemp2), by(Season Team)
	quietly replace `i'FSAV1 = 0 if `i'FSAV1 == .
	quietly replace `i'FSAV2 = 0 if `i'FSAV2 == .
	quietly gen `i'FSAV = `i'FSAV1+`i'FSAV2

	quietly egen `i'SSTemp1 = sum(AV) if MulPos == "SS" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly egen `i'SSTemp2 = sum(AV) if MulPos == "S" & Rookie == "`i'", by(Season Team MulPos Rookie)
	quietly replace `i'SSTemp2 = `i'SSTemp2/2
	quietly egen `i'SSAV1 = mean(`i'SSTemp1), by(Season Team)
	quietly egen `i'SSAV2 = mean(`i'SSTemp2), by(Season Team)
	quietly replace `i'SSAV1 = 0 if `i'SSAV1 == .
	quietly replace `i'SSAV2 = 0 if `i'SSAV2 == .
	quietly gen `i'SSAV = `i'SSAV1+`i'SSAV2

	quietly drop `i'LTTemp1 `i'LTTemp2 `i'LTAV1 `i'LTAV2 `i'RTTemp1 `i'RTTemp2 `i'RTAV1 `i'RTAV2 `i'ILBTemp1 `i'ILBTemp2 `i'ILBAV1 `i'ILBAV2 `i'OLBTemp1 `i'OLBTemp2 `i'OLBAV1 `i'OLBAV2 `i'FSTemp1 `i'FSTemp2 `i'FSAV1 `i'FSAV2 `i'SSTemp1 `i'SSTemp2 `i'SSAV1 `i'SSAV2
} 

foreach j in "QB" "RB" "FB" "WR" "TE" "G" "C" "DE" "DT" "CB" "K" "P" "LS" "LT" "RT" "ILB" "OLB" "FS" "SS" {
	quietly gen `j'AV = Rook`j'AV+Vet`j'AV
}

* Calculate Mulholland's positional cap hits (Mulholland Omits Dead Money)
gen Flag = 1
foreach i in "Vet" "Rook" {
	foreach j in "QB" "RB" "FB" "WR" "TE" "G" "C" "DE" "DT" "CB" "K" "P" "LS" {
		if Flag == 1 {
			quietly egen `i'`j'Temp = sum(TotalCapHit) if MulPos == "`j'" & Rookie == "`i'", by(Season Team MulPos Rookie)		
		}
		if Flag == 2 {
			quietly egen `i'`j'Temp = sum(TotalCapHit) if MulPos == "`j'" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)		
		}
		quietly egen `i'`j'Cap = mean(`i'`j'Temp), by(Season Team)
		quietly replace `i'`j'Cap = 0 if `i'`j'Cap == .
		quietly drop `i'`j'Temp
	}
}

foreach i in "Vet" "Rook" {
	if Flag == 1 {
		quietly egen `i'LTTemp1 = sum(TotalCapHit) if MulPos == "LT" & Rookie == "`i'", by(Season Team MulPos Rookie)
		quietly egen `i'LTTemp2 = sum(TotalCapHit) if MulPos == "T" & Rookie == "`i'", by(Season Team MulPos Rookie)
	}
	if Flag == 2 {
		quietly egen `i'LTTemp1 = sum(TotalCapHit) if MulPos == "LT" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
		quietly egen `i'LTTemp2 = sum(TotalCapHit) if MulPos == "T" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
	}
	quietly replace `i'LTTemp2 = `i'LTTemp2/2
	quietly egen `i'LTCap1 = mean(`i'LTTemp1), by(Season Team)
	quietly egen `i'LTCap2 = mean(`i'LTTemp2), by(Season Team)
	quietly replace `i'LTCap1 = 0 if `i'LTCap1 == .
	quietly replace `i'LTCap2 = 0 if `i'LTCap2 == .
	quietly gen `i'LTCap = `i'LTCap1+`i'LTCap2

	if Flag == 1 {
		quietly egen `i'RTTemp1 = sum(TotalCapHit) if MulPos == "RT" & Rookie == "`i'", by(Season Team MulPos Rookie)
		quietly egen `i'RTTemp2 = sum(TotalCapHit) if MulPos == "T" & Rookie == "`i'", by(Season Team MulPos Rookie)
	}
	if Flag == 2 {
		quietly egen `i'RTTemp1 = sum(TotalCapHit) if MulPos == "RT" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
		quietly egen `i'RTTemp2 = sum(TotalCapHit) if MulPos == "T" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
	}
	quietly replace `i'RTTemp2 = `i'RTTemp2/2
	quietly egen `i'RTCap1 = mean(`i'RTTemp1), by(Season Team)
	quietly egen `i'RTCap2 = mean(`i'RTTemp2), by(Season Team)
	quietly replace `i'RTCap1 = 0 if `i'RTCap1 == .
	quietly replace `i'RTCap2 = 0 if `i'RTCap2 == .
	quietly gen `i'RTCap = `i'RTCap1+`i'RTCap2

	if Flag == 1 {
		quietly egen `i'ILBTemp1 = sum(TotalCapHit) if MulPos == "ILB" & Rookie == "`i'", by(Season Team MulPos Rookie)
		quietly egen `i'ILBTemp2 = sum(TotalCapHit) if MulPos == "LB" & Rookie == "`i'", by(Season Team MulPos Rookie)
	}
	if Flag == 2 {
		quietly egen `i'ILBTemp1 = sum(TotalCapHit) if MulPos == "ILB" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
		quietly egen `i'ILBTemp2 = sum(TotalCapHit) if MulPos == "LB" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
	}
	quietly replace `i'ILBTemp2 = `i'ILBTemp2/2
	quietly egen `i'ILBCap1 = mean(`i'ILBTemp1), by(Season Team)
	quietly egen `i'ILBCap2 = mean(`i'ILBTemp2), by(Season Team)
	quietly replace `i'ILBCap1 = 0 if `i'ILBCap1 == .
	quietly replace `i'ILBCap2 = 0 if `i'ILBCap2 == .
	quietly gen `i'ILBCap = `i'ILBCap1+`i'ILBCap2

	if Flag == 1 {
		quietly egen `i'OLBTemp1 = sum(TotalCapHit) if MulPos == "OLB" & Rookie == "`i'", by(Season Team MulPos Rookie)
		quietly egen `i'OLBTemp2 = sum(TotalCapHit) if MulPos == "LB" & Rookie == "`i'", by(Season Team MulPos Rookie)
	}
	if Flag == 2 {
		quietly egen `i'OLBTemp1 = sum(TotalCapHit) if MulPos == "OLB" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
		quietly egen `i'OLBTemp2 = sum(TotalCapHit) if MulPos == "LB" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
	}
	quietly replace `i'OLBTemp2 = `i'OLBTemp2/2
	quietly egen `i'OLBCap1 = mean(`i'OLBTemp1), by(Season Team)
	quietly egen `i'OLBCap2 = mean(`i'OLBTemp2), by(Season Team)
	quietly replace `i'OLBCap1 = 0 if `i'OLBCap1 == .
	quietly replace `i'OLBCap2 = 0 if `i'OLBCap2 == .
	quietly gen `i'OLBCap = `i'OLBCap1+`i'OLBCap2

	if Flag == 1 {
		quietly egen `i'FSTemp1 = sum(TotalCapHit) if MulPos == "FS" & Rookie == "`i'", by(Season Team MulPos Rookie)
		quietly egen `i'FSTemp2 = sum(TotalCapHit) if MulPos == "S" & Rookie == "`i'", by(Season Team MulPos Rookie)
	}
	if Flag == 2 {
		quietly egen `i'FSTemp1 = sum(TotalCapHit) if MulPos == "FS" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
		quietly egen `i'FSTemp2 = sum(TotalCapHit) if MulPos == "S" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
	}
	quietly replace `i'FSTemp2 = `i'FSTemp2/2
	quietly egen `i'FSCap1 = mean(`i'FSTemp1), by(Season Team)
	quietly egen `i'FSCap2 = mean(`i'FSTemp2), by(Season Team)
	quietly replace `i'FSCap1 = 0 if `i'FSCap1 == .
	quietly replace `i'FSCap2 = 0 if `i'FSCap2 == .
	quietly gen `i'FSCap = `i'FSCap1+`i'FSCap2

	if Flag == 1 {
		quietly egen `i'SSTemp1 = sum(TotalCapHit) if MulPos == "SS" & Rookie == "`i'", by(Season Team MulPos Rookie)
		quietly egen `i'SSTemp2 = sum(TotalCapHit) if MulPos == "S" & Rookie == "`i'", by(Season Team MulPos Rookie)
	}
	if Flag == 2 {
		quietly egen `i'SSTemp1 = sum(TotalCapHit) if MulPos == "SS" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
		quietly egen `i'SSTemp2 = sum(TotalCapHit) if MulPos == "S" & Rookie == "`i'" & _merge == 3, by(Season Team MulPos Rookie)
	}
	quietly replace `i'SSTemp2 = `i'SSTemp2/2
	quietly egen `i'SSCap1 = mean(`i'SSTemp1), by(Season Team)
	quietly egen `i'SSCap2 = mean(`i'SSTemp2), by(Season Team)
	quietly replace `i'SSCap1 = 0 if `i'SSCap1 == .
	quietly replace `i'SSCap2 = 0 if `i'SSCap2 == .
	quietly gen `i'SSCap = `i'SSCap1+`i'SSCap2

	quietly drop `i'LTTemp1 `i'LTTemp2 `i'LTCap1 `i'LTCap2 `i'RTTemp1 `i'RTTemp2 `i'RTCap1 `i'RTCap2 `i'ILBTemp1 `i'ILBTemp2 `i'ILBCap1 `i'ILBCap2 `i'OLBTemp1 `i'OLBTemp2 `i'OLBCap1 `i'OLBCap2 `i'FSTemp1 `i'FSTemp2 `i'FSCap1 `i'FSCap2 `i'SSTemp1 `i'SSTemp2 `i'SSCap1 `i'SSCap2
}

foreach j in "QB" "RB" "FB" "WR" "TE" "G" "C" "DE" "DT" "CB" "K" "P" "LS" "LT" "RT" "ILB" "OLB" "FS" "SS" {
	quietly gen `j'Cap = Rook`j'Cap+Vet`j'Cap
}

sort Season Team Player
gen Counter = 1
local NObs = _N
forvalues i = 2/`NObs'{
	quietly replace Counter in `i' = Counter[`i'-1]+1 if Season[`i'-1] == Season[`i'] & Team[`i'-1] == Team[`i']
	quietly replace Counter in `i' = 1 if Season[`i'-1] != Season[`i'] | Team[`i'-1] != Team[`i']
}
drop if Counter != 1
drop  Flag _merge No Player Age PosAV G GS Wt Ht CollegeUniv BirthDate Yrs AV Draftedtmrndyr Salary Status RookieSeason Rookie PosCap CapHit TotalCapHit CapHitPctLeagueCap DeadCap BaseP5Salary SigningBonusProration PerGameBonus RosterBonus OptionBonus WorkoutBonus RestructureProration IncentivesLikely MulPos Counter

save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 10 Season AV Cap Clean.dta", replace