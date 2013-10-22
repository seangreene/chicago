# set the working directory
setwd('~/dataviz-fall-2013/chicago/')

# store tsv data into a variable
guns <- read.delim('assets/county-data.txt')

# cleanup those header names, (scratch this, it overwrote a row of data, hardcoded the headers in actual file)
# names(guns) < - c('county', 'guns')

# we need to convert those gun stats into numbers
guns$guns <- as.numeric(guns$guns)

# what is the max?
max(guns$guns)

# ah, we came across a problem.... I'd seen some counties with over 1,000 but the max is only 127? Might have to do with the commas. Let's try this again...
guns <- read.delim('assets/county-data.txt')
guns$guns <- as.numeric(gsub(",", "", guns$guns))
max(guns$guns)

# much better... but I'd like to make a county based map, I'll need fips codes... [google search. . . and found at http://quickfacts.census.gov/qfd/download/FIPS_CountyName.txt]
# let's bring that data in and merge the stuff
fips <- read.delim('assets/fips_counties.txt')

# make sure those fips numbers are numbers
fips$fips <- as.numeric(fips$fips)

# match counties, but since in the guns the counties are uppercase and in fips, they are lowercase, lets make the lowercase uppercase
fips$county <- toupper(fips$county)
match(fips$county, guns$county)

# there's somethign wrong with the data because there is an unusual amount of counties not matching, issue is that in one file there is string that says "county" for all the counties, fixing by batch removing and checking if they appear in the other file.
# new attempt after cleanup
match(fips$county, guns$county)
# success!

#