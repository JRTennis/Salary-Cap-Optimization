clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 9 Merge Overall.dta", replace

* Variable Creation
gen CapPct = CapHit/Cap
gen APYPct = ContractAverage/Cap
gen Post2018 = 0
replace Post2018 = 1 if Season >= 2018
gen QB = 0
replace QB = 1 if Position == "QB"
gen Veteran = 0
replace Veteran = 1 if Rookie == 0
gen Pre2011 = 0
replace Pre2011 = 1 if RookieSeason < 2011
gen Pre2011Rookie = 0
replace Pre2011Rookie = 1 if Pre2011 == 1 & Rookie == 1

* Position fixed effects
gen PosFE = .
replace PosFE = 1 if Position == "QB"
replace PosFE = 2 if Position == "RB" | Position == "FB"
replace PosFE = 3 if Position == "WR" | Position == "KR"
replace PosFE = 4 if Position == "TE" | Position == "WLB"
replace PosFE = 5 if Position == "LT"
replace PosFE = 6 if Position == "G"
replace PosFE = 7 if Position == "C" | (Position == "OL" & Player == "Brenden Jaimes")
replace PosFE = 8 if Position == "RT" | Position == "T" | (Position == "OL" & Player == "Isaac Alarcon")
replace PosFE = 9 if Position == "DE"
replace PosFE = 10 if Position == "DT"
replace PosFE = 11 if Position == "ILB" | Position == "LB"
replace PosFE = 12 if Position == "OLB"
replace PosFE = 13 if Position == "CB"
replace PosFE = 14 if Position == "FS"
replace PosFE = 15 if Position == "SS" | Position == "S"
replace PosFE = 16 if Position == "K"
replace PosFE = 17 if Position == "P" | Position == "PR"
replace PosFE = 18 if Position == "LS"

gen Index = _n
local NObs = _N
sort Team Season Index
gen TeamFE = 1
forvalues i = 2/`NObs' {
	quietly replace TeamFE in `i' = TeamFE[`i'-1] if Team[`i'] == Team[`i'-1]
	quietly replace TeamFE in `i' = TeamFE[`i'-1]+1 if Team[`i'] != Team[`i'-1]
}
gen FE = 1
forvalues i = 2/`NObs' {
	quietly replace FE in `i' = FE[`i'-1] if Team[`i'] == Team[`i'-1] & Season[`i'] == Season[`i'-1]
	quietly replace FE in `i' = FE[`i'-1]+1 if Team[`i'] != Team[`i'-1] | Season[`i'] != Season[`i'-1]
}
sort Index

