clear all
use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 1 CapHit.dta", replace
* Drop observations where Player is blank
drop if Player == ""
* Identify players with multiple contracts
gen Index = _n
sort Season Team Player Position Index
gen ContractNum = 1
replace ContractNum = ContractNum[_n-1]+1 if Season[_n] == Season[_n-1] & Team[_n] == Team[_n-1] & Player[_n] == Player[_n-1] & Position[_n] == Position[_n-1]
sort Index
* List duplicates by Season Team Player Position, copy into Excel
duplicates tag Season Team Player Position, generate(DupTag)
preserve
gsort Season Team Player Position -CapHit Index
list Season Team Player Position CapHit ContractNum if DupTag>0
restore
* Drop duplicates by Season Team Player Position CapHit
duplicates drop Season Team Player Position CapHit, force
* Insert players who don't show up in CapHit data (see Excel)
insobs 2, before(1)
replace Season = 2011 if _n==1
replace Team = "DAL" if _n==1
replace Player = "Clifton Geathers" if _n==1
replace Position = "DE" if _n==1
replace CapHit = 0 if _n==1
replace ContractNum = 2 if _n==1
replace Season = 2021 if _n==2
replace Team = "DAL" if _n==2
replace Player = "Darian Thompson" if _n==2
replace Position = "FS" if _n==2
replace CapHit = 0 if _n==2
replace ContractNum = 2 if _n==2
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 4 CapHit Clean.dta", replace

use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 2 ContractAverage.dta", replace
* Drop observations where Player is blank
drop if Player == ""
gen Index = _n
* List duplicates by Season Team Player Position, copy into Excel
duplicates tag Season Team Player Position, generate(DupTag)
preserve
gsort Season Team Player Position -ContractAverage Index
list Season Team Player Position ContractAverage if DupTag>0
restore
* Drop duplicates by Season Team Player Position ContractAverage who are also duplicates by CapHit
duplicates drop Season Team Player Position ContractAverage if Player == "Prince Emili" | Player == "Michael Tutsie" | Player == "Tre'Mon Morris-Brash", force
gen ContractNum = 1
quietly replace ContractNum = 3 if Season == 2012 & Team == "PIT" & Player == "Alameda Ta'amu" & Position == "DT" & ContractAverage == 34200
quietly replace ContractNum = 2 if Season == 2011 & Team == "BAL" & Player == "Chavis Williams" & Position == "LB" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "CHI" & Player == "Max Komar" & Position == "WR" & ContractAverage == 490000
quietly replace ContractNum = 2 if Season == 2011 & Team == "CIN" & Player == "Armon Binns" & Position == "WR" & ContractAverage == 468333
quietly replace ContractNum = 2 if Season == 2011 & Team == "CIN" & Player == "Brandon Ghee" & Position == "CB" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "CIN" & Player == "Leon Hall" & Position == "CB" & ContractAverage == 2720000
quietly replace ContractNum = 2 if Season == 2011 & Team == "DAL" & Player == "Clifton Geathers" & Position == "DE" & ContractAverage == 473555
quietly replace ContractNum = 2 if Season == 2011 & Team == "IND" & Player == "Ricardo Mathews" & Position == "DT" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "JAX" & Player == "Colin Cloherty" & Position == "TE" & ContractAverage == 420000
quietly replace ContractNum = 2 if Season == 2011 & Team == "MIA" & Player == "Pat Devlin" & Position == "QB" & ContractAverage == 467000
quietly replace ContractNum = 2 if Season == 2011 & Team == "MIN" & Player == "Allen Reisner" & Position == "TE" & ContractAverage == 193800
quietly replace ContractNum = 2 if Season == 2011 & Team == "MIN" & Player == "Stephen Burton" & Position == "WR" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "NE" & Player == "Alex Silvestro" & Position == "TE/DE" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "NE" & Player == "Nick McDonald" & Position == "C" & ContractAverage == 540000
quietly replace ContractNum = 2 if Season == 2011 & Team == "NE" & Player == "Ross Ventrone" & Position == "SS/CB" & ContractAverage == 149940
quietly replace ContractNum = 2 if Season == 2011 & Team == "NYG" & Player == "Martin Parker" & Position == "DT" & ContractAverage == 510000
quietly replace ContractNum = 2 if Season == 2011 & Team == "PHI" & Player == "Cedric Thornton" & Position == "DT" & ContractAverage == 467500
quietly replace ContractNum = 2 if Season == 2011 & Team == "SD" & Player == "Bront Bird" & Position == "ILB/LB" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "SD" & Player == "Bryan Walters" & Position == "WR" & ContractAverage == 420000
quietly replace ContractNum = 2 if Season == 2011 & Team == "SD" & Player == "Steve Schilling" & Position == "G" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "SEA" & Player == "Chris Maragos" & Position == "FS/S" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2011 & Team == "SEA" & Player == "Paul Fanaika" & Position == "G" & ContractAverage == 51300
quietly replace ContractNum = 2 if Season == 2011 & Team == "STL" & Player == "Kevin Hughes" & Position == "T" & ContractAverage == 5000
quietly replace ContractNum = 2 if Season == 2011 & Team == "WAS" & Player == "Will Montgomery" & Position == "C" & ContractAverage == 640000
quietly replace ContractNum = 2 if Season == 2012 & Team == "BAL" & Player == "Bobby Rainey" & Position == "RB" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2012 & Team == "CIN" & Player == "Dan Herron" & Position == "RB" & ContractAverage == 480000
quietly replace ContractNum = 2 if Season == 2012 & Team == "DAL" & Player == "Barry Church" & Position == "SS/S" & ContractAverage == 409000
quietly replace ContractNum = 2 if Season == 2012 & Team == "DET" & Player == "Alphonso Smith" & Position == "CB" & ContractAverage == 615000
quietly replace ContractNum = 2 if Season == 2012 & Team == "JAX" & Player == "Keith Toston" & Position == "RB" & ContractAverage == 465000 & Player[_n-1] == "Keith Toston"
quietly replace ContractNum = 2 if Season == 2012 & Team == "MIA" & Player == "Chandler Burden" & Position == "C" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2012 & Team == "MIN" & Player == "Allen Reisner" & Position == "TE" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2012 & Team == "NE" & Player == "Donte Stallworth" & Position == "WR" & ContractAverage == 875000
quietly replace ContractNum = 2 if Season == 2012 & Team == "NE" & Player == "Nick McDonald" & Position == "C" & ContractAverage == 64000
quietly replace ContractNum = 2 if Season == 2012 & Team == "PHI" & Player == "Antonio Dixon" & Position == "DT" & ContractAverage == 615000
quietly replace ContractNum = 2 if Season == 2012 & Team == "PHI" & Player == "Emil Igwenagu" & Position == "TE" & ContractAverage == 483667
quietly replace ContractNum = 2 if Season == 2012 & Team == "PIT" & Player == "Alameda Ta'amu" & Position == "DT" & ContractAverage == 435000
quietly replace ContractNum = 2 if Season == 2012 & Team == "SF" & Player == "Michael Wilhoite" & Position == "ILB/LB" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2012 & Team == "SF" & Player == "Tony Jerod-Eddie" & Position == "DE" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2012 & Team == "STL" & Player == "Cory Harkey" & Position == "FB" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2012 & Team == "STL" & Player == "Sammy Brown" & Position == "DE" & ContractAverage == 480000
quietly replace ContractNum = 2 if Season == 2012 & Team == "STL" & Player == "Tim Barnes" & Position == "C" & ContractAverage == 96900
quietly replace ContractNum = 2 if Season == 2012 & Team == "WAS" & Player == "Tom Compton" & Position == "G/T" & ContractAverage == 480000
quietly replace ContractNum = 2 if Season == 2013 & Team == "ARI" & Player == "Brittan Golden" & Position == "WR" & ContractAverage == 18000
quietly replace ContractNum = 2 if Season == 2013 & Team == "ATL" & Player == "Adam Replogle" & Position == "G" & ContractAverage == 495000
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Da'Rick Rogers" & Position == "WR" & ContractAverage == 77824
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Jeris Pendleton" & Position == "DT" & ContractAverage == 18000
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Josh McNary" & Position == "OLB/LB" & ContractAverage == 450000
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Sheldon Price" & Position == "CB" & ContractAverage == 450000
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Xavier Nixon" & Position == "LT/T" & ContractAverage == 450000
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Danny Noble" & Position == "TE" & ContractAverage == 24000
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Drew Nowak" & Position == "C" & ContractAverage == 481667
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Jeremy Ebert" & Position == "WR" & ContractAverage == 450000
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Jordan Miller" & Position == "DT" & ContractAverage == 480000
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Kyle Love" & Position == "DT" & ContractAverage == 630000
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Ricky Stanzi" & Position == "QB" & ContractAverage == 130588
quietly replace ContractNum = 2 if Season == 2013 & Team == "KC" & Player == "Rishaw  Johnson" & Position == "G" & ContractAverage == 18000
quietly replace ContractNum = 2 if Season == 2013 & Team == "KC" & Player == "Rokevious Watkins" & Position == "G" & ContractAverage == 50000
quietly replace ContractNum = 2 if Season == 2013 & Team == "MIA" & Player == "Sam Brenner" & Position == "C" & ContractAverage == 60000
quietly replace ContractNum = 2 if Season == 2013 & Team == "MIN" & Player == "Rodney Smith" & Position == "WR" & ContractAverage == 36000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NE" & Player == "Sealver Siliga" & Position == "DT" & ContractAverage == 30000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NO" & Player == "Ryan Griffin" & Position == "QB" & ContractAverage == 42000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Charles James" & Position == "CB" & ContractAverage == 24000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Eric Herman" & Position == "RT/T" & ContractAverage == 450000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Jon Beason" & Position == "ILB/LB" & ContractAverage == 3250000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Julian Talley" & Position == "WR" & ContractAverage == 495000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Stephen Goodin" & Position == "G" & ContractAverage == 72000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYJ" & Player == "Chris Pantale" & Position == "TE" & ContractAverage == 72000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYJ" & Player == "Saalim Hakim" & Position == "WR" & ContractAverage == 54000
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYJ" & Player == "Troy Davis" & Position == "OLB/LB" & ContractAverage == 24000
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Chance Casey" & Position == "CB" & ContractAverage == 78000
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Lamar Mady" & Position == "G" & ContractAverage == 12000
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Marshall McFadden" & Position == "ILB/LB" & ContractAverage == 78000
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Ricky Lumpkin" & Position == "DT" & ContractAverage == 18000
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Shelton Johnson" & Position == "S" & ContractAverage == 78000
quietly replace ContractNum = 2 if Season == 2013 & Team == "PHI" & Player == "Keelan Johnson" & Position == "SS/S" & ContractAverage == 497922
quietly replace ContractNum = 2 if Season == 2013 & Team == "PHI" & Player == "Matthew Tucker" & Position == "RB" & ContractAverage == 36000
quietly replace ContractNum = 2 if Season == 2013 & Team == "PIT" & Player == "Brian Arnfelt" & Position == "DE" & ContractAverage == 450000
quietly replace ContractNum = 2 if Season == 2013 & Team == "PIT" & Player == "Terence Garvin" & Position == "ILB/LB" & ContractAverage == 102000
quietly replace ContractNum = 2 if Season == 2013 & Team == "SD" & Player == "Jacob Byrne" & Position == "TE" & ContractAverage == 450000
quietly replace ContractNum = 2 if Season == 2013 & Team == "SD" & Player == "Marcus Cromartie" & Position == "CB" & ContractAverage == 496667
quietly replace ContractNum = 2 if Season == 2013 & Team == "SD" & Player == "Thomas Keiser" & Position == "OLB/LB" & ContractAverage == 24000
quietly replace ContractNum = 2 if Season == 2013 & Team == "SEA" & Player == "Ricardo Lockette" & Position == "WR" & ContractAverage == 6000
quietly replace ContractNum = 2 if Season == 2013 & Team == "SF" & Player == "Darryl Morris" & Position == "CB" & ContractAverage == 18000
quietly replace ContractNum = 2 if Season == 2013 & Team == "SF" & Player == "Derek Carrier" & Position == "TE" & ContractAverage == 60000
quietly replace ContractNum = 2 if Season == 2013 & Team == "STL" & Player == "Justin Veltung" & Position == "WR" & ContractAverage == 405000
quietly replace ContractNum = 2 if Season == 2013 & Team == "STL" & Player == "Sammy Brown" & Position == "DE" & ContractAverage == 480000
quietly replace ContractNum = 2 if Season == 2013 & Team == "TB" & Player == "Ka'lial Glaud" & Position == "OLB/LB" & ContractAverage == 54000
quietly replace ContractNum = 2 if Season == 2013 & Team == "TB" & Player == "Matthew Masifilo" & Position == "G" & ContractAverage == 90000
quietly replace ContractNum = 2 if Season == 2013 & Team == "TEN" & Player == "Michael Preston" & Position == "WR" & ContractAverage == 239647
quietly replace ContractNum = 2 if Season == 2013 & Team == "TEN" & Player == "Rusty Smith" & Position == "QB" & ContractAverage == 24000
quietly replace ContractNum = 2 if Season == 2013 & Team == "WAS" & Player == "Jawan Jamison" & Position == "RB" & ContractAverage == 495000
quietly replace ContractNum = 2 if Season == 2013 & Team == "WAS" & Player == "Will Compton" & Position == "ILB/LB" & ContractAverage == 496667
quietly replace ContractNum = 2 if Season == 2014 & Team == "CLE" & Player == "Connor Shaw" & Position == "QB" & ContractAverage == 511667
quietly replace ContractNum = 2 if Season == 2014 & Team == "DET" & Player == "Darryl Tapp" & Position == "DE" & ContractAverage == 950000
quietly replace ContractNum = 2 if Season == 2014 & Team == "DET" & Player == "Mohammed Seisay" & Position == "CB" & ContractAverage == 107100
quietly replace ContractNum = 2 if Season == 2017 & Team == "WAS" & Player == "Quinton Dunbar" & Position == "CB" & ContractAverage == 525000
quietly replace ContractNum = 2 if Season == 2019 & Team == "GB" & Player == "Lucas Patrick" & Position == "G" & ContractAverage == 645000
quietly replace ContractNum = 2 if Season == 2019 & Team == "TB" & Player == "John Franklin" & Position == "CB" & ContractAverage == 540000
quietly replace ContractNum = 2 if Season == 2020 & Team == "PHI" & Player == "Luke Juriga" & Position == "C" & ContractAverage == 33600
quietly replace ContractNum = 2 if Season == 2021 & Team == "ATL" & Player == "Nick Thurman" & Position == "DE" & ContractAverage == 9200 & Player[_n-1] == "Nick Thurman"
quietly replace ContractNum = 2 if Season == 2021 & Team == "DAL" & Player == "Darian Thompson" & Position == "FS" & ContractAverage == 990000
quietly replace ContractNum = 2 if Season == 2021 & Team == "IND" & Player == "Brett Hundley" & Position == "QB" & ContractAverage == 14000
quietly replace ContractNum = 2 if Season == 2021 & Team == "NO" & Player == "Caleb Benenoch" & Position == "RT" & ContractAverage == 98000
quietly replace ContractNum = 2 if Season == 2021 & Team == "PHI" & Player == "Luke Juriga" & Position == "C" & ContractAverage == 18400
quietly replace ContractNum = 2 if Season == 2021 & Team == "TB" & Player == "Pierre Desir" & Position == "CB" & ContractAverage == 238000
quietly replace ContractNum = 2 if Season == 2022 & Team == "LAR" & Player == "Earnest Brown" & Position == "DE" & ContractAverage == 787500
quietly replace ContractNum = 2 if Season == 2022 & Team == "NO" & Player == "Josh Andrews" & Position == "C" & ContractAverage == 358200
quietly replace ContractNum = 2 if Season == 2023 & Team == "MIA" & Player == "Robbie Anderson" & Position == "WR" & ContractAverage == 48300
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 5 ContractAverage Clean.dta", replace

