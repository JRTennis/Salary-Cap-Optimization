log using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Do 15 Game Analysis Pre-2018.smcl", replace
clear all
scalar t1 = c(current_time)
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 23 Final Dataset.dta"

foreach x in Rate ANYA TANYA FPA {
	foreach y in Game Season {
		* Logit Regressions with Game and Season Variables
		quietly logit Win Diff`y'`x' DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio DiffFE* if Season < 2018, vce(cluster GameID)
		* Generate Matrices for Coefs, Variances, and PseudoR2s
		quietly matrix `y'Coef`x' = e(b)
		quietly matrix `y'Coef`x' = `y'Coef`x'[1,1..7]
		quietly matrix `y'CoefV`x' = e(V)
		quietly scalar `y'PseudoR2`x' = e(r2_p)
		
		* Generate Marginal Effects
		quietly predict `y'xb`x', xb
		quietly gen `y'Predict`x' = exp(`y'xb`x')/(exp(`y'xb`x')+1)
		quietly gen `y'ME`x' = `y'Predict`x'*(1-`y'Predict`x')*`y'Coef`x'[1,1]
		quietly replace `y'ME`x' = . if Season >= 2018
		
		* Generate Variables and Matrices for AMEs and AME Variances
		quietly margins, dydx(Diff`y'`x' DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio) post
		quietly matrix `y'AME`x' = e(b)
		quietly gen `y'AME`x' = `y'AME`x'[1,1]
		quietly matrix `y'AMEV`x' = e(V)
		
		* Calculate Logit Standard Errors
		quietly matrix `y'CoefVDiag`x' = vecdiag(`y'CoefV`x')
		quietly local NColsCoef = colsof(`y'CoefVDiag`x')
		quietly matrix `y'CoefSE`x' = J(1,`NColsCoef',.)
		forvalues i = 1/`NColsCoef' {
			quietly matrix `y'CoefSE`x'[1,`i'] = sqrt(`y'CoefVDiag`x'[1,`i'])
		}
		quietly matrix `y'CoefSE`x' = `y'CoefSE`x'[1,1..7]
		
		* Calculate Logit AME Standard Errors
		quietly matrix `y'AMEVDiag`x' = vecdiag(`y'AMEV`x')
		quietly local NColsAME = colsof(`y'AMEVDiag`x')
		quietly matrix `y'AMESE`x' = J(1,`NColsAME',.)
		forvalues i = 1/`NColsAME' {
			quietly matrix `y'AMESE`x'[1,`i'] = sqrt(`y'AMEVDiag`x'[1,`i'])
		}
		quietly gen `y'AMESE`x' = `y'AMESE`x'[1,1]
		
		* Linear Regressions with Game and Season Variables
		quietly reg Win Diff`y'`x' DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio DiffFE* if Season < 2018, vce(cluster GameID)
		* Generate Matrices for Coefs, Variances, and R2s
		quietly matrix `y'Lin`x' = e(b)
		quietly matrix `y'Lin`x' = `y'Lin`x'[1,1..7]
		quietly matrix `y'LinV`x' = e(V)
		quietly scalar `y'R2`x' = e(r2)
		
		* Calculate Linear Standard Errors
		quietly matrix `y'LinVDiag`x' = vecdiag(`y'LinV`x')
		quietly local NColsLin = colsof(`y'LinVDiag`x')
		quietly matrix `y'LinSE`x' = J(1,`NColsLin',.)
		forvalues i = 1/`NColsLin' {
			quietly matrix `y'LinSE`x'[1,`i'] = sqrt(`y'LinVDiag`x'[1,`i'])
		}
		quietly matrix `y'LinSE`x' = `y'LinSE`x'[1,1..7]
	}
	
	* Instrumental Variables
	foreach z in "" "NoQ4" {
		quietly ivregress 2sls Win (DiffGame`x' = DiffSeason`x'`z') DiffNonQBFantPt DiffHome DiffRestDays DifflogIM DiffSGini DiffSNSRatio DiffFE* if Season < 2018, vce(cluster GameID)
		* Generate Matrices for Coefs, Variances, and R2s
		quietly matrix IVLin`x'`z' = e(b)
		quietly matrix IVLin`x'`z' = IVLin`x'`z'[1,1..7]
		quietly matrix IVLinV`x'`z' = e(V)
		quietly scalar IVR2`x'`z' = e(r2)
		
		* Calculate IV Standard Errors
		quietly matrix IVLinVDiag`x'`z' = vecdiag(IVLinV`x'`z')
		quietly local NColsIV = colsof(IVLinVDiag`x'`z')
		quietly matrix IVLinSE`x'`z' = J(1,`NColsIV',.)
		forvalues i = 1/`NColsIV' {
			quietly matrix IVLinSE`x'`z'[1,`i'] = sqrt(IVLinVDiag`x'`z'[1,`i'])
		}
		quietly matrix IVLinSE`x'`z' = IVLinSE`x'`z'[1,1..7]
		
		* First-Stage F Statistics
		quietly estat firststage
		quietly scalar IVF`x'`z' = r(singleresults)[1,4]
		disp "`x'`z' F = " IVF`x'`z'
		quietly scalar IVFp`x'`z' = r(singleresults)[1,7]
		disp "`x'`z' p = " IVFp`x'`z'
	}
}

