# matrices, lists, and data frames
# Feb 11 2020
#JLW

# -------------------------------------------------------------------------

library(ggplot2)
# create a matrix from an atomic vector
m <- matrix(data = 1:12, nrow = 4, ncol = 3)
print(m)

# must specify at least one of the two dimensions
m <- matrix(data = 1:12, nrow = 4)
print(m)

# use byrow = TRUE to fill one row at a time
m <- matrix(data = 1:12, nrow = 4, byrow = TRUE)
print(m)

# use dim() to see dimensions
dim(m)

# can also change dimensions of matrix (must be correct size)
dim(m) <- c(6, 2)
print(m)
dim(m) <- c(4,3)
print(m)

# to get separate components of dim
nrow(m)
ncol(m)

# note that length still applies to original atomic vector
length(m)

# to add names
rownames(m) <- c("a", "b", "c", "d")
print(m)
colnames(m) <- LETTERS[1:ncol(m)]
print(m)
rownames(m) <- letters[nrow(m):1]
print(m)

# specify particular elements eithin matrix with brackets and subscripts

# print a single element
# print row 2, column 3
print(m[2,3])

# print an entire row (or column) by leaving entry blank
# print row 2, showing all columns
print(m[2,])

# print everything
print(m)
print(m[,])
print(m[])

rownames(m) <- paste("Species", LETTERS[1:nrow(m)], sep = "")
colnames(m) <- paste("Site", 1:ncol(m), sep = "")
print(m)

# also add names through dimnames function

dimnames(m) <- list(paste("Site", 1:nrow(m), sep = ""),
                    paste("Species", LETTERS[1:ncol(m)], sep = ""))
print(m)

#transpose a matrix with t()
m2 <- t(m)
print(m2)

# add a row to m with rbind
m2 <- rbind(m2, c(10, 20, 30, 40))
print(m2)

# now fix the label
rownames(m2)
print(m2)
rownames(m2)[4] <- "myfix"
print(m2)

# access individual rows as well as indices

m2["myfix", "Site3"]# equivalent to m2[4,3]
m2[c("SpeciesC", "myfix"), c("Site3", "Site4")]

# can always change back to a vector at any time:
myVec <- as.vector(m)
print(myVec)

# -------------------------------------------------------------------------

# lists

# lists are atomic vectors but each element can hold things of different types and sizes

myList <- list(1:10, matrix(data = 1:8, nrow = 4, byrow = TRUE), letters[1:3], pi)
str(myList)
print(myList)

# using [] gives you a single item, which is of type list
myList[4]
myList[4] - 3 # can't subtract a number from a list!

# single brackets gives you only the element in that slot, which is always of type list

# to grab the object itself, use [[]]
myList[[4]]
myList[[4]] - 3 # now subtraction works

# if a list has 10 elements it is like a train with 10 cars
# [[5]] gives you the contents of car #5
# [c(4,5,6)] gives you a little train with cars 4, 5, and 6

# once the double bracket is called, you can access individual elements as before

myList[[2]]
myList[[2]][4,1]

# name list items when they are created

myList2 <- list(Tester = FALSE, littleM = matrix(1:9, nrow = 3))
print(myList2)

# named elements can be accessed with a dollar sign

myList2$littleM[2, 3]# get row 2, column 3
myList2$littleM # show whole matrix
myList2$littleM[2,] # show second row, all columns
myList2$littleM[2] #gives second vector element in matrix

# the "unlist" strings everything back into a single atomic vector; coercion is used if there are mixed data types
UnRolled <- unlist(myList2)
print(UnRolled)

# The most common use of a list: output from a linear model

yVar <- runif(10)
xVar <- runif(10)
myModel <- lm(yVar ~ xVar)
qplot(x = xVar, y = yVar)

# look at output of mymodel
print(myModel)

# full results are in summary
print(summary(myModel))

