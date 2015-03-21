# Codebook

Data was obtained from:
- Description: 	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
- Download: 	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Please see the features_info.txt text file within the download link for a full description of all the source fields.

None of the original data have been modified, simply merged into a single data set.

The following steps are taken by the `run_analysis.R` file to perform this merge:

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
- Filters columns to only include means and standard deviations.

After the process has finished, there is one data frame variable in scope, `combinedData`.
`combinedData` contains one row per event and one column per type of measurement. Only 66 of the original 541 columns are kept.