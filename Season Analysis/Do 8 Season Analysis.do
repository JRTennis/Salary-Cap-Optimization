clear all

* PeriodFlag = 0 if 2011-2024, 1 if 2011-2017, 2 if 2018-2024
local PeriodFlag = 0
if `PeriodFlag' == 0 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 12 AME.dta"
}
else if `PeriodFlag' == 1 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 15 AME Pre-2018.dta"
}
else if `PeriodFlag' == 2 {
	use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 16 AME Post-2018.dta"
}
foreach x in Rate ANYA TANYA FPA {
	local GameAME`x' = GameAME`x'
	local SeasonAME`x' = SeasonAME`x'
}

use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 11 Season Merge.dta"
if `PeriodFlag' == 1 {
	keep if Season < 2018
}
else if `PeriodFlag' == 2 {
	keep if Season >= 2018
}

* 2011 Indianapolis Colts missing Vegas Wins O/U
gen MissWinTotal = 0
replace MissWinTotal = 1 if WinTotal == .
label variable MissWinTotal MissWinTotal
order MissWinTotal, after(WinTotal)
sum WinTotal
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

* Generate Variables and Summarize (Pool FB with RB)
gen RBFBAV = RBAV+FBAV
gen OffAV = QBAV+RBFBAV+WRAV+TEAV+LTAV+GAV+CAV+RTAV
gen DefAV = DEAV+DTAV+ILBAV+OLBAV+CBAV+FSAV+SSAV
gen STAV = KAV+PAV+LSAV
gen NonQBAV = OffAV-QBAV
gen RBFBCap = RBCap+FBCap
gen OffCap = QBCap+RBFBCap+WRCap+TECap+LTCap+GCap+CCap+RTCap
gen DefCap = DECap+DTCap+ILBCap+OLBCap+CBCap+FSCap+SSCap
gen STCap = KCap+PCap+LSCap

foreach x in QB RBFB WR TE LT G C RT {
	quietly gen Non`x'Cap = OffCap-`x'Cap
}
foreach x in DE DT ILB OLB CB FS SS {
	quietly gen Non`x'Cap = DefCap-`x'Cap
}
foreach x in K P LS {
	quietly gen Non`x'Cap = STCap-`x'Cap
}

gen Cap = QBCap+RBFBCap+WRCap+TECap+LTCap+GCap+CCap+RTCap+DECap+DTCap+ILBCap+OLBCap+CBCap+FSCap+SSCap+KCap+PCap+LSCap
foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
	quietly gen `x'CapPct = `x'Cap/Cap
	quietly gen Non`x'CapPct = Non`x'Cap/Cap
}
foreach x in Off Def ST {
	quietly gen `x'CapPct = `x'Cap/Cap
}

* Season Analysis for All Positions
local NPos = 18
* SpecFlag = 0 if Baseline, 1 if Calibrated
local SpecFlag = 0
* CoYFlag = 0 if no CoY, 1 if CoY
local CoYFlag = 0
if `CoYFlag' == 0 {
	local CoY = ""
}
else if `CoYFlag' == 1 {
	local CoY = "CoY"
}

* CapFlag = 0 if log(x)+ZeroDum, 1 if log(x+Epsilon), 2 if sqrt(x), 3 if asinh(x/Epsilon)
local CapFlag = 0
scalar Epsilon = 1
* CorrectFlag = 0 if no correction term, 1 if correction term
local CorrectFlag = 0
* ArsinhFlag = 0 if restricted translog is log(x), 1 if it's arsinh(x)
local ArsinhFlag = 1

* Stage 1: Reg Wins on AV
* Unconstrained
reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 `CoY' i.FE, vce(cluster FE)
matrix Uncon = e(b)
matrix UnconV = e(V)
scalar UnconR2 = e(r2)
scalar UnconAdjR2 = e(r2_a)

* Standard Errors
quietly matrix UnconVDiag = vecdiag(UnconV)
quietly local UnconNCols = colsof(UnconVDiag)
quietly matrix UnconSE = J(1,`UnconNCols',.)
forvalues i = 1/`UnconNCols' {
	quietly matrix UnconSE[1,`i'] = sqrt(UnconVDiag[1,`i'])
}

gen Count = 1
foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
	quietly gen `x'Uncon = Uncon[1,Count]
	quietly replace Count = Count+1
}

* Interactions
gen OLAV = LTAV+GAV+CAV+RTAV
gen GCRTAV = GAV+CAV+RTAV

gen QBNonQBAV = QBAV*NonQBAV
gen OffDefAV = OffAV*DefAV
gen QBWRAV = QBAV*WRAV
gen RBOLAV = RBFBAV*OLAV
gen QBTEAV = QBAV*TEAV
gen LTOLAV = LTAV*GCRTAV

reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 `CoY' QBWRAV RBOLAV i.FE, vce(cluster FE)
matrix G1Coefs = e(b)
matrix G1V = e(V)
scalar G1R2 = e(r2)
scalar G1AdjR2 = e(r2_a)
reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 `CoY' QBWRAV RBOLAV QBTEAV LTOLAV i.FE, vce(cluster FE)
matrix G2Coefs = e(b)
matrix G2V = e(V)
scalar G2R2 = e(r2)
scalar G2AdjR2 = e(r2_a)
reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV WinTotal MissWinTotal SeasonPost2021 `CoY' QBNonQBAV OffDefAV i.FE, vce(cluster FE)
matrix G3Coefs = e(b)
matrix G3V = e(V)
scalar G3R2 = e(r2)
scalar G3AdjR2 = e(r2_a)

* Standard Errors
forvalues i = 1/3 {
	quietly matrix G`i'VDiag = vecdiag(G`i'V)
	quietly local G`i'NCols = colsof(G`i'VDiag)
	quietly matrix G`i'SE = J(1,`G`i'NCols',.)
	forvalues j = 1/`G`i'NCols' {
		quietly matrix G`i'SE[1,`j'] = sqrt(G`i'VDiag[1,`j'])
	}
}

* Cobb-Douglas and Restricted Translog
foreach x in Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV NonQBAV OffAV DefAV OLAV GCRTAV {
	* Inverse hyperbolic sine due to zero values
	if `ArsinhFlag' == 0 {
		quietly gen Ln`x' = log(`x')
	}
	else if `ArsinhFlag' == 1 {
		quietly gen Ln`x' = asinh(`x')
	}
}
gen LnQBNonQBAV = LnQBAV*LnNonQBAV
gen LnOffDefAV = LnOffAV*LnDefAV
gen LnQBWRAV = LnQBAV*LnWRAV
gen LnRBOLAV = LnRBFBAV*LnOLAV
gen LnQBTEAV = LnQBAV*LnTEAV
gen LnLTOLAV = LnLTAV*LnOLAV

