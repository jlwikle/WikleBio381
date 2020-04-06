# ------------------------------
# Basic anatomy and use of for loops
# 30 Mar 2020
# JLW
# ------------------------------
#
# Anatomy of a for loop

# for (var in seq) { # start of the loop

#body of for loop

# } # end of loop

# var is a counter variable that holds the current value of the counter in the loop
# seq is an integer vector (or vector of character strings that defines
# the starting and ending values of the loop)

# suggest using i, j, k for var (counter)

# how NOT to set up your for loop
my_dogs <- c("chow", "akita", "malamute", "husky", "samoyed")

for(i in my_dogs){
  print(i)
}

# set it up this way instead

for(i in 1:length(my_dogs)){
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

# potential hazard: suppose our vector is empty!
my_bad_dogs <- NULL

for(i in 1:length(my_bad_dogs)){
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

# safer way to code var in the for loop is to use seq_along

for(i in seq_along(my_dogs)){
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

# handles the empty vector correctly
for(i in seq_along(my_bad_dogs)){
  cat("i =", i, "my_bad_dogs[i] =", my_bad_dogs[i], "\n")
}

# could also define vector lengt from a constant
zz <- 5
for(i in seq_len(zz)){
  cat("i =", i, "my_dogs[i] =", my_dogs[i], "\n")
}

# Tips for for loops ------------------------------

# tip #1: do not change object dimensions inside a loop
# avoid these functions (cbind, rbind, c, list)

my_dat <- runif(1)
for(i in 2:10){
  temp <- runif(1)
  my_dat <- c(my_dat, temp) # don't do this!
  cat("loop number =", i, "vector element =", my_dat[i], "\n")
}
print(my_dat)

# tip #2: Don't do things in a loop if you do not need to!

for(i in 1:length(my_dogs)){
  my_dogs[i] <- toupper(my_dogs[i])
  cat("i =", i, "my_dogs[i]", my_dogs[i], "\n")
}
# could have been done without a loop

z <- c("dog", "cat", "pig")
toupper(z)

# tip #3: do not use a loop if you can vectorize!

my_dat <- seq(1:10)
for(i in seq_along(my_dat)){
  my_dat[i] <- my_dat[i] + my_dat[i]^2
  cat("loop number =", i, "vector element =", my_dat[i], "\n")
}

# no loop needed to do this
z <- 1:10
z <- z + z^2
print(z)

# tip #4: understand distinction between counter variable i, and the 
# vector element z[i]

z <- c(10, 2, 4)
for(i in seq_along(z)){
  cat("i =", i, "z[i] =", z[i], "\n")
}

# what is the value of i at the end of the loop?
print(i) # the final value that was assigned to it

# what is the value of z at the end of the loop?
print(z) # it's still the same vector

# tip #5: use next() to skip certain elements in the loop
z <- 1:20
# suppose we want to work only odd-numbered elements?
for(i in seq_along(z)){
  if(i %% 2 == 0) next # %% gives remainder - is it == 0? if so, skip
  print(i)
}

# another method to do the same thing, probably faster

z_sub <- z[z %% 2 != 0]

length(z)
length(z_sub)

for(i in seq_along(z_sub)){
  cat("i =", i, "z_sub[i] =", z_sub[i], "\n")
}

# use break to set up a conditional to break out of a loop early

# create simple random walk population model function

# -------------------------------
# FUNCTION ran_walk
# description: stochastic random walk
# inputs: times = number of time steps
#         n1 = initial population size (=n[1])
#         lambda = finite rate of increase
#         noise_sd = standard deviation of a normal distribuion with
#                    mean = 0 
# outputs: vector n with population sizes > 0
#          until extinction, then NA values
###################################
library(tcltk)
library(ggplot2)
ran_walk <- function(times = 100, 
                     n1 = 50,
                     lambda = 1,
                     noise_sd = 10){
n <- rep(NA, times)  # create output vector
n[1] <- n1 # initialize starting population size
noise <- rnorm(n = times, mean = 0, sd = noise_sd) # random noise vector
for(i in 1:(times - 1)){
  n[i + 1] <- n[i] * lambda + noise[i]
  if(n[i + 1] <= 0){
    n[i + 1] <- NA
    cat("Population extinction at time", i, "\n")
    tkbell()
    break
  } # end of if statement
} # end of for loop
#function body

return(n)

} # end of ran_walk
#--------------------------------

# explore model parameters interactively
# with simple graphics

pop <- ran_walk()
qplot(x = 1:100, y = pop, geom = "line")

# check out performance with no noise
pop <- ran_walk(noise_sd = 0)
qplot(x = 1:100, y = pop, geom = "line")

pop <- ran_walk(noise_sd = 5, lambda = 0.98)
qplot(x = 1:100, y = pop, geom = "line")

# double for loops ------------------------------

m <- matrix(round(runif(20), digits = 2), nrow = 5)

# loop over rows of matrix
for(i in 1:nrow(m)){
  m[i,] <- m[i,] + i
}
print(m)

m <- matrix(round(runif(20), digits = 2), nrow = 5)
# loop over columns
for(j in 1:ncol(m)){
  m[,j] <- m[,j] + j
}
print(m)

# loop over rows and columns with double for loop

m <- matrix(round(runif(20), digits = 2), nrow = 5)
for(i in 1:nrow(m)){# start of outer loop
  for(j in 1:ncol(m)){# start of inner loop
    m[i,j] <- m[i,j] + i + j
    
  } # end of inner loop (columns)
} # end of outer loop (rows)
print(m)





