## R Programs written for part of the Coursera R Programming Course

All of these codes utilize that data in outcome-of-care-measures.csv from the Hospital Compare web site (http://hospitalcompare.hhs.gov)
run by the U.S. Department of Health and Human Services. The purpose of the web site is to provide data and
information about the quality of care at over 4,000 Medicare-certi ed hospitals in the U.S. This dataset es-
sentially covers all major U.S. hospitals.  This dataset is used for a variety of purposes, including determining
whether hospitals should be fined for not providing high quality care to patients.

best.R is a function designed to find the best hospital in a state.  It take two arguments:  the 2-character abbreviated name of a state and an outcome name.  The function reads the outcome-of-care-measures.csv file and returns a character vector
with  the  name  of  the  hospital  that  has  the  best  (i.e. lowest)  30-day  mortality  for  the  specified  outcome
in that state.  The outcomes can be one of "heart attack", "heart failure", or "pneumonia".  Hospitals that do not have data on a particular outcome are excluded from the set of hospitals when deciding the rankings.  If there is a tie for the best hospital for a given outcome, then the hospital names are sorted in alphabetical order and the  first hospital in that set is chosen.

rankhospital.R is a function designed to find a hospital of a given rank for a given outcome in a given state.  It takes three arguments:  the 2-character abbreviated name of a state, an outcome, and the ranking of a hospital in that state for that outcome.  It reads the
outcome-of-care-measures.csv file and returns a character vector with the name of the hospital that has the ranking specified by the
num argument.  Again, ties are broken alphabetically by hospital name.

rankall.R is a function that ranks hospitals in all states.  It takes two arguments: an outcome name and a hospital rank-
ing.  It reads the outcome-of-care-measures.csv file and returns a 2-column data frame containing the hospital in each state that has the ranking specified in the input.  The hospital ranking variable "num" can take  values "best", "worst", or an integer indicating the ranking (smaller numbers are better).
