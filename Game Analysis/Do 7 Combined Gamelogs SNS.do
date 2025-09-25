clear all
use "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Game Analysis\Data 13 Starters.dta"
format GameID %-17s

* Replace TeamID with team name
gen Team = ""
label variable Team Team
replace Team = "Atlanta Falcons"        if TeamID == "ATL"
replace Team = "Buffalo Bills"          if TeamID == "BUF"
replace Team = "Carolina Panthers"      if TeamID == "CAR"
replace Team = "Chicago Bears"          if TeamID == "CHI"
replace Team = "Cincinnati Bengals"     if TeamID == "CIN"
replace Team = "Cleveland Browns"       if TeamID == "CLE"
replace Team = "Indianapolis Colts"     if TeamID == "CLT"
replace Team = "Arizona Cardinals"      if TeamID == "CRD"
replace Team = "Dallas Cowboys"         if TeamID == "DAL"
replace Team = "Denver Broncos"         if TeamID == "DEN"
replace Team = "Detroit Lions"          if TeamID == "DET"
replace Team = "Green Bay Packers"      if TeamID == "GNB"
replace Team = "Houston Texans"         if TeamID == "HTX"
replace Team = "Jacksonville Jaguars"   if TeamID == "JAX"
replace Team = "Kansas City Chiefs"     if TeamID == "KAN"
replace Team = "Miami Dolphins"         if TeamID == "MIA"
replace Team = "Minnesota Vikings"      if TeamID == "MIN"
replace Team = "New Orleans Saints"     if TeamID == "NOR"
replace Team = "New England Patriots"   if TeamID == "NWE"
replace Team = "New York Giants"        if TeamID == "NYG"
replace Team = "New York Jets"          if TeamID == "NYJ"
replace Team = "Tennessee Titans"       if TeamID == "OTI"
replace Team = "Philadelphia Eagles"    if TeamID == "PHI"
replace Team = "Pittsburgh Steelers"    if TeamID == "PIT"
replace Team = "Las Vegas Raiders"      if TeamID == "RAI"
replace Team = "Los Angeles Rams"       if TeamID == "RAM"
replace Team = "Baltimore Ravens"       if TeamID == "RAV"
replace Team = "Los Angeles Chargers"   if TeamID == "SDG"
replace Team = "Seattle Seahawks"       if TeamID == "SEA"
replace Team = "San Francisco 49ers"    if TeamID == "SFO"
replace Team = "Tampa Bay Buccaneers"   if TeamID == "TAM"
replace Team = "Washington Commanders"  if TeamID == "WAS"

* Merge with Combined Gamelogs
merge m:m GameID Team using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Game Analysis\Data 11 Combined Gamelogs.dta"
keep GameID Team Opp Season Week Player Pos
sort Team Season Week
order Player Pos, last

*Distinguish between two different players with same name
replace Player = "Charles Johnson DE" if Player == "Charles Johnson" & Team == "Carolina Panthers" & Season == 2017 & Pos == "DE"
replace Player = "Greg Jones RB" if Player == "Greg Jones" & Team == "Jacksonville Jaguars" & Season == 2012 & Pos == "FB"
replace Player = "Jaylon Moore OL" if Player == "Jaylon Moore" & Team == "San Francisco 49ers" & Season == 2024 & Pos == "OL"

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

