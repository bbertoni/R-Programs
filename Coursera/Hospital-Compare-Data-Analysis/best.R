# The function best takes in two arguments: the two-character abbreviated
# name of the state and an outcome name.  It returns a character vector 
# with the name of the hospital that has the best (i.e. lowest) 30-day
# mortality for the specified outcome in that state.

# The outcomes can be one of "heart attack", "heart failure", or 
# "pneumonia".

# Hospitals that do not have data on a particular outcome are excluded
# from the ranking.

best <- function(state,outcome) {
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
    
    # find the index (indicies if there is a tie) of the hospital with the 
    # lowest 30-day mortality for the specified outcome
    index <- which(state_outcome_data==min(state_outcome_data,na.rm=TRUE))
    
    # return the hospital name with the lowest 30-day mortality rate
    # if there is a tie, the hospital names are listed in alphabetical
    # order and the first one is returned
    min(state_data$Hospital.Name[index])
    
}