use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 3 ContractLength.dta", replace
* Drop observations where Player is blank
drop if Player == ""
gen Index = _n
* List duplicates by Season Team Player Position, copy into Excel
duplicates tag Season Team Player Position, generate(DupTag)
preserve
gsort Season Team Player Position -ContractLength Index
list Season Team Player Position ContractLength if DupTag>0
restore
* Drop duplicates by Season Team Player Position ContractAverage who are also duplicates by CapHit
duplicates drop Season Team Player Position ContractLength if Player == "Prince Emili" | Player == "Michael Tutsie" | Player == "Tre'Mon Morris-Brash", force
* Drop fictitious contract lengths
duplicates drop Season Team Player Position ContractLength if Player == "Austin Calitro" | Player == "Benjamin Braden" | Player == "John Hurst" | Player == "Jeremy McNichols" | Player == "Brett Rypien", force
drop if (Season == 2021 & Team == "TB" & Player == "Justin Watson" & Position == "WR" & ContractLength == 1) | (Season == 2024 & Team == "PHI" & Player == "Ian Book" & Position == "QB" & ContractLength == 1)
* Account for multiple contracts
gen ContractNum = 1
quietly replace ContractNum = 3 if Season == 2012 & Team == "PIT" & Player == "Alameda Ta'amu" & Position == "DT" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "BAL" & Player == "Chavis Williams" & Position == "LB" & ContractLength == 1 & Player[_n-1] == "Chavis Williams"
quietly replace ContractNum = 2 if Season == 2011 & Team == "CHI" & Player == "Max Komar" & Position == "WR" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2011 & Team == "CIN" & Player == "Armon Binns" & Position == "WR" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2011 & Team == "CIN" & Player == "Brandon Ghee" & Position == "CB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "CIN" & Player == "Leon Hall" & Position == "CB" & ContractLength == 5
quietly replace ContractNum = 2 if Season == 2011 & Team == "DAL" & Player == "Clifton Geathers" & Position == "DE" & ContractLength == 4
quietly replace ContractNum = 2 if Season == 2011 & Team == "IND" & Player == "Ricardo Mathews" & Position == "DT" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "JAX" & Player == "Colin Cloherty" & Position == "TE" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2011 & Team == "MIA" & Player == "Pat Devlin" & Position == "QB" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2011 & Team == "MIN" & Player == "Allen Reisner" & Position == "TE" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "MIN" & Player == "Stephen Burton" & Position == "WR" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "NE" & Player == "Alex Silvestro" & Position == "TE/DE" & ContractLength == 1 & Player[_n-1] == "Alex Silvestro"
quietly replace ContractNum = 2 if Season == 2011 & Team == "NE" & Player == "Nick McDonald" & Position == "C" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2011 & Team == "NE" & Player == "Ross Ventrone" & Position == "SS/CB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "NYG" & Player == "Martin Parker" & Position == "DT" & ContractLength == 4
quietly replace ContractNum = 2 if Season == 2011 & Team == "PHI" & Player == "Cedric Thornton" & Position == "DT" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2011 & Team == "SD" & Player == "Bront Bird" & Position == "ILB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "SD" & Player == "Bryan Walters" & Position == "WR" & ContractLength == 2 & Player[_n-1] != "Bryan Walters"
quietly replace ContractNum = 2 if Season == 2011 & Team == "SD" & Player == "Steve Schilling" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "SEA" & Player == "Chris Maragos" & Position == "FS/S" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "SEA" & Player == "Paul Fanaika" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "STL" & Player == "Kevin Hughes" & Position == "T" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2011 & Team == "WAS" & Player == "Will Montgomery" & Position == "C" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "BAL" & Player == "Bobby Rainey" & Position == "RB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "CIN" & Player == "Dan Herron" & Position == "RB" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2012 & Team == "DAL" & Player == "Barry Church" & Position == "SS/S" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2012 & Team == "DET" & Player == "Alphonso Smith" & Position == "CB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "JAX" & Player == "Keith Toston" & Position == "RB" & ContractLength == 1 & Player[_n-1] == "Keith Toston"
quietly replace ContractNum = 2 if Season == 2012 & Team == "MIA" & Player == "Chandler Burden" & Position == "C" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "MIN" & Player == "Allen Reisner" & Position == "TE" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "NE" & Player == "Donte Stallworth" & Position == "WR" & ContractLength == 1 & Player[_n-1] != "Donte Stallworth"
quietly replace ContractNum = 2 if Season == 2012 & Team == "NE" & Player == "Nick McDonald" & Position == "C" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "PHI" & Player == "Antonio Dixon" & Position == "DT" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "PHI" & Player == "Emil Igwenagu" & Position == "TE" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2012 & Team == "PIT" & Player == "Alameda Ta'amu" & Position == "DT" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2012 & Team == "SF" & Player == "Michael Wilhoite" & Position == "ILB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "SF" & Player == "Tony Jerod-Eddie" & Position == "DE" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "STL" & Player == "Cory Harkey" & Position == "FB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "STL" & Player == "Sammy Brown" & Position == "DE" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2012 & Team == "STL" & Player == "Tim Barnes" & Position == "C" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2012 & Team == "WAS" & Player == "Tom Compton" & Position == "G/T" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "ARI" & Player == "Brittan Golden" & Position == "WR" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "ATL" & Player == "Adam Replogle" & Position == "G" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Da'Rick Rogers" & Position == "WR" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Jeris Pendleton" & Position == "DT" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Josh McNary" & Position == "OLB/LB" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Sheldon Price" & Position == "CB" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2013 & Team == "IND" & Player == "Xavier Nixon" & Position == "LT/T" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Danny Noble" & Position == "TE" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Drew Nowak" & Position == "C" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Jeremy Ebert" & Position == "WR" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Jordan Miller" & Position == "DT" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Kyle Love" & Position == "DT" & ContractLength == 1 & Player[_n-1] != "Kyle Love"
quietly replace ContractNum = 2 if Season == 2013 & Team == "JAX" & Player == "Ricky Stanzi" & Position == "QB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "KC" & Player == "Rishaw  Johnson" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "KC" & Player == "Rokevious Watkins" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "MIA" & Player == "Sam Brenner" & Position == "C" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "MIN" & Player == "Rodney Smith" & Position == "WR" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NE" & Player == "Sealver Siliga" & Position == "DT" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NO" & Player == "Ryan Griffin" & Position == "QB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Charles James" & Position == "CB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Eric Herman" & Position == "RT/T" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Jon Beason" & Position == "ILB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Julian Talley" & Position == "WR" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYG" & Player == "Stephen Goodin" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYJ" & Player == "Chris Pantale" & Position == "TE" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYJ" & Player == "Saalim Hakim" & Position == "WR" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "NYJ" & Player == "Troy Davis" & Position == "OLB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Chance Casey" & Position == "CB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Lamar Mady" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Marshall McFadden" & Position == "ILB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Ricky Lumpkin" & Position == "DT" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "OAK" & Player == "Shelton Johnson" & Position == "S" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "PHI" & Player == "Keelan Johnson" & Position == "SS/S" & ContractLength == 4
quietly replace ContractNum = 2 if Season == 2013 & Team == "PHI" & Player == "Matthew Tucker" & Position == "RB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "PIT" & Player == "Brian Arnfelt" & Position == "DE" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2013 & Team == "PIT" & Player == "Terence Garvin" & Position == "ILB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "SD" & Player == "Jacob Byrne" & Position == "TE" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2013 & Team == "SD" & Player == "Marcus Cromartie" & Position == "CB" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "SD" & Player == "Thomas Keiser" & Position == "OLB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "SEA" & Player == "Ricardo Lockette" & Position == "WR" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "SF" & Player == "Darryl Morris" & Position == "CB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "SF" & Player == "Derek Carrier" & Position == "TE" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "STL" & Player == "Justin Veltung" & Position == "WR" & ContractLength == 1 & Player[_n-1] != "Justin Veltung"
quietly replace ContractNum = 2 if Season == 2013 & Team == "STL" & Player == "Sammy Brown" & Position == "DE" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "TB" & Player == "Ka'lial Glaud" & Position == "OLB/LB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "TB" & Player == "Matthew Masifilo" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "TEN" & Player == "Michael Preston" & Position == "WR" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2013 & Team == "TEN" & Player == "Rusty Smith" & Position == "QB" & ContractLength == 1 & Player[_n-1] == "Rusty Smith"
quietly replace ContractNum = 2 if Season == 2013 & Team == "WAS" & Player == "Jawan Jamison" & Position == "RB" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2013 & Team == "WAS" & Player == "Will Compton" & Position == "ILB/LB" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2014 & Team == "CLE" & Player == "Connor Shaw" & Position == "QB" & ContractLength == 3
quietly replace ContractNum = 2 if Season == 2014 & Team == "DET" & Player == "Darryl Tapp" & Position == "DE" & ContractLength == 1 & Player[_n-1] != "Darryl Tapp"
quietly replace ContractNum = 2 if Season == 2014 & Team == "DET" & Player == "Mohammed Seisay" & Position == "CB" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2017 & Team == "WAS" & Player == "Quinton Dunbar" & Position == "CB" & ContractLength == 3 & Player[_n-1] == "Quinton Dunbar"
quietly replace ContractNum = 2 if Season == 2019 & Team == "GB" & Player == "Lucas Patrick" & Position == "G" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2019 & Team == "TB" & Player == "John Franklin" & Position == "CB" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2020 & Team == "PHI" & Player == "Luke Juriga" & Position == "C" & ContractLength == 1
quietly replace ContractNum = 2 if Season == 2021 & Team == "ATL" & Player == "Nick Thurman" & Position == "DE" & ContractLength == 1 & Player[_n-1] == "Nick Thurman"
quietly replace ContractNum = 2 if Season == 2021 & Team == "DAL" & Player == "Darian Thompson" & Position == "FS" & ContractLength == 1 & Player[_n-1] != "Darian Thompson"
quietly replace ContractNum = 2 if Season == 2021 & Team == "IND" & Player == "Brett Hundley" & Position == "QB" & ContractLength == 1 & Player[_n-1] == "Brett Hundley"
quietly replace ContractNum = 2 if Season == 2021 & Team == "NO" & Player == "Caleb Benenoch" & Position == "RT" & ContractLength == 1 & Player[_n-1] == "Caleb Benenoch"
quietly replace ContractNum = 2 if Season == 2021 & Team == "PHI" & Player == "Luke Juriga" & Position == "C" & ContractLength == 1 & Player[_n-1] == "Luke Juriga"
quietly replace ContractNum = 2 if Season == 2021 & Team == "TB" & Player == "Pierre Desir" & Position == "CB" & ContractLength == 1 & Player[_n-1] == "Pierre Desir"
quietly replace ContractNum = 2 if Season == 2022 & Team == "LAR" & Player == "Earnest Brown" & Position == "DE" & ContractLength == 2
quietly replace ContractNum = 2 if Season == 2022 & Team == "NO" & Player == "Josh Andrews" & Position == "C" & ContractLength == 1 & Player[_n-1] == "Josh Andrews"
quietly replace ContractNum = 2 if Season == 2023 & Team == "MIA" & Player == "Robbie Anderson" & Position == "WR" & ContractLength == 1 & Player[_n-1] == "Robbie Anderson"
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 6 ContractLength Clean.dta", replace

