# Probability distributions
# Feb 18 2020
# JLW
# dist functions
# begin with d is density function
# begin with p is cumulative probability function
# q is quantile function (inverse of p)
# r is random number generator

library(ggplot2)
library(MASS)


# Poisson Distribution ----------------------------------------------------

# discrete 0 to infinity
# only parameter is lambda ( > 0, continuous)
# lambda is constant rate parameter (observations per unit time or unit area)

# d for probability density
hits <- 0:10
myvec <- dpois(x = hits, lambda = 1) # one event per time or area unit
qplot(x = hits, y = myvec, 
      geom = "col", 
      color = I('black'),
      fill = I('honeydew'))

myvec <- dpois(x = hits, lambda = 4.4) 
qplot(x = hits, y = myvec, 
      geom = "col", 
      color = I('black'),
      fill = I('coral1'))
sum(myvec) # sum should always be 1.0 (our example pop is small)

# for a poisson with lambda = 2, 
# what is the probability that a single draw
# will yield a 0
dpois(x = 0, lambda = 2)

# p for cumulative probability
hits <- 0:10
myvec <- ppois(q = hits, lambda = 2)
qplot(x = hits, y = myvec, 
      geom = "col", 
      color = I('black'),
      fill = I('coral1'))

# for poisson with lambda = 2, what is probability that a single random
# draw will yield x <= 1?

ppois(q = 1, lambda = 2)

p1 <- dpois(x = 1, lambda = 2)
print(p1)
p2 <- dpois(x = 0, lambda = 2)
print(p2)
p1 + p2 # same as doing ppois, just manually summing for cumulative value

# q for the inverse of p
qpois(p = 0.5, lambda = 2.5 ) # half of probability

# simulate a poisson to get actual values
ran_pois <- rpois(n = 1000, lambda = 2.5)

qplot(x = ran_pois,
      color = I('black'),
      fill = I('coral1'))

quantile(x = ran_pois, probs = c(0.025, 0.975)) # these cut out 2.5% on either
# end for returning 95% interval


# Binomial Distribution ---------------------------------------------------

# p = probability of a dichotomous outcome (successes in certain no. of trials)
# size = number of trials (eg number of coin flips)
# x = possible outcomes
# outcome x is bounded between 0 and size

# density for binomial
hits <- 0:10
myvec <- dbinom(x = hits, size = 10, prob = 0.5)
qplot(x = hits, y = myvec, 
      geom = "col", 
      color = I('black'),
      fill = I('coral1'))

# what is the probability of getting 5 heads out of 10 tosses?
dbinom(x = 5, size = 10, prob = 0.5) # (exactly 5 heads)

# biased coin
hits <- 0:10
myvec <- dbinom(x = hits, size = 10, prob = 0.005)
qplot(x = hits, y = myvec, 
      geom = "col", 
      color = I('black'),
      fill = I('coral1'))

# p function for tail probability
# probability of 5 or fewer heads out of 10 tosses
pbinom(q = 5, size = 10, prob = 0.5)# 0.623 because size includes a 0
pbinom(q = 4, size = 9, prob = 0.5) # gives 0.5

# what is a 95% confidence interval for 100 trials of a coin with p = 0.7?
qbinom(p = c(0.025, 0.975), size = 100, prob = 0.7) # CI = 61-79

# how does this compare to a sample interval for real data?
my_coins <- rbinom(n = 50, size = 100, prob = 0.5) #100 coins 50 times
qplot(x = my_coins,
      color = I('black'),
      fill = I('coral1'))

# 95% CI for this set of data
quantile(x = my_coins, probs = c(0.025, 0.975)) # = 37.68 - 57.78

# Negative Binomial -------------------------------------------------------

# "slightly more realistic version of the poisson"

# number of failures in a series of Bernouli trials with 
# p = probability of success before a targeted number of successes (= size)
# generats a distribution that is more heterogenous (overdispersed) than Poisson

hits <- 0:40
myvec <- dnbinom(x = hits, size = 5, prob = 0.5) #how many tails will you get 
# before 5 total heads on coin flip?
qplot(x = hits,
      y = myvec,
      geom = 'col',
      color = I('black'),
      fill = I('coral1'))

# geometric series is a special case in which number of successes
# is = 1. each bar is a constant fraction of the one that came before it
# with prob = 1 - p

myvec <- dnbinom(x = hits, size = 1, prob = 0.1)
qplot(x = hits,
      y = myvec,
      geom = 'col',
      color = I('black'),
      fill = I('coral1')) # each successive bar is 90% as high as the bar before
# it. basically q factor

# alternatively specify mean = mu of the distribution and size
# this gives us a poisson with a lambda value that varies
# dispersion parameter is the shape parameter from a gamma distribution
# as it increases, the variance gets smaller

nbi_ran <- rnbinom(n = 1000, size = 0.1, mu = 5)
qplot(nbi_ran, color = I('black'), fill = I('coral1'))










































