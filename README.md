# Getting and Cleaning Data Week 2 submission

This project contains a code book, Codebook.md, and a single code file, run_analysis.R. 

run_analysis.R executes the following tasks:

- Loads any necessary libraries (data.table, plyr) for data manipulation
- Loads training data set including activities and subjects
- Loads test data set including activities and subjects
- Loads activity lookup file
- Reads column headers for the data sets and names the data set columns accordingly
- Joins activity data sets to activity lookup set to retrieve the name
- Joins subject data to core sensor data sets
- Joins activity data to core sensor data sets
- Adds source indicator to distinguish between the two sets if needed later
- Combines both test and training data sets into a single data frame
- Filters columns to only include anything means and standard deviations.

Concatenations are done using cbind or rbind, and joins are done using the join() function from the dplyr package.
Filter is done using SQL-style %like% or %in% commands.