foreach y in CapPct APYPct {
	local CountZ = 1
	foreach z in QB RB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
		foreach x in Rookie Veteran {
			forvalues i = 2011/2024 {
				quietly egen `x'`z'`y'Rank`i' = rank(-`y') if Season == `i' & PosFE == `CountZ' & `x' == 1, track
			}
			
			quietly gen `x'`z'`y'Rank = `x'`z'`y'Rank2011 if `x'`z'`y'Rank2011 != .
			forvalues i = 2012/2024 {
				quietly replace `x'`z'`y'Rank = `x'`z'`y'Rank`i' if `x'`z'`y'Rank`i' != .
				quietly drop `x'`z'`y'Rank`i'
			}
		}
		local CountZ = `CountZ'+1
	}
	
	* Expensive=1 for Highest-Paid Rookies and Veterans at Each Position in Each Season
	quietly gen `y'Expensive = 0
	quietly replace `y'Expensive = 1 if Rookie == 1 & ((RookieQB`y'Rank <= 16 & PosFE == 1) | (RookieRB`y'Rank <= 16 & PosFE == 2) | (RookieWR`y'Rank <= 48 & PosFE == 3) | (RookieTE`y'Rank <= 16 & PosFE == 4) | (RookieLT`y'Rank <= 16 & PosFE == 5) | (RookieG`y'Rank <= 32 & PosFE == 6) | (RookieC`y'Rank <= 16 & PosFE == 7) | (RookieRT`y'Rank <= 16 & PosFE == 8) | (RookieDE`y'Rank <= 32 & PosFE == 9) | (RookieDT`y'Rank <= 32 & PosFE == 10) | (RookieILB`y'Rank <= 16 & PosFE == 11) | (RookieOLB`y'Rank <= 32 & PosFE == 12) | (RookieCB`y'Rank <= 32 & PosFE == 13) | (RookieFS`y'Rank <= 16 & PosFE == 14) | (RookieSS`y'Rank <= 16 & PosFE == 15) | (RookieK`y'Rank <= 16 & PosFE == 16) | (RookieP`y'Rank <= 16 & PosFE == 17) | (RookieLS`y'Rank <= 16 & PosFE == 18))
	quietly replace `y'Expensive = 1 if Veteran == 1 & ((VeteranQB`y'Rank <= 16 & PosFE == 1) | (VeteranRB`y'Rank <= 16 & PosFE == 2) | (VeteranWR`y'Rank <= 48 & PosFE == 3) | (VeteranTE`y'Rank <= 16 & PosFE == 4) | (VeteranLT`y'Rank <= 16 & PosFE == 5) | (VeteranG`y'Rank <= 32 & PosFE == 6) | (VeteranC`y'Rank <= 16 & PosFE == 7) | (VeteranRT`y'Rank <= 16 & PosFE == 8) | (VeteranDE`y'Rank <= 32 & PosFE == 9) | (VeteranDT`y'Rank <= 32 & PosFE == 10) | (VeteranILB`y'Rank <= 16 & PosFE == 11) | (VeteranOLB`y'Rank <= 32 & PosFE == 12) | (VeteranCB`y'Rank <= 32 & PosFE == 13) | (VeteranFS`y'Rank <= 16 & PosFE == 14) | (VeteranSS`y'Rank <= 16 & PosFE == 15) | (VeteranK`y'Rank <= 16 & PosFE == 16) | (VeteranP`y'Rank <= 16 & PosFE == 17) | (VeteranLS`y'Rank <= 16 & PosFE == 18))
}

* Composite DID
foreach x in Cap APY {
	gen `x'PctTripTreat = 0
	replace `x'PctTripTreat = 1 if QB==1 & Veteran==1
	
	gen `x'PctQuadTreat = 0
	replace `x'PctQuadTreat = 1 if QB==1 & Veteran==1 & `x'PctExpensive==1
}

foreach x in Trip Quad {
	reg CapPct Post2018##CapPct`x'Treat Pre2011Rookie i.Season i.PosFE i.TeamFE, vce(cluster FE)
	matrix CoefCap`x'Comp = e(b)
	matrix VCap`x'Comp = e(V)
	scalar R2Cap`x'Comp = e(r2)
	quietly matrix VDiagCap`x'Comp = vecdiag(VCap`x'Comp)
	quietly local NColsCap`x'Comp = colsof(VDiagCap`x'Comp)
	quietly matrix SECap`x'Comp = J(1,`NColsCap`x'Comp',.)
	forvalues i = 1/`NColsCap`x'Comp' {
		quietly matrix SECap`x'Comp[1,`i'] = sqrt(VDiagCap`x'Comp[1,`i'])
	}

	reg APYPct Post2018##APYPct`x'Treat Pre2011Rookie ContractLength i.Season i.PosFE i.TeamFE, vce(cluster FE)
	matrix CoefAPY`x'Comp = e(b)
	matrix VAPY`x'Comp = e(V)
	scalar R2APY`x'Comp = e(r2)
	quietly matrix VDiagAPY`x'Comp = vecdiag(VAPY`x'Comp)
	quietly local NColsAPY`x'Comp = colsof(VDiagAPY`x'Comp)
	quietly matrix SEAPY`x'Comp = J(1,`NColsAPY`x'Comp',.)
	forvalues i = 1/`NColsAPY`x'Comp' {
		quietly matrix SEAPY`x'Comp[1,`i'] = sqrt(VDiagAPY`x'Comp[1,`i'])
	}
}

