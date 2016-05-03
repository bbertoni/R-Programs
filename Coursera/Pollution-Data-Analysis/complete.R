complete<-function(directory,id=1:332) {
    
    # format the file numbers
    id2<-paste(formatC(id, width=3, flag="0"),sep="")
    
    # open the files
    files<-c()
    for (n in id2) {
        files<-c(files,paste("/home/bridget/Coursera/RProgramming/"
                             ,directory,"/",n,".csv",sep=""))
    }
    data<-lapply(files,read.csv)
    
    # get the number of complete cases
    cases<-c()
    numcomplete<-c()
    for (i in 1:length(data)) {
        cases<-complete.cases(data[[i]]$nitrate,data[[i]]$sulfate)
        numcomplete<-c(numcomplete,length(cases[cases==TRUE]))
    }

    # create the output data frame
    output<-data.frame("id"=id,"nobs"=numcomplete)
    
    output
    
}