reg LnWins LnQBAV LnRBFBAV LnWRAV LnTEAV LnLTAV LnGAV LnCAV LnRTAV LnDEAV LnDTAV LnILBAV LnOLBAV LnCBAV LnFSAV LnSSAV LnKAV LnPAV LnLSAV WinTotal MissWinTotal SeasonPost2021 `CoY' i.FE, vce(cluster FE)
matrix LnUncon = e(b)
matrix LnUnconV = e(V)
scalar LnUnconR2 = e(r2)
scalar LnUnconAdjR2 = e(r2_a)
scalar LnUnconN = e(N)
reg LnWins LnQBAV LnRBFBAV LnWRAV LnTEAV LnLTAV LnGAV LnCAV LnRTAV LnDEAV LnDTAV LnILBAV LnOLBAV LnCBAV LnFSAV LnSSAV LnKAV LnPAV LnLSAV WinTotal MissWinTotal SeasonPost2021 `CoY' LnQBWRAV LnRBOLAV i.FE, vce(cluster FE)
matrix LnG1Coefs = e(b)
matrix LnG1V = e(V)
scalar LnG1R2 = e(r2)
scalar LnG1AdjR2 = e(r2_a)
reg LnWins LnQBAV LnRBFBAV LnWRAV LnTEAV LnLTAV LnGAV LnCAV LnRTAV LnDEAV LnDTAV LnILBAV LnOLBAV LnCBAV LnFSAV LnSSAV LnKAV LnPAV LnLSAV WinTotal MissWinTotal SeasonPost2021 `CoY' LnQBWRAV LnRBOLAV LnQBTEAV LnLTOLAV i.FE, vce(cluster FE)
matrix LnG2Coefs = e(b)
matrix LnG2V = e(V)
scalar LnG2R2 = e(r2)
scalar LnG2AdjR2 = e(r2_a)
reg LnWins LnQBAV LnRBFBAV LnWRAV LnTEAV LnLTAV LnGAV LnCAV LnRTAV LnDEAV LnDTAV LnILBAV LnOLBAV LnCBAV LnFSAV LnSSAV LnKAV LnPAV LnLSAV WinTotal MissWinTotal SeasonPost2021 `CoY' LnQBNonQBAV LnOffDefAV i.FE, vce(cluster FE)
matrix LnG3Coefs = e(b)
matrix LnG3V = e(V)
scalar LnG3R2 = e(r2)
scalar LnG3AdjR2 = e(r2_a)

* Standard Errors
foreach x in "Uncon" "G1" "G2" "G3" {
	quietly matrix Ln`x'VDiag = vecdiag(Ln`x'V)
	quietly local Ln`x'NCols = colsof(Ln`x'VDiag)
	quietly matrix Ln`x'SE = J(1,`Ln`x'NCols',.)
	forvalues i = 1/`Ln`x'NCols' {
		quietly matrix Ln`x'SE[1,`i'] = sqrt(Ln`x'VDiag[1,`i'])
	}
}

* Constrained with optimal weights
sum QBAV
gen QBAVSD = r(sd)
scalar QBAVSD = r(sd)
local Factor = (10*16+4*17)/14
foreach x in Rate ANYA TANYA FPA {
	quietly sum `x'
	quietly gen `x'SD = r(sd)
	scalar `x'SD = r(sd)
	if `SpecFlag' == 1 {
		quietly gen `x'WinP = `SeasonAME`x''*`x'SD*100
		quietly gen `x'Wins = `SeasonAME`x''*`x'SD*`Factor'
		quietly gen `x'Const = `SeasonAME`x''*(`x'SD/QBAVSD)*`Factor'
		
		quietly sum `x'
		quietly gen `x'WTB = (r(max)-r(min))/r(sd)
		quietly gen `x'WTBWins = `x'WTB*`x'Wins
	}
}

if `SpecFlag' == 0 {
	scalar AvgConst = Uncon[1,1]
}
else if `SpecFlag' == 1 {
	tempfile dataset
	save `dataset', replace
	
	if `PeriodFlag' == 0 {
		use "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\Data 17 Game Bootstrap.dta", clear
	}
	else if `PeriodFlag' == 1 {
		use "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\Data 18 Game Bootstrap Pre-2018.dta", clear
	}
	else if `PeriodFlag' == 2 {
		use "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\Data 19 Game Bootstrap Post-2018.dta", clear
	}
	
	foreach x in Rate ANYA TANYA FPA {
		quietly gen `x'Scale = `x'*(`x'SD/QBAVSD)*`Factor'
	}
	corr RateScale ANYAScale TANYAScale FPAScale, cov
	matrix BootV = r(C)
	matrix InvBootV = invsym(BootV)
	matrix Ones = J(4,1,1)
	matrix Denom = Ones'*InvBootV *Ones
	matrix Weights = InvBootV*Ones/Denom[1,1]
	
	use `dataset', clear
	scalar AvgConst = Weights[1,1]*RateConst+Weights[2,1]*ANYAConst+Weights[3,1]*TANYAConst+Weights[4,1]*FPAConst
}

* Constrain AV Coefs > 0 (Stata 19's nl command breaks when the dependent variable name is capitalized)
gen wins = Wins
if `CoYFlag' == 0 {
	nl (wins=AvgConst*QBAV+exp({lnb2})*RBFBAV+exp({lnb3})*WRAV+exp({lnb4})*TEAV+exp({lnb5})*LTAV+exp({lnb6})*GAV+exp({lnb7})*CAV+exp({lnb8})*RTAV+exp({lnb9})*DEAV+exp({lnb10})*DTAV+exp({lnb11})*ILBAV+exp({lnb12})*OLBAV+exp({lnb13})*CBAV+exp({lnb14})*FSAV+exp({lnb15})*SSAV+exp({lnb16})*KAV+exp({lnb17})*PAV+exp({lnb18})*LSAV+{a1}*WinTotal+{a2}*MissWinTotal+{a3}*SeasonPost2021+{i2}*FE2+{i3}*FE3+{i4}*FE4+{i5}*FE5+{i6}*FE6+{i7}*FE7+{i8}*FE8+{i9}*FE9+{i10}*FE10+{i11}*FE11+{i12}*FE12+{i13}*FE13+{i14}*FE14+{i15}*FE15+{i16}*FE16+{i17}*FE17+{i18}*FE18+{i19}*FE19+{i20}*FE20+{i21}*FE21+{i22}*FE22+{i23}*FE23+{i24}*FE24+{i25}*FE25+{i26}*FE26+{i27}*FE27+{i28}*FE28+{i29}*FE29+{i30}*FE30+{i31}*FE31+{i32}*FE32+{b0}), vce(cluster FE)
}
else if `CoYFlag' == 1 {
	nl (wins=AvgConst*QBAV+exp({lnb2})*RBFBAV+exp({lnb3})*WRAV+exp({lnb4})*TEAV+exp({lnb5})*LTAV+exp({lnb6})*GAV+exp({lnb7})*CAV+exp({lnb8})*RTAV+exp({lnb9})*DEAV+exp({lnb10})*DTAV+exp({lnb11})*ILBAV+exp({lnb12})*OLBAV+exp({lnb13})*CBAV+exp({lnb14})*FSAV+exp({lnb15})*SSAV+exp({lnb16})*KAV+exp({lnb17})*PAV+exp({lnb18})*LSAV+{a1}*WinTotal+{a2}*MissWinTotal+{a3}*SeasonPost2021+{a4}*CoY+{i2}*FE2+{i3}*FE3+{i4}*FE4+{i5}*FE5+{i6}*FE6+{i7}*FE7+{i8}*FE8+{i9}*FE9+{i10}*FE10+{i11}*FE11+{i12}*FE12+{i13}*FE13+{i14}*FE14+{i15}*FE15+{i16}*FE16+{i17}*FE17+{i18}*FE18+{i19}*FE19+{i20}*FE20+{i21}*FE21+{i22}*FE22+{i23}*FE23+{i24}*FE24+{i25}*FE25+{i26}*FE26+{i27}*FE27+{i28}*FE28+{i29}*FE29+{i30}*FE30+{i31}*FE31+{i32}*FE32+{b0}), vce(cluster FE)
}
drop wins
matrix Const = e(b)
matrix ConstV = e(V)
scalar ConstR2 = e(r2)
scalar ConstAdjR2 = e(r2_a)