use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 5 ContractAverage Clean.dta", replace
merge 1:1 Season Team Player Position ContractNum using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 6 ContractLength Clean.dta"
drop if _merge!=3
drop _merge
merge 1:1 Season Team Player Position ContractNum using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 4 CapHit Clean.dta"
drop if _merge!=3
drop _merge
keep Season Team Player Position CapHit ContractAverage ContractLength
order Season Team Player Position CapHit ContractAverage ContractLength
gsort Season Team Player Position -CapHit
replace Team = "Arizona Cardinals" if Team == "ARI"
replace Team = "Atlanta Falcons" if Team == "ATL"
replace Team = "Baltimore Ravens" if Team == "BAL"
replace Team = "Buffalo Bills" if Team == "BUF"
replace Team = "Carolina Panthers" if Team == "CAR"
replace Team = "Chicago Bears" if Team == "CHI"
replace Team = "Cincinnati Bengals" if Team == "CIN"
replace Team = "Cleveland Browns" if Team == "CLE"
replace Team = "Dallas Cowboys" if Team == "DAL"
replace Team = "Denver Broncos" if Team == "DEN"
replace Team = "Detroit Lions" if Team == "DET"
replace Team = "Green Bay Packers" if Team == "GB"
replace Team = "Houston Texans" if Team == "HOU"
replace Team = "Indianapolis Colts" if Team == "IND"
replace Team = "Jacksonville Jaguars" if Team == "JAX"
replace Team = "Kansas City Chiefs" if Team == "KC"
replace Team = "Los Angeles Chargers" if Team == "LAC" | Team == "SD"
replace Team = "Los Angeles Rams" if Team == "LAR" | Team == "STL"
replace Team = "Las Vegas Raiders" if Team == "LV" | Team == "OAK"
replace Team = "Miami Dolphins" if Team == "MIA"
replace Team = "Minnesota Vikings" if Team == "MIN"
replace Team = "New England Patriots" if Team == "NE"
replace Team = "New Orleans Saints" if Team == "NO"
replace Team = "New York Giants" if Team == "NYG"
replace Team = "New York Jets" if Team == "NYJ"
replace Team = "Philadelphia Eagles" if Team == "PHI"
replace Team = "Pittsburgh Steelers" if Team == "PIT"
replace Team = "Seattle Seahawks" if Team == "SEA"
replace Team = "San Francisco 49ers" if Team == "SF"
replace Team = "Tampa Bay Buccaneers" if Team == "TB"
replace Team = "Tennessee Titans" if Team == "TEN"
replace Team = "Washington Commanders" if Team == "WAS"
replace Player = "Greg Jones MLB" if Player == "Greg Jones" & Season == 2012 & Team == "Jacksonville Jaguars" & Position == "ILB/LB"
replace Player = "Greg Jones RB" if Player == "Greg Jones" & Season == 2012 & Team == "Jacksonville Jaguars" & Position == "FB"
replace Player = "T.J. Carter CB" if Player == "T.J. Carter" & Season == 2022 & Team == "Los Angeles Rams" & Position == "CB"
replace Player = "T.J. Carter DE" if Player == "T.J. Carter" & Season == 2022 & Team == "Los Angeles Rams" & Position == "DT"
* Fix apostrophes and delete commas
replace Player = subinstr(Player, "`=uchar(8217)'", "'", .)
replace Player = subinstr(Player, ",", "", .)
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 7 Merge Spotrac.dta", replace

use "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 8 Cap Tables.dta", replace
keep if CapHit != .
keep Season Team Player PosCap CapHit RookieSeason Rookie
merge 1:1 Season Team Player CapHit using "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 7 Merge Spotrac.dta"
drop Position
rename PosCap Position
label variable CapHit "Cap Hit"
label variable Position "Position"
label variable ContractAverage "Contract Average"
label variable ContractLength "Contract Length"

