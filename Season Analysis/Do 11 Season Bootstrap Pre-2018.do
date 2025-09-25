log using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Do 11 Season Bootstrap Pre-2018.smcl", replace
clear all
set more off
timer clear 1
timer on 1

* Game-level AMEs
local SeasonFlag = 1
if `SeasonFlag' == 0 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 17 Game Bootstrap.dta", clear
}
else if `SeasonFlag' == 1 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 18 Game Bootstrap Pre-2018.dta", clear
}
else if `SeasonFlag' == 2 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 19 Game Bootstrap Post-2018.dta", clear
}

* Create observation index
gen obs_id = _n

* First 500 rows → SeasonAMEs1
preserve
keep if obs_id <= 500
mkmat Rate ANYA TANYA FPA, matrix(SeasonAMEs1)
restore

* Last 500 rows → SeasonAMEs2
keep if obs_id > 500
mkmat Rate ANYA TANYA FPA, matrix(SeasonAMEs2)

* Season-level data
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 11 Season Merge.dta", replace
if `SeasonFlag' == 1 {
	keep if Season < 2018
}
else if `SeasonFlag' == 2 {
	keep if Season >= 2018
}
local CoYFlag = 1
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
		quietly gen `i'`x'ZeroDum = 0
		quietly replace `i'`x'ZeroDum = 1 if `i'`x'CapPct == 0
		quietly gen `i'`x'CapPctZTO = `i'`x'CapPct
		quietly replace `i'`x'CapPctZTO = 1 if `i'`x'CapPctZTO == 0
		quietly gen Log`i'`x'CapPctZTO = log(`i'`x'CapPctZTO)
	}
}

* Compute QBAV constraint
quietly sum QBAV
scalar QBAVSD = r(sd)
scalar Factor = (10*16+4*17)/14
local i = 1
foreach x in Rate ANYA TANYA FPA {
	quietly sum `x'
	scalar `x'SD = r(sd)
	matrix `x'Const1 = SeasonAMEs1[1..rowsof(SeasonAMEs1),`i']*(`x'SD/QBAVSD)*Factor
	matrix `x'Const2 = SeasonAMEs2[1..rowsof(SeasonAMEs1),`i']*(`x'SD/QBAVSD)*Factor
	local ++i
}

* Obtain optimal weights
tempfile dataset
save `dataset', replace

if `SeasonFlag' == 0 {
	use "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\Data 17 Game Bootstrap.dta", clear
}
else if `SeasonFlag' == 1 {
	use "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\Data 18 Game Bootstrap Pre-2018.dta", clear
}
else if `SeasonFlag' == 2 {
	use "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\Data 19 Game Bootstrap Post-2018.dta", clear
}

foreach x in Rate ANYA TANYA FPA {
    quietly gen `x'Scale = `x'*(`x'SD/QBAVSD)*Factor
}
corr RateScale ANYAScale TANYAScale FPAScale, cov
matrix BootV = r(C)
matrix InvBootV = invsym(BootV)
matrix Ones = J(4,1,1)
matrix Denom = Ones'*InvBootV *Ones
matrix Weights = InvBootV*Ones/Denom[1,1]