* Reconstruct Const and ConstV to match Stata 18 formatting
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
	
	matrix ConstV11 = ConstV[45+`CoYFlag'..52+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV21 = ConstV[36+`CoYFlag'..44+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV31 = ConstV[1..3+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV41 = ConstV[15+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV51 = ConstV[26+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV61 = ConstV[30+`CoYFlag'..35+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV71 = ConstV[5+`CoYFlag'..14+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV81 = ConstV[16+`CoYFlag'..25+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV91 = ConstV[27+`CoYFlag'..29+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	matrix ConstV101 = ConstV[4+`CoYFlag',45+`CoYFlag'..52+`CoYFlag']
	
	matrix ConstV22 = ConstV[36+`CoYFlag'..44+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV32 = ConstV[1..3+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV42 = ConstV[15+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV52 = ConstV[26+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV62 = ConstV[30+`CoYFlag'..35+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV72 = ConstV[5+`CoYFlag'..14+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV82 = ConstV[16+`CoYFlag'..25+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV92 = ConstV[27+`CoYFlag'..29+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	matrix ConstV102 = ConstV[4+`CoYFlag',36+`CoYFlag'..44+`CoYFlag']
	
	matrix ConstV33 = ConstV[1..3+`CoYFlag',1..3+`CoYFlag']
	matrix ConstV43 = ConstV[15+`CoYFlag',1..3+`CoYFlag']
	matrix ConstV53 = ConstV[26+`CoYFlag',1..3+`CoYFlag']
	matrix ConstV63 = ConstV[30+`CoYFlag'..35+`CoYFlag',1..3+`CoYFlag']
	matrix ConstV73 = ConstV[5+`CoYFlag'..14+`CoYFlag',1..3+`CoYFlag']
	matrix ConstV83 = ConstV[16+`CoYFlag'..25+`CoYFlag',1..3+`CoYFlag']
	matrix ConstV93 = ConstV[27+`CoYFlag'..29+`CoYFlag',1..3+`CoYFlag']
	matrix ConstV103 = ConstV[4+`CoYFlag',1..3+`CoYFlag']
	
	matrix ConstV44 = ConstV[15+`CoYFlag',15+`CoYFlag']
	matrix ConstV54 = ConstV[26+`CoYFlag',15+`CoYFlag']
	matrix ConstV64 = ConstV[30+`CoYFlag'..35+`CoYFlag',15+`CoYFlag']
	matrix ConstV74 = ConstV[5+`CoYFlag'..14+`CoYFlag',15+`CoYFlag']
	matrix ConstV84 = ConstV[16+`CoYFlag'..25+`CoYFlag',15+`CoYFlag']
	matrix ConstV94 = ConstV[27+`CoYFlag'..29+`CoYFlag',15+`CoYFlag']
	matrix ConstV104 = ConstV[4+`CoYFlag',15+`CoYFlag']
	
	matrix ConstV55 = ConstV[26+`CoYFlag',26+`CoYFlag']
	matrix ConstV65 = ConstV[30+`CoYFlag'..35+`CoYFlag',26+`CoYFlag']
	matrix ConstV75 = ConstV[5+`CoYFlag'..14+`CoYFlag',26+`CoYFlag']
	matrix ConstV85 = ConstV[16+`CoYFlag'..25+`CoYFlag',26+`CoYFlag']
	matrix ConstV95 = ConstV[27+`CoYFlag'..29+`CoYFlag',26+`CoYFlag']
	matrix ConstV105 = ConstV[4+`CoYFlag',26+`CoYFlag']
	
	matrix ConstV66 = ConstV[30+`CoYFlag'..35+`CoYFlag',30+`CoYFlag'..35+`CoYFlag']
	matrix ConstV76 = ConstV[5+`CoYFlag'..14+`CoYFlag',30+`CoYFlag'..35+`CoYFlag']
	matrix ConstV86 = ConstV[16+`CoYFlag'..25+`CoYFlag',30+`CoYFlag'..35+`CoYFlag']
	matrix ConstV96 = ConstV[27+`CoYFlag'..29+`CoYFlag',30+`CoYFlag'..35+`CoYFlag']
	matrix ConstV106 = ConstV[4+`CoYFlag',30+`CoYFlag'..35+`CoYFlag']
	
	matrix ConstV77 = ConstV[5+`CoYFlag'..14+`CoYFlag',5+`CoYFlag'..14+`CoYFlag']
	matrix ConstV87 = ConstV[16+`CoYFlag'..25+`CoYFlag',5+`CoYFlag'..14+`CoYFlag']
	matrix ConstV97 = ConstV[27+`CoYFlag'..29+`CoYFlag',5+`CoYFlag'..14+`CoYFlag']
	matrix ConstV107 = ConstV[4+`CoYFlag',5+`CoYFlag'..14+`CoYFlag']
	
	matrix ConstV88 = ConstV[16+`CoYFlag'..25+`CoYFlag',16+`CoYFlag'..25+`CoYFlag']
	matrix ConstV98 = ConstV[27+`CoYFlag'..29+`CoYFlag',16+`CoYFlag'..25+`CoYFlag']
	matrix ConstV108 = ConstV[4+`CoYFlag',16+`CoYFlag'..25+`CoYFlag']
	
	matrix ConstV99 = ConstV[27+`CoYFlag'..29+`CoYFlag',27+`CoYFlag'..29+`CoYFlag']
	matrix ConstV109 = ConstV[4+`CoYFlag',27+`CoYFlag'..29+`CoYFlag']
	
	matrix ConstV1010 = ConstV[4+`CoYFlag',4+`CoYFlag']
	
	matrix ConstV = (ConstV11 , ConstV21', ConstV31', ConstV41', ConstV51', ConstV61', ConstV71', ConstV81', ConstV91', ConstV101'  ///
					\ConstV21 , ConstV22 , ConstV32', ConstV42', ConstV52', ConstV62', ConstV72', ConstV82', ConstV92', ConstV102'  ///
					\ConstV31 , ConstV32 , ConstV33 , ConstV43', ConstV53', ConstV63', ConstV73', ConstV83', ConstV93', ConstV103'  ///
					\ConstV41 , ConstV42 , ConstV43 , ConstV44 , ConstV54', ConstV64', ConstV74', ConstV84', ConstV94', ConstV104'  ///
					\ConstV51 , ConstV52 , ConstV53 , ConstV54 , ConstV55 , ConstV65', ConstV75', ConstV85', ConstV95', ConstV105'  ///
					\ConstV61 , ConstV62 , ConstV63 , ConstV64 , ConstV65 , ConstV66 , ConstV76', ConstV86', ConstV96', ConstV106'  ///
					\ConstV71 , ConstV72 , ConstV73 , ConstV74 , ConstV75 , ConstV76 , ConstV77 , ConstV87', ConstV97', ConstV107'  ///
					\ConstV81 , ConstV82 , ConstV83 , ConstV84 , ConstV85 , ConstV86 , ConstV87 , ConstV88 , ConstV98', ConstV108'  ///
					\ConstV91 , ConstV92 , ConstV93 , ConstV94 , ConstV95 , ConstV96 , ConstV97 , ConstV98 , ConstV99 , ConstV109'  ///
					\ConstV101, ConstV102, ConstV103, ConstV104, ConstV105, ConstV106, ConstV107, ConstV108, ConstV109, ConstV1010)
	
	matrix drop ConstV11 ConstV21 ConstV31 ConstV41 ConstV51 ConstV61 ConstV71 ConstV81 ConstV91 ConstV101 ///
				ConstV22 ConstV32 ConstV42 ConstV52 ConstV62 ConstV72 ConstV82 ConstV92 ConstV102 ///
				ConstV33 ConstV43 ConstV53 ConstV63 ConstV73 ConstV83 ConstV93 ConstV103 ///
				ConstV44 ConstV54 ConstV64 ConstV74 ConstV84 ConstV94 ConstV104 ///
				ConstV55 ConstV65 ConstV75 ConstV85 ConstV95 ConstV105 ///
				ConstV66 ConstV76 ConstV86 ConstV96 ConstV106 ///
				ConstV77 ConstV87 ConstV97 ConstV107 ///
				ConstV88 ConstV98 ConstV108 ///
				ConstV99 ConstV109 ///
				ConstV1010
}

* Exp transform and apply delta method for variance matrix
forvalues i = 2/18 {
    if c(version) < 19 {
        quietly nlcom b`i': exp(_b[lnb`i':_cons])
    }
    else {
        quietly nlcom b`i': exp(_b[lnb`i'])
    }
	quietly matrix Const[1,`i'-1] = r(b)
	quietly matrix ConstV[`i'-1,`i'-1] = r(V)
}

quietly matrix ConstVDiag = vecdiag(ConstV)
quietly local ConstNCols = colsof(ConstVDiag)
quietly matrix ConstSE = J(1,`ConstNCols',.)
forvalues i = 1/`ConstNCols' {
	quietly matrix ConstSE[1,`i'] = sqrt(ConstVDiag[1,`i'])
}

matrix Const = (AvgConst,Const)
matrix ConstSE = (.,ConstSE)

foreach x in "" "SE" {
	matrix Const`x'L = Const`x'[1...,1..21+`CoYFlag']
	matrix Const`x'R = Const`x'[1...,22+`CoYFlag'...]
	matrix Const`x' = (Const`x'L,0,Const`x'R)
	matrix Const`x'L = Const`x'[1...,1..53+`CoYFlag']
	matrix Const`x'R = Const`x'[1...,54+`CoYFlag'...]
	matrix Const`x' = (Const`x'L,0,Const`x'R)
}

replace Count = 1
foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
	quietly gen `x'Const = Const[1,Count]
	quietly replace Count = Count+1
}

* Display Stage 1
replace Count = 1
foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
	if Count == 1 {
		disp "Legend: Unconstrained / Constrained"
	}
	disp "`x' Stage 1: " `x'Uncon " / " `x'Const
	quietly replace Count = Count+1
}
correlate QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV
correlate DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV
correlate KAV PAV LSAV

* Stage 2: Reg AV on Cap (Use CapPct Because Cap Increases)
foreach i in Rook Vet {
	gen `i'RBFBAV = `i'RBAV+`i'FBAV
	gen `i'RBFBCap = `i'RBCap+`i'FBCap
	gen `i'Cap = `i'QBCap+`i'RBFBCap+`i'WRCap+`i'TECap+`i'LTCap+`i'GCap+`i'CCap+`i'RTCap+`i'DECap+`i'DTCap+`i'ILBCap+`i'OLBCap+`i'CBCap+`i'FSCap+`i'SSCap+`i'KCap+`i'PCap+`i'LSCap
}

foreach i in Rook Vet {
	foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
		if `SpecFlag' == 0 {
			quietly gen `i'`x'Win = `x'Uncon*`i'`x'AV
		}
		else if `SpecFlag' == 1 {
			quietly gen `i'`x'Win = `x'Const*`i'`x'AV
		}
	}
}

foreach i in Rook Vet {
	foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
		* Zero dummy for teams that don't allocate toward a position-contract type pair
		quietly gen `i'`x'CapPct = `i'`x'Cap/`i'Cap*100
		if `CapFlag' == 0 {
			quietly gen `i'`x'ZeroDum = 0
			quietly replace `i'`x'ZeroDum = 1 if `i'`x'CapPct == 0
			quietly gen `i'`x'CapPctZTO = `i'`x'CapPct
			quietly replace `i'`x'CapPctZTO = 1 if `i'`x'CapPctZTO == 0
			quietly gen Log`i'`x'CapPctZTO = log(`i'`x'CapPctZTO)
		}
		else if `CapFlag' == 1 {
			quietly gen Log`i'`x'CapPctEpsilon = log(`i'`x'CapPct+Epsilon)
		}
		else if `CapFlag' == 2 {
			quietly gen Sqrt`i'`x'CapPct = sqrt(`i'`x'CapPct)
		}
		else if `CapFlag' == 3 {
			quietly gen Asinh`i'`x'CapPctEpsilon = asinh(`i'`x'CapPct/Epsilon)
		}
		
		* Cost Effectiveness Regressions
		if `CapFlag' == 0 {
			quietly reg `i'`x'AV Log`i'`x'CapPctZTO `i'`x'ZeroDum, vce(cluster FE)
		}
		else if `CapFlag' == 1 {
			quietly reg `i'`x'AV Log`i'`x'CapPctEpsilon, vce(cluster FE)
		}
		else if `CapFlag' == 2 {
			quietly reg `i'`x'AV Sqrt`i'`x'CapPct, vce(cluster FE)
		}
		else if `CapFlag' == 3 {
			quietly reg `i'`x'AV Asinh`i'`x'CapPctEpsilon, vce(cluster FE)
		}
		quietly matrix `i'`x'Coefs = e(b)
		quietly matrix `i'`x'V = e(V)
		quietly scalar `i'`x'R2 = e(r2)
		quietly gen `i'`x'Coef = `i'`x'Coefs[1,1]
		
		* Standard Errors
		quietly matrix `i'`x'VDiag = vecdiag(`i'`x'V)
		quietly local `i'`x'NCols = colsof(`i'`x'VDiag)
		quietly matrix `i'`x'SE = J(1,``i'`x'NCols',.)
		forvalues j = 1/``i'`x'NCols' {
			quietly matrix `i'`x'SE[1,`j'] = sqrt(`i'`x'VDiag[1,`j'])
		}
	}
}

* Display Stage 2
replace Count = 1
foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
	if Count == 1 {
		disp "Legend: Rookie / Veteran"
	}
	disp "`x' Stage 2: " Rook`x'Coef " / " Vet`x'Coef
	quietly replace Count = Count+1
}

* Obtain and Display Optimal Allocation
foreach i in Rook Vet {
	if `SpecFlag' == 0 {
		if `CapFlag' == 0 | `CapFlag' == 1 | `CapFlag' == 3 {
			quietly gen `i'SumCoef = QBUncon*`i'QBCoef+RBFBUncon*`i'RBFBCoef+WRUncon*`i'WRCoef+TEUncon*`i'TECoef+LTUncon*`i'LTCoef+GUncon*`i'GCoef+CUncon*`i'CCoef+RTUncon*`i'RTCoef+DEUncon*`i'DECoef+DTUncon*`i'DTCoef+ILBUncon*`i'ILBCoef+OLBUncon*`i'OLBCoef+CBUncon*`i'CBCoef+FSUncon*`i'FSCoef+SSUncon*`i'SSCoef+KUncon*`i'KCoef+PUncon*`i'PCoef+LSUncon*`i'LSCoef
		}
		else if `CapFlag' == 2 {
			quietly gen `i'SumCoef = (QBUncon*`i'QBCoef)^2+(RBFBUncon*`i'RBFBCoef)^2+(WRUncon*`i'WRCoef)^2+(TEUncon*`i'TECoef)^2+(LTUncon*`i'LTCoef)^2+(GUncon*`i'GCoef)^2+(CUncon*`i'CCoef)^2+(RTUncon*`i'RTCoef)^2+(DEUncon*`i'DECoef)^2+(DTUncon*`i'DTCoef)^2+(ILBUncon*`i'ILBCoef)^2+(OLBUncon*`i'OLBCoef)^2+(CBUncon*`i'CBCoef)^2+(FSUncon*`i'FSCoef)^2+(SSUncon*`i'SSCoef)^2+(KUncon*`i'KCoef)^2+(PUncon*`i'PCoef)^2+(LSUncon*`i'LSCoef)^2
		}
	}
	else if `SpecFlag' == 1 {
		if `CapFlag' == 0 | `CapFlag' == 1 | `CapFlag' == 3 {
			quietly gen `i'SumCoef = QBConst*`i'QBCoef+RBFBConst*`i'RBFBCoef+WRConst*`i'WRCoef+TEConst*`i'TECoef+LTConst*`i'LTCoef+GConst*`i'GCoef+CConst*`i'CCoef+RTConst*`i'RTCoef+DEConst*`i'DECoef+DTConst*`i'DTCoef+ILBConst*`i'ILBCoef+OLBConst*`i'OLBCoef+CBConst*`i'CBCoef+FSConst*`i'FSCoef+SSConst*`i'SSCoef+KConst*`i'KCoef+PConst*`i'PCoef+LSConst*`i'LSCoef
		}
		else if `CapFlag' == 2 {
			quietly gen `i'SumCoef = (QBConst*`i'QBCoef)^2+(RBFBConst*`i'RBFBCoef)^2+(WRConst*`i'WRCoef)^2+(TEConst*`i'TECoef)^2+(LTConst*`i'LTCoef)^2+(GConst*`i'GCoef)^2+(CConst*`i'CCoef)^2+(RTConst*`i'RTCoef)^2+(DEConst*`i'DECoef)^2+(DTConst*`i'DTCoef)^2+(ILBConst*`i'ILBCoef)^2+(OLBConst*`i'OLBCoef)^2+(CBConst*`i'CBCoef)^2+(FSConst*`i'FSCoef)^2+(SSConst*`i'SSCoef)^2+(KConst*`i'KCoef)^2+(PConst*`i'PCoef)^2+(LSConst*`i'LSCoef)^2
		}
	}
}

