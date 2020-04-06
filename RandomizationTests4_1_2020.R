# ------------------------------
# Randomization tests
# 01 Apr 2020
# JLW
# ------------------------------
#

# Statistical p is probability of obtaining observed results (or something
# or something more extreme)
# If the null hypothesis were true p(data/H0)
# Null hypothesis is hypothesis of "no effect"
# Variation is caused by measurement error or other unspecified
# and less important sources of varation

# two advantages of randomization test
# -relaxes assumptions of standard parametric tests (normality,balanced 
# sample sizes, common variance)
# -gives a more intuitive understanding of statistical probability

# Steps in randomization test ------------------------------
# 1. Define a metric X as a single number to represent pattern
# 2. Calculate X(obs) the metric for the empirical (observed) data 
# that we start with
# 3. Randomize or reshuffle the data. Randomize in a way that would
# uncouple the association between observed data and their assignment 
# to treatment groups. Ideally, the randomization only affects the
# pattern of treatment effects in the data. Other aspects of the data (such
# as sample sizes) are preserved in the randomization. Simulate 
# the null hypothesis!
# 4. For this single randomization, calculate the x(sim). If H0 is true,
# then x(sim) should be similar to x(obs). If H0 is false, x(obs) is very 
# different than x(sim). 
# 5. Repeat steps (3) and (4) many times (typically n = 1000). This will
# let us visualize as a histogram the distribution of x(sim); distribution of
# x values when H0 is true
# 6. Estimate tail probability of the observed metric (or something more 
# extreme) given the null distribution (p(x(obs))|H0).

# Preliminaries ------------------------------

library(ggplot2)
library(TeachingDemos)

# for repeatable random numbers
set.seed(97)

# does same thing but with any character sequence
char2seed("paper plane")
char2seed("paper plane", set = FALSE)

# if you don't do either one, uses system time:
Sys.time()
# turns into number of seconds or milliseconds
as.numeric(Sys.time())

# keep system time seed:
my_seed <- as.numeric(Sys.time())
set.seed(my_seed)

# for exercise
char2seed("espresso withdrawal")

# toy example ------------------------------

# create treatment groups
trt_group <- c(rep("Control", 4), rep("Treatment", 5))
print(trt_group)

# create response variable
z <- c(runif(4) + 1, runif(5) + 10)
print(z)

# combine vectors in data fram
df <- data.frame(trt = trt_group, res = z)
print(df)

# look at means in the two groups
obs <- tapply(df$res, df$trt, mean)
print(obs)

# create a simulated data set

# set up a new data frame
df_sim <- df
df_sim$res <- sample(df_sim$res) # this will reorder the values
print(df_sim)

# look at the means in two groups of randomized data
obs_sim <- tapply(df_sim$res, df_sim$trt, mean)
print(obs_sim)



