* Record Position for players not in cap tables
quietly replace Position = "WR" if Player == "A.J.  Jenkins" & CapHit == 1263188 & _merge == 2
quietly replace Position = "WR" if Player == "A.J.  Jenkins" & CapHit == 705797 & _merge == 2
quietly replace Position = "WR" if Player == "A.J.  Jenkins" & CapHit == 1021594 & _merge == 2
quietly replace Position = "WR" if Player == "Ace  Sanders" & CapHit == 518282 & _merge == 2
quietly replace Position = "WR" if Player == "Ace  Sanders" & CapHit == 491811 & _merge == 2
quietly replace Position = "DE" if Player == "Alex Brown" & CapHit == 3000000 & _merge == 2
quietly replace Position = "DT" if Player == "Alex Magee" & CapHit == 703750 & _merge == 2
quietly replace Position = "DT" if Player == "Alex Magee" & CapHit == 788750 & _merge == 2
quietly replace Position = "ILB" if Player == "Alex Singleton" & CapHit == 6913333 & _merge == 2
quietly replace Position = "LT" if Player == "Andrew Thomas" & CapHit == 19687941 & _merge == 2
quietly replace Position = "S" if Player == "Anthony Smith" & CapHit == 685000 & _merge == 2
quietly replace Position = "RT" if Player == "Austin Deculus" & CapHit == 57222 & _merge == 2
quietly replace Position = "RB" if Player == "Austin Ekeler" & CapHit == 3170000 & _merge == 2
quietly replace Position = "RT" if Player == "Austin Jackson" & CapHit == 4262116 & _merge == 2
quietly replace Position = "LB" if Player == "Ben Leber" & CapHit == 1250000 & _merge == 2
quietly replace Position = "OLB" if Player == "Benton Whitley" & CapHit == 88334 & _merge == 2
quietly replace Position = "DT" if Player == "Bilal Nichols" & CapHit == 4840000 & _merge == 2
quietly replace Position = "OLB" if Player == "Bradley Chubb" & CapHit == 15813841 & _merge == 2
quietly replace Position = "S" if Player == "Brenden Schooler" & CapHit == 1465000 & _merge == 2
quietly replace Position = "CB" if Player == "Chevis Jackson" & CapHit == 480000 & _merge == 2
quietly replace Position = "WR" if Player == "Christian Kirk" & CapHit == 24119294 & _merge == 2
quietly replace Position = "RB" if Player == "Christian McCaffrey" & CapHit == 6329647 & _merge == 2
quietly replace Position = "DT" if Player == "Christian Wilkins" & CapHit == 10012000 & _merge == 2
quietly replace Position = "DE" if Player == "Clifton Geathers" & CapHit == 0 & _merge == 2
quietly replace Position = "CB" if Player == "D'Angelo Ross" & CapHit == 57222 & _merge == 2
quietly replace Position = "RB" if Player == "Da'Rel Scott" & CapHit == 555000 & _merge == 2
quietly replace Position = "FS" if Player == "Darian Thompson" & CapHit == 0 & _merge == 2
quietly replace Position = "OLB" if Player == "Darius Harris" & CapHit == 109444 & _merge == 2
quietly replace Position = "DT" if Player == "Darryl Richard" & CapHit == 330000 & _merge == 2
quietly replace Position = "DE" if Player == "Dave Tollefson" & CapHit == 520000 & _merge == 2
quietly replace Position = "DE" if Player == "Dave Tollefson" & CapHit == 1000000 & _merge == 2
quietly replace Position = "WR" if Player == "David Anderson" & CapHit == 322352 & _merge == 2
quietly replace Position = "CB" if Player == "David Andrews" & CapHit == 7101470 & _merge == 2
quietly replace Position = "RT" if Player == "David Diehl" & CapHit == 4500000 & _merge == 2
quietly replace Position = "RT" if Player == "David Diehl" & CapHit == 3325000 & _merge == 2
quietly replace Position = "RT" if Player == "David Diehl" & CapHit == 1200000 & _merge == 2
quietly replace Position = "DE" if Player == "David Veikune" & CapHit == 671816 & _merge == 2
quietly replace Position = "DT" if Player == "DeWayne Carter" & CapHit == 1021463 & _merge == 2
quietly replace Position = "WR" if Player == "Deion Branch" & CapHit == 2300000 & _merge == 2
quietly replace Position = "WR" if Player == "Deion Branch" & CapHit == 1575000 & _merge == 2
quietly replace Position = "WR" if Player == "Deon Butler" & CapHit == 615000 & _merge == 2
quietly replace Position = "DT" if Player == "Derek Landri" & CapHit == 735000 & _merge == 2
quietly replace Position = "DT" if Player == "Derek Landri" & CapHit == 525000 & _merge == 2
quietly replace Position = "TE" if Player == "Derek Schouman" & CapHit == 525000 & _merge == 2
quietly replace Position = "WR" if Player == "Devin Aromashodu" & CapHit == 800000 & _merge == 2
quietly replace Position = "DT" if Player == "Dexter Lawrence" & CapHit == 14340482 & _merge == 2
quietly replace Position = "S" if Player == "Dominique Barber" & CapHit == 587000 & _merge == 2
quietly replace Position = "WR" if Player == "Donald Driver" & CapHit == 5000000 & _merge == 2
quietly replace Position = "WR" if Player == "Donald Driver" & CapHit == 5000000 & _merge == 2
quietly replace Position = "TE" if Player == "Donald Lee" & CapHit == 810000 & _merge == 2
quietly replace Position = "CB" if Player == "Donald Strickland" & CapHit == 575000 & _merge == 2
quietly replace Position = "CB" if Player == "Drew Coleman" & CapHit == 1333333 & _merge == 2
quietly replace Position = "S" if Player == "Eric Frampton" & CapHit == 1033333 & _merge == 2
quietly replace Position = "C" if Player == "Eric Heitmann" & CapHit == 2562500 & _merge == 2
quietly replace Position = "DE" if Player == "Eric Moore" & CapHit == 640000 & _merge == 2
quietly replace Position = "WR" if Player == "Gabriel Davis" & CapHit == 4494117 & _merge == 2
quietly replace Position = "QB" if Player == "Gardner Minshew" & CapHit == 7790000 & _merge == 2
quietly replace Position = "TE" if Player == "Garrett Mills" & CapHit == 640000 & _merge == 2
quietly replace Position = "G" if Player == "Geoff Hangartner" & CapHit == 1000000 & _merge == 2
quietly replace Position = "G" if Player == "Geoff Hangartner" & CapHit == 1541666 & _merge == 2
quietly replace Position = "RT" if Player == "George Fant" & CapHit == 3170000 & _merge == 2
quietly replace Position = "WR" if Player == "Greg Childs" & CapHit == 480146 & _merge == 2
quietly replace Position = "K" if Player == "Greg Zuerlein" & CapHit == 1835058 & _merge == 2
quietly replace Position = "LB" if Player == "H.B. Blades" & CapHit == 525000 & _merge == 2
quietly replace Position = "C" if Player == "Hank Fraley" & CapHit == 1066667 & _merge == 2
quietly replace Position = "C" if Player == "Hank Fraley" & CapHit == 1066667 & _merge == 2
quietly replace Position = "S" if Player == "Haruki Nakamura" & CapHit == 1180833 & _merge == 2
quietly replace Position = "C" if Player == "Hjalte Froholdt" & CapHit == 4133413 & _merge == 2
quietly replace Position = "DT" if Player == "Howard Green" & CapHit == 810000 & _merge == 2
quietly replace Position = "C" if Player == "Hunter Nourzad" & CapHit == 874879 & _merge == 2
quietly replace Position = "TE" if Player == "Isaiah Stanback" & CapHit == 600000 & _merge == 2
quietly replace Position = "ILB" if Player == "Ja'whaun Bentley" & CapHit == 5433333 & _merge == 2
quietly replace Position = "WR" if Player == "Jabar Gaffney" & CapHit == 2400000 & _merge == 2
quietly replace Position = "S" if Player == "Jabrill Peppers" & CapHit == 6610000 & _merge == 2
quietly replace Position = "DE" if Player == "Jacob Ford" & CapHit == 1300000 & _merge == 2
quietly replace Position = "RB" if Player == "Jacob Hester" & CapHit == 1408462 & _merge == 2
quietly replace Position = "RB" if Player == "Jacob Hester" & CapHit == 700000 & _merge == 2
quietly replace Position = "TE" if Player == "Jake O'Connell" & CapHit == 615000 & _merge == 2
quietly replace Position = "RB" if Player == "James Conner" & CapHit == 11232560 & _merge == 2
quietly replace Position = "LB" if Player == "James Farrior" & CapHit == 3825000 & _merge == 2
quietly replace Position = "G" if Player == "Jason Spitz" & CapHit == 1750000 & _merge == 2
quietly replace Position = "DT" if Player == "Javon Hargrave" & CapHit == 8777352 & _merge == 2
quietly replace Position = "OLB" if Player == "Jeremiah Owusu-Koramoah" & CapHit == 3414679 & _merge == 2
quietly replace Position = "RB" if Player == "Jerious Norwood" & CapHit == 710000 & _merge == 2
quietly replace Position = "DE" if Player == "Jimmy Wilkerson" & CapHit == 1500000 & _merge == 2
quietly replace Position = "QB" if Player == "John Beck" & CapHit == 800000 & _merge == 2
quietly replace Position = "QB" if Player == "John Beck" & CapHit == 540000 & _merge == 2
quietly replace Position = "G" if Player == "John Moffitt" & CapHit == 625000 & _merge == 2
quietly replace Position = "G" if Player == "John Moffitt" & CapHit == 752500 & _merge == 2
quietly replace Position = "WR" if Player == "Johnny Knox" & CapHit == 576060 & _merge == 2
quietly replace Position = "WR" if Player == "Johnny Knox" & CapHit == 51060 & _merge == 2
quietly replace Position = "WR" if Player == "Johnny Knox" & CapHit == 1260000 & _merge == 2
quietly replace Position = "S" if Player == "Jon McGraw" & CapHit == 525000 & _merge == 2
quietly replace Position = "RT" if Player == "Jonah Williams" & CapHit == 6280000 & _merge == 2
quietly replace Position = "DT" if Player == "Jonathan Allen" & CapHit == 20970588 & _merge == 2
quietly replace Position = "LB" if Player == "Jonathan Goff" & CapHit == 590500 & _merge == 2
quietly replace Position = "LT" if Player == "Jordan Mailata" & CapHit == 11666000 & _merge == 2
quietly replace Position = "G" if Player == "Josh Ball" & CapHit == 41667 & _merge == 2
quietly replace Position = "WR" if Player == "Juaquin Iglesias" & CapHit == 405000 & _merge == 2
quietly replace Position = "DT" if Player == "Justin Jones" & CapHit == 6345000 & _merge == 2
quietly replace Position = "CB" if Player == "Justin Tryon" & CapHit == 662250 & _merge == 2
quietly replace Position = "T" if Player == "Kareem McKenzie" & CapHit == 7085714 & _merge == 2
quietly replace Position = "RT" if Player == "Kelvin Beachum" & CapHit == 2557500 & _merge == 2
quietly replace Position = "ILB" if Player == "Kenneth Murray" & CapHit == 5410000 & _merge == 2
quietly replace Position = "DE" if Player == "Kenyon Coleman" & CapHit == 2345000 & _merge == 2
quietly replace Position = "DE" if Player == "Kenyon Coleman" & CapHit == 555000 & _merge == 2
quietly replace Position = "RB" if Player == "Kevin Faulk" & CapHit == 525000 & _merge == 2
quietly replace Position = "RB" if Player == "Kevin Smith" & CapHit == 765000 & _merge == 2
quietly replace Position = "DT" if Player == "Khyiris Tonga" & CapHit == 1670000 & _merge == 2
quietly replace Position = "ILB" if Player == "Krys Barnes" & CapHit == 1052500 & _merge == 2
quietly replace Position = "DE" if Player == "Kyle Moore" & CapHit == 216176 & _merge == 2
quietly replace Position = "CB" if Player == "Kyu Blu Kelly" & CapHit == 152500 & _merge == 2
quietly replace Position = "CB" if Player == "L'Jarius Sneed" & CapHit == 9520000 & _merge == 2
quietly replace Position = "G" if Player == "Landon Dickerson" & CapHit == 5996130 & _merge == 2
quietly replace Position = "G" if Player == "Leonard Davis" & CapHit == 540000 & _merge == 2
quietly replace Position = "TE" if Player == "Leonard Pope" & CapHit == 725000 & _merge == 2
quietly replace Position = "C" if Player == "Lloyd Cushenberry" & CapHit == 6155000 & _merge == 2
quietly replace Position = "OLB" if Player == "Mack Wilson" & CapHit == 3401667 & _merge == 2
quietly replace Position = "S" if Player == "Madieu Williams" & CapHit == 540000 & _merge == 2
quietly replace Position = "T" if Player == "Marcus McNeill" & CapHit == 6298588 & _merge == 2
quietly replace Position = "S" if Player == "Marcus Williams" & CapHit == 18027918 & _merge == 2
quietly replace Position = "QB" if Player == "Mark Brunell" & CapHit == 1650000 & _merge == 2
quietly replace Position = "TE" if Player == "Martin Rucker" & CapHit == 673425 & _merge == 2
quietly replace Position = "G" if Player == "Matt Hennessy" & CapHit == 1092500 & _merge == 2
quietly replace Position = "LB" if Player == "Matt McCoy" & CapHit == 710000 & _merge == 2
quietly replace Position = "DT" if Player == "Matt Toeaina" & CapHit == 1240000 & _merge == 2
quietly replace Position = "RB" if Player == "Maurice Morris" & CapHit == 2125000 & _merge == 2
quietly replace Position = "RB" if Player == "Maurice Stovall" & CapHit == 525000 & _merge == 2
quietly replace Position = "DE" if Player == "Maxx Crosby" & CapHit == 30253250 & _merge == 2
quietly replace Position = "RB" if Player == "Michael Carter" & CapHit == 108611 & _merge == 2
quietly replace Position = "OLB" if Player == "Michael Hoecht" & CapHit == 660000 & _merge == 2
quietly replace Position = "OLB" if Player == "Michael Hoecht" & CapHit == 825000 & _merge == 2
quietly replace Position = "OLB" if Player == "Michael Hoecht" & CapHit == 940000 & _merge == 2
quietly replace Position = "OLB" if Player == "Michael Hoecht" & CapHit == 2985000 & _merge == 2
quietly replace Position = "DT" if Player == "Michael Pierce" & CapHit == 3737000 & _merge == 2
quietly replace Position = "DT" if Player == "Michael Pierce" & CapHit == 4072000 & _merge == 2
quietly replace Position = "T" if Player == "Michael Toudouze" & CapHit == 56471 & _merge == 2
quietly replace Position = "WR" if Player == "Mike Sims-Walker" & CapHit == 1375000 & _merge == 2
quietly replace Position = "ILB" if Player == "Milo Eifler" & CapHit == 132501 & _merge == 2
quietly replace Position = "RB" if Player == "Moran Norris" & CapHit == 1677333 & _merge == 2
quietly replace Position = "DT" if Player == "Myron Pryor" & CapHit == 544750 & _merge == 2
quietly replace Position = "DT" if Player == "Myron Pryor" & CapHit == 584750 & _merge == 2
quietly replace Position = "WR" if Player == "Nate Burleson" & CapHit == 2856642 & _merge == 2
quietly replace Position = "WR" if Player == "Nate Burleson" & CapHit == 4031642 & _merge == 2
quietly replace Position = "CB" if Player == "Nazeeh Johnson" & CapHit == 985000 & _merge == 2
quietly replace Position = "G" if Player == "Olisaemeka Udoh" & CapHit == 536741 & _merge == 2
quietly replace Position = "G" if Player == "Olisaemeka Udoh" & CapHit == 716741 & _merge == 2
quietly replace Position = "G" if Player == "Olisaemeka Udoh" & CapHit == 891741 & _merge == 2
quietly replace Position = "G" if Player == "Olisaemeka Udoh" & CapHit == 1006741 & _merge == 2
quietly replace Position = "G" if Player == "Olisaemeka Udoh" & CapHit == 1232500 & _merge == 2
quietly replace Position = "G" if Player == "Olisaemeka Udoh" & CapHit == 2000000 & _merge == 2
quietly replace Position = "RB" if Player == "Ovie Mughelli" & CapHit == 3733333 & _merge == 2
quietly replace Position = "CB" if Player == "Pat Lee" & CapHit == 680000 & _merge == 2
quietly replace Position = "DE" if Player == "Phillip Merling" & CapHit == 1180000 & _merge == 2
quietly replace Position = "TE" if Player == "Randy McMichael" & CapHit == 810000 & _merge == 2
quietly replace Position = "P" if Player == "Reggie Hodges" & CapHit == 935000 & _merge == 2
quietly replace Position = "TE" if Player == "Richard Quinn" & CapHit == 725000 & _merge == 2
quietly replace Position = "G" if Player == "Rishaw  Johnson" & CapHit == 390000 & _merge == 2
quietly replace Position = "G" if Player == "Rishaw  Johnson" & CapHit == 395294 & _merge == 2
quietly replace Position = "G" if Player == "Rishaw  Johnson" & CapHit == 18000 & _merge == 2
quietly replace Position = "G" if Player == "Rishaw  Johnson" & CapHit == 33529 & _merge == 2
quietly replace Position = "CB" if Player == "Ron Bartell" & CapHit == 6612500 & _merge == 2
quietly replace Position = "CB" if Player == "Ron Bartell" & CapHit == 1000000 & _merge == 2
quietly replace Position = "DT" if Player == "Ron Brace" & CapHit == 1146000 & _merge == 2
quietly replace Position = "DT" if Player == "Ron Brace" & CapHit == 1337000 & _merge == 2
quietly replace Position = "WR" if Player == "Roscoe Parrish" & CapHit == 2345000 & _merge == 2
quietly replace Position = "G" if Player == "Russ Hochstein" & CapHit == 1020000 & _merge == 2
quietly replace Position = "T" if Player == "Ryan Diem" & CapHit == 2900000 & _merge == 2
quietly replace Position = "C" if Player == "Ryan Pontbriand" & CapHit == 1150000 & _merge == 2
quietly replace Position = "RB" if Player == "Ryan Torain" & CapHit == 525000 & _merge == 2
quietly replace Position = "WR" if Player == "Sammie Stroughter" & CapHit == 537067 & _merge == 2
quietly replace Position = "WR" if Player == "Sammie Stroughter" & CapHit == 627067 & _merge == 2
quietly replace Position = "DT" if Player == "Shelby Harris" & CapHit == 2186000 & _merge == 2
quietly replace Position = "CB" if Player == "Sheldon Brown" & CapHit == 4000000 & _merge == 2
quietly replace Position = "CB" if Player == "Sheldon Brown" & CapHit == 5250000 & _merge == 2
quietly replace Position = "DT" if Player == "Sheldon Rankins" & CapHit == 11705882 & _merge == 2
quietly replace Position = "DT" if Player == "Sione Pouha" & CapHit == 2450000 & _merge == 2
quietly replace Position = "WR" if Player == "Steve Smith" & CapHit == 2281250 & _merge == 2
quietly replace Position = "WR" if Player == "Steve Smith" & CapHit == 1843750 & _merge == 2
quietly replace Position = "TE" if Player == "T.J. Hockenson" & CapHit == 7046176 & _merge == 2
quietly replace Position = "ILB" if Player == "Tavares Gooden" & CapHit == 700000 & _merge == 2
quietly replace Position = "S" if Player == "Tom Zbikowski" & CapHit == 1091667 & _merge == 2
quietly replace Position = "DT" if Player == "Tommy Togiai" & CapHit == 401667 & _merge == 2
quietly replace Position = "RB" if Player == "Travis Homer" & CapHit == 2013400 & _merge == 2
quietly replace Position = "OLB" if Player == "Tre'Mon Morris-Brash" & CapHit == 225000 & _merge == 2
quietly replace Position = "LT" if Player == "Trent Williams" & CapHit == 21614953 & _merge == 2
quietly replace Position = "DT" if Player == "Trevor Laws" & CapHit == 962500 & _merge == 2
quietly replace Position = "DT" if Player == "Trevor Laws" & CapHit == 540000 & _merge == 2
quietly replace Position = "S" if Player == "Troy Nolan" & CapHit == 554565 & _merge == 2
quietly replace Position = "G" if Player == "Trystan Colon-Castillo" & CapHit == 1727941 & _merge == 2
quietly replace Position = "LB" if Player == "Tully Banta-Cain" & CapHit == 4500000 & _merge == 2
quietly replace Position = "S" if Player == "Tyrone Culver" & CapHit == 700000 & _merge == 2
quietly replace Position = "TE" if Player == "Visanthe Shiancoe" & CapHit == 1200000 & _merge == 2
quietly replace Position = "DE" if Player == "Zach Sieler" & CapHit == 6252000 & _merge == 2
quietly replace Position = "RB" if Player == "Zack Moss" & CapHit == 2866176 & _merge == 2