foreach i in Rook Vet {
	foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
		if `SpecFlag' == 0 {
			if `CapFlag' == 0 | `CapFlag' == 1 | `CapFlag' == 3 {
				if (`CapFlag' == 1 | `CapFlag' == 3) & `CorrectFlag' == 1 {
					quietly scalar OptMean`i'`x'CapPct = `x'Uncon*`i'`x'Coef/`i'SumCoef+(Epsilon*`NPos'*`x'Uncon*`i'`x'Coef/`i'SumCoef-Epsilon)/100
				}
				else {
					quietly scalar OptMean`i'`x'CapPct = `x'Uncon*`i'`x'Coef/`i'SumCoef
				}
			}
			else if `CapFlag' == 2 {
				quietly scalar OptMean`i'`x'CapPct = (`x'Uncon*`i'`x'Coef)^2/`i'SumCoef
			}
			disp "`i'`x' Optimal: " OptMean`i'`x'CapPct
		}
		
		else if `SpecFlag' == 1 {
			if `CapFlag' == 0 | `CapFlag' == 1 | `CapFlag' == 3 {
				if (`CapFlag' == 1 | `CapFlag' == 3) & `CorrectFlag' == 1 {
					quietly scalar OptMean`i'`x'CapPct = `x'Const*`i'`x'Coef/`i'SumCoef+(Epsilon*`NPos'*`x'Const*`i'`x'Coef/`i'SumCoef-Epsilon)/100
				}
				else {
					quietly scalar OptMean`i'`x'CapPct = `x'Const*`i'`x'Coef/`i'SumCoef
				}
			}
			else if `CapFlag' == 2 {
				quietly scalar OptMean`i'`x'CapPct = (`x'Const*`i'`x'Coef)^2/`i'SumCoef
			}
			disp "`i'`x' Optimal: " OptMean`i'`x'CapPct
		}
	}
}

