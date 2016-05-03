# This code makes use of movie rental data from the mysql sakila database.
# The goal is to construct measures of the time that a movie from a store
# could have been rented and the actual time that it was rented.  The
# ratio between the time a movie was actually rented and the time it was
# available is calculated.  The movies and stores with the "N" highest and 
# lowest values of this ratio are printed out.

movie_rental_times <- function(N) {
    # get the data from the mysql query of the sakila database
    data <- read.csv("/home/bridget/sakila-db/mysql_movie_dates_3.csv")
    
    # split the data based on the film id and store id
    # remove empty entries
    s <- split(data, list(data$film_id,data$store_id),drop=TRUE)
    
    # for each movie-store combination (i.e. each element in s),
    # and for each copy of the same movie at a given store,
    # calculate the time a movie could have been rented (tmax)
    # and the time it was actually rented (trent) and their ratio
    # (ratio).  tmax is defined as the time time between a mvoie's
    # earliest rental date and latest return date.
    final_ratio <- c()
    for (i in 1:length(s)) { # for a given movie in a given store...
        # split based on copies of a given movie at a given store
        s2 <- split(s[[i]],s[[i]]$inventory_id)
        ratio <- c()
        for (j in 1:length(s2)) { # for a given copy...
            if (nrow(s2[[j]])!=1) { # throw out instances where
                # a movie was only rented once
                # convert all date/times into date/time objects
                rental_date <- as.POSIXlt(s2[[j]]$rental_date)
                return_date <- as.POSIXlt(s2[[j]]$return_date)
                # calculate time differences in days
                tmax <- as.numeric( difftime(max(return_date),
                                             min(rental_date),units="days") )
                trent <- sum( as.numeric( difftime(return_date, rental_date,
                                                   units="days" ) ) )
                ratio <- c( ratio, trent / tmax )
            }
            
        }
        # if a given movie at a given store a multiple copies,
        # use its max ratio to quantify rental time vs available
        # time
        max_ratio <- max(ratio)
        # record the generated data
        final_ratio <- c(final_ratio, max_ratio)
    }
    
    # print out the movies and stores with the largest ratio
    max_index <- order(final_ratio,decreasing=TRUE)[1:N]
    finalmax <- c()
    for (i in 1:length(max_index)) {
        title <- as.vector(s[[max_index[[i]]]]$title[1])
        store <- as.vector(s[[max_index[[i]]]]$store_id[1])
#        print(paste("Max ratio of",sprintf('%1.3f',final_ratio[[max_index[[i]]]]),
#                    "for the movie",title,"and the store",store))
        finalrow <- cbind(sprintf('%1.3f',final_ratio[[max_index[[i]]]]),title,store)
        finalmax <- rbind(finalmax,finalrow)
    }
    
    cat("\n") # print a blank line separating maxs and mins
    
    # print out the movies and stores with the smallest ratio
    min_index <- order(final_ratio,decreasing=FALSE)[1:N]
    finalmin <- c()
    for (i in 1:length(min_index)) {
        title <- as.vector(s[[min_index[[i]]]]$title[1])
        store <- as.vector(s[[min_index[[i]]]]$store_id[1])
#        print(paste("Min ratio of",sprintf('%1.3f',final_ratio[[min_index[[i]]]]),
#                    "for the movie",title,"and the store",store))
        finalrow <- cbind(sprintf('%1.3f',final_ratio[[min_index[[i]]]]),title,store)
        finalmin <- rbind(finalmin,finalrow)
    }
    return(list(finalmax,finalmin))
}

