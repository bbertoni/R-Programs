# This code makes use of movie rental data from the mysql sakila database.
# The goal is to calculate which times of the year a movie is likely to be
# rented out.  The total time that movie rental entries exist is calculated
# and then divided into "N" intervals.  The number of times a movie is 
# rented in each time interval is calculated and then the movies with the 
# maximum number of rentals in a given time period is printed out.

movie_days <- function(N) {
    # get the data from the mysql query of the sakila database
    data <- read.csv("/home/bridget/sakila-db/mysql_movie_dates_3.csv")

    # calculate the time range for all movies
    rental_date <- as.POSIXlt(data$rental_date)
    return_date <- as.POSIXlt(data$return_date)
    tmax <- max(return_date)
    tmin <- min(rental_date)
    # split up the time range
    tstep <- (tmax - tmin) / N
    times <- c(tmin)
    for (j in 1:N) {
        times <- c(times, tmin + j*tstep)
    }

    # split the data by movie
    s <- split(data, data$film_id)
    
    counts <- c()
    titles <- c()
    stores <- c()
    for (i in 1:length(s)) {
        # count the number of times a movie is rented out during these 
        # intervals
        rental_date <- as.POSIXlt(s[[i]]$rental_date)
        return_date <- as.POSIXlt(s[[i]]$return_date)
        count <- rep(0,N)
        for (k in 1:length(rental_date)) {
            for (m in 1:N) {
                if (rental_date[k] <= times[m] && 
                    return_date[k] >= times[m+1]) { 
                    # if in middle of interval...
                    count[m] <- count[m] + 1
                } else if (times[m+1] > rental_date[k] &&
                           rental_date[k] >= times[m]) {
                    # if at start of interval...
                    count[m] <- count[m] + 1
                } else if (times[m+1] > return_date[k] &&
                           return_date[k] >= times[m]) {
                    # if at end of interval...
                    count[m] <- count[m] + 1
                }
            }
        }
        titles <- c(titles,as.character(s[[i]]$title[[1]]))
        counts <- cbind(counts,count)
    }
    
    colnames(counts) <- titles
    colnames(counts) <- stores
    # counts is now a matrix with each column representing a given movie
    # title.  counts has 9 rows, corresponding to the N equally spaced time 
    # intervals over which the movie was rented.
    
    # now find the movies and times where movies are rented the most
    max <- max(counts)
    indicies <- which(counts == max, arr.ind = TRUE)
    finalmat <- c()
    for (i in 1:nrow(indicies)) {
        row <- indicies[i,1]
        col <- indicies[i,2]
        tmin <- as.character(times[row]) 
        tmax <- as.character(times[row+1])
        movie <- titles[col]
#        print(paste(movie,"was checked out by",max,"people over the time period",
#                    tmin,"to",tmax))
        finalrow <- cbind(movie,max,tmin,tmax)
        finalmat <- rbind(finalmat,finalrow)
    }
    finalmat
}
