# Function structure and use
# Feb 25 2020
# JLW


# -------------------------------------------------------------------------

# everything in R is a function
sum(3,2) # 'prefix' function
3 + 2    # an 'operator,' but it is actually a function
`+`(3,2) # rewritten as an 'infix' function

y <- 3
print(y)
`<-`(yy, 3)
print(yy)

# to see contents of a function, print it
print(read.table) # Will show all of the code underlying a function

sd         # print function
sd(c(3,2)) # call function with parameters
sd()       # call function without inputs - throws errow (but not all functions)


# The anatomy of a user-defined function ----------------------------------

function_name <- function(par_x = default_x, # provide a default value for variables # first give variable names, then default values
                          par_y = default_y,
                          par_z = default_z){
  # function body
  # lines of r code and annotation
  # may call other functions inside
  # can create functions inside functions
  # create local variables
  
  return(z) # returns from the function a single element
}

function_name
function_name()

# things to consider with functions
# use prominent hash fenching around your function code
# give a header with function name, description of input and output
# names inside functions can be short
# functions should be short and simple, no more than 1 screen of text
# if too complex, break into multiple functions
# provide default values for all input parameters
# make default values from random number generators

######################################################
# FUNCTION: hardy_weinberg
# input: an allele frequency p (0, 1)
# output: p and the frequencies of genotypes AA AB BB

# -------------------------------------------------------------------------

hardy_weinberg <- function(p = runif(1)){
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p = p, f_AA = f_AA, f_AB = f_AB, f_BB = f_BB)
  return(vec_out)
}
######################################################

hardy_weinberg() # this runs it with the random p default
hardy_weinberg(p = 0.5)
pp <- 0.6
hardy_weinberg(p = pp)
print(pp)
print(hardy_weinberg(p = pp))

######################################################
# FUNCTION: hardy_weinberg2
# input: an allele frequency p (0, 1)
# output: p and the frequencies of genotypes AA AB BB

# -------------------------------------------------------------------------

hardy_weinberg2 <- function(p = runif(1)){
  if(p > 1.0 | p < 0.0){
    return("Function failure: p must be <= 1 and >= 0")
  }
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p = p, f_AA = f_AA, f_AB = f_AB, f_BB = f_BB)
  return(vec_out)
}
######################################################
hardy_weinberg(1.1) # runs but doesn't work for the task
hardy_weinberg2(1.1)
z <- hardy_weinberg2(1.1) # doesn't throw an error
print(z) #shows you the error

# use 'stop' for true error trapping

######################################################
# FUNCTION: hardy_weinberg3
# input: an allele frequency p (0, 1)
# output: p and the frequencies of genotypes AA AB BB

# -------------------------------------------------------------------------

hardy_weinberg3 <- function(p = runif(1)){
  if(p > 1.0 | p < 0.0){
    stop("Function failure: p must be <= 1 and >= 0")
  }
  q <- 1 - p
  f_AA <- p^2
  f_AB <- 2*p*q
  f_BB <- q^2
  vec_out <- list(p = p, f_AA = f_AA, f_AB = f_AB, f_BB = f_BB)
  return(vec_out)
}
######################################################

hardy_weinberg3(1.1) # says error, then gives our assigned message
z <- hardy_weinberg3(1.1) #gives error even with assignment

# -------------------------------------------------------------------------

# global variables: visible in all parts of the code, declared in main
# body of program

# local variables: visible only within the function; either declared
# in the function or passed to it through input parameters

# functions can "see" variables in global environment
# global environment can't "see" variables in function

# example:

my_func <- function(a = 3, b = 4){
  z <- a + b
  return(z)
}

my_func()

my_func_bad <- function(a = 3){
  z <- a + b
  return(z)
}

my_func_bad() # error message, looking for b (in local 1st, then global)
b <- 100
my_func_bad() # works now because b is in global ## don't do this ##

my_func_ok <- function(a = 3){
  bb <- 100
  z <- a + bb
  return(z)
}
my_func_ok() # runs fine
print(bb) # error, because bb does not exist in global env.

###########################################################
# FUNCTION: fit_linear
# fits simple regression line
# inputs: numeric vectors of predictor x, response y
# output: slope and p-value
# -------------------------------------------------------------------------
fit_linear <- function(x = runif(20), y = runif(20)){
  my_mod <- lm(y ~ x)
  my_out <- list(slope = summary(my_mod)$coefficients[2,1],
                 p_val = summary(my_mod)$coefficients[2,4])
  plot(x = x, y = y)
  return(my_out)
}
# -------------------------------------------------------------------------
fit_linear()

# create slightly more complex input value

###########################################################
# FUNCTION: fit_linear2
# fits simple regression line
# inputs: numeric vectors of predictor x, response y
# output: slope and p-value
# -------------------------------------------------------------------------
fit_linear2 <- function(p = NULL){
  if(is.null(p)){
    p <- list(x = runif(20), y = runif(20))
  }
  my_mod <- lm(p$y ~ p$x)
  my_out <- list(slope = summary(my_mod)$coefficients[2,1],
                 p_val = summary(my_mod)$coefficients[2,4])
  plot(x = p$x, y = p$y)
  return(my_out)
}
# -------------------------------------------------------------------------
fit_linear2()
my_pars <- list(x = 1:10, y = runif(10))
fit_linear2(my_pars)

# use do.call to pass a list of parameters to a function
z <- c(runif(99), NA)
mean(z)
mean(x = z, na.rm = TRUE)
mean(x = z, na.rm = TRUE, trim = 0.05) # removes extreme values
my_list <- list(x = z, na.rm = TRUE, trim = 0.05)
mean(my_list) # doesn't work, because list
do.call(mean, my_list) # this asks for function , then list of parameters



















