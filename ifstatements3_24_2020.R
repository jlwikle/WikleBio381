# ------------------------------
# Booleans and if/else control structures
# 24 Mar 2020
# JLW
# ------------------------------
#
# review of boolean operators ------------------------------

# simple inequality
# uses logical operators
5 > 3 # spits out true
5 < 3 # spits out false
5 >= 5 # TRUE
5 <= 5 # TRUE
5 == 3 # makes sure to use ==
5 != 3

# compound statements use  & or |

# use  & for AND
FALSE & FALSE #returns FALSE
FALSE & TRUE #returns FALSE
TRUE & TRUE #returns TRUE
5 > 3 & 1 != 2 #returns TRUE
1 == 2 & 1 != 2 #returns FALSE

# use | for OR
FALSE | FALSE #returns FALSE
FALSE | TRUE #returns TRUE
TRUE | TRUE #returns TRUE
1 == 2 | 1 != 2 #returns TRUE

# boolean operators work with vectors

1:5 > 3 #returns FALSE FALSE FALSE  TRUE  TRUE

a <- 1:10
b <- 10:1

a > 4 & b > 4 #returns FALSE FALSE FALSE FALSE  TRUE  TRUE FALSE FALSE
# FALSE FALSE

sum(a > 4 & b > 4) # coerces booleans to numeric values
# = 2 for 2 TRUES

# "long" form evaluates only the first element

a < 4 & b > 4 # evaluates all elements and gives vector of T/F
a < 4 && b > 4 # evaluates only the first comparison that gives a boolean

## also for OR ||

# vector result
a < 4 | b > 4

# single boolean result
a < 4 || b > 4

## xor for exclusive OR testing of vectors
# works for (TRUE FALSE) but not for (FALSE FALSE) or (TRUE TRUE)

a <- c(0, 0, 1)
b <- c(0, 1, 1)
xor(a,b) # returns FALSE TRUE FALSE
# 0-0 gives false, 0-1 gives TRUE, 1-1 gives FALSE

# by comparison with ordinary |

a | b # returns FALSE TRUE TRUE
# (TRUE TRUE) gives TRUE here instead of FALSE

# Set operations ------------------------------

# boolean algebra on sets of atomic vectors (numeric, logical, character)
# equivalent of drawing Venn diagrams

a <- 1:7
b <- 5:10

# union to get all elements (OR for set)
union(a,b) # both vectors including what they have in common
# returns 1  2  3  4  5  6  7  8  9 10

# intersection to get common elements (AND for set)
intersect(a, b)
# returns 5 6 7

# setdiff to get distinct elements in a
setdiff(a,b) # elements in a, NOT b
# returns 1 2 3 4
setdiff(b, a) # elements in b, NOT a
# returns 8  9 10

# setequal to check for identical elements
setequal(a,b) # FALSE

## more generally, to compare any two objects
z <- matrix(1:12, nrow = 4, byrow = TRUE)
z1 <- matrix(1:12, nrow = 4, byrow = FALSE)

# this just compares element by element:
z == z1

# single boolean for whole set:
identical(z, z1) # FALSE
z1 <- z
identical(z, z1) # TRUE

# most useful in if statements is %in% or is.element
# these are equivalent but NG prefers %in% for readability

d <- 12
d %in% union(a,b) # is d in the union of a and b?
is.element(d, union(a,b)) # does same thing but more clunky

# avoid long, compound OR statements
a <- 2
a == 1 | a == 2 | a == 3
#instead
a %in% (c(1, 2, 3))

# check for partial matching with vector comparisons
a <- 1:7
d <- c(10, 12)
d %in% union(a, b) # returns TRUE FALSE (element by element)
d %in% a # returns FALSE FALSE (still by element)

# if statement ------------------------------

# anatomy of if statements

# if(condition) expression

# if(condition) expression1 else expression2

# if(condition1) expression1 else
# if(condition2) expression2 else expression3

# - final unspecified else captures the rest of the unspecified conditions
# else statement must appear on the same line as previous expression
# instead of single expression, can use curly brackets to execute
# a set of lines to be executed when the condition is met

z <- signif(runif(1), digits = 2)
print(z)

# simple if statement with no else
if(z > 0.5) cat(z, "is a bigger than average number", "\n")
# my number is smaller, so nothing happened


# compound if statement with 3 outcomes

if(z > 0.8) cat(z, "is a large number", "\n") else
  if(z <0.2) cat(z, "is a small number", "\n") else
  {cat(z, "is a number of typical size", "\n")
  cat("z^2 = ", z^2, "\n")}

# if statement wants a single boolean value (TRUE FALSE)
# if you give an if statement a vector of booleans
# it will only operate on the first element in that vector

z <- 1:10

# this does not do anything:
if(z > 7) print(z)

# probably not what you want
if(z < 7) print(z)

# use subsetting!
print(z[z < 7])

# ifelse function ------------------------------

# ifelse(test, yes, no)
# "test" is an object that can be coerced into a logical TRUE/FALSE
# "yes" returns values for TRUE elements in the test
# "no" returns values for FALSE elements in the test

# suppose we have an insect population in which each female lays on average 10.2 eggs, following a poisson distribution. lambda = 10.2. However, there is a 35% chance of parasitism, in which case, no eggs are laid. Here is a random sample of eggs laid for a group of 1000 individuals

tester <- runif(1000) # start with random uniform values
eggs <- ifelse(tester > 0.35, 
               rpois(n = 1000, lambda = 10.2),
               0)
hist(eggs)

# suppose we have a vector of probability values (perhaps from a simulation). We want to highlight significant values in the vector for plotting.

p_vals <- runif(1000)
z <- ifelse(p_vals <= 0.025, "lower_tail", "non_sig")
#upper tail
z[p_vals >= 0.975] <- "upper_tail"
table(z)

# Here's how NG would do it

z1 <- rep("non_sig", 1000)
z1[p_vals <= 0.025] <- "lower_tail"
z1[p_vals >= 0.975] <- "upper_tail"
table(z1)





























