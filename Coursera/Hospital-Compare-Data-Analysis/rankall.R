# The function rankall takes two arguments, and outcome name (outcome) and
# a hospital ranking (num).   This function reads the 
# outcome-of-care-measures.csv file and returns a 2-column data frame
# containing the hospital in each state that has the ranking specified by
# num.

# The first column in the data frame is named hospital, which contains the
# hospital name, and the second column is named state, which contains the 
# 2-character abbreviation for the state.  

# Hospitals that do not have data on a particular outcome are excluded 
# from the set of hospitals when deciding the rankings.

rankall <- function(outcome,num="best") {
    # list of state abbreviations in alphabetical order 
    data <- read.csv(paste("/home/bridget/Coursera/RProgramming/rprog_",
                           "data_ProgAssignment3-data/outcome-of-care-",
                           "measures.csv",sep=""),colClasses="character")
    states <- unique(data$State)
    states <- states[order(states)]
    
    # apply rankhospital.R to all of these states
    source("rankhospital.R")
    hospital_name <- sapply(states,rankhospital,outcome=outcome,num=num)
    
    # construct the output data frame
    output <- data.frame("hospital"=hospital_name,"state"=states)
 #   colnames(output) <- c("hospital","state")
    
    output
}