clear all
local SeasonFlag = 0
local CapFlag = 0

if `SeasonFlag' == 0 & `CapFlag' == 0 {
	log using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Do 14 Season Bootstrap Baseline.smcl", replace
}
else if `SeasonFlag' == 1 & `CapFlag' == 0 {
	log using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Do 15 Season Bootstrap Baseline Pre-2018.smcl", replace
}
else if `SeasonFlag' == 2 & `CapFlag' == 0 {
	log using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Do 16 Season Bootstrap Baseline Post-2018.smcl", replace
}
else if `SeasonFlag' == 0 & `CapFlag' == 2 {
	log using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Do 17 Season Bootstrap Baseline Sqrt.smcl", replace
}

set more off
timer clear 1
timer on 1

* Season-level data
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 11 Season Merge.dta", replace
if `SeasonFlag' == 1 {
	keep if Season < 2018
}
else if `SeasonFlag' == 2 {
	keep if Season >= 2018
}
local CoYFlag = 0
local End = 21+`CoYFlag'

* Count observations
count
local Reps = 500
local Progress = 50
set seed 72

* 2011 Indianapolis Colts missing Vegas Wins O/U
gen MissWinTotal = 0
replace MissWinTotal = 1 if WinTotal == .
label variable MissWinTotal MissWinTotal
order MissWinTotal, after(WinTotal)
quietly sum WinTotal
local MeanWinTotal = r(mean)
replace WinTotal = `MeanWinTotal' if WinTotal == .

* Generate Fixed Effects
sort Team Season
local NObs = _N
gen FE = 1
forvalues i = 2/`NObs' {
	quietly replace FE in `i' = FE[`i'-1] if Team[`i'] == Team[`i'-1]
	quietly replace FE in `i' = FE[`i'-1]+1 if Team[`i'] != Team[`i'-1]
}
drop ActualTeam Diff Playoffs SBApp SBWin
xtset FE Season

forvalues i = 1/32 {
	quietly gen FE`i' = 0
	quietly replace FE`i' = 1 if FE == `i'
}
forvalues i = 2011/2024 {
	quietly gen Season`i' = 0
	quietly replace Season`i' = 1 if Season == `i'
}

* Replace season fixed effects with 17 game season dummy
gen SeasonPost2021 = 0
replace SeasonPost2021 = 1 if Season >= 2021
replace SeasonPost2021 = 0 if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")

* Generate variables (Pool FB with RB)
gen RBFBAV = RBAV+FBAV
gen RBFBCap = RBCap+FBCap
gen Cap = QBCap+RBFBCap+WRCap+TECap+LTCap+GCap+CCap+RTCap+DECap+DTCap+ILBCap+OLBCap+CBCap+FSCap+SSCap+KCap+PCap+LSCap
foreach i in Rook Vet {
	gen `i'RBFBAV = `i'RBAV+`i'FBAV
	gen `i'RBFBCap = `i'RBCap+`i'FBCap
	gen `i'Cap = `i'QBCap+`i'RBFBCap+`i'WRCap+`i'TECap+`i'LTCap+`i'GCap+`i'CCap+`i'RTCap+`i'DECap+`i'DTCap+`i'ILBCap+`i'OLBCap+`i'CBCap+`i'FSCap+`i'SSCap+`i'KCap+`i'PCap+`i'LSCap
	
	foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
		quietly gen `i'`x'CapPct = `i'`x'Cap/`i'Cap*100
		if `CapFlag' == 0 {
			quietly gen `i'`x'ZeroDum = 0
			quietly replace `i'`x'ZeroDum = 1 if `i'`x'CapPct == 0
			quietly gen `i'`x'CapPctZTO = `i'`x'CapPct
			quietly replace `i'`x'CapPctZTO = 1 if `i'`x'CapPctZTO == 0
			quietly gen Log`i'`x'CapPctZTO = log(`i'`x'CapPctZTO)
		}
		else if `CapFlag' == 2 {
			quietly gen Sqrt`i'`x'CapPct = sqrt(`i'`x'CapPct)
		}
	}
}