* Match names to Money dataset (see "2 Game Corrections.xlsx")
gen OldPlayer = Player
replace Player = "A.J. Arcuri" if Player == "AJ Arcuri"
replace Player = "A.J. Barner" if Player == "AJ Barner"
replace Player = "A.J. Dillon" if Player == "AJ Dillon"
replace Player = "A.J. Parker" if Player == "AJ Parker"
replace Player = "A.J. Terrell" if Player == "AJ Terrell"
replace Player = "Adam-Pacman Jones" if Player == "Adam Jones"
replace Player = "Alexander Green" if Player == "Alex Green"
replace Player = "A.J. Johnson" if Player == "Alexander Johnson"
replace Player = "Amaré Barno" if Player == "Amare Barno"
replace Player = "Andre Jones Jr." if Player == "Andre Jones"
replace Player = "Andrew Adam" if Player == "Andrew Adams"
replace Player = "Andrew Booth Jr." if Player == "Andrew Booth"
replace Player = "Anthony Walker Jr." if Player == "Anthony Walker"
replace Player = "Audric Estimé" if Player == "Audric Estime"
replace Player = "Deji Olatoye" if Player == "Ayodeji Olatoye"
replace Player = "Benjamin Ijalana" if Player == "Ben Ijalana"
replace Player = "Benjamin Watson" if Player == "Ben Watson"
replace Player = "Brian Robinson" if Player == "Brian Robinson Jr."
replace Player = "Brian Thomas Jr." if Player == "Brian Thomas"
replace Player = "Broderick Washington" if Player == "Broderick Washington Jr."
replace Player = "Olubunmi Rotimi" if Player == "Bunmi Rotimi"
replace Player = "Chauncey Gardner-Johnson" if Player == "C.J. Gardner-Johnson"
replace Player = "Carnell Williams" if Player == "Cadillac Williams"
replace Player = "Calvin Austin" if Player == "Calvin Austin III"
replace Player = "Cam Lewis" if Player == "Cameron Lewis"
replace Player = "Cam Thomas" if Player == "Cameron Thomas"
replace Player = "Cedrick Wilson" if Player == "Cedrick Wilson Jr."
replace Player = "Charles Leno" if Player == "Charles Leno Jr."
replace Player = "Chig Okonkwo" if Player == "Chigoziem Okonkwo"
replace Player = "Christopher Carson" if Player == "Chris Carson"
replace Player = "Christopher Conte" if Player == "Chris Conte"
replace Player = "Chris Harris" if Player == "Chris Harris Jr."
replace Player = "Christopher Owens" if Player == "Chris Owens"
replace Player = "Chris Milton" if Player == "Christopher Milton"
replace Player = "Clark Phillips III" if Player == "Clark Phillips"
replace Player = "Clay Matthews Jr." if Player == "Clay Matthews"
replace Player = "Decobie Durant" if Player == "Cobie Durant"
replace Player = "Cory Trice Jr." if Player == "Cory Trice"
replace Player = "Crevon LeBlanc" if Player == "Cre'von LeBlanc"
replace Player = "D'ante Smith" if Player == "D'Ante Smith"
replace Player = "D.J. Johnson" if Player == "DJ Johnson"
replace Player = "D.J. Turner" if Player == "DJ Turner"
replace Player = "Da'shawn Hand" if Player == "Da'Shawn Hand"
replace Player = "Davonte Lambert" if Player == "DaVonte Lambert"
replace Player = "Daesean Hamilton" if Player == "DaeSean Hamilton"
replace Player = "Dan Batten" if Player == "Danny Batten"
replace Player = "Dan Vitale" if Player == "Danny Vitale"
replace Player = "D.J. Ware" if Player == "Danny Ware"
replace Player = "Dante Fowler Jr." if Player == "Dante Fowler"
replace Player = "Darnell Savage" if Player == "Darnell Savage Jr."
replace Player = "Darrell Baker Jr." if Player == "Darrell Baker"
replace Player = "DeVante Bausby" if Player == "De'Vante Bausby"
replace Player = "Devante Harris" if Player == "De'Vante Harris"
replace Player = "Devon Achane" if Player == "De'Von Achane"
replace Player = "Deandre Carter" if Player == "DeAndre Carter"
replace Player = "Deangelo Tyson" if Player == "DeAngelo Tyson"
replace Player = "Dee Alford" if Player == "DeAundre Alford"
replace Player = "Dejon Gomes" if Player == "DeJon Gomes"
replace Player = "Deshawn Shead" if Player == "DeShawn Shead"
replace Player = "Deshon Elliott" if Player == "DeShon Elliott"
replace Player = "Deatrich Wise" if Player == "Deatrich Wise Jr."
replace Player = "Taitusi Lutui" if Player == "Deuce Lutui"
replace Player = "Devin Bush" if Player == "Devin Bush Jr."
replace Player = "Dorance Armstrong" if Player == "Dorance Armstrong Jr."
replace Player = "E.J. Manuel" if Player == "EJ Manuel"
replace Player = "Earnest Brown" if Player == "Earnest Brown IV"
replace Player = "Evan Smith" if Player == "Evan Dietrich-Smith"
replace Player = "Foley Fatukasi" if Player == "Folorunso Fatukasi"
replace Player = "Gardner Minshew" if Player == "Gardner Minshew II"
replace Player = "George Karlaftis" if Player == "George Karlaftis III"
replace Player = "Greg Newsome" if Player == "Greg Newsome II"
replace Player = "Greg Rousseau" if Player == "Gregory Rousseau"
replace Player = "HaHa Clinton-Dix" if Player == "Ha Ha Clinton-Dix"
replace Player = "Hardy Nickerson Jr." if Player == "Hardy Nickerson"
replace Player = "Henry Ruggs" if Player == "Henry Ruggs III"
replace Player = "Herb Taylor" if Player == "Herbert Taylor"
replace Player = "Irv Smith" if Player == "Irv Smith Jr."
replace Player = "Issac Redman" if Player == "Isaac Redman"
replace Player = "JK Dobbins" if Player == "J.K. Dobbins"
replace Player = "J.J. Arcega-Whiteside" if Player == "JJ Arcega-Whiteside"
replace Player = "J.J. Nelson" if Player == "JJ Nelson"
replace Player = "J'Marcus Bradley" if Player == "Ja'Marcus Bradley"
replace Player = "Ja'whaun Bentley" if Player == "Ja'Whaun Bentley"
replace Player = "Janoris Jenkins" if Player == "Jackrabbit Jenkins"
replace Player = "Jake Martin" if Player == "Jacob Martin"
replace Player = "Jarvis Brownlee Jr." if Player == "Jarvis Brownlee"
replace Player = "Javelin Guidry Jr." if Player == "Javelin Guidry"
replace Player = "Jayson Dimanche" if Player == "Jayson DiManche"
replace Player = "Jedrick Wills" if Player == "Jedrick Wills Jr."
replace Player = "Johnny Newton" if Player == "Jer'Zhan Newton"
replace Player = "Jermaine Carter" if Player == "Jermaine Carter Jr."
replace Player = "Jermaine Johnson" if Player == "Jermaine Johnson II"
replace Player = "JoLonn Dunbar" if Player == "Jo-Lonn Dunbar"
replace Player = "Joseph Morgan" if Player == "Joe Morgan"
replace Player = "Joe Tryon" if Player == "Joe Tryon-Shoyinka"
replace Player = "John Cyprien" if Player == "Johnathan Cyprien"
replace Player = "Jonathan Hilliman" if Player == "Jon Hilliman"
replace Player = "Jon Runyan" if Player == "Jon Runyan Jr."
replace Player = "Jon Bostic" if Player == "Jonathan Bostic"
replace Player = "Johnathan Grimes" if Player == "Jonathan Grimes"
replace Player = "Joshua Cribbs" if Player == "Josh Cribbs"
replace Player = "Joshua Hines-Allen" if Player == "Josh Hines-Allen"
replace Player = "Joshua Thomas" if Player == "Josh Thomas"
replace Player = "Joshua Uche" if Player == "Josh Uche"
replace Player = "Josh Kelley" if Player == "Joshua Kelley"
replace Player = "JuJu Hughes" if Player == "Juju Hughes"
replace Player = "Julie'n Davenport" if Player == "Julién Davenport"
replace Player = "K.C. McDermott" if Player == "KC McDermott"
replace Player = "K.J. Hamler" if Player == "KJ Hamler"
replace Player = "Kavontae Turpin" if Player == "KaVontae Turpin"
replace Player = "Keesean Johnson" if Player == "KeeSean Johnson"
replace Player = "Keivarae Russell" if Player == "KeiVarae Russell"
replace Player = "Kenneth Walker" if Player == "Kenneth Walker III"
replace Player = "Kenny Robinson" if Player == "Kenny Robinson Jr."
replace Player = "Khadarel Hodge" if Player == "KhaDarel Hodge"
replace Player = "LaDarius Gunter" if Player == "Ladarius Gunter"
replace Player = "LaMarcus Joyner" if Player == "Lamarcus Joyner"
replace Player = "Delano Hill" if Player == "Lano Hill"
replace Player = "Laviska Shenault" if Player == "Laviska Shenault Jr."
replace Player = "LeRon McClain" if Player == "Le'Ron McClain"
replace Player = "Leroy Hill" if Player == "LeRoy Hill"
replace Player = "Leon McQuay III" if Player == "Leon McQuay"
replace Player = "Lil'jordan Humphrey" if Player == "Lil'Jordan Humphrey"
replace Player = "Lloyd Cushenberry" if Player == "Lloyd Cushenberry III"
replace Player = "Lonnie Johnson" if Player == "Lonnie Johnson Jr."
replace Player = "Lynn Bowden" if Player == "Lynn Bowden Jr."
replace Player = "Maake Kemoeatu" if Player == "Ma'ake Kemoeatu"
replace Player = "Malcolm Rodríguez" if Player == "Malcolm Rodriguez"
replace Player = "Marion Barber" if Player == "Marion Barber III"
replace Player = "Marvell Tell" if Player == "Marvell Tell III"
replace Player = "Maurice Hurst" if Player == "Maurice Hurst Jr."
replace Player = "Mike Hoecht" if Player == "Michael Hoecht"
replace Player = "Mike Onwenu" if Player == "Michael Onwenu"
replace Player = "Michael Penix Jr." if Player == "Michael Penix"
replace Player = "Mike Woods" if Player == "Michael Woods II"
replace Player = "Michael Ford" if Player == "Mike Ford"
replace Player = "Michael Morgan" if Player == "Mike Morgan"
replace Player = "Michael Neal" if Player == "Mike Neal"
replace Player = "Navorro Bowman" if Player == "NaVorro Bowman"
replace Player = "Nathan Jones" if Player == "Nate Jones"
replace Player = "Nate Gerry" if Player == "Nathan Gerry"
replace Player = "Nick Deluca" if Player == "Nick DeLuca"
replace Player = "Nick Westbrook" if Player == "Nick Westbrook-Ikhine"
replace Player = "Nyheim Miller-Hines" if Player == "Nyheim Hines"
replace Player = "Oshiomogho Atogwe" if Player == "O.J. Atogwe"
replace Player = "Olu Fashanu" if Player == "Olumuyiwa Fashanu"
replace Player = "Olu Oluwatimi" if Player == "Olusegun Oluwatimi"
replace Player = "Phillip Walker" if Player == "P.J. Walker"
replace Player = "Patrick Angerer" if Player == "Pat Angerer"
replace Player = "Patrick Jones" if Player == "Patrick Jones II"
replace Player = "Phillip Loadholt" if Player == "Phil Loadholt"
replace Player = "Jartavius Martin" if Player == "Quan Martin"
replace Player = "Richard LeCount" if Player == "Richard LeCounte"
replace Player = "Ricky Jean Francois" if Player == "Ricky Jean-Francois"
replace Player = "Tariq Woolen" if Player == "Riq Woolen"
replace Player = "Robert Housler" if Player == "Rob Housler"
replace Player = "Robbie Anderson" if Player == "Robbie Chosen"
replace Player = "Rob Kelley" if Player == "Robert Kelley"
replace Player = "Robert Tonyan Jr." if Player == "Robert Tonyan"
replace Player = "Rashad Carmichael" if Player == "Roc Carmichael"
replace Player = "Rodney Thomas" if Player == "Rodney Thomas II"
replace Player = "Ron Leary" if Player == "Ronald Leary"
replace Player = "Johnathan Ford" if Player == "Rudy Ford"
replace Player = "Sam Eguavoen" if Player == "Samuel Eguavoen"
replace Player = "Ahmad Gardner" if Player == "Sauce Gardner"
replace Player = "Scotty Miller" if Player == "Scott Miller"
replace Player = "Sean Bunting" if Player == "Sean Murphy-Bunting"
replace Player = "Sebastian Joseph" if Player == "Sebastian Joseph-Day"
replace Player = "Deion Calhoun" if Player == "Shaq Calhoun"
replace Player = "Shaun-Dion Hamilton" if Player == "Shaun Dion Hamilton"
replace Player = "Stanley Morgan" if Player == "Stanley Morgan Jr."
replace Player = "Starling Thomas V" if Player == "Starling Thomas"
replace Player = "Steve Schilling" if Player == "Stephen Schilling"
replace Player = "Steve Smith" if Player == "Steve Smith Sr."
replace Player = "Steven Sims Jr." if Player == "Steven Sims"
replace Player = "Iosua Opeta" if Player == "Sua Opeta"
replace Player = "Travis Carrie" if Player == "T.J. Carrie"
replace Player = "TJ Jones" if Player == "T.J. Jones"
replace Player = "TK McLendon Jr." if Player == "TK McLendon"
replace Player = "Cornellius Carradine" if Player == "Tank Carradine"
replace Player = "Jalen Tabor" if Player == "Teez Tabor"
replace Player = "Terrace Marshall" if Player == "Terrace Marshall Jr."
replace Player = "Bopete Keyes" if Player == "Thakarius Keyes"
replace Player = "Thayer Munford Jr." if Player == "Thayer Munford"
replace Player = "Thomas Graham Jr." if Player == "Thomas Graham"
replace Player = "Timothy Horne" if Player == "Timmy Horne"
replace Player = "Tre Hawkins III" if Player == "Tre Hawkins"
replace Player = "Tre' Sullivan" if Player == "Tre Sullivan"
replace Player = "Tre McKitty" if Player == "Tre' McKitty"
replace Player = "Tre'quan Smith" if Player == "Tre'Quan Smith"
replace Player = "Trevon Moehrig" if Player == "Tre'von Moehrig"
replace Player = "Trenton Brown" if Player == "Trent Brown"
replace Player = "Trenton Robinson" if Player == "Trent Robinson"
replace Player = "TuTu Atwell" if Player == "Tutu Atwell"
replace Player = "Tyrone Tracy" if Player == "Tyrone Tracy Jr."
replace Player = "Velus Jones" if Player == "Velus Jones Jr."
replace Player = "Vernon Hargreaves" if Player == "Vernon Hargreaves III"
replace Player = "Vladimir Ducasse" if Player == "Vlad Ducasse"
replace Player = "Walter Powell" if Player == "Walt Powell"
replace Player = "Wan'dale Robinson" if Player == "Wan'Dale Robinson"
replace Player = "Warren McClendon Jr." if Player == "Warren McClendon"
replace Player = "William Beatty" if Player == "Will Beatty"
replace Player = "Will Compton" if Player == "William Compton"
replace Player = "William Jackson" if Player == "William Jackson III"
replace Player = "Zac Diles" if Player == "Zach Diles"
replace Player = "Zach Carter" if Player == "Zachary Carter"
replace Player = "Ezekiel Turner" if Player == "Zeke Turner"

