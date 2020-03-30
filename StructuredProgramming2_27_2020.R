# Principles of structured programming
# Feb 27 2020 UPDATED March 23 2020
# JLW


# -------------------------------------------------------------------------

# Pseudocode
# Get data
# Calculate stuff
# Summarize output
# Graph results

# write function for each part

# Code will look (eventually) like this:

# get_data()
# calculate_stuff()
# summarize_output()
# graph_results()

# snippets ----------------------------------------------------------------

my_fun <- function(x = 5) {
  z <- 5 + runif(1)
  return(z)
}# gives you a snippet that you just need to fill in specifics
my_fun()

# build custom snippet for functions --------------------------------------

# Tools > Global Options > Code > Edit snippets

# try using mbar
##########################################################

##########################################################

# msec

# Type anything you want ------------------------------

# mhead

# ------------------------------
# test of mhead
# 23 Mar 2020
# JLW
# ------------------------------
#

# mfun

# -------------------------------
# FUNCTION trialfunct
# description: one line explanation
# inputs: just x = 5 for now
# outputs: real number
###################################
trialfunct <- function(x = 5){

#function body

return("Checking...trialfunct")

} # end of trialfunct
#----------------------------------

trialfunct()
# returns: [1] "Checking...trialfunct"


























