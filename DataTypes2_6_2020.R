# more functions and tricks with atomic vectors
# Feb 6 2020
# JLW

# -------------------------------------------------------------------------

# create empty vector specify its mode and length
z <- vector(mode = 'numeric', length = 0)
z <- c(z, 5)
print(z)
# dynamic sizing: don't do this! (because it's slow in loops)

# preallocate space to a vector
z <- rep(0, 100)
head(z)
# fill with NA
z <- rep(NA, 100)
head(z)

typeof(z)
z[1] <- "Washington"
typeof(z)

v_size <- 100
my_vector <- runif(v_size)
my_names <- paste("Species", seq(1:length(my_vector)), sep = "")
head(my_names)
names(my_vector) <- my_names
head(my_vector)

# rep function for repeating elements
rep(0.5, 6)
rep(x = 0.5, times = 6)
my_vec <- c(1, 2, 3)
rep(x = my_vec, times = 2)
rep(x = my_vec, each = 2)
rep(x = my_vec, times = my_vec)
rep(x = my_vec, each = my_vec)

# using seq to create regular sequences
seq(from = 2, to = 4)
2:4 #called inline function
`:`(2,4) # the colon is your function
seq(from = 2, to = 4, by = 0.5)
x <- seq(from = 2, to = 4, length = 7)
print(x)
my_vec <- 1:length(x)
print(my_vec)
seq_along(my_vec) # same as asking for length, but faster than length(x)

# using random number generator
runif(5)
runif(n = 5, min = 100, max = 110)

# rnorm for normal distribution
rnorm(6)
rnorm(n = 5, mean = 100, sd = 30)

library(ggplot2)
z <- runif(1000)
qplot(x = z)
z <- rnorm(1000)
qplot(x = z)

# use sample function to draw random values from an existing vector
long_vec <- seq_len(10)
print(long_vec)
sample(x = long_vec) #just shuffles them
sample(x = long_vec, size = 3) #default is without replacement
sample(x = long_vec, size = 16, replace = TRUE)
my_weights <- c(rep(20, 5), rep(20, 5))
print(my_weights)
sample(x = long_vec, replace = TRUE, prob = my_weights)

# techniques for subsetting atomic vectors

z <- c(3.1, 9.2, 1.3, 0.4, 7.5)

# subset with positive index values
z[c(2,3)]

# subset with negative values
z[-c(1,5)]

# create a logical vector of conditions for subsetting
z[z < 3]

tester <- z < 3
print(tester)
z[tester]

# which function to find slots
which(z < 3)
z[which(z < 3)]

# use length for relative positioning
z[-c(length(z):(length(z)-2))] #pull out first two elements

# subset named vector elements
names(z) <- letters[1:5]
print(z)
z[c("b", "b")]

# relational operators
# < less than
# > greater than
# <= less than or equal
# >= greater than or equal
# == equal

# logical operators
# ! NOT
# & and (vector)
# | or (vector)
# xor(a,b) a or b, but not a and b
# && and (first element of vector only)
# || or (first element of vector only)

x <- 1:5
y <- c(1:3, 7, 7)
x == 2
x != 2

x == 1 & y == 7
x == 1 | y == 7
x == 3 | y == 3 #third element of both
xor(x == 3, y == 3) #is both, not one or the other
x == 3 && y == 3

# subscripting with missing values
set.seed(90)#repeatable random numbers
z <- runif(10)
z <- round(z, 3)
print(z)
z < 0.5
z[z < 0.5]
which(z < 0.5)
z[which(z < 0.5)]
zD <- c(z, NA, NA)
zD[zD < 0.5] # includes NAs
zD[which(zD < 0.5)] # drops NAs