# drill down into summary to get what we want
str(summary(myModel))
summary(myModel)$coefficients
summary(myModel)$coefficients["xVar", "Pr(>|t|)"]
summary(myModel)$coefficients[2,4]

# -------------------------------------------------------------------------

#Data Frames

# a data frame is a list of equal-lengthed vectors, each of which is a column

varA <- 1:12
varB <- rep(c("Con", "LowN", "HighN"), each = 4)
varC <- runif(12)
dFrame <- data.frame(varA, varB, varC, stringsAsFactors = FALSE)
print(dFrame)
str(dFrame)

# add another row with rbind
# make sure you add a list, with each item corresponding to a column

newData <- list(varA = 13, varB = "HighN", varC = 0.668)
print(newData)
str(newData)

# now bind them
dFrame <- rbind(dFrame, newData)
str(dFrame)
tail(dFrame)

# adding another column is a little easier

newVar <- runif(13)
dFrame <- cbind(dFrame, newVar)
head(dFrame)

# -------------------------------------------------------------------------

# Important distinctions between lists and matrices

# create a matrix and data frame with same structure
zMat <- matrix(data = 1:30, ncol = 3, byrow = TRUE)
zDframe <- as.data.frame(zMat) # coerce it
str(zMat) # an atomic vector with 2 dimensions
str(zDframe) # not norizontal layout of variables!

head(zDframe) # note automatic variable names
head(zMat) # note identical layout

# element referencing is the same in both

zMat[3,3]
zDframe[3,3]

# so is column referencing

zMat[,3]
zDframe[,3]
zDframe$V3
# note use of $ and named variable column and row referencing

# what happens if we refer to only one dimension?

zMat[2] # takes the second element of atomic vector (column fill)
zDframe[2] # takes secone atomic vector (column) from list
zDframe["V2"]
zDframe$V2

# -------------------------------------------------------------------------

#Eliminating missing values

# use complete.cases with atomic vector


# -------------------------------------------------------------------------

#Techniques for assignments and subsetting matrices and dataframes

# same principle applied to both dimensions of a matrix
m <- matrix(data = 1:12, nrow = 3)
dimnames(m) <- list(paste("Species", LETTERS[1:nrow(m)], sep = ""),
                  paste("Site", 1:ncol(m), sep = ""))
print(m)

#subsetting based on elements
m[1:2, 3:4]

# same subsetting based on character strings (but no negative elements)
m[c("SpeciesA", "SpeciesB"), c("Site3", "Site4")]

# use blanks before or after comma to indicate full rows or columns
m[1:2,]
m[,3:4]

# use logicals for more complex subsetting e.g. select all columns for which the totals are >15

colSums(m) > 15
m[, colSums(m) > 15]

# select all rows where the row total is 22
m[rowSums(m) == 22,]

# note  == for logical equal and != for logical NOT equal
m[rowSums(m) != 22,]

# choose all rows for which numbers for site 1 are less than 3 and all columns for which the numbers for species A are less than 5

# first, logical for rows
m[,"Site1"] < 3

# add this in and select with all columns
m[m[, "Site1"] < 3,]

# and for columns
m["SpeciesA",] < 5

# add this in and select for all rows
m[ ,m["SpeciesA", ]<5]

# now combine both
m[m[ ,"Site1"]<3,m["SpeciesA", ]<5]

# and compare with full m
print(m)

# caution! simple subscripting to a vector changes the data type!
z <- m[1,]
print(z)
str(z)

# to keep this as a matrix, must add the drop  = FALSE option
z2 <- m[1, ,drop = FALSE]
print(z2)
str(z2)

# caution #s, always use both dimensions, or you will select a single matrix element

m2 <- matrix(data = runif(9), nrow = 3)
print(m2)
m2[2,]

# but now this will just pull the second element
m2[2]
# probably should specify row and column indicators
m2[2,1]
# also use logicals for assignments, not just subsetting
m2[m2 > 0.6] <- NA
print(m2)





