* Record RookieSeason for players not in cap tables
quietly replace RookieSeason = 2012 if Player == "A.J.  Jenkins" & CapHit == 1263188 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "A.J.  Jenkins" & CapHit == 705797 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "A.J.  Jenkins" & CapHit == 1021594 & _merge == 2
quietly replace RookieSeason = 2013 if Player == "Ace  Sanders" & CapHit == 518282 & _merge == 2
quietly replace RookieSeason = 2013 if Player == "Ace  Sanders" & CapHit == 491811 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Alex Brown" & CapHit == 3000000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Alex Magee" & CapHit == 703750 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Alex Magee" & CapHit == 788750 & _merge == 2
quietly replace RookieSeason = 2015 if Player == "Alex Singleton" & CapHit == 6913333 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Andrew Thomas" & CapHit == 19687941 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Anthony Smith" & CapHit == 685000 & _merge == 2
quietly replace RookieSeason = 2022 if Player == "Austin Deculus" & CapHit == 57222 & _merge == 2
quietly replace RookieSeason = 2017 if Player == "Austin Ekeler" & CapHit == 3170000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Austin Jackson" & CapHit == 4262116 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Ben Leber" & CapHit == 1250000 & _merge == 2
quietly replace RookieSeason = 2022 if Player == "Benton Whitley" & CapHit == 88334 & _merge == 2
quietly replace RookieSeason = 2018 if Player == "Bilal Nichols" & CapHit == 4840000 & _merge == 2
quietly replace RookieSeason = 2018 if Player == "Bradley Chubb" & CapHit == 15813841 & _merge == 2
quietly replace RookieSeason = 2022 if Player == "Brenden Schooler" & CapHit == 1465000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Chevis Jackson" & CapHit == 480000 & _merge == 2
quietly replace RookieSeason = 2018 if Player == "Christian Kirk" & CapHit == 24119294 & _merge == 2
quietly replace RookieSeason = 2017 if Player == "Christian McCaffrey" & CapHit == 6329647 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Christian Wilkins" & CapHit == 10012000 & _merge == 2
quietly replace RookieSeason = 2010 if Player == "Clifton Geathers" & CapHit == 0 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "D'Angelo Ross" & CapHit == 57222 & _merge == 2
quietly replace RookieSeason = 2011 if Player == "Da'Rel Scott" & CapHit == 555000 & _merge == 2
quietly replace RookieSeason = 2016 if Player == "Darian Thompson" & CapHit == 0 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Darius Harris" & CapHit == 109444 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Darryl Richard" & CapHit == 330000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Dave Tollefson" & CapHit == 520000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Dave Tollefson" & CapHit == 1000000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "David Anderson" & CapHit == 322352 & _merge == 2
quietly replace RookieSeason = 2015 if Player == "David Andrews" & CapHit == 7101470 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "David Diehl" & CapHit == 4500000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "David Diehl" & CapHit == 3325000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "David Diehl" & CapHit == 1200000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "David Veikune" & CapHit == 671816 & _merge == 2
quietly replace RookieSeason = 2024 if Player == "DeWayne Carter" & CapHit == 1021463 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Deion Branch" & CapHit == 2300000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Deion Branch" & CapHit == 1575000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Deon Butler" & CapHit == 615000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Derek Landri" & CapHit == 735000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Derek Landri" & CapHit == 525000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Derek Schouman" & CapHit == 525000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Devin Aromashodu" & CapHit == 800000 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Dexter Lawrence" & CapHit == 14340482 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Dominique Barber" & CapHit == 587000 & _merge == 2
quietly replace RookieSeason = 1999 if Player == "Donald Driver" & CapHit == 5000000 & _merge == 2
quietly replace RookieSeason = 1999 if Player == "Donald Driver" & CapHit == 5000000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Donald Lee" & CapHit == 810000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Donald Strickland" & CapHit == 575000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Drew Coleman" & CapHit == 1333333 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Eric Frampton" & CapHit == 1033333 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Eric Heitmann" & CapHit == 2562500 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Eric Moore" & CapHit == 640000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Gabriel Davis" & CapHit == 4494117 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Gardner Minshew" & CapHit == 7790000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Garrett Mills" & CapHit == 640000 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Geoff Hangartner" & CapHit == 1000000 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Geoff Hangartner" & CapHit == 1541666 & _merge == 2
quietly replace RookieSeason = 2016 if Player == "George Fant" & CapHit == 3170000 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "Greg Childs" & CapHit == 480146 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "Greg Zuerlein" & CapHit == 1835058 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "H.B. Blades" & CapHit == 525000 & _merge == 2
quietly replace RookieSeason = 2000 if Player == "Hank Fraley" & CapHit == 1066667 & _merge == 2
quietly replace RookieSeason = 2000 if Player == "Hank Fraley" & CapHit == 1066667 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Haruki Nakamura" & CapHit == 1180833 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Hjalte Froholdt" & CapHit == 4133413 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Howard Green" & CapHit == 810000 & _merge == 2
quietly replace RookieSeason = 2024 if Player == "Hunter Nourzad" & CapHit == 874879 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Isaiah Stanback" & CapHit == 600000 & _merge == 2
quietly replace RookieSeason = 2018 if Player == "Ja'whaun Bentley" & CapHit == 5433333 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Jabar Gaffney" & CapHit == 2400000 & _merge == 2
quietly replace RookieSeason = 2017 if Player == "Jabrill Peppers" & CapHit == 6610000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Jacob Ford" & CapHit == 1300000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Jacob Hester" & CapHit == 1408462 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Jacob Hester" & CapHit == 700000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Jake O'Connell" & CapHit == 615000 & _merge == 2
quietly replace RookieSeason = 2017 if Player == "James Conner" & CapHit == 11232560 & _merge == 2
quietly replace RookieSeason = 1997 if Player == "James Farrior" & CapHit == 3825000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Jason Spitz" & CapHit == 1750000 & _merge == 2
quietly replace RookieSeason = 2016 if Player == "Javon Hargrave" & CapHit == 8777352 & _merge == 2
quietly replace RookieSeason = 2021 if Player == "Jeremiah Owusu-Koramoah" & CapHit == 3414679 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Jerious Norwood" & CapHit == 710000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Jimmy Wilkerson" & CapHit == 1500000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "John Beck" & CapHit == 800000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "John Beck" & CapHit == 540000 & _merge == 2
quietly replace RookieSeason = 2011 if Player == "John Moffitt" & CapHit == 625000 & _merge == 2
quietly replace RookieSeason = 2011 if Player == "John Moffitt" & CapHit == 752500 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Johnny Knox" & CapHit == 576060 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Johnny Knox" & CapHit == 51060 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Johnny Knox" & CapHit == 1260000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Jon McGraw" & CapHit == 525000 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Jonah Williams" & CapHit == 6280000 & _merge == 2
quietly replace RookieSeason = 2017 if Player == "Jonathan Allen" & CapHit == 20970588 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Jonathan Goff" & CapHit == 590500 & _merge == 2
quietly replace RookieSeason = 2018 if Player == "Jordan Mailata" & CapHit == 11666000 & _merge == 2
quietly replace RookieSeason = 2021 if Player == "Josh Ball" & CapHit == 41667 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Juaquin Iglesias" & CapHit == 405000 & _merge == 2
quietly replace RookieSeason = 2018 if Player == "Justin Jones" & CapHit == 6345000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Justin Tryon" & CapHit == 662250 & _merge == 2
quietly replace RookieSeason = 2001 if Player == "Kareem McKenzie" & CapHit == 7085714 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "Kelvin Beachum" & CapHit == 2557500 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Kenneth Murray" & CapHit == 5410000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Kenyon Coleman" & CapHit == 2345000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Kenyon Coleman" & CapHit == 555000 & _merge == 2
quietly replace RookieSeason = 1999 if Player == "Kevin Faulk" & CapHit == 525000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Kevin Smith" & CapHit == 765000 & _merge == 2
quietly replace RookieSeason = 2021 if Player == "Khyiris Tonga" & CapHit == 1670000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Krys Barnes" & CapHit == 1052500 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Kyle Moore" & CapHit == 216176 & _merge == 2
quietly replace RookieSeason = 2023 if Player == "Kyu Blu Kelly" & CapHit == 152500 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "L'Jarius Sneed" & CapHit == 9520000 & _merge == 2
quietly replace RookieSeason = 2021 if Player == "Landon Dickerson" & CapHit == 5996130 & _merge == 2
quietly replace RookieSeason = 2001 if Player == "Leonard Davis" & CapHit == 540000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Leonard Pope" & CapHit == 725000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Lloyd Cushenberry" & CapHit == 6155000 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Mack Wilson" & CapHit == 3401667 & _merge == 2
quietly replace RookieSeason = 2004 if Player == "Madieu Williams" & CapHit == 540000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Marcus McNeill" & CapHit == 6298588 & _merge == 2
quietly replace RookieSeason = 2017 if Player == "Marcus Williams" & CapHit == 18027918 & _merge == 2
quietly replace RookieSeason = 1993 if Player == "Mark Brunell" & CapHit == 1650000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Martin Rucker" & CapHit == 673425 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Matt Hennessy" & CapHit == 1092500 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Matt McCoy" & CapHit == 710000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Matt Toeaina" & CapHit == 1240000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Maurice Morris" & CapHit == 2125000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Maurice Stovall" & CapHit == 525000 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Maxx Crosby" & CapHit == 30253250 & _merge == 2
quietly replace RookieSeason = 2021 if Player == "Michael Carter" & CapHit == 108611 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Michael Hoecht" & CapHit == 660000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Michael Hoecht" & CapHit == 825000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Michael Hoecht" & CapHit == 940000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Michael Hoecht" & CapHit == 2985000 & _merge == 2
quietly replace RookieSeason = 2016 if Player == "Michael Pierce" & CapHit == 3737000 & _merge == 2
quietly replace RookieSeason = 2016 if Player == "Michael Pierce" & CapHit == 4072000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Michael Toudouze" & CapHit == 56471 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Mike Sims-Walker" & CapHit == 1375000 & _merge == 2
quietly replace RookieSeason = 2021 if Player == "Milo Eifler" & CapHit == 132501 & _merge == 2
quietly replace RookieSeason = 2001 if Player == "Moran Norris" & CapHit == 1677333 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Myron Pryor" & CapHit == 544750 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Myron Pryor" & CapHit == 584750 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Nate Burleson" & CapHit == 2856642 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Nate Burleson" & CapHit == 4031642 & _merge == 2
quietly replace RookieSeason = 2022 if Player == "Nazeeh Johnson" & CapHit == 985000 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Olisaemeka Udoh" & CapHit == 536741 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Olisaemeka Udoh" & CapHit == 716741 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Olisaemeka Udoh" & CapHit == 891741 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Olisaemeka Udoh" & CapHit == 1006741 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Olisaemeka Udoh" & CapHit == 1232500 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Olisaemeka Udoh" & CapHit == 2000000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Ovie Mughelli" & CapHit == 3733333 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Pat Lee" & CapHit == 680000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Phillip Merling" & CapHit == 1180000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Randy McMichael" & CapHit == 810000 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Reggie Hodges" & CapHit == 935000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Richard Quinn" & CapHit == 725000 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "Rishaw  Johnson" & CapHit == 390000 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "Rishaw  Johnson" & CapHit == 395294 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "Rishaw  Johnson" & CapHit == 18000 & _merge == 2
quietly replace RookieSeason = 2012 if Player == "Rishaw  Johnson" & CapHit == 33529 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Ron Bartell" & CapHit == 6612500 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Ron Bartell" & CapHit == 1000000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Ron Brace" & CapHit == 1146000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Ron Brace" & CapHit == 1337000 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Roscoe Parrish" & CapHit == 2345000 & _merge == 2
quietly replace RookieSeason = 2001 if Player == "Russ Hochstein" & CapHit == 1020000 & _merge == 2
quietly replace RookieSeason = 2001 if Player == "Ryan Diem" & CapHit == 2900000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Ryan Pontbriand" & CapHit == 1150000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Ryan Torain" & CapHit == 525000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Sammie Stroughter" & CapHit == 537067 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Sammie Stroughter" & CapHit == 627067 & _merge == 2
quietly replace RookieSeason = 2014 if Player == "Shelby Harris" & CapHit == 2186000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Sheldon Brown" & CapHit == 4000000 & _merge == 2
quietly replace RookieSeason = 2002 if Player == "Sheldon Brown" & CapHit == 5250000 & _merge == 2
quietly replace RookieSeason = 2016 if Player == "Sheldon Rankins" & CapHit == 11705882 & _merge == 2
quietly replace RookieSeason = 2005 if Player == "Sione Pouha" & CapHit == 2450000 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Steve Smith" & CapHit == 2281250 & _merge == 2
quietly replace RookieSeason = 2007 if Player == "Steve Smith" & CapHit == 1843750 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "T.J. Hockenson" & CapHit == 7046176 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Tavares Gooden" & CapHit == 700000 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Tom Zbikowski" & CapHit == 1091667 & _merge == 2
quietly replace RookieSeason = 2021 if Player == "Tommy Togiai" & CapHit == 401667 & _merge == 2
quietly replace RookieSeason = 2019 if Player == "Travis Homer" & CapHit == 2013400 & _merge == 2
quietly replace RookieSeason = 2024 if Player == "Tre'Mon Morris-Brash" & CapHit == 225000 & _merge == 2
quietly replace RookieSeason = 2010 if Player == "Trent Williams" & CapHit == 21614953 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Trevor Laws" & CapHit == 962500 & _merge == 2
quietly replace RookieSeason = 2008 if Player == "Trevor Laws" & CapHit == 540000 & _merge == 2
quietly replace RookieSeason = 2009 if Player == "Troy Nolan" & CapHit == 554565 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Trystan Colon-Castillo" & CapHit == 1727941 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Tully Banta-Cain" & CapHit == 4500000 & _merge == 2
quietly replace RookieSeason = 2006 if Player == "Tyrone Culver" & CapHit == 700000 & _merge == 2
quietly replace RookieSeason = 2003 if Player == "Visanthe Shiancoe" & CapHit == 1200000 & _merge == 2
quietly replace RookieSeason = 2018 if Player == "Zach Sieler" & CapHit == 6252000 & _merge == 2
quietly replace RookieSeason = 2020 if Player == "Zack Moss" & CapHit == 2866176 & _merge == 2

