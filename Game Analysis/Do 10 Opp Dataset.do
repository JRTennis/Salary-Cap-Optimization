clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 16 Merge Dataset.dta"
local Flag = 1
drop if TeamDum == 1

* Generate Opponent FEs
sort Opp Season
gen OppFE = 1
local NObs = _N
forvalues i = 2/`NObs' {
	quietly replace OppFE in `i' = OppFE[`i' - 1] + 1 if (Opp[`i'] != Opp[`i' - 1]) | (Season[`i'] != Season[`i' - 1])
	quietly replace OppFE in `i' = OppFE[`i' - 1] if (Opp[`i'] == Opp[`i' - 1]) & (Season[`i'] == Season[`i' - 1])
}
label variable OppFE "OppFE"
gsort Game -TeamDum -QBPassAtt -QBPassCmp -QBRushAtt

* Overall and NoQ4 stats
foreach y in "" "NoQ4" {
	* Game, sum, and omit stats
	foreach x in PassAtt PassCmp PassYds PassTD PassInt Sk SkYds RushAtt RushYds RushTD Fmb FL {
		* Stats for all the quarterbacks who played in each game
		egen OppGameQB`x'`y' = total(QB`x'`y'), by(Game)
		* Total stats for a quarterback on a team in a season
		egen OppSumQB`x'`y' = total(QB`x'`y'), by (OppFE Player)
		* Total stats minus game stats
		gen OppOmitQB`x'`y' = OppSumQB`x'`y' - QB`x'`y'
	}

	* Game and sum passer rating, ANY/A, TANY/A, and FP/A
	foreach x in Game Sum {
		gen a = (Opp`x'QBPassCmp`y' / Opp`x'QBPassAtt`y' - .3) * 5
		gen b = (Opp`x'QBPassYds`y' / Opp`x'QBPassAtt`y' - 3) * 0.25
		gen c = (Opp`x'QBPassTD`y' / Opp`x'QBPassAtt`y') * 20
		gen d = 2.375 - (Opp`x'QBPassInt`y' / Opp`x'QBPassAtt`y' * 25)
		replace a = 0 if a < 0
		replace a = 2.375 if a > 2.375
		replace b = 0 if b < 0
		replace b = 2.375 if b > 2.375
		replace c = 0 if c < 0
		replace c = 2.375 if c > 2.375
		replace d = 0 if d < 0
		replace d = 2.375 if d > 2.375
		gen Opp`x'Rate`y' = (a + b + c + d) / 6 * 100
		drop a b c d
		
		gen Opp`x'ANYA`y' = (Opp`x'QBPassYds`y' - Opp`x'QBSkYds`y' + 20 * Opp`x'QBPassTD`y' - 45 * Opp`x'QBPassInt`y') / (Opp`x'QBPassAtt`y' + Opp`x'QBSk`y')
		gen Opp`x'TANYA`y' = (Opp`x'QBPassYds`y' - Opp`x'QBSkYds`y' + Opp`x'QBRushYds`y' + 20 * (Opp`x'QBPassTD`y' + Opp`x'QBRushTD`y') - 45 * (Opp`x'QBPassInt`y' + Opp`x'QBFL`y')) / (Opp`x'QBPassAtt`y' + Opp`x'QBSk`y' + Opp`x'QBRushAtt`y')
		gen Opp`x'FPA`y' = (.04*Opp`x'QBPassYds`y' + 4*Opp`x'QBPassTD`y' - 2*Opp`x'QBPassInt`y' + .1*Opp`x'QBRushYds`y' + 6*Opp`x'QBRushTD`y' - 2*Opp`x'QBFL`y') / (Opp`x'QBPassAtt`y' + Opp`x'QBRushAtt`y')
	}
	label variable OppGameRate`y' "OppGameRate`y'"
	label variable OppGameANYA`y' "OppGameANYA`y'"
	label variable OppGameTANYA`y' "OppGameTANYA`y'"
	label variable OppGameFPA`y' "OppGameFPA`y'"

	* Weighted average passer rating, ANY/A, TANY/A, and FP/A
	egen OppSeasonRate`y' = total(QBPassAtt`y' / OppGameQBPassAtt`y' * OppSumRate`y'), by(Game)
	egen OppSeasonANYA`y' = total((QBPassAtt`y' + QBSk`y') / (OppGameQBPassAtt`y' + OppGameQBSk`y') * OppSumANYA`y'), by(Game)
	egen OppSeasonTANYA`y' = total((QBPassAtt`y' + QBSk`y' + QBRushAtt`y') / (OppGameQBPassAtt`y' + OppGameQBSk`y' + OppGameQBRushAtt`y') * OppSumTANYA`y'), by(Game)
	egen OppSeasonFPA`y' = total((QBPassAtt`y' + QBRushAtt`y') / (OppGameQBPassAtt`y' + OppGameQBRushAtt`y') * OppSumFPA`y'), by(Game)
	foreach x in Rate ANYA TANYA FPA {
		label variable OppSeason`x'`y' "OppSeason`x'`y'"
	}
}

* Determine if multiple QBs played in game
gen OppMultiFlag = 0
replace OppMultiFlag = 1 if QBPassAtt != OppGameQBPassAtt
label variable OppMultiFlag "OppMultiFlag"

* Generate OppAvgReport
egen OppAvgReport = total(Report * QBPassAtt / OppGameQBPassAtt), by(Game)
label variable OppAvgReport "OppAvgReport"

* Drop quarterbacks who aren't the primary quarterback (already sorted by QBPassAtt then QBPassCmp then QBRushAtt)
gen PrimaryDum = 0
local NObs = _N
forvalues i = 1/`NObs' {
	quietly replace PrimaryDum in `i' = 1 if Game[`i'] != Game[`i'-1]
}
label variable PrimaryDum "PrimaryDum"
drop if PrimaryDum == 0

* Rookie season
gen RookieSeason = .
replace RookieSeason = 1995 if Player == "Kerry Collins"
replace RookieSeason = 1996 if Player == "Jon Kitna"
replace RookieSeason = 1997 if Player == "Jake Delhomme"
replace RookieSeason = 1998 if Player == "Charlie Batch" | Player == "Matt Hasselbeck" | Player == "Peyton Manning"
replace RookieSeason = 1999 if Player == "Donovan McNabb"
replace RookieSeason = 2000 if Player == "Billy Volek" | Player == "Chris Redman" | Player == "Tom Brady"
replace RookieSeason = 2001 if Player == "A.J. Feeley" | Player == "Drew Brees" | Player == "Michael Vick"
replace RookieSeason = 2002 if Player == "David Carr" | Player == "Josh McCown" | Player == "Shaun Hill"
replace RookieSeason = 2003 if Player == "Byron Leftwich" | Player == "Carson Palmer" | Player == "Kyle Boller" | Player == "Rex Grossman" | Player == "Seneca Wallace" | Player == "Tony Romo"
replace RookieSeason = 2004 if Player == "Ben Roethlisberger" | Player == "Eli Manning" | Player == "J.P. Losman" | Player == "Luke McCown" | Player == "Matt Schaub" | Player == "Philip Rivers"
replace RookieSeason = 2005 if Player == "Aaron Rodgers" | Player == "Alex Smith" | Player == "Dan Orlovsky" | Player == "Derek Anderson" | Player == "Jason Campbell" | Player == "Kyle Orton" | Player == "Matt Cassel" | Player == "Ryan Fitzpatrick"
replace RookieSeason = 2006 if Player == "Bruce Gradkowski" | Player == "Charlie Whitehurst" | Player == "Jay Cutler" | Player == "Kellen Clemens" | Player == "Matt Leinart" | Player == "Tarvaris Jackson" | Player == "Vince Young"
replace RookieSeason = 2007 if Player == "Brady Quinn" | Player == "Drew Stanton" | Player == "Kevin Kolb" | Player == "John Beck" | Player == "Matt Moore" | Player == "Tyler Palko" | Player == "Tyler Thigpen"
replace RookieSeason = 2008 if Player == "Caleb Hanie" | Player == "Chad Henne" | Player == "Joe Flacco" | Player == "Josh Johnson" | Player == "Matt Flynn" | Player == "Matt Ryan"
replace RookieSeason = 2009 if Player == "Brian Hoyer" | Player == "Chase Daniel" | Player == "Curtis Painter" | Player == "Graham Harrell" | Player == "Josh Freeman" | Player == "Mark Sanchez" | Player == "Matthew Stafford" | Player == "Stephen McGee" | Player == "Tom Brandstater"
replace RookieSeason = 2010 if Player == "Armanti Edwards" | Player == "Colt McCoy" | Player == "Jimmy Clausen" | Player == "Joe Webb" | Player == "John Skelton" | Player == "Mike Kafka" | Player == "Rusty Smith" | Player == "Sam Bradford" | Player == "Thaddeus Lewis" | Player == "Tim Tebow"
replace RookieSeason = 2011 if Player == "Andy Dalton" | Player == "Blaine Gabbert" | Player == "Cam Newton" | Player == "Christian Ponder" | Player == "Colin Kaepernick" | Player == "Greg McElroy" | Player == "Jake Locker" | Player == "Ryan Mallett" | Player == "Scott Tolzien" | Player == "T.J. Yates" | Player == "Terrelle Pryor" | Player == "Tyrod Taylor"
replace RookieSeason = 2012 if Player == "Alex Tanney" | Player == "Andrew Luck" | Player == "Austin Davis" | Player == "Brandon Weeden" | Player == "Brock Osweiler" | Player == "Case Keenum" | Player == "Dominique Davis" | Player == "Kellen Moore" | Player == "Kirk Cousins" | Player == "Matt Simms" | Player == "Nick Foles" | Player == "Robert Griffin III" | Player == "Russell Wilson" | Player == "Ryan Lindley" | Player == "Ryan Tannehill"
replace RookieSeason = 2013 if Player == "B.J. Daniels" | Player == "EJ Manuel" | Player == "Geno Smith" | Player == "Jeff Tuel" | Player == "Landry Jones" | Player == "Matt Barkley" | Player == "Matt McGloin" | Player == "Mike Glennon" | Player == "Ryan Griffin" | Player == "Ryan Nassib" | Player == "Tyler Bray"
replace RookieSeason = 2014 if Player == "A.J. McCarron" | Player == "Blake Bortles" | Player == "Connor Shaw" | Player == "David Fales" | Player == "Derek Carr" | Player == "Garrett Gilbert" | Player == "Jimmy Garoppolo" | Player == "Johnny Manziel" | Player == "Logan Thomas" | Player == "Teddy Bridgewater" | Player == "Tom Savage" | Player == "Zach Mettenberger"
replace RookieSeason = 2015 if Player == "Brett Hundley" | Player == "Bryce Petty" | Player == "Jameis Winston" | Player == "Marcus Mariota" | Player == "Sean Mannion" | Player == "Taylor Heinicke" | Player == "Trevor Siemian"
replace RookieSeason = 2016 if Player == "Brandon Allen" | Player == "Carson Wentz" | Player == "Cody Kessler" | Player == "Connor Cook" | Player == "Dak Prescott" | Player == "Jacoby Brissett" | Player == "Jared Goff" | Player == "Jeff Driskel" | Player == "Kevin Hogan" | Player == "Nate Sudfeld" | Player == "Paxton Lynch" | Player == "Trevone Boykin"
replace RookieSeason = 2017 if Player == "C.J. Beathard" | Player == "Cooper Rush" | Player == "Davis Webb" | Player == "Deshaun Watson" | Player == "DeShone Kizer" | Player == "Joshua Dobbs" | Player == "Mitchell Trubisky" | Player == "Nathan Peterman" | Player == "Nick Mullens" | Player == "P.J. Walker" | Player == "Patrick Mahomes" | Player == "Taysom Hill"
replace RookieSeason = 2018 if Player == "Baker Mayfield" | Player == "Chris Streveler" | Player == "John Wolford" | Player == "Josh Allen" | Player == "Josh Rosen" | Player == "Kurt Benkert" | Player == "Kyle Allen" | Player == "Lamar Jackson" | Player == "Logan Woodside" | Player == "Luke Falk" | Player == "Mason Rudolph" | Player == "Mike White" | Player == "Sam Darnold" | Player == "Tim Boyle"
replace RookieSeason = 2019 if Player == "Brett Rypien" | Player == "Daniel Jones" | Player == "David Blough" | Player == "Devlin Hodges" | Player == "Drew Lock" | Player == "Dwayne Haskins" | Player == "Easton Stick" | Player == "Gardner Minshew II" | Player == "Jake Browning" | Player == "Jarrett Stidham" | Player == "Kyler Murray" | Player == "Ryan Finley" | Player == "Trace McSorley" | Player == "Will Grier"
replace RookieSeason = 2020 if Player == "Ben DiNucci" | Player == "Bryce Perkins" | Player == "Jacob Eason" | Player == "Jake Fromm" | Player == "Jake Luton" | Player == "Jalen Hurts" | Player == "Joe Burrow" | Player == "Jordan Love" | Player == "Justin Herbert" | Player == "Kendall Hinton" | Player == "Tua Tagovailoa" | Player == "Tyler Huntley"
replace RookieSeason = 2021 if Player == "Davis Mills" | Player == "Feleipe Franks" | Player == "Ian Book" | Player == "Justin Fields" | Player == "Kellen Mond" | Player == "Kyle Trask" | Player == "Mac Jones" | Player == "Sam Ehlinger" | Player == "Trevor Lawrence" | Player == "Trey Lance" | Player == "Zach Wilson"
replace RookieSeason = 2022 if Player == "Anthony Brown" | Player == "Bailey Zappe" | Player == "Brock Purdy" | Player == "Desmond Ridder" | Player == "Kenny Pickett" | Player == "Malik Willis" | Player == "Sam Howell" | Player == "Skylar Thompson"
replace RookieSeason = 2023 if Player == "Aidan O'Connell" | Player == "Anthony Richardson" | Player == "Bryce Young" | Player == "C.J. Stroud" | Player == "Clayton Tune" | Player == "Dorian Thompson-Robinson" | Player == "Hendon Hooker" | Player == "Jake Haener" | Player == "Jaren Hall" | Player == "Sean Clifford" | Player == "Tanner McKee" | Player == "Tommy DeVito" | Player == "Tyson Bagent" | Player == "Will Levis"
replace RookieSeason = 2024 if Player == "Bo Nix" | Player == "Caleb Williams" | Player == "Drake Maye" | Player == "Jayden Daniels" | Player == "Joe Milton" | Player == "Michael Penix" | Player == "Spencer Rattler"

* Drop QBs who didn't have enough experience
if `Flag' == 2 {
	gen Experience = Season - RookieSeason + 1
	drop if Experience < 2
	drop Experience
}

* Drop QBs who didn't have enough other starts
if `Flag' == 3 {
	drop if OppOmitQBPassAtt == 0 & OppOmitQBSk == 0 & OppOmitQBRushAtt == 0
	gen Ones = 1
	egen Counter = sum(Ones), by(OppFE Player)
	drop if Counter < 4
	drop Ones Counter
}

* Keep and order variables
rename Player OppPlayer
keep FE OppFE Game Season Week Team Opp Win OppPlayer OppAvgReport OppGameRate OppSeasonRate OppGameANYA OppSeasonANYA OppGameTANYA OppSeasonTANYA OppGameFPA OppSeasonFPA OppSeasonRateNoQ4 OppSeasonANYANoQ4 OppSeasonTANYANoQ4 OppSeasonFPANoQ4 OppMultiFlag
order FE OppFE Game Season Week Team Opp Win OppPlayer OppAvgReport OppGameRate OppSeasonRate OppGameANYA OppSeasonANYA OppGameTANYA OppSeasonTANYA OppGameFPA OppSeasonFPA OppSeasonRateNoQ4 OppSeasonANYANoQ4 OppSeasonTANYANoQ4 OppSeasonFPANoQ4 OppMultiFlag
sort Game

if `Flag' == 1 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 20 Opp Dataset.dta", replace
}
else if `Flag' == 2 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 21 Opp Dataset Vet.dta", replace
}
else if `Flag' == 3 {
	save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Game Analysis/Data 22 Opp Dataset Four.dta", replace
}