* Merge with cap data
replace Pos = "CB" if Player == "Mike Harris" & Team == "Jacksonville Jaguars" & Season == 2012 & (Week == 15 | Week == 17)
rename Pos PFRPos
merge m:m Team Season Player using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Game Analysis\Data 10 Money Clean.dta"
replace Pos = PFRPos if Pos == ""
keep GameID Team Opp Season Week Player Pos TotalCapHit
replace TotalCapHit = 0 if TotalCapHit == .

* Expand starters-only dataset into full roster-week grid. First, save original dataset for merge
tempfile Starters
save `Starters'

* Build the team-season roster (unique players with Pos & TotalCapHit)
preserve
bysort Team Season Player (Pos TotalCapHit): keep if _n==1
keep Team Season Player Pos TotalCapHit
tempfile Roster
save `Roster'
restore

* Build unique list of Team-Season-Week combos (games)
preserve
bysort Team Season Week GameID Opp: keep if _n==1
keep Team Season Week GameID Opp
tempfile Weeks
save `Weeks'
restore

* Cross join roster x weeks (to create full Team-Season-Week-Player grid)
use `Roster', clear
joinby Team Season using `Weeks'
* Now we have every player for every week on that team-season
* Includes: Team Season Player Pos TotalCapHit + Week/GameID/Opp

* Merge with original dataset (starters only)
merge 1:1 Team Season Week Player using `Starters', keepusing(GameID) keep(match master)

