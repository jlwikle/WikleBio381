# ------------------------------
# Functions and Structured Programming
# 23 Mar 2020
# JLW
# ------------------------------
#
# load libraries ------------------------------
library(ggplot2)

# Create all functions from other script that holds them
# source files ------------------------------
source("MyFunctions.R")

# global variables ------------------------------
ant_file <- "antcountydata.csv"
x_col <- 7 # column 7 in dataframe, latitude center of each county
y_col <- 5 # column 5, number of ant species
##########################################################

# read in data
temp1 <- get_data(file_name = ant_file)

x <- temp1[, x_col] # extract predictor variable
y <- temp1[, y_col] # extract response variable

# fit regression model
temp2 <- calculate_stuff(x_var = x, y_var = y)

# extract residuals
temp3 <- summarize_output(z = temp2)

# create graph of results
graph_results(x_var = x, y_var = y)

print(temp3) # show residuals
print(temp2) # show model summary


























