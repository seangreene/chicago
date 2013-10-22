# set the working directory
setwd('~/dataviz-fall-2013/chicago/')

# store tsv data into a variable
data <- read.delim('county-data.txt')

# cleanup those header names, (scratch this, it overwrote a row of data, hardcoded the headers in actual file)
# names(data) < - c('county', 'guns')

# we need to convert those gun stats into numbers
data$guns <- as.numeric(data$guns)

# what is the max?
max(data$guns)head(d)

# ah, we came across a problem.... I'd seen some counties with over 1,000 but the max is only 127? Might have to do with the commas. Let's try this again...
data <- read.delim('county-data.txt')
data$guns <- as.numeric(gsub(",", "", data$guns))
max(data$guns)

# much better...

# sean greene here

# did this thing Shavin said to clean the data
library(maptools)

get_second_element <- function(item) {
  return (item[2])
}

get_first_element <- function(item) {
  return (item[1])
}

# load the data
data <- read.delim("http://shancarter.github.io/ucb-dataviz-fall-2013/classes/data-practice/county-data.txt", header=F, stringsAsFactors=F)

# rename it like a human
names(data) <- c("county_orig", "guns_orig")

# split it up based on parenthesis
split <- strsplit(data$county_orig, split="\\(")

# make a new field for state
data$state_clean <- sapply(split, get_second_element)

# clean guns
data$state_clean <- gsub("\\)", "", data$state_clean)

# make a new county
data$county_clean <- sapply(split, get_first_element)

# clean guns
data$guns_clean <- as.numeric(gsub(",", "", data$guns_orig))

#</shavin>

# sean green again / sort data
data <- data[order(data$guns_clean, decreasing=T),]

# let's look at the data
barplot(data$guns_clean)
barplot(head(data$guns_clean))

# so there's a huge split in the data.
#the highest comes from Cook County, Ill., where Chicago is

# load FIPS data
FIPS <- read.csv("US_FIPS_Codes.csv")

# rename FIPS columns
names(FIPS)[2] <- "county_clean"
names(FIPS)[1] <- "state_clean"

# make FIPS and data all lowercase
data = as.data.frame(sapply(data, tolower))
FIPS = as.data.frame(sapply(FIPS, tolower))

# concatenate state and county in data to match column in FIPS
data$composite <- paste(data$state_clean, data$county_clean, sep = "_")

# merge the data
# MERGE NOT WORKING. ONLY MERGES SOME OF THE DATA.
merged <- merge(FIPS, data, by="county_clean", all.x = TRUE)
head(merged)

# NOW DATA ARE READY FOR MAPPING SO GLORIOUS.

install.packages("maptools")
library(maptools)
shapes <- readShapePoly("nyt_county/nyt_county.shp")
# SO BEAUTIFUL
plot(shapes, col=rainbow(1000))

# set some map breaks
map_breaks <- c(1, 10, 25, 100, 1000, 10000)

# Tried to sort into buckets, but received an error message that said merged$guns_clean must be numeric, so i made it numeric
merged$guns_clean <- as.numeric(merged$guns_clean)
buckets <- cut(merged$guns_clean,breaks=map_breaks)
numeric_buckets <- as.numeric(buckets)

# install color brewer
install.packages("RColorBrewer")
library(RColorBrewer)

display.brewer.all()

# I want to make a red map using 9 colors
colors <- brewer.pal(6,"Reds")
colors[numeric_buckets]
plot(shapes, col=colors[numeric_buckets])