* Make Tables
foreach x in Rate ANYA TANYA FPA {
	matrix Table`x' = J(15,8,.)
	forvalues i = 1/7 {
		quietly matrix Table`x'[2*`i'-1,1] = GameCoef`x'[1,`i']
		quietly matrix Table`x'[2*`i',1] = GameCoefSE`x'[1,`i']
		quietly matrix Table`x'[2*`i'-1,2] = GameAME`x'[1,`i']
		quietly matrix Table`x'[2*`i',2] = GameAMESE`x'[1,`i']
		quietly matrix Table`x'[2*`i'-1,3] = GameLin`x'[1,`i']
		quietly matrix Table`x'[2*`i',3] = GameLinSE`x'[1,`i']
		
		quietly matrix Table`x'[2*`i'-1,4] = SeasonCoef`x'[1,`i']
		quietly matrix Table`x'[2*`i',4] = SeasonCoefSE`x'[1,`i']
		quietly matrix Table`x'[2*`i'-1,5] = SeasonAME`x'[1,`i']
		quietly matrix Table`x'[2*`i',5] = SeasonAMESE`x'[1,`i']
		quietly matrix Table`x'[2*`i'-1,6] = SeasonLin`x'[1,`i']
		quietly matrix Table`x'[2*`i',6] = SeasonLinSE`x'[1,`i']
		
		quietly matrix Table`x'[2*`i'-1,7] = IVLin`x'[1,`i']
		quietly matrix Table`x'[2*`i',7] = IVLinSE`x'[1,`i']
		quietly matrix Table`x'[2*`i'-1,8] = IVLin`x'NoQ4[1,`i']
		quietly matrix Table`x'[2*`i',8] = IVLinSE`x'NoQ4[1,`i']
	}
	quietly matrix Table`x'[15,1] = GamePseudoR2`x'
	quietly matrix Table`x'[15,3] = GameR2`x'
	quietly matrix Table`x'[15,4] = SeasonPseudoR2`x'
	quietly matrix Table`x'[15,6] = SeasonR2`x'
	quietly matrix Table`x'[15,7] = IVR2`x'
	quietly matrix Table`x'[15,8] = IVR2`x'NoQ4
}
matrix list TableRate
matrix list TableANYA
matrix list TableTANYA
matrix list TableFPA

* Summary Statistics
foreach y in "" "Win" "Loss" {
	foreach x in GameRate SeasonRate GameANYA SeasonANYA GameTANYA SeasonTANYA GameFPA SeasonFPA NonQBFantPt Home RestDays logIM SGini SNSRatio {
		quietly sum `x' if "`y'" == "" & Season < 2018
		else if "`y'" != "" {
			quietly sum `x' if `y' == 1 & Season < 2018
		}
		quietly scalar Mean`x'`y' = r(mean)
		quietly scalar SD`x'`y' = r(sd)
		quietly scalar Min`x'`y' = r(min)
		quietly scalar Max`x'`y' = r(max)
	}
}

matrix Summary = J(42,4,.)
local CountX = 0
foreach x in "" "Win" "Loss" {
	quietly local CountY = 1
	foreach y in "Mean" "SD" "Min" "Max" {
		quietly local CountZ = 0
		foreach z in "Rate" "ANYA" "TANYA" "FPA" {
			quietly matrix Summary[`CountZ'*2+1+`CountX'*14,`CountY'] = `y'Game`z'`x'
			quietly matrix Summary[`CountZ'*2+2+`CountX'*14,`CountY'] = `y'Season`z'`x'
			quietly local CountZ = `CountZ'+1
		}
		quietly matrix Summary[9+`CountX'*14,`CountY'] = `y'NonQBFantPt`x'
		quietly matrix Summary[10+`CountX'*14,`CountY'] = `y'Home`x'
		quietly matrix Summary[11+`CountX'*14,`CountY'] = `y'RestDays`x'
		quietly matrix Summary[12+`CountX'*14,`CountY'] = `y'logIM`x'
		quietly matrix Summary[13+`CountX'*14,`CountY'] = `y'SGini`x'
		quietly matrix Summary[14+`CountX'*14,`CountY'] = `y'SNSRatio`x'
		quietly local CountY = `CountY'+1
	}
	quietly local CountX = `CountX'+1
}
matrix list Summary

* Count effective number of observations and FEs
gen Ones = 1
egen CountPlayer = sum(Ones), by(FE Player)
egen CountFE = sum(Ones), by(FE)
gen Change = 0
replace Change = 1 if CountPlayer < CountFE

gen Time = 1
local NObs = _N
forvalues i = 2/`NObs'{
	quietly replace Time in `i' = Time[`i'-1]+1 if FE[`i'-1] == FE[`i']
	quietly replace Time in `i' = 1 if FE[`i'-1] != FE[`i']
}

count if Change == 1 & Season < 2018
local Num = r(N)
count
local Denom = r(N)
disp `Num'/`Denom'*100

count if Change == 1 & Time == 1 & Season < 2018
local Num = r(N)
count if Time == 1
local Denom = r(N)
disp `Num'/`Denom'*100

export delimited Home GameMERate SeasonMERate GameMEANYA SeasonMEANYA GameMETANYA SeasonMETANYA GameMEFPA SeasonMEFPA using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/4 ME Histograms Pre-2018.csv", replace
scalar t2 = c(current_time)
gen Runtime = cond(clock(t2,"hms")>=clock(t1,"hms"), (clock(t2,"hms")-clock(t1,"hms"))/60000, (clock(t2,"hms")+24*60*60*1000-clock(t1,"hms"))/60000)
disp Runtime " minutes"
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 15 AME Pre-2018.dta", replace
log close