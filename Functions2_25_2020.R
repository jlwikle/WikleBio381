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