* Triple and quadruple DID
reg CapPct Post2018##QB##Veteran Pre2011Rookie i.Season i.PosFE i.TeamFE, vce(cluster FE)
matrix CoefCapTrip = e(b)
matrix VCapTrip = e(V)
scalar R2CapTrip = e(r2)
quietly matrix VDiagCapTrip = vecdiag(VCapTrip)
quietly local NColsCapTrip = colsof(VDiagCapTrip)
quietly matrix SECapTrip = J(1,`NColsCapTrip',.)
forvalues i = 1/`NColsCapTrip' {
	quietly matrix SECapTrip[1,`i'] = sqrt(VDiagCapTrip[1,`i'])
}

reg APYPct Post2018##QB##Veteran Pre2011Rookie ContractLength i.Season i.PosFE i.TeamFE, vce(cluster FE)
matrix CoefAPYTrip = e(b)
matrix VAPYTrip = e(V)
scalar R2APYTrip = e(r2)
quietly matrix VDiagAPYTrip = vecdiag(VAPYTrip)
quietly local NColsAPYTrip = colsof(VDiagAPYTrip)
quietly matrix SEAPYTrip = J(1,`NColsAPYTrip',.)
forvalues i = 1/`NColsAPYTrip' {
	quietly matrix SEAPYTrip[1,`i'] = sqrt(VDiagAPYTrip[1,`i'])
}

reg CapPct Post2018##QB##Veteran##CapPctExpensive Pre2011Rookie i.Season i.PosFE i.TeamFE, vce(cluster FE)
matrix CoefCapQuad = e(b)
matrix VCapQuad = e(V)
scalar R2CapQuad = e(r2)
quietly matrix VDiagCapQuad = vecdiag(VCapQuad)
quietly local NColsCapQuad = colsof(VDiagCapQuad)
quietly matrix SECapQuad = J(1,`NColsCapQuad',.)
forvalues i = 1/`NColsCapQuad' {
	quietly matrix SECapQuad[1,`i'] = sqrt(VDiagCapQuad[1,`i'])
}

reg APYPct Post2018##QB##Veteran##APYPctExpensive Pre2011Rookie ContractLength i.Season i.PosFE i.TeamFE, vce(cluster FE)
matrix CoefAPYQuad = e(b)
matrix VAPYQuad = e(V)
scalar R2APYQuad = e(r2)
quietly matrix VDiagAPYQuad = vecdiag(VAPYQuad)
quietly local NColsAPYQuad = colsof(VDiagAPYQuad)
quietly matrix SEAPYQuad = J(1,`NColsAPYQuad',.)
forvalues i = 1/`NColsAPYQuad' {
	quietly matrix SEAPYQuad[1,`i'] = sqrt(VDiagAPYQuad[1,`i'])
}

* Summary Statistics
gen Triple = 0
replace Triple = 1 if Post2018 == 1 & QB == 1 & Veteran == 1
gen CapPctQuad = 0
replace CapPctQuad = 1 if Post2018 == 1 & QB == 1 & Veteran == 1 & CapPctExpensive == 1
gen APYPctQuad = 0
replace APYPctQuad = 1 if Post2018 == 1 & QB == 1 & Veteran == 1 & APYPctExpensive == 1

foreach x in CapPct APYPct {
	quietly gen `x'Trip1 = .
	quietly replace `x'Trip1 = `x' if Post2018 == 1 & QB == 1 & Veteran == 1
	quietly gen `x'Trip0 = .
	quietly replace `x'Trip0 = `x' if Post2018 == 0 | QB == 0 | Veteran == 0
	quietly gen `x'Quad1 = .
	quietly replace `x'Quad1 = `x' if Post2018 == 1 & QB == 1 & Veteran == 1 & `x'Expensive == 1
	quietly gen `x'Quad0 = .
	quietly replace `x'Quad0 = `x' if Post2018 == 0 | QB == 0 | Veteran == 0 | `x'Expensive == 0
}

foreach x in Post2018 QB Veteran CapPctExpensive APYPctExpensive CapPctTripTreat CapPctQuadTreat APYPctQuadTreat Triple CapPctQuad APYPctQuad CapPct CapPctTrip1 CapPctTrip0 CapPctQuad1 CapPctQuad0 APYPct APYPctTrip1 APYPctTrip0 APYPctQuad1 APYPctQuad0 Pre2011Rookie ContractLength {
	foreach y in mean sd min max {
		quietly sum `x'
		quietly scalar `y'`x' = r(`y')
	}
}

matrix Summary = J(23,4,.)
quietly local CountY = 0
foreach y in mean sd min max {
	quietly local CountX = 0
	foreach x in Post2018 QB Veteran CapPctExpensive APYPctExpensive CapPctTripTreat CapPctQuadTreat APYPctQuadTreat Triple CapPctQuad APYPctQuad CapPct CapPctTrip1 CapPctTrip0 CapPctQuad1 CapPctQuad0 APYPct APYPctTrip1 APYPctTrip0 APYPctQuad1 APYPctQuad0 Pre2011Rookie ContractLength {
		quietly matrix Summary[1+`CountX',1+`CountY'] = `y'`x'
		quietly local CountX = `CountX'+1
	}
	quietly local CountY = `CountY'+1
}

* Regression Tables
matrix TableComp = J(11,4,.)
local CountX = 1
foreach x in Cap APY {
	local CountY = 0
	foreach y in Coef SE {
			matrix TableComp[1+`CountY',`CountX'] = `y'`x'TripComp[1,2]
			matrix TableComp[3+`CountY',`CountX'] = `y'`x'TripComp[1,4]
			matrix TableComp[5+`CountY',`CountX'] = `y'`x'TripComp[1,8]
			matrix TableComp[7+`CountY',`CountX'] = `y'`x'TripComp[1,9]
		if "`x'" == "APY" {
			matrix TableComp[9+`CountY',`CountX'] = `y'`x'TripComp[1,10]
		}
		local CountY = `CountY'+1
	}
	matrix TableComp[11,`CountX'] = R2`x'TripComp
	local CountX = `CountX'+1
}
local CountX = 1
foreach x in Cap APY {
	local CountY = 0
	foreach y in Coef SE {
		matrix TableComp[1+`CountY',2+`CountX'] = `y'`x'QuadComp[1,2]
		matrix TableComp[3+`CountY',2+`CountX'] = `y'`x'QuadComp[1,4]
		matrix TableComp[5+`CountY',2+`CountX'] = `y'`x'QuadComp[1,8]
		matrix TableComp[7+`CountY',2+`CountX'] = `y'`x'QuadComp[1,9]
		if "`x'" == "APY" {
			matrix TableComp[9+`CountY',2+`CountX'] = `y'`x'QuadComp[1,10]
		}
		local CountY = `CountY'+1
	}
	matrix TableComp[11,2+`CountX'] = R2`x'QuadComp
	local CountX = `CountX'+1
}

matrix TableSep = J(35,4,.)
local CountX = 1
foreach x in Cap APY {
	local CountY = 0
	foreach y in Coef SE {
			matrix TableSep[1+`CountY',`CountX'] = `y'`x'Trip[1,2]
			matrix TableSep[3+`CountY',`CountX'] = `y'`x'Trip[1,4]
			matrix TableSep[5+`CountY',`CountX'] = `y'`x'Trip[1,10]
			matrix TableSep[9+`CountY',`CountX'] = `y'`x'Trip[1,8]
			matrix TableSep[11+`CountY',`CountX'] = `y'`x'Trip[1,14]
			matrix TableSep[15+`CountY',`CountX'] = `y'`x'Trip[1,18]
			matrix TableSep[21+`CountY',`CountX'] = `y'`x'Trip[1,26]
			matrix TableSep[31+`CountY',`CountX'] = `y'`x'Trip[1,27]
		if "`x'" == "APY" {
			matrix TableSep[33+`CountY',`CountX'] = `y'`x'Trip[1,28]
		}
		local CountY = `CountY'+1
	}
	matrix TableSep[35,`CountX'] = R2`x'Trip
	local CountX = `CountX'+1
}
local CountX = 1
foreach x in Cap APY {
	local CountY = 0
	foreach y in Coef SE {
		matrix TableSep[1+`CountY',2+`CountX'] = `y'`x'Quad[1,2]
		matrix TableSep[3+`CountY',2+`CountX'] = `y'`x'Quad[1,4]
		matrix TableSep[5+`CountY',2+`CountX'] = `y'`x'Quad[1,10]
		matrix TableSep[7+`CountY',2+`CountX'] = `y'`x'Quad[1,28]
		matrix TableSep[9+`CountY',2+`CountX'] = `y'`x'Quad[1,8]
		matrix TableSep[11+`CountY',2+`CountX'] = `y'`x'Quad[1,14]
		matrix TableSep[13+`CountY',2+`CountX'] = `y'`x'Quad[1,32]
		matrix TableSep[15+`CountY',2+`CountX'] = `y'`x'Quad[1,18]
		matrix TableSep[17+`CountY',2+`CountX'] = `y'`x'Quad[1,36]
		matrix TableSep[19+`CountY',2+`CountX'] = `y'`x'Quad[1,48]
		matrix TableSep[21+`CountY',2+`CountX'] = `y'`x'Quad[1,26]
		matrix TableSep[23+`CountY',2+`CountX'] = `y'`x'Quad[1,44]
		matrix TableSep[25+`CountY',2+`CountX'] = `y'`x'Quad[1,56]
		matrix TableSep[27+`CountY',2+`CountX'] = `y'`x'Quad[1,64]
		matrix TableSep[29+`CountY',2+`CountX'] = `y'`x'Quad[1,80]
		matrix TableSep[31+`CountY',2+`CountX'] = `y'`x'Quad[1,81]
		if "`x'" == "APY" {
			matrix TableSep[33+`CountY',2+`CountX'] = `y'`x'Quad[1,82]
		}
		local CountY = `CountY'+1
	}
	matrix TableSep[35,2+`CountX'] = R2`x'Quad
	local CountX = `CountX'+1
}

matrix list Summary
matrix list TableComp
matrix list TableSep