* In this merge:
*   _merge==3 → player was in original data (starter that week)
*   _merge==1 → player came from roster x week (not a starter)

drop if Week == .
gen Starter = (_merge==3)
drop _merge

* Done: Now each Team-Season-Week has the full roster, with Starter=1 if they actually started, else 0
gsort Team Season Week -Starter Player

* Generate log(Wage Bill) and starter to nonstarter cap hit ratio (like with injured money, we drop QBs)
drop if Pos == "QB"
bysort Team Season Week: egen WageBill = total(TotalCapHit)
gen logWB = log(WageBill)
label variable logWB logWB

bysort Team Season Week: egen StarterCapHit = total(TotalCapHit * Starter)
bysort Team Season Week: egen NonStarterCapHit = total(TotalCapHit * (1-Starter))
gen SNSRatio = StarterCapHit / NonStarterCapHit
label variable SNSRatio SNSRatio
drop StarterCapHit NonStarterCapHit

* Compute Gini coefficient of starter TotalCapHit by Team-Season-Week. First, work only on starters
preserve
keep if Starter==1

* Sort by group & TotalCapHit
bysort Team Season Week (TotalCapHit): gen NInGroup = _N
bysort Team Season Week: gen i = _n

* Total sum of cap hits for starters in this week
bysort Team Season Week: egen TotalCap = total(TotalCapHit)