use `dataset', clear
matrix AvgConst1 = Weights[1,1]*RateConst1+Weights[2,1]*ANYAConst1+Weights[3,1]*TANYAConst1+Weights[4,1]*FPAConst1
matrix AvgConst2 = Weights[1,1]*RateConst2+Weights[2,1]*ANYAConst2+Weights[3,1]*TANYAConst2+Weights[4,1]*FPAConst2
gen wins = Wins

* First half
matrix ImpCoefs1 = J(`Reps', `End', .)
matrix CECoefs1 = J(`Reps', 36, .)

forvalues i = 1/`Reps' {
    preserve
    bsample, cluster(FE)
	
	* Importance regression
	local AvgConst1 = AvgConst1[`i',1]
	capture {
		if `CoYFlag' == 0 {
			nl (wins=`AvgConst1'*QBAV+exp({lnb2})*RBFBAV+exp({lnb3})*WRAV+exp({lnb4})*TEAV+exp({lnb5})*LTAV+exp({lnb6})*GAV+exp({lnb7})*CAV+exp({lnb8})*RTAV+exp({lnb9})*DEAV+exp({lnb10})*DTAV+exp({lnb11})*ILBAV+exp({lnb12})*OLBAV+exp({lnb13})*CBAV+exp({lnb14})*FSAV+exp({lnb15})*SSAV+exp({lnb16})*KAV+exp({lnb17})*PAV+exp({lnb18})*LSAV+{a1}*WinTotal+{a2}*MissWinTotal+{a3}*SeasonPost2021+{i2}*FE2+{i3}*FE3+{i4}*FE4+{i5}*FE5+{i6}*FE6+{i7}*FE7+{i8}*FE8+{i9}*FE9+{i10}*FE10+{i11}*FE11+{i12}*FE12+{i13}*FE13+{i14}*FE14+{i15}*FE15+{i16}*FE16+{i17}*FE17+{i18}*FE18+{i19}*FE19+{i20}*FE20+{i21}*FE21+{i22}*FE22+{i23}*FE23+{i24}*FE24+{i25}*FE25+{i26}*FE26+{i27}*FE27+{i28}*FE28+{i29}*FE29+{i30}*FE30+{i31}*FE31+{i32}*FE32+{b0}), vce(cluster FE) iterate(500)
		}
		else if `CoYFlag' == 1 {
			nl (wins=`AvgConst1'*QBAV+exp({lnb2})*RBFBAV+exp({lnb3})*WRAV+exp({lnb4})*TEAV+exp({lnb5})*LTAV+exp({lnb6})*GAV+exp({lnb7})*CAV+exp({lnb8})*RTAV+exp({lnb9})*DEAV+exp({lnb10})*DTAV+exp({lnb11})*ILBAV+exp({lnb12})*OLBAV+exp({lnb13})*CBAV+exp({lnb14})*FSAV+exp({lnb15})*SSAV+exp({lnb16})*KAV+exp({lnb17})*PAV+exp({lnb18})*LSAV+{a1}*WinTotal+{a2}*MissWinTotal+{a3}*SeasonPost2021+{a4}*CoY+{i2}*FE2+{i3}*FE3+{i4}*FE4+{i5}*FE5+{i6}*FE6+{i7}*FE7+{i8}*FE8+{i9}*FE9+{i10}*FE10+{i11}*FE11+{i12}*FE12+{i13}*FE13+{i14}*FE14+{i15}*FE15+{i16}*FE16+{i17}*FE17+{i18}*FE18+{i19}*FE19+{i20}*FE20+{i21}*FE21+{i22}*FE22+{i23}*FE23+{i24}*FE24+{i25}*FE25+{i26}*FE26+{i27}*FE27+{i28}*FE28+{i29}*FE29+{i30}*FE30+{i31}*FE31+{i32}*FE32+{b0}), vce(cluster FE) iterate(500)
		}
	}

	if _rc == 0 {
		matrix Const = e(b)
		if c(version) >= 19 {
			matrix Constlnb2lnb9 = Const[1,45+`CoYFlag'..52+`CoYFlag']
			matrix Constlnb10lnb18 = Const[1,36+`CoYFlag'..44+`CoYFlag']
			matrix Consta = Const[1,1..3+`CoYFlag']
			matrix Consti2 = Const[1,15+`CoYFlag']
			matrix Consti3 = Const[1,26+`CoYFlag']
			matrix Consti4i9 = Const[1,30+`CoYFlag'..35+`CoYFlag']
			matrix Consti10i19 = Const[1,5+`CoYFlag'..14+`CoYFlag']
			matrix Consti20i29 = Const[1,16+`CoYFlag'..25+`CoYFlag']
			matrix Consti30i32 = Const[1,27+`CoYFlag'..29+`CoYFlag']
			matrix Constb0 = Const[1,4+`CoYFlag']
			matrix Const = (Constlnb2lnb9, Constlnb10lnb18, Consta, Consti2, Consti3, Consti4i9, Consti10i19, Consti20i29, Consti30i32, Constb0)
			matrix drop Constlnb2lnb9 Constlnb10lnb18 Consta Consti2 Consti3 Consti4i9 Consti10i19 Consti20i29 Consti30i32 Constb0
		}
		
		forvalues j = 2/18 {
			if c(version) < 19 {
				quietly nlcom b`j': exp(_b[lnb`j':_cons])
			}
			else {
				quietly nlcom b`j': exp(_b[lnb`j'])
			}
			quietly matrix Const[1,`j'-1] = r(b)
		}
		
		matrix ImpCoefs1[`i',1] = AvgConst1[`i',1]
		forvalues j = 2/`End' {
			matrix ImpCoefs1[`i',`j'] = Const[1,`j'-1]
		}
	}
	
	else {
		display as error "Warning: NLS failed on rep `i'"
	}
	
	* Cost effectiveness regressions
	local j = 1
	foreach c in Rook Vet {
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			capture {
				reg `c'`x'AV Log`c'`x'CapPctZTO `c'`x'ZeroDum, vce(cluster FE)
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
	local AvgConst2 = AvgConst2[`i',1]
	capture {
		if `CoYFlag' == 0 {
			nl (wins=`AvgConst2'*QBAV+exp({lnb2})*RBFBAV+exp({lnb3})*WRAV+exp({lnb4})*TEAV+exp({lnb5})*LTAV+exp({lnb6})*GAV+exp({lnb7})*CAV+exp({lnb8})*RTAV+exp({lnb9})*DEAV+exp({lnb10})*DTAV+exp({lnb11})*ILBAV+exp({lnb12})*OLBAV+exp({lnb13})*CBAV+exp({lnb14})*FSAV+exp({lnb15})*SSAV+exp({lnb16})*KAV+exp({lnb17})*PAV+exp({lnb18})*LSAV+{a1}*WinTotal+{a2}*MissWinTotal+{a3}*SeasonPost2021+{i2}*FE2+{i3}*FE3+{i4}*FE4+{i5}*FE5+{i6}*FE6+{i7}*FE7+{i8}*FE8+{i9}*FE9+{i10}*FE10+{i11}*FE11+{i12}*FE12+{i13}*FE13+{i14}*FE14+{i15}*FE15+{i16}*FE16+{i17}*FE17+{i18}*FE18+{i19}*FE19+{i20}*FE20+{i21}*FE21+{i22}*FE22+{i23}*FE23+{i24}*FE24+{i25}*FE25+{i26}*FE26+{i27}*FE27+{i28}*FE28+{i29}*FE29+{i30}*FE30+{i31}*FE31+{i32}*FE32+{b0}), vce(cluster FE)
		}
		else if `CoYFlag' == 1 {
			nl (wins=`AvgConst2'*QBAV+exp({lnb2})*RBFBAV+exp({lnb3})*WRAV+exp({lnb4})*TEAV+exp({lnb5})*LTAV+exp({lnb6})*GAV+exp({lnb7})*CAV+exp({lnb8})*RTAV+exp({lnb9})*DEAV+exp({lnb10})*DTAV+exp({lnb11})*ILBAV+exp({lnb12})*OLBAV+exp({lnb13})*CBAV+exp({lnb14})*FSAV+exp({lnb15})*SSAV+exp({lnb16})*KAV+exp({lnb17})*PAV+exp({lnb18})*LSAV+{a1}*WinTotal+{a2}*MissWinTotal+{a3}*SeasonPost2021+{a4}*CoY+{i2}*FE2+{i3}*FE3+{i4}*FE4+{i5}*FE5+{i6}*FE6+{i7}*FE7+{i8}*FE8+{i9}*FE9+{i10}*FE10+{i11}*FE11+{i12}*FE12+{i13}*FE13+{i14}*FE14+{i15}*FE15+{i16}*FE16+{i17}*FE17+{i18}*FE18+{i19}*FE19+{i20}*FE20+{i21}*FE21+{i22}*FE22+{i23}*FE23+{i24}*FE24+{i25}*FE25+{i26}*FE26+{i27}*FE27+{i28}*FE28+{i29}*FE29+{i30}*FE30+{i31}*FE31+{i32}*FE32+{b0}), vce(cluster FE)
		}
	}

	if _rc == 0 {
		matrix Const = e(b)
		if c(version) >= 19 {
			matrix Constlnb2lnb9 = Const[1,45+`CoYFlag'..52+`CoYFlag']
			matrix Constlnb10lnb18 = Const[1,36+`CoYFlag'..44+`CoYFlag']
			matrix Consta = Const[1,1..3+`CoYFlag']
			matrix Consti2 = Const[1,15+`CoYFlag']
			matrix Consti3 = Const[1,26+`CoYFlag']
			matrix Consti4i9 = Const[1,30+`CoYFlag'..35+`CoYFlag']
			matrix Consti10i19 = Const[1,5+`CoYFlag'..14+`CoYFlag']
			matrix Consti20i29 = Const[1,16+`CoYFlag'..25+`CoYFlag']
			matrix Consti30i32 = Const[1,27+`CoYFlag'..29+`CoYFlag']
			matrix Constb0 = Const[1,4+`CoYFlag']
			matrix Const = (Constlnb2lnb9, Constlnb10lnb18, Consta, Consti2, Consti3, Consti4i9, Consti10i19, Consti20i29, Consti30i32, Constb0)
			matrix drop Constlnb2lnb9 Constlnb10lnb18 Consta Consti2 Consti3 Consti4i9 Consti10i19 Consti20i29 Consti30i32 Constb0
		}
		
		forvalues j = 2/18 {
			if c(version) < 19 {
				quietly nlcom b`j': exp(_b[lnb`j':_cons])
			}
			else {
				quietly nlcom b`j': exp(_b[lnb`j'])
			}
			quietly matrix Const[1,`j'-1] = r(b)
		}
		
		matrix ImpCoefs2[`i',1] = AvgConst2[`i',1]
		forvalues j = 2/`End' {
			matrix ImpCoefs2[`i',`j'] = Const[1,`j'-1]
		}
	}
	
	else {
		display as error "Warning: NLS failed on rep `i'"
	}
	
	* Cost effectiveness regressions
	local j = 1
	foreach c in Rook Vet {
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
			capture {
				reg `c'`x'AV Log`c'`x'CapPctZTO `c'`x'ZeroDum, vce(cluster FE)
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

* NLS standard errors
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

save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 22 Season Bootstrap Pre-2018.dta", replace
timer off 1
timer list 1
display "Runtime: " r(t1)/60 " minutes"
log close