* First half
matrix ImpCoefs1 = J(`Reps', `End', .)
matrix CECoefs1 = J(`Reps', 36, .)

forvalues i = 1/`Reps' {
    preserve
    bsample, cluster(FE)
	
	* Importance regression
	capture {
		if `CoYFlag' == 0 {
			reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 i.FE, vce(cluster FE)
		}
		else if `CoYFlag' == 1 {
			reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 CoY i.FE, vce(cluster FE)
		}
	}

	if _rc == 0 {
		matrix Uncon = e(b)
		forvalues j = 1/`End' {
			matrix ImpCoefs1[`i',`j'] = Uncon[1,`j']
		}
	}
	
	else {
		display as error "Warning: OLS failed on rep `i'"
	}
	
	* Cost effectiveness regressions
	local j = 1
	foreach c in Rook Vet {
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			capture {
				if `CapFlag' == 0 {
					reg `c'`x'AV Log`c'`x'CapPctZTO `c'`x'ZeroDum, vce(cluster FE)
				}
				else if `CapFlag' == 2 {
					reg `c'`x'AV Sqrt`c'`x'CapPct, vce(cluster FE)
				}
			}
			
			if _rc == 0 {
				matrix Coefs`j' = e(b)
				matrix CECoefs1[`i',`j'] = Coefs`j'[1,1]
			}
			
			else {
				display as error "Warning: OLS failed on rep `i' reg `j'"
			}
			
			local ++j
		}
	}
	
    restore
    if mod(`i', `Progress') == 0 display as text "First matrix: Completed rep `i' of `Reps'"
}

if `CoYFlag' == 0 {
	matrix colnames ImpCoefs1 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef
}
else if `CoYFlag' == 1 {
	matrix colnames ImpCoefs1 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef CoYCoef
}
matrix PosImpCoefs1 = ImpCoefs1[1..rowsof(ImpCoefs1), 1..18]
matrix colnames PosImpCoefs1 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef

matrix colnames CECoefs1 = RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS
matrix RookCECoefs1 = CECoefs1[1..rowsof(CECoefs1), 1..18]
matrix VetCECoefs1 = CECoefs1[1..rowsof(CECoefs1), 19..36]
matrix colnames RookCECoefs1 = RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS
matrix colnames VetCECoefs1 = VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS

* Calculate optimal allocations
if `CapFlag' == 0 {
	foreach c in Rook Vet {
		matrix `c'Denom1 = J(`Reps', 1, .)
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			matrix `c'`x'1 = J(`Reps', 1, .)
		}

		forvalues i = 1/`Reps' {
			matrix `c'Denom1[`i',1] = PosImpCoefs1[`i',1..colsof(PosImpCoefs1)]*`c'CECoefs1[`i',1..colsof(`c'CECoefs1)]'
			
			local j = 1
			foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
				matrix `c'`x'1[`i',1] = PosImpCoefs1[`i',`j']*`c'CECoefs1[`i',`j']/`c'Denom1[`i',1]
				local ++j
			}
		}
	}
}

else if `CapFlag' == 2 {
	* Sqrt spec -> square the products
	foreach c in Rook Vet {
		matrix `c'Denom1 = J(`Reps', 1, .)
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			matrix `c'`x'1 = J(`Reps', 1, .)
		}

		forvalues i = 1/`Reps' {
			scalar __den = 0
			local j = 1

			* Pass 1: store squared numerators and accumulate denominator
			foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
				scalar __num = PosImpCoefs1[`i',`j'] * `c'CECoefs1[`i',`j']
				scalar __num2 = __num^2
				matrix `c'`x'1[`i',1] = __num2
				scalar __den = __den + __num2
				local ++j
			}

			* Guard against degenerate case (all zeros)
			if (__den<=0) {
				* split mass evenly to avoid missing values; tweak if you prefer zeros
				foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
					matrix `c'`x'1[`i',1] = 1/18
				}
				matrix `c'Denom1[`i',1] = 0
			}
			else {
				* Pass 2: normalize
				foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
					matrix `c'`x'1[`i',1] = `c'`x'1[`i',1] / __den
				}
				matrix `c'Denom1[`i',1] = __den
			}
		}
	}
}

matrix Opt1 = [RookQB1, RookRBFB1, RookWR1, RookTE1, RookLT1, RookG1, RookC1, RookRT1, RookDE1, RookDT1, RookILB1, RookOLB1, RookCB1, RookFS1, RookSS1, RookK1, RookP1, RookLS1, ///
VetQB1, VetRBFB1, VetWR1, VetTE1, VetLT1, VetG1, VetC1, VetRT1, VetDE1, VetDT1, VetILB1, VetOLB1, VetCB1, VetFS1, VetSS1, VetK1, VetP1, VetLS1]
matrix colnames Opt1 = RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS ///
VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS

matrix ImpCoefsOpt1 = [ImpCoefs1, Opt1]
if `CoYFlag' == 0 {
	matrix colnames ImpCoefsOpt1 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef ///
RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS ///
VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS
}
else if `CoYFlag' == 1 {
	matrix colnames ImpCoefsOpt1 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef CoYCoef ///
RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS ///
VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS
}

