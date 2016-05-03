# R-Programs
## R Programs written for Coursera R Programming Course

These three R codes operate on the specdata.zip data set which contains 332 .csv files containing pollution monitoring data for 332 monitors at different locations.  Each monitor file contains the data of the observation, the level of sulfate particulate matter measured in the air, and the level of nitrate particulate measured in the air.  There are many 'NA' values in the data.

'pollutantmean.R' calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, ignoring any missing values coded as NA.

'complete.R' reads a directory full of files and reports the number of completely observed cases in each data file. The function returns a data frame where the first column is the name of the file and the second column is the number of complete cases.

'corr.R' takes a directory of data files and a threshold for complete cases and calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function returns a vector of correlations for the monitors that meet the threshold requirement. If no monitors meet the threshold requirement, then the function returns a numeric vector of length 0.
