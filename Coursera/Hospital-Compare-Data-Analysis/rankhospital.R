# The function rankhospital takes three arguments, the two character
# abbreviated name of a state (state), an outcome (outcome), and the
# ranking of a hospital in that state for that outcome.

# The function reads the outcome-of-care-measures.csv file and 
# returns a character vector with the name of the hospital that has 
# the ranking specified by the num argument.

#  The num argument can take values "best", "worst", or an integer 
# indicating the ranking (smaller numbers are better).   If the number 
# given by num is larger than the number of hospitals in that state, 
# then the function returns NA. Hospitals that do not have data on a 
# particular outcome are excluded from the set of hospitals when 
# deciding the rankings.

# If there is a tie, the hospital names are listed in alphabetical
# order and the first one is returned.

rankhospital <- function(state,outcome,num="best") {
    # read in outcome data
    data <- read.csv(paste("/home/bridget/Coursera/RProgramming/rprog_",
                           "data_ProgAssignment3-data/outcome-of-care-",
                           "measures.csv",sep=""),colClasses="character")
    
    # restrict to outcomes from the specified state
    state_data <- data[data$State==state,]
    
    # ensure that the state is valid:
    if (nrow(state_data)==0) {
        stop("invalid state")
    }
    
    # find the index of the outcome, i
    if (outcome == "heart attack") {
        i <- 11L
    } else if (outcome == "heart failure") {
        i <- 17L
    } else if (outcome == "pneumonia") {
        i <- 23L
    } else {
        stop("invalid outcome")
    }
    
    # obtain and properly format the column of the data for a particular 
    # state and outcome
    suppressWarnings(state_outcome_data <- as.numeric(state_data[,i]))
    
    # order the hospital names by their values of 30-day mortality for
    # a given outcome 
    index <- order(state_outcome_data,state_data$Hospital.Name,na.last=NA)
    # here we ordered by the 30 day mortality rate, and then broke ties
    # alphabetically using the hospital name.  The option na.last=NA ignores 
    # the NA elements
    names_ordered <- state_data$Hospital.Name[index]

    # return the requested hospital
    if (num!="best" && num!="worst" && num > length(names_ordered)) {
        "NA"
    } else {
        if (num == "best") {
            num <- 1
        } else if (num == "worst") {
            num <- length(names_ordered)
        }
        names_ordered[num]
    }
    
    
}