* Obtain and Display Actual Allocation
foreach i in Rook Vet {
	foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
		quietly egen Mean`i'`x'CapPct = mean(`i'`x'CapPct)
		quietly scalar ActMean`i'`x'CapPct = Mean`i'`x'CapPct/100
		disp "`i'`x' Actual: " ActMean`i'`x'CapPct
		quietly scalar DiffMean`i'`x'CapPct = ActMean`i'`x'CapPct-OptMean`i'`x'CapPct
	}
}

* Summary Statistics
replace OffCap = QBCap+RBFBCap+WRCap+TECap+LTCap+GCap+CCap+RTCap
replace DefCap = DECap+DTCap+ILBCap+OLBCap+CBCap+FSCap+SSCap
replace STCap = KCap+PCap+LSCap
foreach x in Off Def ST {
	quietly replace `x'CapPct = `x'Cap/Cap
}

matrix Summary = J(50+`CoYFlag',4,.)
foreach x in "" "Rook" "Vet" {
	quietly gen `x'AV = `x'QBAV+`x'RBFBAV+`x'WRAV+`x'TEAV+`x'LTAV+`x'GAV+`x'CAV+`x'RTAV+`x'DEAV+`x'DTAV+`x'ILBAV+`x'OLBAV+`x'CBAV+`x'FSAV+`x'SSAV+`x'KAV+`x'PAV+`x'LSAV
}
foreach x in Wins WinTotal `CoY' {
	quietly sum `x'
	foreach y in mean sd min max {
		quietly scalar `y'`x' = r(`y')
	}
}
foreach x in "" "Rook" "Vet" {
	quietly gen `x'CapPct = `x'Cap/Cap
}

