# Exploring continuous distributions
# Feb 20 2020
# JLW

library(ggplot2)
library(MASS)

# Uniform -----------------------------------------------------------------

qplot(x = runif(n = 100, min = 1, max = 6),
                color = I('black'),
                fill = I('coral1'))

# larger sample size makes it look more uniform
qplot(x = runif(n = 1000, min = 1, max = 6),
      color = I('black'),
      fill = I('coral1'))

#this is if want uniform categorial instead of continuous
qplot(x = sample(1:6, size = 1000, replace = TRUE))

# Normal ------------------------------------------------------------------

my_norm <- rnorm(n = 100, mean = 100, sd = 2)
qplot(x = my_norm,
      color = I('black'),
      fill = I('coral1'))

# problems with normal when mean is small
my_norm <- rnorm(n = 100, mean = 2, sd = 2)
qplot(x = my_norm,
      color = I('black'),
      fill = I('coral1'))
# plot gives you values less than 0
toss_zeroes <- my_norm[my_norm > 0]
qplot(x = toss_zeroes,
      color = I('black'),
      fill = I('coral1'))
mean(toss_zeroes)# mean is now higher than 2
sd(toss_zeroes)# sd is now lower than 2
# the correct way to solve this is to use a dist. that doesn't have -values...

# Gamma -------------------------------------------------------------------

# use for continuous data greater than 0
my_gamma <- rgamma(n = 100, shape = 1, scale = 10)
qplot(x = my_gamma,
      color = I('black'),
      fill = I('coral1'))

# gamma with shape = 1 is exponential dist. with scale = mean
my_gamma <- rgamma(n = 100, shape = 1, scale = 0.1)
qplot(x = my_gamma,
      color = I('black'),
      fill = I('coral1'))

# increase shape parameter distribution looks more normal
my_gamma <- rgamma(n = 100, shape = 20, scale = 1)
qplot(x = my_gamma,
      color = I('black'),
      fill = I('coral1'))

# scale parameter changes both mean and variance!
# mean = shape * scale
# variance = shape * scale^2

# Beta --------------------------------------------------------------------

# continuous, but bounded by 0 and 1
# analagous to the binomial, but with a continuous distribution 
# of possible values

# p(data | parameters)
# p(parameters | data) = maximum likelihood estimator of the parameters

# shape1 = number of successes + 1
# shape2 = number of failures + 1
# You have flipped a coin a number of times and have a certain number of answers
# This predicts what your next coin flip would be

my_beta <- rbeta(n = 1000, shape1 = 5, shape2 = 5)
qplot(x = my_beta,
      color = I('black'),
      fill = I('coral1'))

my_beta <- rbeta(n = 1000, shape1 = 50, shape2 = 50)
qplot(x = my_beta,
      color = I('black'),
      fill = I('coral1'))

# beta with 3 heads and no tails
my_beta <- rbeta(n = 1000, shape1 = 4, shape2 = 1) # 3+1, 0+1
qplot(x = my_beta,
      color = I('black'),
      fill = I('coral1')) # ~80% chance of heads

# with no preexisting probability, distribution looks nearly uniform
my_beta <- rbeta(n = 1000, shape1 = 1, shape2 = 1)
qplot(x = my_beta,
      color = I('black'),
      fill = I('coral1'))

# add one coin flip, distribution starts to shift to one side
my_beta <- rbeta(n = 1000, shape1 = 2, shape2 = 1)
qplot(x = my_beta,
      color = I('black'),
      fill = I('coral1'))

# shape and scale parameters < 1 gives u-shaped distribution
my_beta <- rbeta(n = 1000, shape1 = 0.2, shape2 = 0.1)
qplot(x = my_beta,
      color = I('black'),
      fill = I('coral1'))

# can rescale any variable to 0 - 1 to work with beta dist.

# Estimate parameters from data -------------------------------------------

x <- rnorm(1000, mean = 92.5, sd = 2.5)
qplot(x = x,
      color = I('black'),
      fill = I('coral1'))
fitdistr(x, "normal") # needs vector of numbers and specified distribution
# takes data you put in and estimates parameters of distributions
# below values shows measure of confidence in these estimates

#BUT we don't know that a given dataset is normal
fitdistr(x, "gamma")
x_sim <- rgamma(n = 1000, shape = 1418, rate = 15)
qplot(x = x_sim,
      color = I('black'),
      fill = I('coral1')) # looks similar to our normal






