* Record Rookie for players not in cap tables
quietly replace Rookie = 1 if Player == "A.J.  Jenkins" & CapHit == 1263188 & _merge == 2
quietly replace Rookie = 1 if Player == "A.J.  Jenkins" & CapHit == 705797 & _merge == 2
quietly replace Rookie = 1 if Player == "A.J.  Jenkins" & CapHit == 1021594 & _merge == 2
quietly replace Rookie = 1 if Player == "Ace  Sanders" & CapHit == 518282 & _merge == 2
quietly replace Rookie = 1 if Player == "Ace  Sanders" & CapHit == 491811 & _merge == 2
quietly replace Rookie = 0 if Player == "Alex Brown" & CapHit == 3000000 & _merge == 2
quietly replace Rookie = 1 if Player == "Alex Magee" & CapHit == 703750 & _merge == 2
quietly replace Rookie = 1 if Player == "Alex Magee" & CapHit == 788750 & _merge == 2
quietly replace Rookie = 0 if Player == "Alex Singleton" & CapHit == 6913333 & _merge == 2
quietly replace Rookie = 0 if Player == "Andrew Thomas" & CapHit == 19687941 & _merge == 2
quietly replace Rookie = 0 if Player == "Anthony Smith" & CapHit == 685000 & _merge == 2
quietly replace Rookie = 0 if Player == "Austin Deculus" & CapHit == 57222 & _merge == 2
quietly replace Rookie = 0 if Player == "Austin Ekeler" & CapHit == 3170000 & _merge == 2
quietly replace Rookie = 0 if Player == "Austin Jackson" & CapHit == 4262116 & _merge == 2
quietly replace Rookie = 0 if Player == "Ben Leber" & CapHit == 1250000 & _merge == 2
quietly replace Rookie = 0 if Player == "Benton Whitley" & CapHit == 88334 & _merge == 2
quietly replace Rookie = 0 if Player == "Bilal Nichols" & CapHit == 4840000 & _merge == 2
quietly replace Rookie = 0 if Player == "Bradley Chubb" & CapHit == 15813841 & _merge == 2
quietly replace Rookie = 0 if Player == "Brenden Schooler" & CapHit == 1465000 & _merge == 2
quietly replace Rookie = 0 if Player == "Chevis Jackson" & CapHit == 480000 & _merge == 2
quietly replace Rookie = 0 if Player == "Christian Kirk" & CapHit == 24119294 & _merge == 2
quietly replace Rookie = 0 if Player == "Christian McCaffrey" & CapHit == 6329647 & _merge == 2
quietly replace Rookie = 0 if Player == "Christian Wilkins" & CapHit == 10012000 & _merge == 2
quietly replace Rookie = 0 if Player == "Clifton Geathers" & CapHit == 0 & _merge == 2
quietly replace Rookie = 0 if Player == "D'Angelo Ross" & CapHit == 57222 & _merge == 2
quietly replace Rookie = 1 if Player == "Da'Rel Scott" & CapHit == 555000 & _merge == 2
quietly replace Rookie = 0 if Player == "Darian Thompson" & CapHit == 0 & _merge == 2
quietly replace Rookie = 0 if Player == "Darius Harris" & CapHit == 109444 & _merge == 2
quietly replace Rookie = 0 if Player == "Darryl Richard" & CapHit == 330000 & _merge == 2
quietly replace Rookie = 0 if Player == "Dave Tollefson" & CapHit == 520000 & _merge == 2
quietly replace Rookie = 0 if Player == "Dave Tollefson" & CapHit == 1000000 & _merge == 2
quietly replace Rookie = 0 if Player == "David Anderson" & CapHit == 322352 & _merge == 2
quietly replace Rookie = 0 if Player == "David Andrews" & CapHit == 7101470 & _merge == 2
quietly replace Rookie = 0 if Player == "David Diehl" & CapHit == 4500000 & _merge == 2
quietly replace Rookie = 0 if Player == "David Diehl" & CapHit == 3325000 & _merge == 2
quietly replace Rookie = 0 if Player == "David Diehl" & CapHit == 1200000 & _merge == 2
quietly replace Rookie = 0 if Player == "David Veikune" & CapHit == 671816 & _merge == 2
quietly replace Rookie = 1 if Player == "DeWayne Carter" & CapHit == 1021463 & _merge == 2
quietly replace Rookie = 0 if Player == "Deion Branch" & CapHit == 2300000 & _merge == 2
quietly replace Rookie = 0 if Player == "Deion Branch" & CapHit == 1575000 & _merge == 2
quietly replace Rookie = 0 if Player == "Deon Butler" & CapHit == 615000 & _merge == 2
quietly replace Rookie = 0 if Player == "Derek Landri" & CapHit == 735000 & _merge == 2
quietly replace Rookie = 0 if Player == "Derek Landri" & CapHit == 525000 & _merge == 2
quietly replace Rookie = 0 if Player == "Derek Schouman" & CapHit == 525000 & _merge == 2
quietly replace Rookie = 0 if Player == "Devin Aromashodu" & CapHit == 800000 & _merge == 2
quietly replace Rookie = 0 if Player == "Dexter Lawrence" & CapHit == 14340482 & _merge == 2
quietly replace Rookie = 1 if Player == "Dominique Barber" & CapHit == 587000 & _merge == 2
quietly replace Rookie = 0 if Player == "Donald Driver" & CapHit == 5000000 & _merge == 2
quietly replace Rookie = 0 if Player == "Donald Driver" & CapHit == 5000000 & _merge == 2
quietly replace Rookie = 0 if Player == "Donald Lee" & CapHit == 810000 & _merge == 2
quietly replace Rookie = 0 if Player == "Donald Strickland" & CapHit == 575000 & _merge == 2
quietly replace Rookie = 0 if Player == "Drew Coleman" & CapHit == 1333333 & _merge == 2
quietly replace Rookie = 0 if Player == "Eric Frampton" & CapHit == 1033333 & _merge == 2
quietly replace Rookie = 0 if Player == "Eric Heitmann" & CapHit == 2562500 & _merge == 2
quietly replace Rookie = 0 if Player == "Eric Moore" & CapHit == 640000 & _merge == 2
quietly replace Rookie = 0 if Player == "Gabriel Davis" & CapHit == 4494117 & _merge == 2
quietly replace Rookie = 0 if Player == "Gardner Minshew" & CapHit == 7790000 & _merge == 2
quietly replace Rookie = 0 if Player == "Garrett Mills" & CapHit == 640000 & _merge == 2
quietly replace Rookie = 0 if Player == "Geoff Hangartner" & CapHit == 1000000 & _merge == 2
quietly replace Rookie = 0 if Player == "Geoff Hangartner" & CapHit == 1541666 & _merge == 2
quietly replace Rookie = 0 if Player == "George Fant" & CapHit == 3170000 & _merge == 2
quietly replace Rookie = 1 if Player == "Greg Childs" & CapHit == 480146 & _merge == 2
quietly replace Rookie = 0 if Player == "Greg Zuerlein" & CapHit == 1835058 & _merge == 2
quietly replace Rookie = 0 if Player == "H.B. Blades" & CapHit == 525000 & _merge == 2
quietly replace Rookie = 0 if Player == "Hank Fraley" & CapHit == 1066667 & _merge == 2
quietly replace Rookie = 0 if Player == "Hank Fraley" & CapHit == 1066667 & _merge == 2
quietly replace Rookie = 0 if Player == "Haruki Nakamura" & CapHit == 1180833 & _merge == 2
quietly replace Rookie = 0 if Player == "Hjalte Froholdt" & CapHit == 4133413 & _merge == 2
quietly replace Rookie = 0 if Player == "Howard Green" & CapHit == 810000 & _merge == 2
quietly replace Rookie = 1 if Player == "Hunter Nourzad" & CapHit == 874879 & _merge == 2
quietly replace Rookie = 0 if Player == "Isaiah Stanback" & CapHit == 600000 & _merge == 2
quietly replace Rookie = 0 if Player == "Ja'whaun Bentley" & CapHit == 5433333 & _merge == 2
quietly replace Rookie = 0 if Player == "Jabar Gaffney" & CapHit == 2400000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jabrill Peppers" & CapHit == 6610000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jacob Ford" & CapHit == 1300000 & _merge == 2
quietly replace Rookie = 1 if Player == "Jacob Hester" & CapHit == 1408462 & _merge == 2
quietly replace Rookie = 0 if Player == "Jacob Hester" & CapHit == 700000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jake O'Connell" & CapHit == 615000 & _merge == 2
quietly replace Rookie = 0 if Player == "James Conner" & CapHit == 11232560 & _merge == 2
quietly replace Rookie = 0 if Player == "James Farrior" & CapHit == 3825000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jason Spitz" & CapHit == 1750000 & _merge == 2
quietly replace Rookie = 0 if Player == "Javon Hargrave" & CapHit == 8777352 & _merge == 2
quietly replace Rookie = 0 if Player == "Jeremiah Owusu-Koramoah" & CapHit == 3414679 & _merge == 2
quietly replace Rookie = 0 if Player == "Jerious Norwood" & CapHit == 710000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jimmy Wilkerson" & CapHit == 1500000 & _merge == 2
quietly replace Rookie = 0 if Player == "John Beck" & CapHit == 800000 & _merge == 2
quietly replace Rookie = 0 if Player == "John Beck" & CapHit == 540000 & _merge == 2
quietly replace Rookie = 1 if Player == "John Moffitt" & CapHit == 625000 & _merge == 2
quietly replace Rookie = 1 if Player == "John Moffitt" & CapHit == 752500 & _merge == 2
quietly replace Rookie = 1 if Player == "Johnny Knox" & CapHit == 576060 & _merge == 2
quietly replace Rookie = 1 if Player == "Johnny Knox" & CapHit == 51060 & _merge == 2
quietly replace Rookie = 1 if Player == "Johnny Knox" & CapHit == 1260000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jon McGraw" & CapHit == 525000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jonah Williams" & CapHit == 6280000 & _merge == 2
quietly replace Rookie = 0 if Player == "Jonathan Allen" & CapHit == 20970588 & _merge == 2
quietly replace Rookie = 1 if Player == "Jonathan Goff" & CapHit == 590500 & _merge == 2
quietly replace Rookie = 0 if Player == "Jordan Mailata" & CapHit == 11666000 & _merge == 2
quietly replace Rookie = 0 if Player == "Josh Ball" & CapHit == 41667 & _merge == 2
quietly replace Rookie = 0 if Player == "Juaquin Iglesias" & CapHit == 405000 & _merge == 2
quietly replace Rookie = 0 if Player == "Justin Jones" & CapHit == 6345000 & _merge == 2
quietly replace Rookie = 1 if Player == "Justin Tryon" & CapHit == 662250 & _merge == 2
quietly replace Rookie = 0 if Player == "Kareem McKenzie" & CapHit == 7085714 & _merge == 2
quietly replace Rookie = 0 if Player == "Kelvin Beachum" & CapHit == 2557500 & _merge == 2
quietly replace Rookie = 0 if Player == "Kenneth Murray" & CapHit == 5410000 & _merge == 2
quietly replace Rookie = 0 if Player == "Kenyon Coleman" & CapHit == 2345000 & _merge == 2
quietly replace Rookie = 0 if Player == "Kenyon Coleman" & CapHit == 555000 & _merge == 2
quietly replace Rookie = 0 if Player == "Kevin Faulk" & CapHit == 525000 & _merge == 2
quietly replace Rookie = 0 if Player == "Kevin Smith" & CapHit == 765000 & _merge == 2
quietly replace Rookie = 0 if Player == "Khyiris Tonga" & CapHit == 1670000 & _merge == 2
quietly replace Rookie = 0 if Player == "Krys Barnes" & CapHit == 1052500 & _merge == 2
quietly replace Rookie = 0 if Player == "Kyle Moore" & CapHit == 216176 & _merge == 2
quietly replace Rookie = 0 if Player == "Kyu Blu Kelly" & CapHit == 152500 & _merge == 2
quietly replace Rookie = 0 if Player == "L'Jarius Sneed" & CapHit == 9520000 & _merge == 2
quietly replace Rookie = 0 if Player == "Landon Dickerson" & CapHit == 5996130 & _merge == 2
quietly replace Rookie = 0 if Player == "Leonard Davis" & CapHit == 540000 & _merge == 2
quietly replace Rookie = 0 if Player == "Leonard Pope" & CapHit == 725000 & _merge == 2
quietly replace Rookie = 0 if Player == "Lloyd Cushenberry" & CapHit == 6155000 & _merge == 2
quietly replace Rookie = 0 if Player == "Mack Wilson" & CapHit == 3401667 & _merge == 2
quietly replace Rookie = 0 if Player == "Madieu Williams" & CapHit == 540000 & _merge == 2
quietly replace Rookie = 0 if Player == "Marcus McNeill" & CapHit == 6298588 & _merge == 2
quietly replace Rookie = 0 if Player == "Marcus Williams" & CapHit == 18027918 & _merge == 2
quietly replace Rookie = 0 if Player == "Mark Brunell" & CapHit == 1650000 & _merge == 2
quietly replace Rookie = 1 if Player == "Martin Rucker" & CapHit == 673425 & _merge == 2
quietly replace Rookie = 0 if Player == "Matt Hennessy" & CapHit == 1092500 & _merge == 2
quietly replace Rookie = 0 if Player == "Matt McCoy" & CapHit == 710000 & _merge == 2
quietly replace Rookie = 0 if Player == "Matt Toeaina" & CapHit == 1240000 & _merge == 2
quietly replace Rookie = 0 if Player == "Maurice Morris" & CapHit == 2125000 & _merge == 2
quietly replace Rookie = 0 if Player == "Maurice Stovall" & CapHit == 525000 & _merge == 2
quietly replace Rookie = 0 if Player == "Maxx Crosby" & CapHit == 30253250 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Carter" & CapHit == 108611 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Hoecht" & CapHit == 660000 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Hoecht" & CapHit == 825000 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Hoecht" & CapHit == 940000 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Hoecht" & CapHit == 2985000 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Pierce" & CapHit == 3737000 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Pierce" & CapHit == 4072000 & _merge == 2
quietly replace Rookie = 0 if Player == "Michael Toudouze" & CapHit == 56471 & _merge == 2
quietly replace Rookie = 0 if Player == "Mike Sims-Walker" & CapHit == 1375000 & _merge == 2
quietly replace Rookie = 0 if Player == "Milo Eifler" & CapHit == 132501 & _merge == 2
quietly replace Rookie = 0 if Player == "Moran Norris" & CapHit == 1677333 & _merge == 2
quietly replace Rookie = 1 if Player == "Myron Pryor" & CapHit == 544750 & _merge == 2
quietly replace Rookie = 1 if Player == "Myron Pryor" & CapHit == 584750 & _merge == 2
quietly replace Rookie = 0 if Player == "Nate Burleson" & CapHit == 2856642 & _merge == 2
quietly replace Rookie = 0 if Player == "Nate Burleson" & CapHit == 4031642 & _merge == 2
quietly replace Rookie = 0 if Player == "Nazeeh Johnson" & CapHit == 985000 & _merge == 2
quietly replace Rookie = 1 if Player == "Olisaemeka Udoh" & CapHit == 536741 & _merge == 2
quietly replace Rookie = 1 if Player == "Olisaemeka Udoh" & CapHit == 716741 & _merge == 2
quietly replace Rookie = 1 if Player == "Olisaemeka Udoh" & CapHit == 891741 & _merge == 2
quietly replace Rookie = 1 if Player == "Olisaemeka Udoh" & CapHit == 1006741 & _merge == 2
quietly replace Rookie = 0 if Player == "Olisaemeka Udoh" & CapHit == 1232500 & _merge == 2
quietly replace Rookie = 0 if Player == "Olisaemeka Udoh" & CapHit == 2000000 & _merge == 2
quietly replace Rookie = 0 if Player == "Ovie Mughelli" & CapHit == 3733333 & _merge == 2
quietly replace Rookie = 0 if Player == "Pat Lee" & CapHit == 680000 & _merge == 2
quietly replace Rookie = 1 if Player == "Phillip Merling" & CapHit == 1180000 & _merge == 2
quietly replace Rookie = 0 if Player == "Randy McMichael" & CapHit == 810000 & _merge == 2
quietly replace Rookie = 0 if Player == "Reggie Hodges" & CapHit == 935000 & _merge == 2
quietly replace Rookie = 0 if Player == "Richard Quinn" & CapHit == 725000 & _merge == 2
quietly replace Rookie = 1 if Player == "Rishaw  Johnson" & CapHit == 390000 & _merge == 2
quietly replace Rookie = 1 if Player == "Rishaw  Johnson" & CapHit == 395294 & _merge == 2
quietly replace Rookie = 1 if Player == "Rishaw  Johnson" & CapHit == 18000 & _merge == 2
quietly replace Rookie = 1 if Player == "Rishaw  Johnson" & CapHit == 33529 & _merge == 2
quietly replace Rookie = 0 if Player == "Ron Bartell" & CapHit == 6612500 & _merge == 2
quietly replace Rookie = 0 if Player == "Ron Bartell" & CapHit == 1000000 & _merge == 2
quietly replace Rookie = 1 if Player == "Ron Brace" & CapHit == 1146000 & _merge == 2
quietly replace Rookie = 1 if Player == "Ron Brace" & CapHit == 1337000 & _merge == 2
quietly replace Rookie = 0 if Player == "Roscoe Parrish" & CapHit == 2345000 & _merge == 2
quietly replace Rookie = 0 if Player == "Russ Hochstein" & CapHit == 1020000 & _merge == 2
quietly replace Rookie = 0 if Player == "Ryan Diem" & CapHit == 2900000 & _merge == 2
quietly replace Rookie = 0 if Player == "Ryan Pontbriand" & CapHit == 1150000 & _merge == 2
quietly replace Rookie = 0 if Player == "Ryan Torain" & CapHit == 525000 & _merge == 2
quietly replace Rookie = 1 if Player == "Sammie Stroughter" & CapHit == 537067 & _merge == 2
quietly replace Rookie = 1 if Player == "Sammie Stroughter" & CapHit == 627067 & _merge == 2
quietly replace Rookie = 0 if Player == "Shelby Harris" & CapHit == 2186000 & _merge == 2
quietly replace Rookie = 0 if Player == "Sheldon Brown" & CapHit == 4000000 & _merge == 2
quietly replace Rookie = 0 if Player == "Sheldon Brown" & CapHit == 5250000 & _merge == 2
quietly replace Rookie = 0 if Player == "Sheldon Rankins" & CapHit == 11705882 & _merge == 2
quietly replace Rookie = 0 if Player == "Sione Pouha" & CapHit == 2450000 & _merge == 2
quietly replace Rookie = 0 if Player == "Steve Smith" & CapHit == 2281250 & _merge == 2
quietly replace Rookie = 0 if Player == "Steve Smith" & CapHit == 1843750 & _merge == 2
quietly replace Rookie = 0 if Player == "T.J. Hockenson" & CapHit == 7046176 & _merge == 2
quietly replace Rookie = 0 if Player == "Tavares Gooden" & CapHit == 700000 & _merge == 2
quietly replace Rookie = 0 if Player == "Tom Zbikowski" & CapHit == 1091667 & _merge == 2
quietly replace Rookie = 0 if Player == "Tommy Togiai" & CapHit == 401667 & _merge == 2
quietly replace Rookie = 0 if Player == "Travis Homer" & CapHit == 2013400 & _merge == 2
quietly replace Rookie = 1 if Player == "Tre'Mon Morris-Brash" & CapHit == 225000 & _merge == 2
quietly replace Rookie = 0 if Player == "Trent Williams" & CapHit == 21614953 & _merge == 2
quietly replace Rookie = 1 if Player == "Trevor Laws" & CapHit == 962500 & _merge == 2
quietly replace Rookie = 0 if Player == "Trevor Laws" & CapHit == 540000 & _merge == 2
quietly replace Rookie = 1 if Player == "Troy Nolan" & CapHit == 554565 & _merge == 2
quietly replace Rookie = 0 if Player == "Trystan Colon-Castillo" & CapHit == 1727941 & _merge == 2
quietly replace Rookie = 0 if Player == "Tully Banta-Cain" & CapHit == 4500000 & _merge == 2
quietly replace Rookie = 0 if Player == "Tyrone Culver" & CapHit == 700000 & _merge == 2
quietly replace Rookie = 0 if Player == "Visanthe Shiancoe" & CapHit == 1200000 & _merge == 2
quietly replace Rookie = 0 if Player == "Zach Sieler" & CapHit == 6252000 & _merge == 2
quietly replace Rookie = 0 if Player == "Zack Moss" & CapHit == 2866176 & _merge == 2

drop if _merge == 1
drop _merge
gsort Season Team Player Position -CapHit
gen Cap = .
replace Cap = 120375000 if Season == 2011
replace Cap = 120600000 if Season == 2012
replace Cap = 123600000 if Season == 2013
replace Cap = 133000000 if Season == 2014
replace Cap = 143280000 if Season == 2015
replace Cap = 155270000 if Season == 2016
replace Cap = 167000000 if Season == 2017
replace Cap = 177200000 if Season == 2018
replace Cap = 188200000 if Season == 2019
replace Cap = 198200000 if Season == 2020
replace Cap = 182500000 if Season == 2021
replace Cap = 208200000 if Season == 2022
replace Cap = 224800000 if Season == 2023
replace Cap = 255400000 if Season == 2024
format Cap %11.0g
label variable Cap "Cap"
order Season Team Player Position CapHit ContractAverage Cap ContractLength RookieSeason Rookie
quietly recol, full
save "C:/Users/Owner/OneDrive/Documents/Georgetown University/Thesis Writer/Research/QB Worth/Season Analysis/Data DID 9 Merge Overall.dta", replace