foreach x in "" "Rook" "Vet" "Off" "QB" "RBFB" "WR" "TE" "LT" "G" "C" "RT" "Def" "DE" "DT" "ILB" "OLB" "CB" "FS" "SS" "ST" "K" "P" "LS" {
	foreach y in AV CapPct {
		quietly sum `x'`y'
		foreach z in mean sd min max {
			quietly scalar `z'`x'`y' = r(`z')
		}
	}
}
foreach z in mean sd min max {
	quietly sum Cap
	quietly scalar `z'Cap = r(`z')
}

local CountX = 1
foreach x in Wins WinTotal `CoY' AV Cap RookAV VetAV RookCapPct VetCapPct {
	quietly local CountY = 1
	foreach y in mean sd min max {
		quietly matrix Summary[`CountX',`CountY'] = `y'`x'
		quietly local CountY = `CountY'+1
	}
	quietly local CountX = `CountX'+1
}
foreach x in Off QB RBFB WR TE LT G C RT Def DE DT ILB OLB CB FS SS ST K P LS {
	quietly local CountY = 1
	foreach y in mean sd min max {
		quietly local CountZ = 0
		foreach z in AV CapPct {
			quietly matrix Summary[`CountX'+`CountZ',`CountY'] = `y'`x'`z'
			quietly local CountZ = `CountZ'+21
		}
		quietly local CountY = `CountY'+1
	}
	quietly local CountX = `CountX'+1
}
matrix list Summary, format(%11.0g)
corr QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV

* Regression Tables
if `SpecFlag' == 0 {
	if `CapFlag' == 0 {
		matrix Results = J(44+2*`CoYFlag',9,.)
		local CountX = 1
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS { 
			quietly matrix Results[2*`CountX'-1,1] = Uncon[1,`CountX']
			quietly matrix Results[2*`CountX',1] = UnconSE[1,`CountX']
			
			quietly matrix Results[2*`CountX'-1,2] = Rook`x'Coefs[1,3]
			quietly matrix Results[2*`CountX',2] = Rook`x'SE[1,3]
			quietly matrix Results[2*`CountX'-1,3] = Rook`x'Coefs[1,1]
			quietly matrix Results[2*`CountX',3] = Rook`x'SE[1,1]
			quietly matrix Results[2*`CountX'-1,4] = Rook`x'Coefs[1,2]
			quietly matrix Results[2*`CountX',4] = Rook`x'SE[1,2]
			quietly matrix Results[2*`CountX'-1,5] = Rook`x'R2
			
			quietly matrix Results[2*`CountX'-1,6] = Vet`x'Coefs[1,3]
			quietly matrix Results[2*`CountX',6] = Vet`x'SE[1,3]
			quietly matrix Results[2*`CountX'-1,7] = Vet`x'Coefs[1,1]
			quietly matrix Results[2*`CountX',7] = Vet`x'SE[1,1]
			quietly matrix Results[2*`CountX'-1,8] = Vet`x'Coefs[1,2]
			quietly matrix Results[2*`CountX',8] = Vet`x'SE[1,2]
			quietly matrix Results[2*`CountX'-1,9] = Vet`x'R2
			
			quietly local CountX = `CountX'+1
		}
	}
	
	else {
		matrix Results = J(44+2*`CoYFlag',7,.)
		local CountX = 1
		foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS { 
			quietly matrix Results[2*`CountX'-1,1] = Uncon[1,`CountX']
			quietly matrix Results[2*`CountX',1] = UnconSE[1,`CountX']
			quietly matrix Results[2*`CountX'-1,2] = Rook`x'Coefs[1,2]
			quietly matrix Results[2*`CountX',2] = Rook`x'SE[1,2]
			quietly matrix Results[2*`CountX'-1,3] = Rook`x'Coefs[1,1]
			quietly matrix Results[2*`CountX',3] = Rook`x'SE[1,1]
			quietly matrix Results[2*`CountX'-1,4] = Rook`x'R2
			quietly matrix Results[2*`CountX'-1,5] = Vet`x'Coefs[1,2]
			quietly matrix Results[2*`CountX',5] = Vet`x'SE[1,2]
			quietly matrix Results[2*`CountX'-1,6] = Vet`x'Coefs[1,1]
			quietly matrix Results[2*`CountX',6] = Vet`x'SE[1,1]
			quietly matrix Results[2*`CountX'-1,7] = Vet`x'R2
			quietly local CountX = `CountX'+1
		}
	}
	
	matrix Results[37,1] = Uncon[1,19]
	matrix Results[38,1] = UnconSE[1,19]
	matrix Results[39,1] = Uncon[1,20]
	matrix Results[40,1] = UnconSE[1,20]
	matrix Results[41,1] = Uncon[1,21]
	matrix Results[42,1] = UnconSE[1,21]
	if `CoYFlag' == 1 {
		matrix Results[43,1] = Uncon[1,22]
		matrix Results[44,1] = UnconSE[1,22]
	}
	matrix Results[43+2*`CoYFlag',1] = UnconR2
	matrix Results[44+2*`CoYFlag',1] = UnconAdjR2
	matrix list Results
}

if `SpecFlag' == 1 {
	matrix Results = J(44+2*`CoYFlag',1,.)
	local CountX = 1
	foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS { 
		quietly matrix Results[2*`CountX'-1,1] = Const[1,`CountX']
		quietly matrix Results[2*`CountX',1] = ConstSE[1,`CountX']
		quietly local CountX = `CountX'+1
	}
	matrix Results[37,1] = Const[1,19]
	matrix Results[38,1] = ConstSE[1,19]
	matrix Results[39,1] = Const[1,20]
	matrix Results[40,1] = ConstSE[1,20]
	matrix Results[41,1] = Const[1,21]
	matrix Results[42,1] = ConstSE[1,21]
	if `CoYFlag' == 1 {
		matrix Results[43,1] = Const[1,22]
		matrix Results[44,1] = ConstSE[1,22]
	}
	matrix Results[43+2*`CoYFlag',1] = ConstR2
	matrix Results[44+2*`CoYFlag',1] = ConstAdjR2
	matrix list Results
}

matrix Allocations = J(18,6,.)
local CountX = 1
foreach x in QB RBFB WR TE LT G C RT DE DT ILB OLB CB FS SS K P LS {
	matrix Allocations[`CountX',1] = ActMeanRook`x'CapPct
	matrix Allocations[`CountX',2] = OptMeanRook`x'CapPct
	matrix Allocations[`CountX',3] = DiffMeanRook`x'CapPct
	matrix Allocations[`CountX',4] = ActMeanVet`x'CapPct
	matrix Allocations[`CountX',5] = OptMeanVet`x'CapPct
	matrix Allocations[`CountX',6] = DiffMeanVet`x'CapPct
	local CountX = `CountX'+1
}
matrix list Allocations
scalar list AvgConst 

if `SpecFlag' == 0 {
	foreach x in "" "Ln" {
		quietly matrix `x'Interactions = J(56+2*`CoYFlag',4,.)
		local End = 21+`CoYFlag'
		forvalues i=1/`End' { 
			quietly matrix `x'Interactions[2*`i'-1,1] = `x'Uncon[1,`i']
			quietly matrix `x'Interactions[2*`i',1] = `x'UnconSE[1,`i']
			quietly matrix `x'Interactions[2*`i'-1,2] = `x'G1Coefs[1,`i']
			quietly matrix `x'Interactions[2*`i',2] = `x'G1SE[1,`i']
			quietly matrix `x'Interactions[2*`i'-1,3] = `x'G2Coefs[1,`i']
			quietly matrix `x'Interactions[2*`i',3] = `x'G2SE[1,`i']
			quietly matrix `x'Interactions[2*`i'-1,4] = `x'G3Coefs[1,`i']
			quietly matrix `x'Interactions[2*`i',4] = `x'G3SE[1,`i']
		}
		quietly matrix `x'Interactions[43+2*`CoYFlag',2] = `x'G1Coefs[1,22+`CoYFlag']
		quietly matrix `x'Interactions[44+2*`CoYFlag',2] = `x'G1SE[1,22+`CoYFlag']
		quietly matrix `x'Interactions[45+2*`CoYFlag',2] = `x'G1Coefs[1,23+`CoYFlag']
		quietly matrix `x'Interactions[46+2*`CoYFlag',2] = `x'G1SE[1,23+`CoYFlag']
		quietly matrix `x'Interactions[43+2*`CoYFlag',3] = `x'G2Coefs[1,22+`CoYFlag']
		quietly matrix `x'Interactions[44+2*`CoYFlag',3] = `x'G2SE[1,22+`CoYFlag']
		quietly matrix `x'Interactions[45+2*`CoYFlag',3] = `x'G2Coefs[1,23+`CoYFlag']
		quietly matrix `x'Interactions[46+2*`CoYFlag',3] = `x'G2SE[1,23+`CoYFlag']
		quietly matrix `x'Interactions[47+2*`CoYFlag',3] = `x'G2Coefs[1,24+`CoYFlag']
		quietly matrix `x'Interactions[48+2*`CoYFlag',3] = `x'G2SE[1,24+`CoYFlag']
		quietly matrix `x'Interactions[49+2*`CoYFlag',3] = `x'G2Coefs[1,25+`CoYFlag']
		quietly matrix `x'Interactions[50+2*`CoYFlag',3] = `x'G2SE[1,25+`CoYFlag']
		quietly matrix `x'Interactions[51+2*`CoYFlag',4] = `x'G3Coefs[1,22+`CoYFlag']
		quietly matrix `x'Interactions[52+2*`CoYFlag',4] = `x'G3SE[1,22+`CoYFlag']
		quietly matrix `x'Interactions[53+2*`CoYFlag',4] = `x'G3Coefs[1,23+`CoYFlag']
		quietly matrix `x'Interactions[54+2*`CoYFlag',4] = `x'G3SE[1,23+`CoYFlag']
		quietly matrix `x'Interactions[55+2*`CoYFlag',1] = `x'UnconR2
		quietly matrix `x'Interactions[55+2*`CoYFlag',2] = `x'G1R2
		quietly matrix `x'Interactions[55+2*`CoYFlag',3] = `x'G2R2
		quietly matrix `x'Interactions[55+2*`CoYFlag',4] = `x'G3R2
		quietly matrix `x'Interactions[56+2*`CoYFlag',1] = `x'UnconAdjR2
		quietly matrix `x'Interactions[56+2*`CoYFlag',2] = `x'G1AdjR2
		quietly matrix `x'Interactions[56+2*`CoYFlag',3] = `x'G2AdjR2
		quietly matrix `x'Interactions[56+2*`CoYFlag',4] = `x'G3AdjR2
		matrix list `x'Interactions
	}
	
	if `ArsinhFlag' == 0 {
		scalar list LnUnconN
	}
}

* Compensated wins
if `CapFlag' == 0 {
	sum WinTotal
	local MeanWinTotal = r(mean)
	sum MissWinTotal
	local MeanMissWinTotal = r(mean)
	sum CoY
	local MeanCoY = r(mean)

	gen CompWins =              Const[1,1]*(RookQBCoefs[1,3]+RookQBCoefs[1,1]*LogRookQBCapPctZTO+RookQBCoefs[1,2]*RookQBZeroDum+VetQBCoefs[1,3]+VetQBCoefs[1,1]*LogVetQBCapPctZTO+VetQBCoefs[1,2]*VetQBZeroDum)
	replace CompWins = CompWins+Const[1,2]*(RookRBFBCoefs[1,3]+RookRBFBCoefs[1,1]*LogRookRBFBCapPctZTO+RookRBFBCoefs[1,2]*RookRBFBZeroDum+VetRBFBCoefs[1,3]+VetRBFBCoefs[1,1]*LogVetRBFBCapPctZTO+VetRBFBCoefs[1,2]*VetRBFBZeroDum)
	replace CompWins = CompWins+Const[1,3]*(RookWRCoefs[1,3]+RookWRCoefs[1,1]*LogRookWRCapPctZTO+RookWRCoefs[1,2]*RookWRZeroDum+VetWRCoefs[1,3]+VetWRCoefs[1,1]*LogVetWRCapPctZTO+VetWRCoefs[1,2]*VetWRZeroDum)
	replace CompWins = CompWins+Const[1,4]*(RookTECoefs[1,3]+RookTECoefs[1,1]*LogRookTECapPctZTO+RookTECoefs[1,2]*RookTEZeroDum+VetTECoefs[1,3]+VetTECoefs[1,1]*LogVetTECapPctZTO+VetTECoefs[1,2]*VetTEZeroDum)
	replace CompWins = CompWins+Const[1,5]*(RookLTCoefs[1,3]+RookLTCoefs[1,1]*LogRookLTCapPctZTO+RookLTCoefs[1,2]*RookLTZeroDum+VetLTCoefs[1,3]+VetLTCoefs[1,1]*LogVetLTCapPctZTO+VetLTCoefs[1,2]*VetLTZeroDum)
	replace CompWins = CompWins+Const[1,6]*(RookGCoefs[1,3]+RookGCoefs[1,1]*LogRookGCapPctZTO+RookGCoefs[1,2]*RookGZeroDum+VetGCoefs[1,3]+VetGCoefs[1,1]*LogVetGCapPctZTO+VetGCoefs[1,2]*VetGZeroDum)
	replace CompWins = CompWins+Const[1,7]*(RookCCoefs[1,3]+RookCCoefs[1,1]*LogRookCCapPctZTO+RookCCoefs[1,2]*RookCZeroDum+VetCCoefs[1,3]+VetCCoefs[1,1]*LogVetCCapPctZTO+VetCCoefs[1,2]*VetCZeroDum)
	replace CompWins = CompWins+Const[1,8]*(RookRTCoefs[1,3]+RookRTCoefs[1,1]*LogRookRTCapPctZTO+RookRTCoefs[1,2]*RookRTZeroDum+VetRTCoefs[1,3]+VetRTCoefs[1,1]*LogVetRTCapPctZTO+VetRTCoefs[1,2]*VetRTZeroDum)

	replace CompWins = CompWins+Const[1,9]*(RookDECoefs[1,3]+RookDECoefs[1,1]*LogRookDECapPctZTO+RookDECoefs[1,2]*RookDEZeroDum+VetDECoefs[1,3]+VetDECoefs[1,1]*LogVetDECapPctZTO+VetDECoefs[1,2]*VetDEZeroDum)
	replace CompWins = CompWins+Const[1,10]*(RookDTCoefs[1,3]+RookDTCoefs[1,1]*LogRookDTCapPctZTO+RookDTCoefs[1,2]*RookDTZeroDum+VetDTCoefs[1,3]+VetDTCoefs[1,1]*LogVetDTCapPctZTO+VetDTCoefs[1,2]*VetDTZeroDum)
	replace CompWins = CompWins+Const[1,11]*(RookILBCoefs[1,3]+RookILBCoefs[1,1]*LogRookILBCapPctZTO+RookILBCoefs[1,2]*RookILBZeroDum+VetILBCoefs[1,3]+VetILBCoefs[1,1]*LogVetILBCapPctZTO+VetILBCoefs[1,2]*VetILBZeroDum)
	replace CompWins = CompWins+Const[1,12]*(RookOLBCoefs[1,3]+RookOLBCoefs[1,1]*LogRookOLBCapPctZTO+RookOLBCoefs[1,2]*RookOLBZeroDum+VetOLBCoefs[1,3]+VetOLBCoefs[1,1]*LogVetOLBCapPctZTO+VetOLBCoefs[1,2]*VetOLBZeroDum)
	replace CompWins = CompWins+Const[1,13]*(RookCBCoefs[1,3]+RookCBCoefs[1,1]*LogRookCBCapPctZTO+RookCBCoefs[1,2]*RookCBZeroDum+VetCBCoefs[1,3]+VetCBCoefs[1,1]*LogVetCBCapPctZTO+VetCBCoefs[1,2]*VetCBZeroDum)
	replace CompWins = CompWins+Const[1,14]*(RookFSCoefs[1,3]+RookFSCoefs[1,1]*LogRookFSCapPctZTO+RookFSCoefs[1,2]*RookFSZeroDum+VetFSCoefs[1,3]+VetFSCoefs[1,1]*LogVetFSCapPctZTO+VetFSCoefs[1,2]*VetFSZeroDum)
	replace CompWins = CompWins+Const[1,15]*(RookSSCoefs[1,3]+RookSSCoefs[1,1]*LogRookSSCapPctZTO+RookSSCoefs[1,2]*RookSSZeroDum+VetSSCoefs[1,3]+VetSSCoefs[1,1]*LogVetSSCapPctZTO+VetSSCoefs[1,2]*VetSSZeroDum)

	replace CompWins = CompWins+Const[1,16]*(RookKCoefs[1,3]+RookKCoefs[1,1]*LogRookKCapPctZTO+RookKCoefs[1,2]*RookKZeroDum+VetKCoefs[1,3]+VetKCoefs[1,1]*LogVetKCapPctZTO+VetKCoefs[1,2]*VetKZeroDum)
	replace CompWins = CompWins+Const[1,17]*(RookPCoefs[1,3]+RookPCoefs[1,1]*LogRookPCapPctZTO+RookPCoefs[1,2]*RookPZeroDum+VetPCoefs[1,3]+VetPCoefs[1,1]*LogVetPCapPctZTO+VetPCoefs[1,2]*VetPZeroDum)
	replace CompWins = CompWins+Const[1,18]*(RookLSCoefs[1,3]+RookLSCoefs[1,1]*LogRookLSCapPctZTO+RookLSCoefs[1,2]*RookLSZeroDum+VetLSCoefs[1,3]+VetLSCoefs[1,1]*LogVetLSCapPctZTO+VetLSCoefs[1,2]*VetLSZeroDum)
	replace CompWins = CompWins+Const[1,19]*`MeanWinTotal'+Const[1,20]*`MeanMissWinTotal'+Const[1,21]*SeasonPost2021+Const[1,22]*`MeanCoY'

	sum Wins
	local MeanWins = r(mean)
	sum CompWins
	local MeanCompWins = r(mean)
	replace CompWins = CompWins+`MeanWins'-`MeanCompWins'
}

* Line plots
if `PeriodFlag' == 0 & `CapFlag' == 0 {
	sum RookQBCapPct RookRBFBCapPct RookWRCapPct RookTECapPct RookLTCapPct RookGCapPct RookCCapPct RookRTCapPct RookDECapPct RookDTCapPct RookILBCapPct RookOLBCapPct RookCBCapPct RookFSCapPct RookSSCapPct RookKCapPct RookPCapPct RookLSCapPct VetQBCapPct VetRBFBCapPct VetWRCapPct VetTECapPct VetLTCapPct VetGCapPct VetCCapPct VetRTCapPct VetDECapPct VetDTCapPct VetILBCapPct VetOLBCapPct VetCBCapPct VetFSCapPct VetSSCapPct VetKCapPct VetPCapPct VetLSCapPct
	
	foreach x in RookQB RookRBFB RookWR RookTE RookLT RookG RookC RookRT RookDE RookDT RookILB RookOLB RookCB RookFS RookSS RookK RookP RookLS VetQB VetRBFB VetWR VetTE VetLT VetG VetC VetRT VetDE VetDT VetILB VetOLB VetCB VetFS VetSS VetK VetP VetLS {
		quietly sum `x'ZeroDum
		quietly scalar `x'ZeroDumMean = r(mean)
	}
	
	matrix Lineplots = [RookQBCoefs \ RookRBFBCoefs \ RookWRCoefs \ RookTECoefs \ RookLTCoefs \ RookGCoefs \ RookCCoefs \ RookRTCoefs \ ///
						RookDECoefs \ RookDTCoefs \ RookILBCoefs \ RookOLBCoefs \ RookCBCoefs \ RookFSCoefs \ RookSSCoefs \ RookKCoefs \ RookPCoefs \ RookLSCoefs \ ///
						VetQBCoefs \ VetRBFBCoefs \ VetWRCoefs \ VetTECoefs \ VetLTCoefs \ VetGCoefs \ VetCCoefs \ VetRTCoefs \ ///
						VetDECoefs \ VetDTCoefs \ VetILBCoefs \ VetOLBCoefs \ VetCBCoefs \ VetFSCoefs \ VetSSCoefs \ VetKCoefs \ VetPCoefs \ VetLSCoefs]
	
	svmat Lineplots
	rename (Lineplots1 Lineplots2 Lineplots3) (Slope ZeroDumCoef Intercept)
	export delimited Slope ZeroDumCoef Intercept using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\1 Lineplots.csv", replace
	drop Slope ZeroDumCoef Intercept
}

* Scatter plots
if `PeriodFlag' == 0 & `SpecFlag' == 1 & `CoYFlag' == 1 & `CapFlag' == 0 {
	export delimited Season Team Wins CompWins RookCapPct OffCapPct QBCapPct using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\2 Scatterplots.csv", replace
}

* Delta method standard errors
if `SpecFlag' == 0 & `CoYFlag' == 0 {
	matrix Actual = (Allocations[1..18,1] \ Allocations[1..18,4])
	svmat Actual
	
	matrix SlopeCoefs = [RookQBCoefs[1,1] \ RookRBFBCoefs[1,1] \ RookWRCoefs[1,1] \ RookTECoefs[1,1] \ RookLTCoefs[1,1] \ RookGCoefs[1,1] \ RookCCoefs[1,1] \ RookRTCoefs[1,1] \ ///
	RookDECoefs[1,1] \ RookDTCoefs[1,1] \ RookILBCoefs[1,1] \ RookOLBCoefs[1,1] \ RookCBCoefs[1,1] \ RookFSCoefs[1,1] \ RookSSCoefs[1,1] \ RookKCoefs[1,1] \ RookPCoefs[1,1] \ RookLSCoefs[1,1] \ ///
	VetQBCoefs[1,1] \ VetRBFBCoefs[1,1] \ VetWRCoefs[1,1] \ VetTECoefs[1,1] \ VetLTCoefs[1,1] \ VetGCoefs[1,1] \ VetCCoefs[1,1] \ VetRTCoefs[1,1] \ ///
	VetDECoefs[1,1] \ VetDTCoefs[1,1] \ VetILBCoefs[1,1] \ VetOLBCoefs[1,1] \ VetCBCoefs[1,1] \ VetFSCoefs[1,1] \ VetSSCoefs[1,1] \ VetKCoefs[1,1] \ VetPCoefs[1,1] \ VetLSCoefs[1,1]]
	svmat SlopeCoefs
		
	matrix SlopeV = [RookQBV[1,1] \ RookRBFBV[1,1] \ RookWRV[1,1] \ RookTEV[1,1] \ RookLTV[1,1] \ RookGV[1,1] \ RookCV[1,1] \ RookRTV[1,1] \ ///
	RookDEV[1,1] \ RookDTV[1,1] \ RookILBV[1,1] \ RookOLBV[1,1] \ RookCBV[1,1] \ RookFSV[1,1] \ RookSSV[1,1] \ RookKV[1,1] \ RookPV[1,1] \ RookLSV[1,1] \ ///
	VetQBV[1,1] \ VetRBFBV[1,1] \ VetWRV[1,1] \ VetTEV[1,1] \ VetLTV[1,1] \ VetGV[1,1] \ VetCV[1,1] \ VetRTV[1,1] \ ///
	VetDEV[1,1] \ VetDTV[1,1] \ VetILBV[1,1] \ VetOLBV[1,1] \ VetCBV[1,1] \ VetFSV[1,1] \ VetSSV[1,1] \ VetKV[1,1] \ VetPV[1,1] \ VetLSV[1,1]]
	svmat SlopeV
	
	matrix UnconCoefs = Uncon[1,1..18]'
	svmat UnconCoefs
	matrix UnconV = UnconV[1..18,1..18]
	svmat UnconV

	rename (SlopeCoefs1 SlopeV1 UnconCoefs1 UnconV1 UnconV2 UnconV3 UnconV4 UnconV5 UnconV6 UnconV7 UnconV8 UnconV9 UnconV10 UnconV11 UnconV12 UnconV13 UnconV14 UnconV15 UnconV16 UnconV17 UnconV18)   (SlopeCoefs SlopeV UnconCoefs UnconVQB UnconVRBFB UnconVWR UnconVTE UnconVLT UnconVG UnconVC UnconVRT UnconVDE UnconVDT UnconVILB UnconVOLB UnconVCB UnconVFS UnconVSS UnconVK UnconVP UnconVLS)
	
	if `PeriodFlag' == 0 & `CapFlag' == 0 {
		export delimited Actual SlopeCoefs SlopeV UnconCoefs UnconVQB UnconVRBFB UnconVWR UnconVTE UnconVLT UnconVG UnconVC UnconVRT UnconVDE UnconVDT UnconVILB UnconVOLB UnconVCB UnconVFS UnconVSS UnconVK UnconVP UnconVLS using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\3 Delta Method.csv", replace
	}
	else if `PeriodFlag' == 1 & `CapFlag' == 0 {
		export delimited Actual SlopeCoefs SlopeV UnconCoefs UnconVQB UnconVRBFB UnconVWR UnconVTE UnconVLT UnconVG UnconVC UnconVRT UnconVDE UnconVDT UnconVILB UnconVOLB UnconVCB UnconVFS UnconVSS UnconVK UnconVP UnconVLS using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\4 Delta Method Pre-2018.csv", replace
	}
	else if `PeriodFlag' == 2 & `CapFlag' == 0 {
		export delimited Actual SlopeCoefs SlopeV UnconCoefs UnconVQB UnconVRBFB UnconVWR UnconVTE UnconVLT UnconVG UnconVC UnconVRT UnconVDE UnconVDT UnconVILB UnconVOLB UnconVCB UnconVFS UnconVSS UnconVK UnconVP UnconVLS using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\5 Delta Method Post-2018.csv", replace
	}
	else if `PeriodFlag' == 0 & `CapFlag' == 2 {
		export delimited Actual SlopeCoefs SlopeV UnconCoefs UnconVQB UnconVRBFB UnconVWR UnconVTE UnconVLT UnconVG UnconVC UnconVRT UnconVDE UnconVDT UnconVILB UnconVOLB UnconVCB UnconVFS UnconVSS UnconVK UnconVP UnconVLS using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Season Analysis\6 Delta Method Sqrt.csv", replace
	}

	drop Actual SlopeCoefs SlopeV UnconCoefs UnconVQB UnconVRBFB UnconVWR UnconVTE UnconVLT UnconVG UnconVC UnconVRT ///
	UnconVDE UnconVDT UnconVILB UnconVOLB UnconVCB UnconVFS UnconVSS UnconVK UnconVP UnconVLS
}