# Manipulating data using dplyr
# Feb 4 2020
# JLW

library(dplyr)

## What is dplyr?
# new-ish package: provides a set of tools for manipulating data
# part of the tidyverse: collection of packages share philosophy, grammar, 
# and data structure
# specifically written to be fast!
# individual functions for most common operations
# easier to figure out what you want to do with your data

#### Core verbs
# filter()                   subsets rows
# arrange()                  arranges data
# select()                   selects columns
# summarize() and group_by() group and summarize data
# mutate()                   creates new columns based on existing data

data(starwars)
class(starwars)

# WHAT IS A TIBBLE?
# modern take on data frames
# keeps great aspects of dataframes and drop frustrating ones: changing variable
# names, changing input type

glimpse(starwars)
head(starwars)

# clean up data
# complete.cases not part of dplyr

starwarsClean <- starwars[complete.cases(starwars[,1:10]),]
is.na(starwarsClean)
anyNA(starwarsClean) # easier than is.na - just returns one answer
anyNA(starwars)

# what does our data look like?
glimpse(starwarsClean)
head(starwarsClean)

# filter(): pick/subset observations by their values
### uses >, >=, <, <=, !=, == for comparisons
### logical operators: & | !
## automatically excludes NAs

# males between 100 and 180 cm
filter(starwarsClean, gender == "male", height < 180, height > 100)# can use 
#commas instead of ampersand, multiple conditions for same variable

# eye color that's blue or brown
filter(starwarsClean, eye_color %in% c("blue", "brown")) # %in% similar to ==

# arrange(): reorders rows

# sort by height in ascending order
arrange(starwarsClean, by = height)

# sort by height in descending order
arrange(starwarsClean, by = desc(height))
#desc() changes order

# by multiple variables
arrange(starwarsClean, height, desc(mass))
#add additional argument to break ties in preceding column

starwars1 <- arrange(starwars, height)
tail(starwars1) #all NAs are dropped to the bottom

# select(): choose variables by their names

# in base R:
starwarsClean[,1:5]

# select with numbers
select(starwarsClean, 1:5)
# select with column names
select(starwarsClean, name:skin_color)
# select to remove variables
select(starwarsClean, -(films:starships))

# rearrange columns
select(starwarsClean, name, gender, species, everything()) # everything() helper
# function useful for moving a couple variables to the beginning
# select by variables containing same string
select(starwarsClean, contains("color"))
# other helpers are ends_with(), starts_with(), matches(), num_range()

## rename columns
select(starwars, haircolor = hair_color, films) # need to list all columns you 
# want to keep
rename(starwarsClean, haircolor = hair_color) # keeps all columns

## mutate: creates new variables with functions of existing variables
mutate(starwarsClean, ratio = height/mass) # can use arithmetic operators

starwars_lbs <- mutate(starwarsClean, mass_lbs = mass * 2.2)# kg to lbs
select(starwars_lbs, 1:3, mass_lbs, everything()) #los to front of dataset

# transmute - same thing but only keeps new variable
transmute(starwarsClean, mass_lbs = mass * 2.2)

## summarize and group_by: collapses values down to a single summary

summarize(starwarsClean, meanHeight = mean(height))

# working with NAs

summarize(starwars, meanHeight = mean(height)) # if any NAs, NA
summarize(starwars, meanHeight = mean(height, na.rm = TRUE))

summarize(starwars, meanHeight = mean(height, na.rm = T), TotalNumber = n())
#n() is another helper function for sample size

# grouped by genders

starwarsGenders <- group_by(starwars, gender)
head(starwarsGenders)

summarize(starwarsGenders, meanHeight = mean(height, na.rm = TRUE), number = n())

## Piping
## used to emphasize a sequence of actions
# takes the output of one statement and makes it the input of the next statement
# don't use if you want to keep intermediate results
## formatting: space before pipe, follow it by new line
# %>% 

starwarsClean %>% 
  group_by(gender) %>% 
  summarize(meanHeight = mean(height),
            number = n())

























