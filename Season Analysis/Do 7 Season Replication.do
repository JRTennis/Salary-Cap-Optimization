* Mulholland 2016: https://core.ac.uk/reader/76391600
clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 11 Season Merge.dta"

gen RBFBAV = RBAV+FBAV
reg Wins QBAV RBFBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV, robust
reg Wins QBAV RBAV FBAV WRAV TEAV LTAV GAV CAV RTAV DEAV DTAV ILBAV OLBAV CBAV FSAV SSAV KAV PAV LSAV if Season <= 2015, robust
matrix coefs = e(b)

gen Flag1 = 1
if Flag1 == 1 {
	gen QBbeta = coefs[1,1]
	gen RBbeta = coefs[1,2]
	gen FBbeta = coefs[1,3]
	gen WRbeta = coefs[1,4]
	gen TEbeta = coefs[1,5]
	gen LTbeta = coefs[1,6]
	gen Gbeta = coefs[1,7]
	gen Cbeta = coefs[1,8]
	gen RTbeta = coefs[1,9]
	gen DEbeta = coefs[1,10]
	gen DTbeta = coefs[1,11]
	gen ILBbeta = coefs[1,12]
	gen OLBbeta = coefs[1,13]
	gen CBbeta = coefs[1,14]
	gen FSbeta = coefs[1,15]
	gen SSbeta = coefs[1,16]
	gen Kbeta = coefs[1,17]
	gen Pbeta = coefs[1,18]
	gen LSbeta = coefs[1,19]
}
*Mulholland Table 1 Coefs
if Flag1 == 2 {
	gen QBbeta = .285
	gen RBbeta = .053
	gen FBbeta = .136
	gen WRbeta = .056
	gen TEbeta = .025
	gen LTbeta = .036
	gen Gbeta = .070
	gen Cbeta = .055
	gen RTbeta = .043
	gen DEbeta = .084
	gen DTbeta = .072
	gen ILBbeta = .097
	gen OLBbeta = .128
	gen CBbeta = .109
	gen FSbeta = .062
	gen SSbeta = .042
	gen Kbeta = .087
	gen Pbeta = .115
	gen LSbeta = .015
}

* If Flag2 = 2, we're not dropping observations where `x'Cap = 0
gen Flag2 = 1
gen SumWinbeta = 0
foreach x in "QB" "RB" "FB" "WR" "TE" "LT" "G" "C" "RT" "DE" "DT" "ILB" "OLB" "CB" "FS" "SS" "K" "P" "LS"{
	gen `x'Win = `x'beta*`x'AV
	if Flag2 == 1 {
		gen log`x'Cap = log(`x'Cap)
	}
	if Flag2 == 2 {
		gen log`x'Cap = log(`x'Cap+1)
	}
	reg `x'Win log`x'Cap if Season <= 2015, robust
	matrix `x'coefs = e(b)
	gen `x'Winbeta = `x'coefs[1,1]
	replace SumWinbeta = SumWinbeta+`x'Winbeta
}
gen Cap1115 = (120375000+120600000+123600000+133000000+143280000)/5
foreach x in "QB" "RB" "FB" "WR" "TE" "LT" "G" "C" "RT" "DE" "DT" "ILB" "OLB" "CB" "FS" "SS" "K" "P" "LS"{
	if Flag2 == 1 {
		gen `x'Allocation = `x'Winbeta/SumWinbeta*100
	}
	if Flag2 == 2 {
		gen `x'Allocation = (`x'Winbeta/SumWinbeta+(19*`x'Winbeta/SumWinbeta-1)/Cap1115)*100
	}
	display "`x' Optimal: " `x'Allocation
}
* Mulholland Table 2 Coefs: .318 .030 .077 .205 .025 .043 .390 .069 .092 .504 .374 .369 .559 .263 .160 .119 .032 .040 .002

* Calvetti Replication (Flag3 = 2 comes closest to matching Calvetti's interaction results)
gen PPG = PF/16
replace PPG = PF/17 if Season >= 2021
replace PPG = PF/16 if Season == 2022 & (Team == "Buffalo Bills" | Team == "Cincinnati Bengals")

gen OLAV = RTAV+LTAV+GAV+CAV
gen Flag3 = 1
if Flag3 == 2 {
	replace OLAV = LTAV+GAV
}
gen sqrtQBWRAV = sqrt(QBAV*WRAV)
gen sqrtRBFBOLAV = sqrt(RBFBAV*OLAV)
gen sqrtQBTEAV = sqrt(QBAV*TEAV)
gen sqrtLTOLAV = sqrt(LTAV*OLAV)

reg PPG QBAV RBFBAV WRAV TEAV RTAV LTAV GAV CAV KAV if Season != 2022, robust
reg PPG QBAV RBFBAV WRAV TEAV RTAV LTAV GAV CAV KAV sqrtQBWRAV sqrtRBFBOLAV if Season != 2022, robust
reg PPG QBAV RBFBAV WRAV TEAV RTAV LTAV GAV CAV KAV sqrtQBWRAV sqrtRBFBOLAV sqrtQBTEAV sqrtLTOLAV if Season != 2022, robust

drop Flag1 Flag2 Flag3