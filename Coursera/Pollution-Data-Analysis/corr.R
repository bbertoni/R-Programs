corr <- function(directory,threshold=0) {

    # input all files and calculate the number of complete cases
    id<-1:332
    data<-complete(directory,id)
    
    # keep only the monitors where the number of complete cases
    # is larger than the threshold
    datathresh<-data[data$nobs>threshold,]
    
    # return numeric vector of length 0 if no monitors pass the
    # threshold requirement
    if (length(datathresh$id)==0) {
        end<-numeric()
        end
    }   else {
        # format the file numbers for files that pass the threshold
        # requirement
        idthresh<-datathresh$id
        id2<-paste(formatC(idthresh, width=3, flag="0"),sep="")

        # open the files that pass the threshold requirement
        files<-c()
        for (n in id2) {
            files<-c(files,paste("/home/bridget/Coursera/RProgramming/"
                                 ,directory,"/",n,".csv",sep=""))
        }
        datafull<-lapply(files,read.csv)
        
        # calculate the correlation between sulfate and nitrate
        # on each monitor that passes the threshold requirement
        correlation<-c()
        for (i in 1:length(idthresh)) {
            correlation<-c(correlation,cor(datafull[[i]]$sulfate,datafull[[i]]$nitrate,
                                           use="complete.obs"))
        }
        
        correlation
    }
    
}