# download (temporarily) the training and test files and their column names from the zipped data, unzip it, 
# and import into R
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp <- tempfile()
download.file(url,temp)

train <- read.table(unz(temp,"UCI HAR Dataset/train/X_train.txt")) # training data
train_subject <- read.table(unz(temp,"UCI HAR Dataset/train/subject_train.txt")) # labels training subjects
train_activity <- read.table(unz(temp,"UCI HAR Dataset/train/y_train.txt")) # labels training activities

test <- read.table(unz(temp,"UCI HAR Dataset/test/X_test.txt")) # test data
test_subject <- read.table(unz(temp,"UCI HAR Dataset/test/subject_test.txt")) # labels test subjects
test_activity <- read.table(unz(temp,"UCI HAR Dataset/test/y_test.txt")) # labels test activities

col_names <- read.table(unz(temp,"UCI HAR Dataset/features.txt"))
col_names <- as.vector(col_names[,2]) # extract the column names for the data

activity_names <- read.table(unz(temp,"UCI HAR Dataset/activity_labels.txt")) # extract the activity names

unlink(temp)

###############################################################################################################

# put all the training data together
train <- cbind(train,train_subject,train_activity)
colnames(train)[length(colnames(train))-1] <- "subject" # rename columns otherwise by default they will be 
                                                        # both called "V1" and this will cause problems for
                                                        # merge()
colnames(train)[length(colnames(train))] <- "activity"

# put all of the test data together
test <- cbind(test,test_subject,test_activity)
colnames(test)[length(colnames(test))-1] <- "subject"
colnames(test)[length(colnames(test))] <- "activity"

# add new column names to the list as well
col_names <- c(col_names,"subject","activity")

# merge training and test datasets
merged <-merge(train,test,all.x=TRUE,all.y=TRUE) # these data sets are independent and each has 561 columns in 
                                                 # the same order, so just stack the two data sets together

###############################################################################################################

# retain only those columns of the data which are means or standard deviations
# i.e. retain only those columns of the data which have names containing the strings "mean()" or "std()"
# also keep "subject" and "activity" columns
col_indices <- grepl("(mean\\(\\)|std\\(\\))",col_names) # use double backslash to get parenthesis
col_indices[length(col_indices)] <- TRUE
col_indices[length(col_indices)-1] <- TRUE

merged <- merged[,col_indices]
col_names <- col_names[col_indices]

###############################################################################################################

# use descriptive activity names instead of numbers
activity_names[,2] <- as.character(activity_names[,2]) # convert activity names list to character vector
activity_names[,2] <- tolower(activity_names[,2]) # make them all lowercase for tidy data

for (i in 1:nrow(activity_names)) {
    rows <- merged$activity == activity_names[i,1]
    merged$activity[rows] <- activity_names[i,2]
}

###############################################################################################################

# appropriately label the data set with descriptive data names, i.e. edit col_names

# the names as already specified are nicely descriptive, so here we just clean up the names a bit by removing
# the instances of "()" and making all the text lowercase

col_names <- gsub("\\(\\)","",col_names) # again need the \\ for ( and )
col_names <- tolower(col_names)

# assign these columns names to the merged data set:
colnames(merged) <- col_names

###############################################################################################################

# Finally, create a second, independent tidy data set with the average of each variable for each activity and 
# each subject

# we'll use the reshape package and the dplyr package
library(reshape)
library(dplyr)

# melt the merged data so that we sort by subject and activity
merged_melt <- melt(merged,id=c("subject","activity")) # 4 column data frame with columns "subject",
                                                       # "activity", all the other variable names in one column
                                                       # called "variable", and their values in a column 
                                                       # called "value"

# calculate the mean for a given subject, activity, and variable
means <- ddply(merged_melt, c("subject","activity","variable"), summarize,mean = mean(value))
# This created a 4 column data frame with columns "subject", "activity", "variable", and "mean"

# recast the data to have columns "subject", "activity", all the columns names previously grouped under
# "variable", and place the values from the previous "mean" column into the data frame.
data <- dcast(means,subject+activity~variable,value.var="mean")

# relabel the commons to show that they now represent mean values:
colnames(data) <- paste("avg",colnames(data),sep="-")
colnames(data)[1] <- "subject" # correct the column names I just messed up...
colnames(data)[2] <- "activity"

# Now data contains out final tidy data set!  Output it:
write.table(data,"/home/bridget/Coursera/Getting_and_Cleaning_Data/tidy_data.txt",row.names=FALSE)


