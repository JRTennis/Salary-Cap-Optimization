clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 6 Season AV Clean.dta"

* Merge Injuries with Money
merge 1:1 Team Season Player using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 8 Season Cap Clean.dta"

* Copy observations where _merge = 1 into "2 Season Corrections.xlsx", and add code to "Do 2 AV Clean" to fix names that don't match Cap dataset
order _merge, first
label variable _merge "Merge"
sort _merge Team Season Player
drop Index OldPlayer

* Get Spotrac positions for players missing from Cap dataset (Mulholland and Calvetti don't do this; see "2 Season Corrections.xlsx")
gen Flag = 1
if Flag == 1 {
	quietly replace PosCap = "OLB" if Player == "A.J. Edds" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Aaron Brown" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Adrian Arrington" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Adrian Awasom" & Team == "Minnesota Vikings" & Season == 2011
	quietly replace PosCap = "S" if Player == "Akwasi Owusu-Ansah" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "S" if Player == "Al Afalava" & Team == "Tennessee Titans" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Al Harris" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Albert Haynesworth" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Amon Gordon" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Andre Carter" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Andre Fluellen" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "G" if Player == "Andrew Gardner" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Andrew Hawkins" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "G" if Player == "Anthony Herrera" & Team == "Minnesota Vikings" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Anthony Hill" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Anthony Madison" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Antonio Dixon" & Team == "Indianapolis Colts" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Antwon Blake" & Team == "Jacksonville Jaguars" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Aqib Talib" & Team == "Tampa Bay Buccaneers" & Season == 2012
	quietly replace PosCap = "RB" if Player == "Armando Allen" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Armando Allen" & Team == "Chicago Bears" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Armon Binns" & Team == "Cincinnati Bengals" & Season == 2012
	quietly replace PosCap = "DT" if Player == "Aubrayo Franklin" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Austin Pettis" & Team == "Los Angeles Chargers" & Season == 2014
	quietly replace PosCap = "DT" if Player == "Auston English" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Ben Leber" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Benny Sapp" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Benny Sapp" & Team == "Minnesota Vikings" & Season == 2011
	quietly replace PosCap = "P" if Player == "Brad Maynard" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Brandon Burton" & Team == "Cincinnati Bengals" & Season == 2013
	quietly replace PosCap = "CB" if Player == "Brandon Hughes" & Team == "Philadelphia Eagles" & Season == 2013
	quietly replace PosCap = "CB" if Player == "Brandon Rusnak" & Team == "Jacksonville Jaguars" & Season == 2019
	quietly replace PosCap = "WR" if Player == "Brandon Stokley" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Brandon Tate" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Brandon Zylstra" & Team == "Minnesota Vikings" & Season == 2018
	quietly replace PosCap = "WR" if Player == "Braylon Edwards" & Team == "New York Jets" & Season == 2012
	quietly replace PosCap = "C" if Player == "Brian De La Puente" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Brian Iwuh" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Brian Jackson" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Brian Leonard" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Brian Leonard" & Team == "Cincinnati Bengals" & Season == 2012
	quietly replace PosCap = "RB" if Player == "Brian Leonard" & Team == "New Orleans Saints" & Season == 2014
	quietly replace PosCap = "RB" if Player == "Brian Leonard" & Team == "Tampa Bay Buccaneers" & Season == 2013
	quietly replace PosCap = "WR" if Player == "Brian Robiskie" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Brian Sanford" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Brian Schaefering" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Brian Williams" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Bruce Davis" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Bruce Irvin" & Team == "Miami Dolphins" & Season == 2023
	quietly replace PosCap = "ILB" if Player == "Bryan Kehl" & Team == "Washington Commanders" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Bryan McCann" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Bryant Johnson" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Byron Westbrook" & Team == "Washington Commanders" & Season == 2011
	quietly replace PosCap = "S" if Player == "C.J. Wallace" & Team == "Los Angeles Chargers" & Season == 2011
	quietly replace PosCap = "K" if Player == "Cade York" & Team == "Washington Commanders" & Season == 2024
	quietly replace PosCap = "QB" if Player == "Caleb Hanie" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Carl Ihenacho" & Team == "Las Vegas Raiders" & Season == 2012
	quietly replace PosCap = "C" if Player == "Casey Wiegmann" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Chad Spann" & Team == "Pittsburgh Steelers" & Season == 2011
	quietly replace PosCap = "G" if Player == "Chandler Brewer" & Team == "Tennessee Titans" & Season == 2024
	quietly replace PosCap = "DE" if Player == "Chauncey Davis" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Chris Harper" & Team == "Green Bay Packers" & Season == 2013
	quietly replace PosCap = "S" if Player == "Chris Harris" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Chris Hawkins" & Team == "Tennessee Titans" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Chris Massey" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Chris Ogbonnaya" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Chris Ogbonnaya" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "LS" if Player == "Christian Yount" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "LS" if Player == "Christian Yount" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Clifton Geathers" & Team == "Indianapolis Colts" & Season == 2012
	quietly replace PosCap = "C" if Player == "Colin Baxter" & Team == "Los Angeles Chargers" & Season == 2011
	quietly replace PosCap = "C" if Player == "Colin Baxter" & Team == "New York Jets" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Colin Cloherty" & Team == "Jacksonville Jaguars" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Colin Cochart" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Collin Franklin" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Corbin Bryant" & Team == "Pittsburgh Steelers" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Courtney Roby" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Crezdon Butler" & Team == "Arizona Cardinals" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Crezdon Butler" & Team == "Washington Commanders" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Damian Williams" & Team == "Los Angeles Rams" & Season == 2014
	quietly replace PosCap = "DT" if Player == "Damion Square" & Team == "Cincinnati Bengals" & Season == 2021
	quietly replace PosCap = "WR" if Player == "Dan Chisena" & Team == "Baltimore Ravens" & Season == 2023
	quietly replace PosCap = "TE" if Player == "Dan Gronkowski" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "Dan Skuta" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Dane Sanzenbacher" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "RT" if Player == "Daniel Baldridge" & Team == "Jacksonville Jaguars" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Daniel Fells" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Daniel Muir" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Daniel Te'o-Nesheim" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Dante Rosario" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Darren Evans" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "ILB" if Player == "Darryl Sharpton" & Team == "Houston Texans" & Season == 2012
	quietly replace PosCap = "K" if Player == "Dave Rayner" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "LB" if Player == "David Nixon" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "LB" if Player == "David Vobora" & Team == "Seattle Seahawks" & Season == 2011
	quietly replace PosCap = "DT" if Player == "DeMario Pressley" & Team == "Carolina Panthers" & Season == 2011
	quietly replace PosCap = "RT" if Player == "Dennis Roland" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "S" if Player == "Deon Grant" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Derek Hagan" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "G" if Player == "Derrick Dockery" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Derrick Martin" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Desmond Bryant" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Devin Hester" & Team == "Seattle Seahawks" & Season == 2016
	quietly replace PosCap = "CB" if Player == "Dimitri Patterson" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "S" if Player == "Dominique Barber" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Donald Strickland" & Team == "New York Jets" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Donnie Avery" & Team == "Tennessee Titans" & Season == 2011
	quietly replace PosCap = "T" if Player == "Drew Miller" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Dwayne Hendricks" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Earnest Graham" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Eddie Jones" & Team == "New York Jets" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Eddie Williams" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Eddie Williams" & Team == "Seattle Seahawks" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Elbert Mack" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Eldra Buckley" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Emanuel Cook" & Team == "New York Jets" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Eric Foster" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "ILB" if Player == "Eric Martin" & Team == "Cleveland Browns" & Season == 2014
	quietly replace PosCap = "DE" if Player == "Eric Moore" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "Ernie Sims" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Ethan Fernea" & Team == "Indianapolis Colts" & Season == 2022
	quietly replace PosCap = "TE" if Player == "Evan Moore" & Team == "Seattle Seahawks" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Fendi Onobun" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Frank Walker" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Fred Robbins" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "Gary Guyton" & Team == "Los Angeles Chargers" & Season == 2012
	quietly replace PosCap = "DE" if Player == "Geno Grissom" & Team == "Indianapolis Colts" & Season == 2018
	quietly replace PosCap = "OLB" if Player == "Geno Hayes" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "DE" if Player == "George Johnson" & Team == "Tampa Bay Buccaneers" & Season == 2012
	quietly replace PosCap = "DE" if Player == "George Selvie" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "S" if Player == "Gerald Alexander" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Gerard Warren" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Greg Lloyd" & Team == "Buffalo Bills" & Season == 2012
	quietly replace PosCap = "DT" if Player == "Hebron Fangupo" & Team == "Seattle Seahawks" & Season == 2012
	quietly replace PosCap = "T" if Player == "Herbert Taylor" & Team == "Jacksonville Jaguars" & Season == 2012
	quietly replace PosCap = "DT" if Player == "Howard Green" & Team == "Green Bay Packers" & Season == 2011
	quietly replace PosCap = "G" if Player == "Ikechuku Ndukwe" & Team == "Los Angeles Chargers" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Isaiah Ekejiuba" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Isaiah Pead" & Team == "Miami Dolphins" & Season == 2016
	quietly replace PosCap = "TE" if Player == "Jacob Byrne" & Team == "Houston Texans" & Season == 2013
	quietly replace PosCap = "CB" if Player == "Jacques Reeves" & Team == "Kansas City Chiefs" & Season == 2012
	quietly replace PosCap = "LB" if Player == "Jamaal Westerman" & Team == "Arizona Cardinals" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Jamar Newsome" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "S" if Player == "James Butler" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "LB" if Player == "James Farrior" & Team == "Pittsburgh Steelers" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "James-Michael Johnson" & Team == "Tampa Bay Buccaneers" & Season == 2015
	quietly replace PosCap = "DE" if Player == "Jammie Kirlew" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "S" if Player == "Jarrad Page" & Team == "Minnesota Vikings" & Season == 2011
	quietly replace PosCap = "T" if Player == "Jarriel King" & Team == "Seattle Seahawks" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Jason Babin" & Team == "Arizona Cardinals" & Season == 2015
	quietly replace PosCap = "WR" if Player == "Jason Hill" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Jason Hill" & Team == "New York Jets" & Season == 2012
	quietly replace PosCap = "OLB" if Player == "Jason Williams" & Team == "Philadelphia Eagles" & Season == 2012
	quietly replace PosCap = "DE" if Player == "Jayme Mitchell" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Jeff Charleston" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Jeremiah Johnson" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "G" if Player == "Jeremy Bridges" & Team == "Carolina Panthers" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Jeremy Kerley" & Team == "New York Jets" & Season == 2017
	quietly replace PosCap = "DE" if Player == "Jeremy Mincey" & Team == "Denver Broncos" & Season == 2013
	quietly replace PosCap = "WR" if Player == "Jerheme Urban" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "RT" if Player == "Jermey Parnell" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Jerome Murphy" & Team == "Detroit Lions" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Jerome Murphy" & Team == "New Orleans Saints" & Season == 2012
	quietly replace PosCap = "LB" if Player == "Jerry Brown" & Team == "Indianapolis Colts" & Season == 2012
	quietly replace PosCap = "OLB" if Player == "Jerry Franklin" & Team == "Chicago Bears" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Jesse Holley" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Jim Dray" & Team == "Buffalo Bills" & Season == 2016
	quietly replace PosCap = "OLB" if Player == "JoLonn Dunbar" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "LS" if Player == "Joe Fortunato" & Team == "Green Bay Packers" & Season == 2021
	quietly replace PosCap = "T" if Player == "Joe Haeg" & Team == "Pittsburgh Steelers" & Season == 2021
	quietly replace PosCap = "ILB" if Player == "Joe Mays" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Joe Porter" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "TE" if Player == "John Gilmore" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "G" if Player == "John Greco" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "S" if Player == "Jon McGraw" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Jonathan Nelson" & Team == "Carolina Panthers" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Jonathan Wade" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Jonathan Wilhite" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "S" if Player == "Jordan Babineaux" & Team == "Tennessee Titans" & Season == 2011
	quietly replace PosCap = "S" if Player == "Jordan Lucas" & Team == "Miami Dolphins" & Season == 2016
	quietly replace PosCap = "WR" if Player == "Jordan Shipley" & Team == "Tampa Bay Buccaneers" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Josh Gordy" & Team == "Indianapolis Colts" & Season == 2012
	quietly replace PosCap = "QB" if Player == "Josh McCown" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Josh Victorian" & Team == "Pittsburgh Steelers" & Season == 2012
	quietly replace PosCap = "DT" if Player == "Jovan Haye" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Jovan Haye" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Julian Posey" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Justice Cunningham" & Team == "Los Angeles Rams" & Season == 2013
	quietly replace PosCap = "DT" if Player == "Justin Bannan" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Justin Houston" & Team == "Miami Dolphins" & Season == 2023
	quietly replace PosCap = "TE" if Player == "Justin Peelle" & Team == "San Francisco 49ers" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Justin Snow" & Team == "Washington Commanders" & Season == 2012
	quietly replace PosCap = "DE" if Player == "Justin Trattou" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Justin Tryon" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Justin Tryon" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "T" if Player == "Kareem McKenzie" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Keary Colbert" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "QB" if Player == "Kellen Clemens" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Kellen Heard" & Team == "Los Angeles Rams" & Season == 2012
	quietly replace PosCap = "DT" if Player == "Kelly Gregg" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Kelvin Benjamin" & Team == "Buffalo Bills" & Season == 2017
	quietly replace PosCap = "LB" if Player == "Ken Amato" & Team == "Tennessee Titans" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Kenny Onatolu" & Team == "Minnesota Vikings" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Kerwynn Williams" & Team == "Los Angeles Chargers" & Season == 2013
	quietly replace PosCap = "CB" if Player == "Kevin Barnes" & Team == "Detroit Lions" & Season == 2012
	quietly replace PosCap = "LB" if Player == "Kevin Bentley" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Kevin Bentley" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Kevin Brock" & Team == "Cincinnati Bengals" & Season == 2013
	quietly replace PosCap = "DE" if Player == "Keyunta Dawson" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Kiante Tripp" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Kregg Lumpkin" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "G" if Player == "Kyle DeVan" & Team == "Philadelphia Eagles" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Kyle McCarthy" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Kyle Miller" & Team == "Indianapolis Colts" & Season == 2012
	quietly replace PosCap = "LS" if Player == "Kyle Nelson" & Team == "Los Angeles Chargers" & Season == 2012
	quietly replace PosCap = "LS" if Player == "Kyle Nelson" & Team == "San Francisco 49ers" & Season == 2019
	quietly replace PosCap = "QB" if Player == "Kyle Orton" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "Kyle Wilber" & Team == "Las Vegas Raiders" & Season == 2021
	quietly replace PosCap = "WR" if Player == "Laurent Robinson" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Lawrence Cager" & Team == "New York Jets" & Season == 2022
	quietly replace PosCap = "FB" if Player == "Lawrence Vickers" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "CB" if Player == "LeQuan Lewis" & Team == "Dallas Cowboys" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Legedu Naanee" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Leigh Bodden" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Leigh Torrence" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Leonard Pope" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Leonard Pope" & Team == "Pittsburgh Steelers" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Lito Sheppard" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Lousaka Polite" & Team == "Atlanta Falcons" & Season == 2012
	quietly replace PosCap = "RB" if Player == "Lousaka Polite" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "S" if Player == "Mana Silva" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "S" if Player == "Mana Silva" & Team == "Dallas Cowboys" & Season == 2012
	quietly replace PosCap = "RB" if Player == "Manase Tonga" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "TE" if Player == "MarQueis Gray" & Team == "Miami Dolphins" & Season == 2016
	quietly replace PosCap = "T" if Player == "Marc Colombo" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Mardy Gilyard" & Team == "Philadelphia Eagles" & Season == 2012
	quietly replace PosCap = "DE" if Player == "Mario Addison" & Team == "Carolina Panthers" & Season == 2012
	quietly replace PosCap = "LT" if Player == "Mark Asper" & Team == "Jacksonville Jaguars" & Season == 2012
	quietly replace PosCap = "QB" if Player == "Mark Brunell" & Team == "New York Jets" & Season == 2011
	quietly replace PosCap = "T" if Player == "Mark LeVoir" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Marquice Cole" & Team == "New York Jets" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Marshay Green" & Team == "Indianapolis Colts" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Martin Rucker" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Martin Rucker" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Mason Brodine" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "C" if Player == "Matt Katula" & Team == "Minnesota Vikings" & Season == 2011
	quietly replace PosCap = "P" if Player == "Matt Turk" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "P" if Player == "Matt Turk" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "K" if Player == "Michael Badgley" & Team == "Tennessee Titans" & Season == 2021
	quietly replace PosCap = "CB" if Player == "Michael Coe" & Team == "Dallas Cowboys" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Michael Coe" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Michael Coe" & Team == "New York Giants" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Michael Coe" & Team == "New York Giants" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Michael Higgins" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Michael Higgins" & Team == "New Orleans Saints" & Season == 2012
	quietly replace PosCap = "LB" if Player == "Michael Lockley" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Micheal Spurlock" & Team == "Jacksonville Jaguars" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Micheal Spurlock" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Mike McNeill" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Mike Pennel" & Team == "Green Bay Packers" & Season == 2016
	quietly replace PosCap = "OLB" if Player == "Mike Rivera" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "WR" if Player == "Mike Sims-Walker" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Mike Sims-Walker" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "T" if Player == "Mike Tepper" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Mike Wright" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Mitch King" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "G" if Player == "Mitch Petrus" & Team == "New England Patriots" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Morgan Trent" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Nate Collins" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "K" if Player == "Nate Kaeding" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "G" if Player == "Nate Livings" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "FS" if Player == "Nate Ness" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Nate Triplett" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Nathan Jones" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "Nicholas Morrow" & Team == "Philadelphia Eagles" & Season == 2024
	quietly replace PosCap = "P" if Player == "Nick Harris" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Nick Hayden" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Nick Miller" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "K" if Player == "Nick Novak" & Team == "Los Angeles Chargers" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Nick Reed" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Nick Reed" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "K" if Player == "Nick Rose" & Team == "Los Angeles Chargers" & Season == 2018
	quietly replace PosCap = "S" if Player == "O.J. Atogwe" & Team == "Washington Commanders" & Season == 2011
	quietly replace PosCap = "C" if Player == "Olin Kreutz" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "G" if Player == "Oniel Cousins" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "RT" if Player == "Pat McQuistan" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "Patrick Trahan" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Paul Oliver" & Team == "Los Angeles Chargers" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Phillip Adams" & Team == "Seattle Seahawks" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Phillip Supernaw" & Team == "Kansas City Chiefs" & Season == 2014
	quietly replace PosCap = "WR" if Player == "Quan Cosby" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "T" if Player == "Quinn Ojinnaka" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "T" if Player == "Quinn Ojinnaka" & Team == "Los Angeles Rams" & Season == 2012
	quietly replace PosCap = "RB" if Player == "Quinn Porter" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Raheem Brock" & Team == "Seattle Seahawks" & Season == 2011
	quietly replace PosCap = "OLB" if Player == "Ramon Humber" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "G" if Player == "Reggie Wells" & Team == "Carolina Panthers" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Richard Medlin" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "G" if Player == "Richie Incognito" & Team == "Las Vegas Raiders" & Season == 2019
	quietly replace PosCap = "CB" if Player == "Rico Murray" & Team == "Cincinnati Bengals" & Season == 2011
	quietly replace PosCap = "C" if Player == "Rob Bruggeman" & Team == "Atlanta Falcons" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Rob Myers" & Team == "Washington Commanders" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Robert Hughes" & Team == "Arizona Cardinals" & Season == 2013
	quietly replace PosCap = "OLB" if Player == "Robert James" & Team == "Kansas City Chiefs" & Season == 2013
	quietly replace PosCap = "P" if Player == "Robert Malone" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Roderick Hood" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "FS" if Player == "Ron Parker" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "FS" if Player == "Rontez Miles" & Team == "New York Jets" & Season == 2018
	quietly replace PosCap = "QB" if Player == "Rudy Carpenter" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "C" if Player == "Ryan Cook" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "T" if Player == "Ryan Diem" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "P" if Player == "Ryan Donahue" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "C" if Player == "Ryan Pontbriand" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Ryan Taylor" & Team == "Cleveland Browns" & Season == 2014
	quietly replace PosCap = "RB" if Player == "Ryan Torain" & Team == "Washington Commanders" & Season == 2011
	quietly replace PosCap = "S" if Player == "Sabby Piscitelli" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "LT" if Player == "Sam Young" & Team == "Jacksonville Jaguars" & Season == 2013
	quietly replace PosCap = "RB" if Player == "Sammy Morris" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "C" if Player == "Samson Satele" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2021
	quietly replace PosCap = "LB" if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2022
	quietly replace PosCap = "LB" if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2023
	quietly replace PosCap = "DT" if Player == "Scott Paxson" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "C" if Player == "Scott Wedige" & Team == "Arizona Cardinals" & Season == 2012
	quietly replace PosCap = "G" if Player == "Seth Olsen" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Shane Vereen" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "DT" if Player == "Shaun Rogers" & Team == "New Orleans Saints" & Season == 2011
	quietly replace PosCap = "K" if Player == "Shayne Graham" & Team == "Baltimore Ravens" & Season == 2011
	quietly replace PosCap = "K" if Player == "Shayne Graham" & Team == "Miami Dolphins" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Stephen Cooper" & Team == "Los Angeles Chargers" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Stephen Franklin" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Stephen Spach" & Team == "Jacksonville Jaguars" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Stephen Spach" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Sterling Moore" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Sterling Moore" & Team == "New England Patriots" & Season == 2012
	quietly replace PosCap = "TE" if Player == "Steve Maneri" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "TE" if Player == "Steve Maneri" & Team == "New England Patriots" & Season == 2014
	quietly replace PosCap = "RB" if Player == "Steve Slaton" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "K" if Player == "Steven Hauschka" & Team == "Seattle Seahawks" & Season == 2011
	quietly replace PosCap = "SS" if Player == "Stevie Brown" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "CB" if Player == "T.J. Heath" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "WR" if Player == "T.J. Houshmandzadeh" & Team == "Las Vegas Raiders" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Tashard Choice" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Tashard Choice" & Team == "Washington Commanders" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Terrance Ganaway" & Team == "Los Angeles Rams" & Season == 2012
	quietly replace PosCap = "DT" if Player == "Terrence Cody" & Team == "Baltimore Ravens" & Season == 2014
	quietly replace PosCap = "C" if Player == "Thomas Austin" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "RB" if Player == "Thomas Clayton" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "RT" if Player == "Thomas Welch" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "S" if Player == "Tim Atchison" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Tim Crowder" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "ILB" if Player == "Tim Dobbins" & Team == "Houston Texans" & Season == 2011
	quietly replace PosCap = "WR" if Player == "Tiquan Underwood" & Team == "New England Patriots" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Titus Brown" & Team == "Cleveland Browns" & Season == 2011
	quietly replace PosCap = "CB" if Player == "Tony Carter" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "FB" if Player == "Tony Fiammetta" & Team == "Dallas Cowboys" & Season == 2011
	quietly replace PosCap = "LT" if Player == "Tony Hills" & Team == "Denver Broncos" & Season == 2011
	quietly replace PosCap = "G" if Player == "Tony Wragge" & Team == "Los Angeles Rams" & Season == 2011
	quietly replace PosCap = "T" if Player == "Trai Essex" & Team == "Indianapolis Colts" & Season == 2012
	quietly replace PosCap = "DT" if Player == "Travian Robertson" & Team == "Seattle Seahawks" & Season == 2014
	quietly replace PosCap = "S" if Player == "Troy Nolan" & Team == "Miami Dolphins" & Season == 2012
	quietly replace PosCap = "CB" if Player == "Trumaine McBride" & Team == "Jacksonville Jaguars" & Season == 2011
	quietly replace PosCap = "LS" if Player == "Tyler Ott" & Team == "Seattle Seahawks" & Season == 2016
	quietly replace PosCap = "QB" if Player == "Tyler Palko" & Team == "Kansas City Chiefs" & Season == 2011
	quietly replace PosCap = "LT" if Player == "Tyler Polumbus" & Team == "Washington Commanders" & Season == 2011
	quietly replace PosCap = "S" if Player == "Tyvis Powell" & Team == "Seattle Seahawks" & Season == 2016
	quietly replace PosCap = "CB" if Player == "Vince Agnew" & Team == "Dallas Cowboys" & Season == 2012
	quietly replace PosCap = "S" if Player == "Vincent Fuller" & Team == "Detroit Lions" & Season == 2011
	quietly replace PosCap = "FS" if Player == "Winston Guy" & Team == "Indianapolis Colts" & Season == 2014
	quietly replace PosCap = "S" if Player == "Winston Venable" & Team == "Chicago Bears" & Season == 2011
	quietly replace PosCap = "LB" if Player == "Xavier Adibi" & Team == "Minnesota Vikings" & Season == 2011
	quietly replace PosCap = "ILB" if Player == "Zac Diles" & Team == "Indianapolis Colts" & Season == 2011
	quietly replace PosCap = "ILB" if Player == "Zac Diles" & Team == "Tampa Bay Buccaneers" & Season == 2011
	quietly replace PosCap = "DE" if Player == "Zach Kerr" & Team == "Cincinnati Bengals" & Season == 2021
	quietly replace PosCap = "G" if Player == "Zack Williams" & Team == "Carolina Panthers" & Season == 2012
}
drop Flag

* Get RookieSeason for players missing from Cap dataset (see "2 Season Corrections.xlsx")
quietly replace RookieSeason = 2010 if Player == "A.J. Edds" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Aaron Brown" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Adrian Arrington" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Adrian Awasom" & Team == "Minnesota Vikings" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Akwasi Owusu-Ansah" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Al Afalava" & Team == "Tennessee Titans" & Season == 2012
quietly replace RookieSeason = 1997 if Player == "Al Harris" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "Albert Haynesworth" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Amon Gordon" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2001 if Player == "Andre Carter" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Andre Fluellen" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2009 if Player == "Andrew Gardner" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Andrew Hawkins" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Anthony Herrera" & Team == "Minnesota Vikings" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Anthony Hill" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Anthony Madison" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Antonio Dixon" & Team == "Indianapolis Colts" & Season == 2012
quietly replace RookieSeason = 2012 if Player == "Antwon Blake" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace RookieSeason = 2008 if Player == "Aqib Talib" & Team == "Tampa Bay Buccaneers" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Armando Allen" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Armando Allen" & Team == "Chicago Bears" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Armon Binns" & Team == "Cincinnati Bengals" & Season == 2012
quietly replace RookieSeason = 2003 if Player == "Aubrayo Franklin" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Austin Pettis" & Team == "Los Angeles Chargers" & Season == 2014
quietly replace RookieSeason = 2010 if Player == "Auston English" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "Ben Leber" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Benny Sapp" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Benny Sapp" & Team == "Minnesota Vikings" & Season == 2011
quietly replace RookieSeason = 1997 if Player == "Brad Maynard" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Brandon Burton" & Team == "Cincinnati Bengals" & Season == 2013
quietly replace RookieSeason = 2009 if Player == "Brandon Hughes" & Team == "Philadelphia Eagles" & Season == 2013
quietly replace RookieSeason = 2019 if Player == "Brandon Rusnak" & Team == "Jacksonville Jaguars" & Season == 2019
quietly replace RookieSeason = 1999 if Player == "Brandon Stokley" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Brandon Tate" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2018 if Player == "Brandon Zylstra" & Team == "Minnesota Vikings" & Season == 2018
quietly replace RookieSeason = 2005 if Player == "Braylon Edwards" & Team == "New York Jets" & Season == 2012
quietly replace RookieSeason = 2008 if Player == "Brian De La Puente" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Brian Iwuh" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Brian Jackson" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Brian Leonard" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Brian Leonard" & Team == "Cincinnati Bengals" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Brian Leonard" & Team == "New Orleans Saints" & Season == 2014
quietly replace RookieSeason = 2007 if Player == "Brian Leonard" & Team == "Tampa Bay Buccaneers" & Season == 2013
quietly replace RookieSeason = 2009 if Player == "Brian Robiskie" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Brian Sanford" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Brian Schaefering" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "Brian Williams" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Bruce Davis" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2012 if Player == "Bruce Irvin" & Team == "Miami Dolphins" & Season == 2023
quietly replace RookieSeason = 2008 if Player == "Bryan Kehl" & Team == "Washington Commanders" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Bryan McCann" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Bryant Johnson" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Byron Westbrook" & Team == "Washington Commanders" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "C.J. Wallace" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace RookieSeason = 2022 if Player == "Cade York" & Team == "Washington Commanders" & Season == 2024
quietly replace RookieSeason = 2008 if Player == "Caleb Hanie" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Carl Ihenacho" & Team == "Las Vegas Raiders" & Season == 2012
quietly replace RookieSeason = 1996 if Player == "Casey Wiegmann" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Chad Spann" & Team == "Pittsburgh Steelers" & Season == 2011
quietly replace RookieSeason = 2019 if Player == "Chandler Brewer" & Team == "Tennessee Titans" & Season == 2024
quietly replace RookieSeason = 2005 if Player == "Chauncey Davis" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2013 if Player == "Chris Harper" & Team == "Green Bay Packers" & Season == 2013
quietly replace RookieSeason = 2005 if Player == "Chris Harris" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Chris Hawkins" & Team == "Tennessee Titans" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "Chris Massey" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Chris Ogbonnaya" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Chris Ogbonnaya" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Christian Yount" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Christian Yount" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Clifton Geathers" & Team == "Indianapolis Colts" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Colin Baxter" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Colin Baxter" & Team == "New York Jets" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Colin Cloherty" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Colin Cochart" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Collin Franklin" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Corbin Bryant" & Team == "Pittsburgh Steelers" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Courtney Roby" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Crezdon Butler" & Team == "Arizona Cardinals" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Crezdon Butler" & Team == "Washington Commanders" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Damian Williams" & Team == "Los Angeles Rams" & Season == 2014
quietly replace RookieSeason = 2013 if Player == "Damion Square" & Team == "Cincinnati Bengals" & Season == 2021
quietly replace RookieSeason = 2020 if Player == "Dan Chisena" & Team == "Baltimore Ravens" & Season == 2023
quietly replace RookieSeason = 2009 if Player == "Dan Gronkowski" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Dan Skuta" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Dane Sanzenbacher" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Daniel Baldridge" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace RookieSeason = 2006 if Player == "Daniel Fells" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Daniel Muir" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Daniel Te'o-Nesheim" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Dante Rosario" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Darren Evans" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Darryl Sharpton" & Team == "Houston Texans" & Season == 2012
quietly replace RookieSeason = 2005 if Player == "Dave Rayner" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "David Nixon" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "David Vobora" & Team == "Seattle Seahawks" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "DeMario Pressley" & Team == "Carolina Panthers" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Dennis Roland" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2000 if Player == "Deon Grant" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Derek Hagan" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Derrick Dockery" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Derrick Martin" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Desmond Bryant" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Devin Hester" & Team == "Seattle Seahawks" & Season == 2016
quietly replace RookieSeason = 2007 if Player == "Dimitri Patterson" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2008 if Player == "Dominique Barber" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Donald Strickland" & Team == "New York Jets" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Donnie Avery" & Team == "Tennessee Titans" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Drew Miller" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Dwayne Hendricks" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Earnest Graham" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Eddie Jones" & Team == "New York Jets" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Eddie Williams" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Eddie Williams" & Team == "Seattle Seahawks" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Elbert Mack" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Eldra Buckley" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Emanuel Cook" & Team == "New York Jets" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Eric Foster" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2013 if Player == "Eric Martin" & Team == "Cleveland Browns" & Season == 2014
quietly replace RookieSeason = 2005 if Player == "Eric Moore" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Ernie Sims" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2022 if Player == "Ethan Fernea" & Team == "Indianapolis Colts" & Season == 2022
quietly replace RookieSeason = 2008 if Player == "Evan Moore" & Team == "Seattle Seahawks" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Fendi Onobun" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Frank Walker" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2000 if Player == "Fred Robbins" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Gary Guyton" & Team == "Los Angeles Chargers" & Season == 2012
quietly replace RookieSeason = 2015 if Player == "Geno Grissom" & Team == "Indianapolis Colts" & Season == 2018
quietly replace RookieSeason = 2008 if Player == "Geno Hayes" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "George Johnson" & Team == "Tampa Bay Buccaneers" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "George Selvie" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Gerald Alexander" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2001 if Player == "Gerard Warren" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Greg Lloyd" & Team == "Buffalo Bills" & Season == 2012
quietly replace RookieSeason = 2012 if Player == "Hebron Fangupo" & Team == "Seattle Seahawks" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Herbert Taylor" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace RookieSeason = 2002 if Player == "Howard Green" & Team == "Green Bay Packers" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Ikechuku Ndukwe" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Isaiah Ekejiuba" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2012 if Player == "Isaiah Pead" & Team == "Miami Dolphins" & Season == 2016
quietly replace RookieSeason = 2013 if Player == "Jacob Byrne" & Team == "Houston Texans" & Season == 2013
quietly replace RookieSeason = 2004 if Player == "Jacques Reeves" & Team == "Kansas City Chiefs" & Season == 2012
quietly replace RookieSeason = 2009 if Player == "Jamaal Westerman" & Team == "Arizona Cardinals" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Jamar Newsome" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "James Butler" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 1997 if Player == "James Farrior" & Team == "Pittsburgh Steelers" & Season == 2011
quietly replace RookieSeason = 2012 if Player == "James-Michael Johnson" & Team == "Tampa Bay Buccaneers" & Season == 2015
quietly replace RookieSeason = 2010 if Player == "Jammie Kirlew" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Jarrad Page" & Team == "Minnesota Vikings" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Jarriel King" & Team == "Seattle Seahawks" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Jason Babin" & Team == "Arizona Cardinals" & Season == 2015
quietly replace RookieSeason = 2007 if Player == "Jason Hill" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Jason Hill" & Team == "New York Jets" & Season == 2012
quietly replace RookieSeason = 2009 if Player == "Jason Williams" & Team == "Philadelphia Eagles" & Season == 2012
quietly replace RookieSeason = 2006 if Player == "Jayme Mitchell" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Jeff Charleston" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Jeremiah Johnson" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Jeremy Bridges" & Team == "Carolina Panthers" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Jeremy Kerley" & Team == "New York Jets" & Season == 2017
quietly replace RookieSeason = 2006 if Player == "Jeremy Mincey" & Team == "Denver Broncos" & Season == 2013
quietly replace RookieSeason = 2003 if Player == "Jerheme Urban" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Jermey Parnell" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Jerome Murphy" & Team == "Detroit Lions" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Jerome Murphy" & Team == "New Orleans Saints" & Season == 2012
quietly replace RookieSeason = 2012 if Player == "Jerry Brown" & Team == "Indianapolis Colts" & Season == 2012
quietly replace RookieSeason = 2012 if Player == "Jerry Franklin" & Team == "Chicago Bears" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Jesse Holley" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Jim Dray" & Team == "Buffalo Bills" & Season == 2016
quietly replace RookieSeason = 2008 if Player == "JoLonn Dunbar" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2017 if Player == "Joe Fortunato" & Team == "Green Bay Packers" & Season == 2021
quietly replace RookieSeason = 2016 if Player == "Joe Haeg" & Team == "Pittsburgh Steelers" & Season == 2021
quietly replace RookieSeason = 2008 if Player == "Joe Mays" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Joe Porter" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "John Gilmore" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "John Greco" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "Jon McGraw" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Jonathan Nelson" & Team == "Carolina Panthers" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Jonathan Wade" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Jonathan Wilhite" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Jordan Babineaux" & Team == "Tennessee Titans" & Season == 2011
quietly replace RookieSeason = 2016 if Player == "Jordan Lucas" & Team == "Miami Dolphins" & Season == 2016
quietly replace RookieSeason = 2010 if Player == "Jordan Shipley" & Team == "Tampa Bay Buccaneers" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Josh Gordy" & Team == "Indianapolis Colts" & Season == 2012
quietly replace RookieSeason = 2002 if Player == "Josh McCown" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Josh Victorian" & Team == "Pittsburgh Steelers" & Season == 2012
quietly replace RookieSeason = 2005 if Player == "Jovan Haye" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Jovan Haye" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Julian Posey" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2013 if Player == "Justice Cunningham" & Team == "Los Angeles Rams" & Season == 2013
quietly replace RookieSeason = 2002 if Player == "Justin Bannan" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Justin Houston" & Team == "Miami Dolphins" & Season == 2023
quietly replace RookieSeason = 2002 if Player == "Justin Peelle" & Team == "San Francisco 49ers" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Justin Snow" & Team == "Washington Commanders" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Justin Trattou" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Justin Tryon" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Justin Tryon" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2001 if Player == "Kareem McKenzie" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Keary Colbert" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Kellen Clemens" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Kellen Heard" & Team == "Los Angeles Rams" & Season == 2012
quietly replace RookieSeason = 1999 if Player == "Kelly Gregg" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2014 if Player == "Kelvin Benjamin" & Team == "Buffalo Bills" & Season == 2017
quietly replace RookieSeason = 2002 if Player == "Ken Amato" & Team == "Tennessee Titans" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Kenny Onatolu" & Team == "Minnesota Vikings" & Season == 2011
quietly replace RookieSeason = 2013 if Player == "Kerwynn Williams" & Team == "Los Angeles Chargers" & Season == 2013
quietly replace RookieSeason = 2009 if Player == "Kevin Barnes" & Team == "Detroit Lions" & Season == 2012
quietly replace RookieSeason = 2002 if Player == "Kevin Bentley" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "Kevin Bentley" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Kevin Brock" & Team == "Cincinnati Bengals" & Season == 2013
quietly replace RookieSeason = 2007 if Player == "Keyunta Dawson" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Kiante Tripp" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Kregg Lumpkin" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Kyle DeVan" & Team == "Philadelphia Eagles" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Kyle McCarthy" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Kyle Miller" & Team == "Indianapolis Colts" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Kyle Nelson" & Team == "Los Angeles Chargers" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Kyle Nelson" & Team == "San Francisco 49ers" & Season == 2019
quietly replace RookieSeason = 2005 if Player == "Kyle Orton" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2012 if Player == "Kyle Wilber" & Team == "Las Vegas Raiders" & Season == 2021
quietly replace RookieSeason = 2007 if Player == "Laurent Robinson" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2020 if Player == "Lawrence Cager" & Team == "New York Jets" & Season == 2022
quietly replace RookieSeason = 2006 if Player == "Lawrence Vickers" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "LeQuan Lewis" & Team == "Dallas Cowboys" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Legedu Naanee" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2005 if Player == "Leigh Bodden" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Leigh Torrence" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Leonard Pope" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Leonard Pope" & Team == "Pittsburgh Steelers" & Season == 2012
quietly replace RookieSeason = 2002 if Player == "Lito Sheppard" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Lousaka Polite" & Team == "Atlanta Falcons" & Season == 2012
quietly replace RookieSeason = 2004 if Player == "Lousaka Polite" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Mana Silva" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Mana Silva" & Team == "Dallas Cowboys" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Manase Tonga" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2013 if Player == "MarQueis Gray" & Team == "Miami Dolphins" & Season == 2016
quietly replace RookieSeason = 2002 if Player == "Marc Colombo" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Mardy Gilyard" & Team == "Philadelphia Eagles" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Mario Addison" & Team == "Carolina Panthers" & Season == 2012
quietly replace RookieSeason = 2012 if Player == "Mark Asper" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace RookieSeason = 1993 if Player == "Mark Brunell" & Team == "New York Jets" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Mark LeVoir" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Marquice Cole" & Team == "New York Jets" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Marshay Green" & Team == "Indianapolis Colts" & Season == 2012
quietly replace RookieSeason = 2008 if Player == "Martin Rucker" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Martin Rucker" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Mason Brodine" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Matt Katula" & Team == "Minnesota Vikings" & Season == 2011
quietly replace RookieSeason = 1995 if Player == "Matt Turk" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 1995 if Player == "Matt Turk" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2018 if Player == "Michael Badgley" & Team == "Tennessee Titans" & Season == 2021
quietly replace RookieSeason = 2007 if Player == "Michael Coe" & Team == "Dallas Cowboys" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Michael Coe" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Michael Coe" & Team == "New York Giants" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Michael Coe" & Team == "New York Giants" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Michael Higgins" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Michael Higgins" & Team == "New Orleans Saints" & Season == 2012
quietly replace RookieSeason = 2011 if Player == "Michael Lockley" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Micheal Spurlock" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace RookieSeason = 2006 if Player == "Micheal Spurlock" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Mike McNeill" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2014 if Player == "Mike Pennel" & Team == "Green Bay Packers" & Season == 2016
quietly replace RookieSeason = 2009 if Player == "Mike Rivera" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Mike Sims-Walker" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Mike Sims-Walker" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Mike Tepper" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Mike Wright" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Mitch King" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Mitch Petrus" & Team == "New England Patriots" & Season == 2012
quietly replace RookieSeason = 2009 if Player == "Morgan Trent" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Nate Collins" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Nate Kaeding" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2006 if Player == "Nate Livings" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Nate Ness" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Nate Triplett" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2004 if Player == "Nathan Jones" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2017 if Player == "Nicholas Morrow" & Team == "Philadelphia Eagles" & Season == 2024
quietly replace RookieSeason = 2001 if Player == "Nick Harris" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Nick Hayden" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Nick Miller" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Nick Novak" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Nick Reed" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Nick Reed" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2016 if Player == "Nick Rose" & Team == "Los Angeles Chargers" & Season == 2018
quietly replace RookieSeason = 2005 if Player == "O.J. Atogwe" & Team == "Washington Commanders" & Season == 2011
quietly replace RookieSeason = 1998 if Player == "Olin Kreutz" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Oniel Cousins" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Pat McQuistan" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Patrick Trahan" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Paul Oliver" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Phillip Adams" & Team == "Seattle Seahawks" & Season == 2011
quietly replace RookieSeason = 2014 if Player == "Phillip Supernaw" & Team == "Kansas City Chiefs" & Season == 2014
quietly replace RookieSeason = 2009 if Player == "Quan Cosby" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Quinn Ojinnaka" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Quinn Ojinnaka" & Team == "Los Angeles Rams" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Quinn Porter" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2002 if Player == "Raheem Brock" & Team == "Seattle Seahawks" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Ramon Humber" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Reggie Wells" & Team == "Carolina Panthers" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Richard Medlin" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Richie Incognito" & Team == "Las Vegas Raiders" & Season == 2019
quietly replace RookieSeason = 2010 if Player == "Rico Murray" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Rob Bruggeman" & Team == "Atlanta Falcons" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Rob Myers" & Team == "Washington Commanders" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Robert Hughes" & Team == "Arizona Cardinals" & Season == 2013
quietly replace RookieSeason = 2008 if Player == "Robert James" & Team == "Kansas City Chiefs" & Season == 2013
quietly replace RookieSeason = 2010 if Player == "Robert Malone" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Roderick Hood" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Ron Parker" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2013 if Player == "Rontez Miles" & Team == "New York Jets" & Season == 2018
quietly replace RookieSeason = 2009 if Player == "Rudy Carpenter" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Ryan Cook" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2001 if Player == "Ryan Diem" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Ryan Donahue" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Ryan Pontbriand" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Ryan Taylor" & Team == "Cleveland Browns" & Season == 2014
quietly replace RookieSeason = 2008 if Player == "Ryan Torain" & Team == "Washington Commanders" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Sabby Piscitelli" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Sam Young" & Team == "Jacksonville Jaguars" & Season == 2013
quietly replace RookieSeason = 2000 if Player == "Sammy Morris" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Samson Satele" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2020 if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2021
quietly replace RookieSeason = 2020 if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2022
quietly replace RookieSeason = 2020 if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2023
quietly replace RookieSeason = 2006 if Player == "Scott Paxson" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2012 if Player == "Scott Wedige" & Team == "Arizona Cardinals" & Season == 2012
quietly replace RookieSeason = 2009 if Player == "Seth Olsen" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Shane Vereen" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2001 if Player == "Shaun Rogers" & Team == "New Orleans Saints" & Season == 2011
quietly replace RookieSeason = 2000 if Player == "Shayne Graham" & Team == "Baltimore Ravens" & Season == 2011
quietly replace RookieSeason = 2000 if Player == "Shayne Graham" & Team == "Miami Dolphins" & Season == 2011
quietly replace RookieSeason = 2003 if Player == "Stephen Cooper" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Stephen Franklin" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Stephen Spach" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace RookieSeason = 2005 if Player == "Stephen Spach" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Sterling Moore" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Sterling Moore" & Team == "New England Patriots" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Steve Maneri" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2013 if Player == "Steve Maneri" & Team == "New England Patriots" & Season == 2014
quietly replace RookieSeason = 2008 if Player == "Steve Slaton" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Steven Hauschka" & Team == "Seattle Seahawks" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Stevie Brown" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "T.J. Heath" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2001 if Player == "T.J. Houshmandzadeh" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Tashard Choice" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Tashard Choice" & Team == "Washington Commanders" & Season == 2011
quietly replace RookieSeason = 2012 if Player == "Terrance Ganaway" & Team == "Los Angeles Rams" & Season == 2012
quietly replace RookieSeason = 2010 if Player == "Terrence Cody" & Team == "Baltimore Ravens" & Season == 2014
quietly replace RookieSeason = 2010 if Player == "Thomas Austin" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Thomas Clayton" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2010 if Player == "Thomas Welch" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Tim Atchison" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Tim Crowder" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2006 if Player == "Tim Dobbins" & Team == "Houston Texans" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Tiquan Underwood" & Team == "New England Patriots" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Titus Brown" & Team == "Cleveland Browns" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Tony Carter" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2009 if Player == "Tony Fiammetta" & Team == "Dallas Cowboys" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Tony Hills" & Team == "Denver Broncos" & Season == 2011
quietly replace RookieSeason = 2011 if Player == "Tony Wragge" & Team == "Los Angeles Rams" & Season == 2011
quietly replace RookieSeason = 2005 if Player == "Trai Essex" & Team == "Indianapolis Colts" & Season == 2012
quietly replace RookieSeason = 2012 if Player == "Travian Robertson" & Team == "Seattle Seahawks" & Season == 2014
quietly replace RookieSeason = 2009 if Player == "Troy Nolan" & Team == "Miami Dolphins" & Season == 2012
quietly replace RookieSeason = 2007 if Player == "Trumaine McBride" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace RookieSeason = 2014 if Player == "Tyler Ott" & Team == "Seattle Seahawks" & Season == 2016
quietly replace RookieSeason = 2007 if Player == "Tyler Palko" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Tyler Polumbus" & Team == "Washington Commanders" & Season == 2011
quietly replace RookieSeason = 2016 if Player == "Tyvis Powell" & Team == "Seattle Seahawks" & Season == 2016
quietly replace RookieSeason = 2011 if Player == "Vince Agnew" & Team == "Dallas Cowboys" & Season == 2012
quietly replace RookieSeason = 2005 if Player == "Vincent Fuller" & Team == "Detroit Lions" & Season == 2011
quietly replace RookieSeason = 2012 if Player == "Winston Guy" & Team == "Indianapolis Colts" & Season == 2014
quietly replace RookieSeason = 2011 if Player == "Winston Venable" & Team == "Chicago Bears" & Season == 2011
quietly replace RookieSeason = 2008 if Player == "Xavier Adibi" & Team == "Minnesota Vikings" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Zac Diles" & Team == "Indianapolis Colts" & Season == 2011
quietly replace RookieSeason = 2007 if Player == "Zac Diles" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace RookieSeason = 2014 if Player == "Zach Kerr" & Team == "Cincinnati Bengals" & Season == 2021
quietly replace RookieSeason = 2011 if Player == "Zack Williams" & Team == "Carolina Panthers" & Season == 2012

* Get Rookie for players missing from Cap dataset (see "2 Season Corrections.xlsx")
quietly replace Rookie = 1 if Player == "A.J. Edds" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 1 if Player == "Aaron Brown" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 1 if Player == "Adrian Arrington" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Adrian Awasom" & Team == "Minnesota Vikings" & Season == 2011
quietly replace Rookie = 1 if Player == "Akwasi Owusu-Ansah" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 1 if Player == "Al Afalava" & Team == "Tennessee Titans" & Season == 2012
quietly replace Rookie = 0 if Player == "Al Harris" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Albert Haynesworth" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Amon Gordon" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 0 if Player == "Andre Carter" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Andre Fluellen" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 0 if Player == "Andrew Gardner" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 1 if Player == "Andrew Hawkins" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 0 if Player == "Anthony Herrera" & Team == "Minnesota Vikings" & Season == 2011
quietly replace Rookie = 0 if Player == "Anthony Hill" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Anthony Madison" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 0 if Player == "Antonio Dixon" & Team == "Indianapolis Colts" & Season == 2012
quietly replace Rookie = 1 if Player == "Antwon Blake" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace Rookie = 0 if Player == "Aqib Talib" & Team == "Tampa Bay Buccaneers" & Season == 2012
quietly replace Rookie = 1 if Player == "Armando Allen" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 0 if Player == "Armando Allen" & Team == "Chicago Bears" & Season == 2012
quietly replace Rookie = 1 if Player == "Armon Binns" & Team == "Cincinnati Bengals" & Season == 2012
quietly replace Rookie = 0 if Player == "Aubrayo Franklin" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 1 if Player == "Austin Pettis" & Team == "Los Angeles Chargers" & Season == 2014
quietly replace Rookie = 0 if Player == "Auston English" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Ben Leber" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Benny Sapp" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 0 if Player == "Benny Sapp" & Team == "Minnesota Vikings" & Season == 2011
quietly replace Rookie = 0 if Player == "Brad Maynard" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Brandon Burton" & Team == "Cincinnati Bengals" & Season == 2013
quietly replace Rookie = 0 if Player == "Brandon Hughes" & Team == "Philadelphia Eagles" & Season == 2013
quietly replace Rookie = 1 if Player == "Brandon Rusnak" & Team == "Jacksonville Jaguars" & Season == 2019
quietly replace Rookie = 0 if Player == "Brandon Stokley" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 1 if Player == "Brandon Tate" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 1 if Player == "Brandon Zylstra" & Team == "Minnesota Vikings" & Season == 2018
quietly replace Rookie = 0 if Player == "Braylon Edwards" & Team == "New York Jets" & Season == 2012
quietly replace Rookie = 0 if Player == "Brian De La Puente" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Brian Iwuh" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 0 if Player == "Brian Jackson" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Brian Leonard" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 0 if Player == "Brian Leonard" & Team == "Cincinnati Bengals" & Season == 2012
quietly replace Rookie = 0 if Player == "Brian Leonard" & Team == "New Orleans Saints" & Season == 2014
quietly replace Rookie = 0 if Player == "Brian Leonard" & Team == "Tampa Bay Buccaneers" & Season == 2013
quietly replace Rookie = 1 if Player == "Brian Robiskie" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Brian Sanford" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Brian Schaefering" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Brian Williams" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 1 if Player == "Bruce Davis" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "Bruce Irvin" & Team == "Miami Dolphins" & Season == 2023
quietly replace Rookie = 0 if Player == "Bryan Kehl" & Team == "Washington Commanders" & Season == 2012
quietly replace Rookie = 1 if Player == "Bryan McCann" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Bryant Johnson" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 0 if Player == "Byron Westbrook" & Team == "Washington Commanders" & Season == 2011
quietly replace Rookie = 0 if Player == "C.J. Wallace" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace Rookie = 0 if Player == "Cade York" & Team == "Washington Commanders" & Season == 2024
quietly replace Rookie = 0 if Player == "Caleb Hanie" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 1 if Player == "Carl Ihenacho" & Team == "Las Vegas Raiders" & Season == 2012
quietly replace Rookie = 0 if Player == "Casey Wiegmann" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 1 if Player == "Chad Spann" & Team == "Pittsburgh Steelers" & Season == 2011
quietly replace Rookie = 0 if Player == "Chandler Brewer" & Team == "Tennessee Titans" & Season == 2024
quietly replace Rookie = 0 if Player == "Chauncey Davis" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 1 if Player == "Chris Harper" & Team == "Green Bay Packers" & Season == 2013
quietly replace Rookie = 0 if Player == "Chris Harris" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 1 if Player == "Chris Hawkins" & Team == "Tennessee Titans" & Season == 2011
quietly replace Rookie = 0 if Player == "Chris Massey" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 1 if Player == "Chris Ogbonnaya" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Chris Ogbonnaya" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 1 if Player == "Christian Yount" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Christian Yount" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Clifton Geathers" & Team == "Indianapolis Colts" & Season == 2012
quietly replace Rookie = 1 if Player == "Colin Baxter" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace Rookie = 1 if Player == "Colin Baxter" & Team == "New York Jets" & Season == 2011
quietly replace Rookie = 0 if Player == "Colin Cloherty" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace Rookie = 1 if Player == "Colin Cochart" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 1 if Player == "Collin Franklin" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 1 if Player == "Corbin Bryant" & Team == "Pittsburgh Steelers" & Season == 2011
quietly replace Rookie = 0 if Player == "Courtney Roby" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Crezdon Butler" & Team == "Arizona Cardinals" & Season == 2012
quietly replace Rookie = 1 if Player == "Crezdon Butler" & Team == "Washington Commanders" & Season == 2012
quietly replace Rookie = 0 if Player == "Damian Williams" & Team == "Los Angeles Rams" & Season == 2014
quietly replace Rookie = 0 if Player == "Damion Square" & Team == "Cincinnati Bengals" & Season == 2021
quietly replace Rookie = 0 if Player == "Dan Chisena" & Team == "Baltimore Ravens" & Season == 2023
quietly replace Rookie = 0 if Player == "Dan Gronkowski" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Dan Skuta" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 1 if Player == "Dane Sanzenbacher" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 1 if Player == "Daniel Baldridge" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace Rookie = 0 if Player == "Daniel Fells" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 0 if Player == "Daniel Muir" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 1 if Player == "Daniel Te'o-Nesheim" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Dante Rosario" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 1 if Player == "Darren Evans" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 1 if Player == "Darryl Sharpton" & Team == "Houston Texans" & Season == 2012
quietly replace Rookie = 0 if Player == "Dave Rayner" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "David Nixon" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "David Vobora" & Team == "Seattle Seahawks" & Season == 2011
quietly replace Rookie = 0 if Player == "DeMario Pressley" & Team == "Carolina Panthers" & Season == 2011
quietly replace Rookie = 0 if Player == "Dennis Roland" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 0 if Player == "Deon Grant" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 0 if Player == "Derek Hagan" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "Derrick Dockery" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Derrick Martin" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 1 if Player == "Desmond Bryant" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "Devin Hester" & Team == "Seattle Seahawks" & Season == 2016
quietly replace Rookie = 0 if Player == "Dimitri Patterson" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 1 if Player == "Dominique Barber" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 0 if Player == "Donald Strickland" & Team == "New York Jets" & Season == 2011
quietly replace Rookie = 1 if Player == "Donnie Avery" & Team == "Tennessee Titans" & Season == 2011
quietly replace Rookie = 0 if Player == "Drew Miller" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 1 if Player == "Dwayne Hendricks" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 0 if Player == "Earnest Graham" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 1 if Player == "Eddie Jones" & Team == "New York Jets" & Season == 2011
quietly replace Rookie = 0 if Player == "Eddie Williams" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Eddie Williams" & Team == "Seattle Seahawks" & Season == 2011
quietly replace Rookie = 0 if Player == "Elbert Mack" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Eldra Buckley" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 1 if Player == "Emanuel Cook" & Team == "New York Jets" & Season == 2011
quietly replace Rookie = 1 if Player == "Eric Foster" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Eric Martin" & Team == "Cleveland Browns" & Season == 2014
quietly replace Rookie = 0 if Player == "Eric Moore" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Ernie Sims" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 1 if Player == "Ethan Fernea" & Team == "Indianapolis Colts" & Season == 2022
quietly replace Rookie = 0 if Player == "Evan Moore" & Team == "Seattle Seahawks" & Season == 2012
quietly replace Rookie = 1 if Player == "Fendi Onobun" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Frank Walker" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Fred Robbins" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Gary Guyton" & Team == "Los Angeles Chargers" & Season == 2012
quietly replace Rookie = 0 if Player == "Geno Grissom" & Team == "Indianapolis Colts" & Season == 2018
quietly replace Rookie = 1 if Player == "Geno Hayes" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 1 if Player == "George Johnson" & Team == "Tampa Bay Buccaneers" & Season == 2012
quietly replace Rookie = 1 if Player == "George Selvie" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Gerald Alexander" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 0 if Player == "Gerard Warren" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Greg Lloyd" & Team == "Buffalo Bills" & Season == 2012
quietly replace Rookie = 1 if Player == "Hebron Fangupo" & Team == "Seattle Seahawks" & Season == 2012
quietly replace Rookie = 0 if Player == "Herbert Taylor" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace Rookie = 0 if Player == "Howard Green" & Team == "Green Bay Packers" & Season == 2011
quietly replace Rookie = 0 if Player == "Ikechuku Ndukwe" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace Rookie = 0 if Player == "Isaiah Ekejiuba" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 0 if Player == "Isaiah Pead" & Team == "Miami Dolphins" & Season == 2016
quietly replace Rookie = 1 if Player == "Jacob Byrne" & Team == "Houston Texans" & Season == 2013
quietly replace Rookie = 0 if Player == "Jacques Reeves" & Team == "Kansas City Chiefs" & Season == 2012
quietly replace Rookie = 0 if Player == "Jamaal Westerman" & Team == "Arizona Cardinals" & Season == 2012
quietly replace Rookie = 1 if Player == "Jamar Newsome" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "James Butler" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "James Farrior" & Team == "Pittsburgh Steelers" & Season == 2011
quietly replace Rookie = 0 if Player == "James-Michael Johnson" & Team == "Tampa Bay Buccaneers" & Season == 2015
quietly replace Rookie = 1 if Player == "Jammie Kirlew" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Jarrad Page" & Team == "Minnesota Vikings" & Season == 2011
quietly replace Rookie = 1 if Player == "Jarriel King" & Team == "Seattle Seahawks" & Season == 2011
quietly replace Rookie = 0 if Player == "Jason Babin" & Team == "Arizona Cardinals" & Season == 2015
quietly replace Rookie = 0 if Player == "Jason Hill" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Jason Hill" & Team == "New York Jets" & Season == 2012
quietly replace Rookie = 0 if Player == "Jason Williams" & Team == "Philadelphia Eagles" & Season == 2012
quietly replace Rookie = 0 if Player == "Jayme Mitchell" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Jeff Charleston" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Jeremiah Johnson" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 0 if Player == "Jeremy Bridges" & Team == "Carolina Panthers" & Season == 2012
quietly replace Rookie = 0 if Player == "Jeremy Kerley" & Team == "New York Jets" & Season == 2017
quietly replace Rookie = 0 if Player == "Jeremy Mincey" & Team == "Denver Broncos" & Season == 2013
quietly replace Rookie = 0 if Player == "Jerheme Urban" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 0 if Player == "Jermey Parnell" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 1 if Player == "Jerome Murphy" & Team == "Detroit Lions" & Season == 2012
quietly replace Rookie = 0 if Player == "Jerome Murphy" & Team == "New Orleans Saints" & Season == 2012
quietly replace Rookie = 1 if Player == "Jerry Brown" & Team == "Indianapolis Colts" & Season == 2012
quietly replace Rookie = 1 if Player == "Jerry Franklin" & Team == "Chicago Bears" & Season == 2012
quietly replace Rookie = 0 if Player == "Jesse Holley" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Jim Dray" & Team == "Buffalo Bills" & Season == 2016
quietly replace Rookie = 0 if Player == "JoLonn Dunbar" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Joe Fortunato" & Team == "Green Bay Packers" & Season == 2021
quietly replace Rookie = 0 if Player == "Joe Haeg" & Team == "Pittsburgh Steelers" & Season == 2021
quietly replace Rookie = 1 if Player == "Joe Mays" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 0 if Player == "Joe Porter" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "John Gilmore" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "John Greco" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Jon McGraw" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 1 if Player == "Jonathan Nelson" & Team == "Carolina Panthers" & Season == 2011
quietly replace Rookie = 0 if Player == "Jonathan Wade" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 1 if Player == "Jonathan Wilhite" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 0 if Player == "Jordan Babineaux" & Team == "Tennessee Titans" & Season == 2011
quietly replace Rookie = 1 if Player == "Jordan Lucas" & Team == "Miami Dolphins" & Season == 2016
quietly replace Rookie = 1 if Player == "Jordan Shipley" & Team == "Tampa Bay Buccaneers" & Season == 2012
quietly replace Rookie = 0 if Player == "Josh Gordy" & Team == "Indianapolis Colts" & Season == 2012
quietly replace Rookie = 0 if Player == "Josh McCown" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 0 if Player == "Josh Victorian" & Team == "Pittsburgh Steelers" & Season == 2012
quietly replace Rookie = 0 if Player == "Jovan Haye" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 0 if Player == "Jovan Haye" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Julian Posey" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 1 if Player == "Justice Cunningham" & Team == "Los Angeles Rams" & Season == 2013
quietly replace Rookie = 0 if Player == "Justin Bannan" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Justin Houston" & Team == "Miami Dolphins" & Season == 2023
quietly replace Rookie = 0 if Player == "Justin Peelle" & Team == "San Francisco 49ers" & Season == 2011
quietly replace Rookie = 0 if Player == "Justin Snow" & Team == "Washington Commanders" & Season == 2012
quietly replace Rookie = 1 if Player == "Justin Trattou" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 1 if Player == "Justin Tryon" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Justin Tryon" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 0 if Player == "Kareem McKenzie" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 0 if Player == "Keary Colbert" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 0 if Player == "Kellen Clemens" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Kellen Heard" & Team == "Los Angeles Rams" & Season == 2012
quietly replace Rookie = 0 if Player == "Kelly Gregg" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 1 if Player == "Kelvin Benjamin" & Team == "Buffalo Bills" & Season == 2017
quietly replace Rookie = 0 if Player == "Ken Amato" & Team == "Tennessee Titans" & Season == 2011
quietly replace Rookie = 0 if Player == "Kenny Onatolu" & Team == "Minnesota Vikings" & Season == 2011
quietly replace Rookie = 1 if Player == "Kerwynn Williams" & Team == "Los Angeles Chargers" & Season == 2013
quietly replace Rookie = 1 if Player == "Kevin Barnes" & Team == "Detroit Lions" & Season == 2012
quietly replace Rookie = 0 if Player == "Kevin Bentley" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Kevin Bentley" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 1 if Player == "Kevin Brock" & Team == "Cincinnati Bengals" & Season == 2013
quietly replace Rookie = 0 if Player == "Keyunta Dawson" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 1 if Player == "Kiante Tripp" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Kregg Lumpkin" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Kyle DeVan" & Team == "Philadelphia Eagles" & Season == 2011
quietly replace Rookie = 1 if Player == "Kyle McCarthy" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 0 if Player == "Kyle Miller" & Team == "Indianapolis Colts" & Season == 2012
quietly replace Rookie = 1 if Player == "Kyle Nelson" & Team == "Los Angeles Chargers" & Season == 2012
quietly replace Rookie = 0 if Player == "Kyle Nelson" & Team == "San Francisco 49ers" & Season == 2019
quietly replace Rookie = 0 if Player == "Kyle Orton" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 0 if Player == "Kyle Wilber" & Team == "Las Vegas Raiders" & Season == 2021
quietly replace Rookie = 0 if Player == "Laurent Robinson" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 1 if Player == "Lawrence Cager" & Team == "New York Jets" & Season == 2022
quietly replace Rookie = 0 if Player == "Lawrence Vickers" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 1 if Player == "LeQuan Lewis" & Team == "Dallas Cowboys" & Season == 2012
quietly replace Rookie = 0 if Player == "Legedu Naanee" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 0 if Player == "Leigh Bodden" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Leigh Torrence" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Leonard Pope" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 0 if Player == "Leonard Pope" & Team == "Pittsburgh Steelers" & Season == 2012
quietly replace Rookie = 0 if Player == "Lito Sheppard" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "Lousaka Polite" & Team == "Atlanta Falcons" & Season == 2012
quietly replace Rookie = 0 if Player == "Lousaka Polite" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 1 if Player == "Mana Silva" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Mana Silva" & Team == "Dallas Cowboys" & Season == 2012
quietly replace Rookie = 1 if Player == "Manase Tonga" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "MarQueis Gray" & Team == "Miami Dolphins" & Season == 2016
quietly replace Rookie = 0 if Player == "Marc Colombo" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 0 if Player == "Mardy Gilyard" & Team == "Philadelphia Eagles" & Season == 2012
quietly replace Rookie = 0 if Player == "Mario Addison" & Team == "Carolina Panthers" & Season == 2012
quietly replace Rookie = 1 if Player == "Mark Asper" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace Rookie = 0 if Player == "Mark Brunell" & Team == "New York Jets" & Season == 2011
quietly replace Rookie = 0 if Player == "Mark LeVoir" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Marquice Cole" & Team == "New York Jets" & Season == 2011
quietly replace Rookie = 0 if Player == "Marshay Green" & Team == "Indianapolis Colts" & Season == 2012
quietly replace Rookie = 0 if Player == "Martin Rucker" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Martin Rucker" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 1 if Player == "Mason Brodine" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "Matt Katula" & Team == "Minnesota Vikings" & Season == 2011
quietly replace Rookie = 0 if Player == "Matt Turk" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 0 if Player == "Matt Turk" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Michael Badgley" & Team == "Tennessee Titans" & Season == 2021
quietly replace Rookie = 0 if Player == "Michael Coe" & Team == "Dallas Cowboys" & Season == 2012
quietly replace Rookie = 0 if Player == "Michael Coe" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 0 if Player == "Michael Coe" & Team == "New York Giants" & Season == 2011
quietly replace Rookie = 0 if Player == "Michael Coe" & Team == "New York Giants" & Season == 2012
quietly replace Rookie = 1 if Player == "Michael Higgins" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 1 if Player == "Michael Higgins" & Team == "New Orleans Saints" & Season == 2012
quietly replace Rookie = 1 if Player == "Michael Lockley" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Micheal Spurlock" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace Rookie = 0 if Player == "Micheal Spurlock" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 1 if Player == "Mike McNeill" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 1 if Player == "Mike Pennel" & Team == "Green Bay Packers" & Season == 2016
quietly replace Rookie = 0 if Player == "Mike Rivera" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 0 if Player == "Mike Sims-Walker" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Mike Sims-Walker" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Mike Tepper" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Mike Wright" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Mitch King" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Mitch Petrus" & Team == "New England Patriots" & Season == 2012
quietly replace Rookie = 0 if Player == "Morgan Trent" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Nate Collins" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Nate Kaeding" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 0 if Player == "Nate Livings" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Nate Ness" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Nate Triplett" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Nathan Jones" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Nicholas Morrow" & Team == "Philadelphia Eagles" & Season == 2024
quietly replace Rookie = 0 if Player == "Nick Harris" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Nick Hayden" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 0 if Player == "Nick Miller" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Nick Novak" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace Rookie = 0 if Player == "Nick Reed" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 1 if Player == "Nick Reed" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Nick Rose" & Team == "Los Angeles Chargers" & Season == 2018
quietly replace Rookie = 0 if Player == "O.J. Atogwe" & Team == "Washington Commanders" & Season == 2011
quietly replace Rookie = 0 if Player == "Olin Kreutz" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Oniel Cousins" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 0 if Player == "Pat McQuistan" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Patrick Trahan" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 0 if Player == "Paul Oliver" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace Rookie = 0 if Player == "Phillip Adams" & Team == "Seattle Seahawks" & Season == 2011
quietly replace Rookie = 1 if Player == "Phillip Supernaw" & Team == "Kansas City Chiefs" & Season == 2014
quietly replace Rookie = 0 if Player == "Quan Cosby" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 0 if Player == "Quinn Ojinnaka" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Quinn Ojinnaka" & Team == "Los Angeles Rams" & Season == 2012
quietly replace Rookie = 0 if Player == "Quinn Porter" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Raheem Brock" & Team == "Seattle Seahawks" & Season == 2011
quietly replace Rookie = 0 if Player == "Ramon Humber" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Reggie Wells" & Team == "Carolina Panthers" & Season == 2011
quietly replace Rookie = 1 if Player == "Richard Medlin" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 0 if Player == "Richie Incognito" & Team == "Las Vegas Raiders" & Season == 2019
quietly replace Rookie = 1 if Player == "Rico Murray" & Team == "Cincinnati Bengals" & Season == 2011
quietly replace Rookie = 0 if Player == "Rob Bruggeman" & Team == "Atlanta Falcons" & Season == 2011
quietly replace Rookie = 0 if Player == "Rob Myers" & Team == "Washington Commanders" & Season == 2011
quietly replace Rookie = 0 if Player == "Robert Hughes" & Team == "Arizona Cardinals" & Season == 2013
quietly replace Rookie = 0 if Player == "Robert James" & Team == "Kansas City Chiefs" & Season == 2013
quietly replace Rookie = 0 if Player == "Robert Malone" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 0 if Player == "Roderick Hood" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 1 if Player == "Ron Parker" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "Rontez Miles" & Team == "New York Jets" & Season == 2018
quietly replace Rookie = 0 if Player == "Rudy Carpenter" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Ryan Cook" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 0 if Player == "Ryan Diem" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 1 if Player == "Ryan Donahue" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 0 if Player == "Ryan Pontbriand" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Ryan Taylor" & Team == "Cleveland Browns" & Season == 2014
quietly replace Rookie = 0 if Player == "Ryan Torain" & Team == "Washington Commanders" & Season == 2011
quietly replace Rookie = 0 if Player == "Sabby Piscitelli" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 0 if Player == "Sam Young" & Team == "Jacksonville Jaguars" & Season == 2013
quietly replace Rookie = 0 if Player == "Sammy Morris" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Samson Satele" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 0 if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2021
quietly replace Rookie = 0 if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2022
quietly replace Rookie = 0 if Player == "Scoota Harris" & Team == "Washington Commanders" & Season == 2023
quietly replace Rookie = 0 if Player == "Scott Paxson" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Scott Wedige" & Team == "Arizona Cardinals" & Season == 2012
quietly replace Rookie = 0 if Player == "Seth Olsen" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 1 if Player == "Shane Vereen" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Shaun Rogers" & Team == "New Orleans Saints" & Season == 2011
quietly replace Rookie = 0 if Player == "Shayne Graham" & Team == "Baltimore Ravens" & Season == 2011
quietly replace Rookie = 0 if Player == "Shayne Graham" & Team == "Miami Dolphins" & Season == 2011
quietly replace Rookie = 0 if Player == "Stephen Cooper" & Team == "Los Angeles Chargers" & Season == 2011
quietly replace Rookie = 1 if Player == "Stephen Franklin" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Stephen Spach" & Team == "Jacksonville Jaguars" & Season == 2012
quietly replace Rookie = 0 if Player == "Stephen Spach" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 1 if Player == "Sterling Moore" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Sterling Moore" & Team == "New England Patriots" & Season == 2012
quietly replace Rookie = 0 if Player == "Steve Maneri" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 0 if Player == "Steve Maneri" & Team == "New England Patriots" & Season == 2014
quietly replace Rookie = 1 if Player == "Steve Slaton" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 0 if Player == "Steven Hauschka" & Team == "Seattle Seahawks" & Season == 2011
quietly replace Rookie = 0 if Player == "Stevie Brown" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 1 if Player == "T.J. Heath" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "T.J. Houshmandzadeh" & Team == "Las Vegas Raiders" & Season == 2011
quietly replace Rookie = 1 if Player == "Tashard Choice" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 1 if Player == "Tashard Choice" & Team == "Washington Commanders" & Season == 2011
quietly replace Rookie = 1 if Player == "Terrance Ganaway" & Team == "Los Angeles Rams" & Season == 2012
quietly replace Rookie = 0 if Player == "Terrence Cody" & Team == "Baltimore Ravens" & Season == 2014
quietly replace Rookie = 0 if Player == "Thomas Austin" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 0 if Player == "Thomas Clayton" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Thomas Welch" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 1 if Player == "Tim Atchison" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Tim Crowder" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Tim Dobbins" & Team == "Houston Texans" & Season == 2011
quietly replace Rookie = 0 if Player == "Tiquan Underwood" & Team == "New England Patriots" & Season == 2011
quietly replace Rookie = 0 if Player == "Titus Brown" & Team == "Cleveland Browns" & Season == 2011
quietly replace Rookie = 1 if Player == "Tony Carter" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 1 if Player == "Tony Fiammetta" & Team == "Dallas Cowboys" & Season == 2011
quietly replace Rookie = 0 if Player == "Tony Hills" & Team == "Denver Broncos" & Season == 2011
quietly replace Rookie = 1 if Player == "Tony Wragge" & Team == "Los Angeles Rams" & Season == 2011
quietly replace Rookie = 0 if Player == "Trai Essex" & Team == "Indianapolis Colts" & Season == 2012
quietly replace Rookie = 0 if Player == "Travian Robertson" & Team == "Seattle Seahawks" & Season == 2014
quietly replace Rookie = 1 if Player == "Troy Nolan" & Team == "Miami Dolphins" & Season == 2012
quietly replace Rookie = 0 if Player == "Trumaine McBride" & Team == "Jacksonville Jaguars" & Season == 2011
quietly replace Rookie = 0 if Player == "Tyler Ott" & Team == "Seattle Seahawks" & Season == 2016
quietly replace Rookie = 0 if Player == "Tyler Palko" & Team == "Kansas City Chiefs" & Season == 2011
quietly replace Rookie = 0 if Player == "Tyler Polumbus" & Team == "Washington Commanders" & Season == 2011
quietly replace Rookie = 1 if Player == "Tyvis Powell" & Team == "Seattle Seahawks" & Season == 2016
quietly replace Rookie = 0 if Player == "Vince Agnew" & Team == "Dallas Cowboys" & Season == 2012
quietly replace Rookie = 0 if Player == "Vincent Fuller" & Team == "Detroit Lions" & Season == 2011
quietly replace Rookie = 0 if Player == "Winston Guy" & Team == "Indianapolis Colts" & Season == 2014
quietly replace Rookie = 1 if Player == "Winston Venable" & Team == "Chicago Bears" & Season == 2011
quietly replace Rookie = 1 if Player == "Xavier Adibi" & Team == "Minnesota Vikings" & Season == 2011
quietly replace Rookie = 0 if Player == "Zac Diles" & Team == "Indianapolis Colts" & Season == 2011
quietly replace Rookie = 0 if Player == "Zac Diles" & Team == "Tampa Bay Buccaneers" & Season == 2011
quietly replace Rookie = 0 if Player == "Zach Kerr" & Team == "Cincinnati Bengals" & Season == 2021
quietly replace Rookie = 1 if Player == "Zack Williams" & Team == "Carolina Panthers" & Season == 2012

sort _merge Team Season Status Player
quietly recol, full
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data 9 Season AV Cap.dta", replace