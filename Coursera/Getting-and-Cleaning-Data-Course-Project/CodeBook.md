## Input Data
The input data accelerometer data from Samsung Galaxy S Smartphones is described here http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones and was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip on June 2, 2016.

This data contains many files and folders.  I used the data that they provided which they derived from the raw data and randomly divided into a "training" set and a "test" set.  In particular I made use of the files

* "UCI HAR Dataset/train/X_train.txt" - contains 561 derived variables describing training observations
* "UCI HAR Dataset/train/subject_train.txt" - contains the subject number for each of the training observations
* "UCI HAR Dataset/train/y_train.txt" - contains the activity labels for each of the training observations
* "UCI HAR Dataset/test/X_test.txt" - contains the 561 derived variables describing the test observations
* "UCI HAR Dataset/test/subject_test.txt" - contains the subject number for each of the test observations
* "UCI HAR Dataset/test/y_test.txt" - contains the activity labels for each of the test observations
* "UCI HAR Dataset/features.txt" - lists the names of the 561 variables
* "UCI HAR Dataset/activity_labels.txt" - relates the activity labels (numbers) to their actual names

## Transformations to Data

1. The three training data files are column-bound to produce one training data set called "train" (which now has 563 variables, the 561 from the first file, and now also a "subject" variable and an "activity" variable).
2. The three test data files are column-bound to produce one test data set called "test" (which now has 563 variables, the 561 from the first file, and now also a "subject" variable and an "activity" variable).
3. The independent training and test data are then merged/combined to form a data frame called "merged."
4. The variables in the columns of the data frame "merged" are restricted to the data which are means or standard deviations, or are the "subject" or "activity" variables.
5. The "activity" variable is converted from a numeric value (as it is given in the original "y_train.txt" and "y_train.txt" data sets) to a descriptive character value using the correspondence given in "activity_labels.txt."
6. The "merged" data frame is "tidied up" by removing instances of "()" in the variable names, making all the variable names lowercase, and making the "activity" character values lowercase.
7. A new, independent data frame called "data" is created by:
  1. Melting the data frame "merged" to a four column data set containing the columns "subject", "activity", "variable" (which contains the other variable names), and "value" (which contains the values of the variables for a given variable name, subject, and activity).
  2. The mean for each variable (only means and standard deviation variables from the original data set) for a given "subject" and "activity" is the calculated.
  3. The data is recast as a data frame called "data" with columns "subject", "activity", and all the columns names previously grouped under "variable", now with a preceeding "avg-" label.  The rows contain the values labeling the "subject" and "activity" and giving the mean value for each other variable (i.e. the means and standard deviations from the original data set) for the given "subject" and "activity".

## Output Data

The output is a data frame called "data" which contains the columns "subject" (a numerical value between 1 and 30 labeling the person that the data was obtained from), "activity" (one of the six activities: "walking", "walking_upstairs", "walking_downstairs", "sitting", "standing", or laying"), and all the columns names previously grouped under "variable", now with a preceeding "avg-" label.  These columns are:

"avg-tbodyacc-mean-x", "avg-tbodyacc-mean-y", "avg-tbodyacc-mean-z",
"avg-tbodyacc-std-x", "avg-tbodyacc-std-y", "avg-tbodyacc-std-z",
"avg-tgravityacc-mean-x", "avg-tgravityacc-mean-y", "avg-tgravityacc-mean-z",

"avg-tgravityacc-std-x", "avg-tgravityacc-std-y", "avg-tgravityacc-std-z", 
"avg-tbodyaccjerk-mean-x", "avg-tbodyaccjerk-mean-y", "avg-tbodyaccjerk-mean-z",
"avg-tbodyaccjerk-std-x", "avg-tbodyaccjerk-std-y", "avg-tbodyaccjerk-std-z",
"avg-tbodygyro-mean-x", "avg-tbodygyro-mean-y", "avg-tbodygyro-mean-z",
"avg-tbodygyro-std-x", "avg-tbodygyro-std-y", "avg-tbodygyro-std-z",
"avg-tbodygyrojerk-mean-x", "avg-tbodygyrojerk-mean-y", "avg-tbodygyrojerk-mean-z",
"avg-tbodygyrojerk-std-x", "avg-tbodygyrojerk-std-y", "avg-tbodygyrojerk-std-z",
"avg-tbodyaccmag-mean", "avg-tbodyaccmag-std", 
"avg-tgravityaccmag-mean", "avg-tgravityaccmag-std",
"avg-tbodyaccjerkmag-mean", "avg-tbodyaccjerkmag-std",
"avg-tbodygyromag-mean", "avg-tbodygyromag-std",
"avg-tbodygyrojerkmag-mean", "avg-tbodygyrojerkmag-std",
"avg-fbodyacc-mean-x", "avg-fbodyacc-mean-y", "avg-fbodyacc-mean-z"
"avg-fbodyacc-std-x", "avg-fbodyacc-std-y", "avg-fbodyacc-std-z",
"avg-fbodyaccjerk-mean-x", "avg-fbodyaccjerk-mean-y", "avg-fbodyaccjerk-mean-z",
"avg-fbodyaccjerk-std-x", "avg-fbodyaccjerk-std-y", "avg-fbodyaccjerk-std-z",
"avg-fbodygyro-mean-x", "avg-fbodygyro-mean-y", "avg-fbodygyro-mean-z",
"avg-fbodygyro-std-x", "avg-fbodygyro-std-y", "avg-fbodygyro-std-z",
"avg-fbodyaccmag-mean", "avg-fbodyaccmag-std",
"avg-fbodybodyaccjerkmag-mean", "avg-fbodybodyaccjerkmag-std",
"avg-fbodybodygyromag-mean", "avg-fbodybodygyromag-std",
"avg-fbodybodygyrojerkmag-mean", "avg-fbodybodygyrojerkmag-std".

The rows contain the values labeling the "subject" and "activity" and giving the mean value for each other variable (i.e. the means and standard deviations from the original data set) for the given "subject" and "activity".
