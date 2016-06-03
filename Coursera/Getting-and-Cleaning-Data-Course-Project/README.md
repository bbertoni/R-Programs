This repo contains two files, "run_analysis.R" and "CodeBook.md."

## run_analysis.R
"run_analysis.R" is an R code which operates on the accelerometer data set from SamsungGalaxy S smartphones from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones .  The data is contained in https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip .  This code 
* Merges the training and the test sets to create one data set
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names.
* From the data set obtained, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## CodeBook.md
"CodeBook.md" describes the variables, the data, and the transformations that were performed to clean up the data. 
