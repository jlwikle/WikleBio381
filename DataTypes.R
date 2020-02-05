# Basic examples of data types and their uses
# February 4, 2020
# JLW


# -------------------------------------------------------------------------

# Using the assgnment operator
x <- 5 # preferred
y = 4 # legal but not used except in function defaults
y = y + 1
y <- y + 1
y
print(y) # should use print() instead of just the variable

# -------------------------------------------------------------------------

# variable names
z <- 3 # use lower case
plantHeight <- 3 # camel case naming
plant.height <- 3 # avoid periods
plant_height <- 3 # snake case - preferred code (all lower case with_)
. <- 5 # use exclusively for temporary variables

# -------------------------------------------------------------------------

# combine or concatenate function
z <- c(3.2, 5, 5, 6)
print(z)
typeof(z)
is.numeric(z)
is.character(z)

# character variable bracketed by quotes (single or double)

z <- c("perch", "striped bass", "trout")
print(z)
z <- c("this is one 'character string'", "and another")
print(z)

z <- c(c(2, 3), c(4.4, 6))
print(z)
z <- c(TRUE, FALSE, FALSE)
typeof(z)

# -------------------------------------------------------------------------

# Properties of atomic vectors

# has a unique type
typeof(z)
is.logical(z)

# has a specified length
length(z)

# optional names
z <- runif(5)
print(z)
names(z) <- c("chow", 
              "pug",
              "beagle",
              "greyhound",
              "akita")
print(z)
z[3] # single element
z[c(3,4)]
z[c("beagle", "greyhound")]
z[c(3,3,3)]

# add names when variable is first built

z2 <- (c(gold = 3.3, silver = 10, lead = 2))
z2
# reset names
names(z2) <- NULL

# names some elements but not others
names(z2) <- c("copper", "zinc")
print(z2)

# -------------------------------------------------------------------------

# NA for missing data
z <- c(3.2, 3.3, NA)
print(z)
typeof(z)
length(z)
typeof(z[3])
z1 <- NA
typeof(z1)
is.na(z) # boolean to find NA
!is.na(z) # boolean to find NOT NA
mean(z) # can't calculate mean on vector with NA
mean(!is.na(z)) # this code will run, but turned T/F into 0 and 1 so wrong
mean(z[!is.na(z)]) #correct

# Nan, -Inf, Inf from numeric division
z <- 0/0
print(z) # Not a Number
typeof(z)
z <- 1/0
print(z) # Infinitely large
z <- -1/0
print(z) # negative Infinity

# null is nothing
z <- NULL
typeof(z)
length(z)
is.null(z)

# -------------------------------------------------------------------------

# Three features of atomic vectors

# 1. Coercion
# All atomics are of the same type
# If elements are different, R coerces them
# logical -> integer -> double -> character
z <- c(0.1, 5, "O.2")
typeof(z) # R has coerced all of it to characters
print(z)

# use coercion for useful calculations
a <- runif(10)
print(a)
a > 0.5
sum(a > 0.5) # Sums the TRUEs
mean(a > 0.7) # gives proportion of elements that meet that criteria. It adds the TRUEs, then divides by the total

#qualifying exam question:
# in a normal distribution, approximately what percent of observations from a normal (0,1) are larger than 2.0
mean(rnorm(100000) > 2) # 2 sds are 95%, 2.5 leftover at top and bottom

# 2. Vectorization
z <- c(10, 20, 30)
z + 1
z2 <- c(1, 2, 3)
z + z2 # adds up elements one at a time
z^2

# recycling
z <- c(10, 20, 30)
z2 <- c(1, 2)
z + z2