* Second half
matrix ImpCoefs2 = J(`Reps', `End', .)
matrix CECoefs2 = J(`Reps', 36, .)

forvalues i = 1/`Reps' {
    preserve
    bsample, cluster(FE)
	
	* Importance regression
	capture {
		if `CoYFlag' == 0 {
			reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 i.FE, vce(cluster FE)
		}
		else if `CoYFlag' == 1 {
			reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 CoY i.FE, vce(cluster FE)
		}
	}

	if _rc == 0 {
		matrix Uncon = e(b)
		forvalues j = 1/`End' {
			matrix ImpCoefs2[`i',`j'] = Uncon[1,`j']
		}
	}
	
	else {
		display as error "Warning: OLS failed on rep `i'"
	}
	
	* Cost effectiveness regressions
	local j = 1
	foreach c in Rook Vet {
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			capture {
				if `CapFlag' == 0 {
					reg `c'`x'AV Log`c'`x'CapPctZTO `c'`x'ZeroDum, vce(cluster FE)
				}
				else if `CapFlag' == 2 {
					reg `c'`x'AV Sqrt`c'`x'CapPct, vce(cluster FE)
				}
			}
			
			if _rc == 0 {
				matrix Coefs`j' = e(b)
				matrix CECoefs2[`i',`j'] = Coefs`j'[1,1]
			}
			
			else {
				display as error "Warning: OLS failed on rep `i' reg `j'"
			}
			
			local ++j
		}
	}
	
    restore
    if mod(`i', `Progress') == 0 display as text "Second matrix: Completed rep `i' of `Reps'"
}

if `CoYFlag' == 0 {
	matrix colnames ImpCoefs2 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef
}
else if `CoYFlag' == 1 {
	matrix colnames ImpCoefs2 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef CoYCoef
}
matrix PosImpCoefs2 = ImpCoefs2[1..rowsof(ImpCoefs1), 1..18]
matrix colnames PosImpCoefs2 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef

matrix colnames CECoefs2 = RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS
matrix RookCECoefs2 = CECoefs2[1..rowsof(CECoefs1), 1..18]
matrix VetCECoefs2 = CECoefs2[1..rowsof(CECoefs1), 19..36]
matrix colnames RookCECoefs2 = RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS
matrix colnames VetCECoefs2 = VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS

* Calculate optimal allocations
if `CapFlag' == 0 {
	foreach c in Rook Vet {
		matrix `c'Denom2 = J(`Reps', 1, .)
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			matrix `c'`x'2 = J(`Reps', 1, .)
		}

		forvalues i = 1/`Reps' {
			matrix `c'Denom2[`i',1] = PosImpCoefs2[`i',1..colsof(PosImpCoefs2)]*`c'CECoefs2[`i',1..colsof(`c'CECoefs2)]'
			
			local j = 1
			foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
				matrix `c'`x'2[`i',1] = PosImpCoefs2[`i',`j']*`c'CECoefs2[`i',`j']/`c'Denom2[`i',1]
				local ++j
			}
		}
	}
}

else if `CapFlag' == 2 {
	* Sqrt spec -> square the products
	foreach c in Rook Vet {
		matrix `c'Denom2 = J(`Reps', 1, .)
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			matrix `c'`x'2 = J(`Reps', 1, .)
		}

		forvalues i = 1/`Reps' {
			scalar __den = 0
			local j = 1

			* Pass 1: store squared numerators and accumulate denominator
			foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
				scalar __num  = PosImpCoefs2[`i',`j'] * `c'CECoefs2[`i',`j']
				scalar __num2 = __num^2
				matrix `c'`x'2[`i',1] = __num2
				scalar __den = __den + __num2
				local ++j
			}

			* Guard against degenerate case (all zeros)
			if (__den<=0) {
				foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
					matrix `c'`x'2[`i',1] = 1/18
				}
				matrix `c'Denom2[`i',1] = 0
			}
			else {
				* Pass 2: normalize
				foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
					matrix `c'`x'2[`i',1] = `c'`x'2[`i',1] / __den
				}
				matrix `c'Denom2[`i',1] = __den
			}
		}
	}
}

matrix Opt2 = [RookQB2, RookRBFB2, RookWR2, RookTE2, RookLT2, RookG2, RookC2, RookRT2, RookDE2, RookDT2, RookILB2, RookOLB2, RookCB2, RookFS2, RookSS2, RookK2, RookP2, RookLS2, ///
VetQB2, VetRBFB2, VetWR2, VetTE2, VetLT2, VetG2, VetC2, VetRT2, VetDE2, VetDT2, VetILB2, VetOLB2, VetCB2, VetFS2, VetSS2, VetK2, VetP2, VetLS2]
matrix colnames Opt2 = RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS ///
VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS

matrix ImpCoefsOpt2 = [ImpCoefs2, Opt2]
if `CoYFlag' == 0 {
	matrix colnames ImpCoefsOpt2 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef ///
RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS ///
VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS
}
else if `CoYFlag' == 1 {
	matrix colnames ImpCoefsOpt2 = QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef CoYCoef ///
RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS ///
VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS
}

* Convert and save ImpCoefsOpt1
drop _all
svmat ImpCoefsOpt1, names(col)
gen rep = _n
tempfile boot1
save `boot1', replace

* Clear memory to prepare for second matrix
clear

* Convert and save ImpCoefsOpt2
svmat ImpCoefsOpt2, names(col)
gen rep = _n + `Reps'
tempfile boot2
save `boot2', replace

* Append and save final combined dataset
use `boot1', clear
append using `boot2'
replace MissWinTotalCoef = . if MissWinTotalCoef == 0
replace SeasonPost2021Coef = . if SeasonPost2021Coef == 0
drop rep

* OLS standard errors
if `CoYFlag' == 0 {
	local i = 1
	foreach x in QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef {
		quietly sum `x'
		scalar SE`i' = r(sd)
		local ++i
	}
	
	matrix SE = [SE1\SE2\SE3\SE4\SE5\SE6\SE7\SE8\SE9\SE10\SE11\SE12\SE13\SE14\SE15\SE16\SE17\SE18\SE19\SE20\SE21]
	matrix rownames SE = QBAVSE RBFBAVSE WRAVSE TEAVSE LTAVSE GAVSE CAVSE RTAVSE DEAVSE DTAVSE ILBAVSE OLBAVSE CBAVSE FSAVSE SSAVSE KAVSE PAVSE LSAVSE WinTotalSE MissWinTotalSE SeasonPost2021SE
	matrix list SE
}

else if `CoYFlag' == 1 {
	local i = 1
	foreach x in QBAVCoef RBFBAVCoef WRAVCoef TEAVCoef LTAVCoef GAVCoef CAVCoef RTAVCoef DEAVCoef DTAVCoef ILBAVCoef OLBAVCoef CBAVCoef FSAVCoef SSAVCoef KAVCoef PAVCoef LSAVCoef WinTotalCoef MissWinTotalCoef SeasonPost2021Coef CoYCoef {
		quietly sum `x'
		scalar SE`i' = r(sd)
		local ++i
	}
	
	matrix SE = [SE1\SE2\SE3\SE4\SE5\SE6\SE7\SE8\SE9\SE10\SE11\SE12\SE13\SE14\SE15\SE16\SE17\SE18\SE19\SE20\SE21\SE22]
	matrix rownames SE = QBAVSE RBFBAVSE WRAVSE TEAVSE LTAVSE GAVSE CAVSE RTAVSE DEAVSE DTAVSE ILBAVSE OLBAVSE CBAVSE FSAVSE SSAVSE KAVSE PAVSE LSAVSE WinTotalSE MissWinTotalSE SeasonPost2021SE CoYSE
	matrix list SE
}

* Confidence intervals
matrix RookLB = J(18,1,.)
matrix RookUB = J(18,1,.)
local i = 1
foreach x in RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS {
	_pctile `x', p(2.5 97.5)
	matrix RookLB[`i',1] = r(r1)
	matrix RookUB[`i',1] = r(r2)
	local ++i
}

matrix VetLB = J(18,1,.)
matrix VetUB = J(18,1,.)
local i = 1
foreach x in VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS {
	_pctile `x', p(2.5 97.5)
	matrix VetLB[`i',1] = r(r1)
	matrix VetUB[`i',1] = r(r2)
	local ++i
}

matrix CI = [RookLB, RookUB, VetLB, VetUB]
matrix colnames CI = RookLB RookUB VetLB VetUB
matrix rownames CI = QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS
matrix list CI


if `SeasonFlag' == 0 & `CapFlag' == 0 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 25 Season Bootstrap Baseline.dta", replace
}
else if `SeasonFlag' == 1 & `CapFlag' == 0 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 26 Season Bootstrap Baseline Pre-2018.dta", replace
}
else if `SeasonFlag' == 2 & `CapFlag' == 0 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 27 Season Bootstrap Baseline Post-2018.dta", replace
}
else if `SeasonFlag' == 0 & `CapFlag' == 2 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 28 Season Bootstrap Baseline Sqrt.dta", replace
}

timer off 1
timer list 1
display "Runtime: " r(t1)/60 " minutes"
log close