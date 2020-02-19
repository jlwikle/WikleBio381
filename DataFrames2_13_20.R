# Finishing data frames, lists
# Formatting data
# Feb 13 2020
# JLW

# -------------------------------------------------------------------------

# matrix and data frame similarities and differences
z_mat <- matrix(data = 1:30, ncol = 3, byrow = TRUE)
z_dataframe <- as.data.frame(z_mat)

#structure
str(z_mat)
str(z_dataframe)

# appearance
head(z_mat)
head(z_dataframe)

# element referencing
z_mat[2,3]
z_dataframe[2,3]

# column referencing
z_mat[,2]
z_dataframe[,2]
z_dataframe$V2

# row referencing
z_mat[2,]
z_dataframe[2,]

# specifying single elements is different!
z_mat[2]# gives second element # should use z_mat[2,1]
z_dataframe[2]# gives second dataset # should use z_dataframe$V2

# complete.cases for scrubbing atomic vectors
zD <- c(runif(3), NA, NA, runif(2))
print(zD)

complete.cases(zD) # gives string of TRUE FALSE
zD[complete.cases(zD)] # will give all non-NA values
zD[!complete.cases(zD)] # will give only NA values (if you need them)

m <- matrix(1:20, nrow = 5)
m[1,1] <- NA
m[5,4] <- NA
print(m)

# sweep out all rows with missing values
m[complete.cases(m),]

# get complete cases for only certain columns
m[complete.cases(m[,c(1,2)]),]#drop only row 1 b/c only looking in cols 1 & 2
m[complete.cases(m[,c(2,3)]),]#don't drop anything b/c no NA
m[complete.cases(m[,c(3,4)]),]#drops row 4 
m[complete.cases(m[,c(1,4)]),]# we lose both 1 and 4 because they both have NA

# techniques for assignments and subsetting matrices and data frames
m <- matrix(data = 1:12, nrow = 3)
dimnames(m) <- list(paste("Species", LETTERS[1:nrow(m)], sep = ""),
                   paste("Site", 1:ncol(m), sep = ""))
m
m[1:2,3:4]
m[c("SpeciesA", "SpeciesB"), c("Site3", "Site4")]

# use blanks to put all rows or columns:
m[c(1,2),]
m[,c(3,4)]

# use logicals for more complex subsetting
# E.G. select all columns w/totals > 15

colSums(m) > 15 #gives TRUE FALSE
m[,colSums(m) > 15]

# select all rows for which total == 22

m[rowSums(m) == 22,]
m[rowSums(m) != 22,] # for rows not equal to 22

m[, "Site1"] < 3
m["SpeciesA",] < 5

m[m[, "Site1"] < 3, m["SpeciesA",] < 5]

# caution! simple subscripting can change data type!
z <- m[1,]
print(z)
str(z) #becomes named integer string

# use drop = FALSE to retain dimensions
z2 <- m[1, , drop = FALSE]
print(z2)
str(z2)

# basic format for data is a csv file


# -------------------------------------------------------------------------

my_data <- read.table(file = "FirstData.csv", 
                      header = TRUE,
                      sep = ",",
                      stringsAsFactors = FALSE)
str(my_data)

# use saveRDS() to save R object as binary
saveRDS(my_data, file = "my_RDSobject")
z <- readRDS("my_RDSobject")
























































