# dplyr II
# Mar 5 2020
# JLW

# Exporting and importing data
library(dplyr)
data(starwars)

starwars1 <- select(starwars, name:species)

## write.table function
write.table(starwars1, file = "StarwarsNamesInfo.csv", row.names = FALSE, sep = ",")

## read in data
data <- read.csv(file = "StarwarsNamesInfo.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE, comment.char = "#") #comment.char tells it to ignore #
head(data)

data <- read.table(file = "StarwarsNamesInfo.csv", header = TRUE, sep = ",", stringsAsFactors = FALSE) #read.table doesn't need comment.char, just ignores
head(data)

class(data)
# can turn df to tibble
data <- as_tibble(data)
glimpse(data)
class(data)

## If only working in R
# saveRDS()
saveRDS(starwars1, file = "StarWarsTibble") # saves R object as file into directory

sw <- readRDS("StarWarsTibble") # restores the R object
head(sw)

# more dplyr --------------------------------------------------------------

glimpse(sw)

## count of NAs
sum(is.na(sw)) #not a dplyr function
# but tells us how many NAs are in whole df

## count of non-NAs
sum(!is.na(sw))

swSp <- sw %>% 
  group_by(species) %>% 
  arrange(desc(mass))
  
# determine sample
swSp %>% 
  summarise(avgMass = mean(mass, na.rm = TRUE), 
            avgHt = mean(height, na.rm = TRUE),
            n = n())

# filter out obs with low sample size
swSp %>% 
  summarise(avgMass = mean(mass, na.rm = TRUE), 
            avgHt = mean(height, na.rm = TRUE),
            n = n()) %>% 
filter(n >= 2) %>% 
  arrange(desc(n)) # from largest to smallest sample size

# count helper
swSp %>% 
  count(eye_color) # gives number of individuals with given eye color

# data are already grouped by species from above

swSp %>% 
  count(wt = height) # sum of all heights by species


# useful summary functions
# use base R functions a lot as well

starwarsSummary <- swSp %>% 
  summarise(avgHeight = mean(height, na.rm = T),
            medHeight = median(height, na.rm = T),
            height_sd = sd(height, na.rm = T),
            height_IQR = IQR(height, na.rm = T),
            min_height = min(height, na.rm = T),
            first_height = first(height),
            n = n(),
            n_eyecolors = n_distinct(eye_color)) %>% 
  filter(n > = 2) %>% 
  arrange(desc(n))



# grouping multiple variables ---------------------------------------------
# and ungroup them

sw2 <- sw[complete.cases(sw),]

#grouped by species and hair color
sw2groups <- group_by(sw2, species, hair_color)

summarise(sw2groups, n = n())

# plus gender
sw3groups <- group_by(sw2, species, hair_color, gender)
summarise(sw3groups, n = n())

# ungrouping
sw3groups %>% 
  ungroup() %>% 
  summarise(n = n())


# grouping with mutate ----------------------------------------------------

# ex. standardize within groups

sw3 <- sw2 %>% 
  group_by(species) %>% 
  mutate(prop_height = height/sum(height)) %>% 
  select(species, height, prop_height)

#arrange by alphabetical order of species
sw3 %>% 
  arrange(species)


# pivot_longer function ---------------------------------------------------

# compare to gather() and spread()
# as replacement to gather and spread!

TrtA <- rnorm(n = 20, mean = 50, sd = 10)
TrtB <- rnorm(n = 20, mean = 45, sd = 10)
TrtC <- rnorm(n = 20, mean = 62, sd = 10)
z <- data.frame(TrtA, TrtB, TrtC)
library(tidyr)

# old code# long_z <- gather(z, Treatment, Data, TrtA:TrtC)

# now
z2 <- z %>% 
  pivot_longer(TrtA:TrtC, names_to = "Treatment", values_to = "Data")
# names_to = column name of category
# values to = column name of value

# pivot_wider uses names_from and values_from

vignette("pivot") #brings up vignette that talks about it