* Weighted sum for numerator: sum( (2*i - n - 1) * x_i )
gen WeightTerm = (2*i - NInGroup - 1) * TotalCapHit
bysort Team Season Week: egen Numer = total(WeightTerm)

* Now compute Gini for each group
gen SGini = Numer / (NInGroup * TotalCap)
label variable SGini SGini

* Keep only one row per group (first row)
bysort Team Season Week (i): keep if _n==1

* Save temporary Gini dataset
keep Team Season Week SGini
tempfile Gini
save `Gini'
restore

* Merge Gini back to full dataset (so all players in that week get the same value)
merge m:1 Team Season Week using `Gini', nogen

* Collapse dataset to game level
keep GameID Team Season Week Opp logWB SGini SNSRatio
duplicates drop

* Generate opponent logWB, SGini, and SNSRatio
local Variable logWB SGini SNSRatio
foreach x in `Variable' {
	quietly gen Opp`x' = .
	local NRows = 800
	local NObs = _N
	local NCols = ceil(`NObs'/`NRows')

	*Sort dataset by Opp and store Variable as a matrix
	sort Opp Season Week
	matrix Matrix = J(`NRows',`NCols',.)
	forvalues i = 1/`NCols' {
		local Start = (`i'-1)*`NRows'+1
		
		forvalues j = 1/`NRows' {
			local Obs = `Start'+`j'-1
			if `Obs' <= `NObs' {
				matrix Matrix[`j',`i'] = `x'[`Obs']
			}
		}
	}

	*Sort dataset by Team and restore matrix as OppVariable
	sort Team Season Week
	local Obs = 1
	forvalues i = 1/`NCols' {
		forvalues j = 1/`NRows' {
			if `Obs' <= `NObs' {
				*Extract value from matrix and store it in OppVariable
				quietly replace Opp`x' = Matrix[`j',`i'] in `Obs'
				local Obs = `Obs'+1
			}
		}
	}
	label variable Opp`x' "Opp`x'"
}
order GameID Team Season Week Opp logWB OpplogWB SGini OppSGini SNSRatio OppSNSRatio

* Merge with Combined Gamelogs IM
merge 1:1 GameID Team using "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Game Analysis\Data 12 Combined Gamelogs IM.dta", nogen
order GameID Team Season Week, after(Game)
order Opp, after(Day)
order logWB SGini SNSRatio, after(logIM)
order OpplogWB OppSGini OppSNSRatio, after(OpplogIM)
save "C:\Users\Owner\OneDrive\Documents\Georgetown University\Thesis Writer\Research\QB Worth\Game Analysis\Data 14 Combined Gamelogs SNS.dta", replace