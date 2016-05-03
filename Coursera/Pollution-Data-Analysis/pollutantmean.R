pollutantmean<-function(directory,pollutant,id=1:332){
    
    # format the file numbers
    
    id<-paste(formatC(id, width=3, flag="0"),sep="")

    # open the files
    files<-c()
    for (n in id) {
        files<-c(files,paste("/home/bridget/Coursera/RProgramming/"
                             ,directory,"/",n,".csv",sep=""))
    }
    data<-lapply(files,read.csv)
    
    # calculate the mean of the pollutant
    # ignore NA values
    
    values<-c()
    for (i in 1:length(data)) {
        values<-c(values,data[[i]][[pollutant]])
    }

    bad<-is.na(values)
    mean(values[!bad])
    
}