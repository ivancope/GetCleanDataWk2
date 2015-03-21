library(data.table) # data.table package required for SQL-style LIKE function to get mean/std columns
library(plyr) # plyr used for Joins

# Load training data set
trainData <- read.table("train/X_train.txt")
trainActivityIDs <- read.table("train/Y_train.txt")
names(trainActivityIDs) = "ActivityID"
trainSubjects <- read.table("train/subject_train.txt")
names(trainSubjects) = "SubjectID"

# Load test data set
testData <- read.table("test/X_test.txt")
testActivityIDs <- read.table("test/Y_test.txt")
names(testActivityIDs) = "ActivityID"
testSubjects <- read.table("test/subject_test.txt")
names(testSubjects) = "SubjectID"

# activity_labels.txt contains enumeration of activity types
# Read this in and provide a "friendly name"
activityLabels <- read.table("activity_labels.txt")
activityLabels <- cbind(activityLabels, data.frame(ActivityName = c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")))
names(activityLabels) = c("ActivityID", "OriginalName", "ActivityName")
activityLabels$OriginalName <- NULL # For this exercise, original name is no longer needed

# Column headers for the 561-column data sets are in features.txt
dataLabels <- read.table("features.txt")
names(dataLabels) = c("ID", "Name")

# Combine description of activities with activity ID data sets
testActivityIDs <- join(testActivityIDs, activityLabels, by = "ActivityID", type = "left")
trainActivityIDs <- join(trainActivityIDs, activityLabels, by = "ActivityID", type = "left")
rm(activityLabels)

# Give column names to the data sets
dataLabelNames <- dataLabels$Name
names(trainData) = dataLabelNames
names(testData) = dataLabelNames

## Clear unnecessary data from memory
rm(dataLabels)
rm(dataLabelNames)

# Combine trainData with subject
trainData <- cbind(trainData, trainSubjects)
rm(trainSubjects)
testData <- cbind(testData, testSubjects)
rm(testSubjects)

# Combine activities with sensor data
testData <- cbind(testData, testActivityIDs)
trainData <- cbind(trainData, trainActivityIDs)
rm(testActivityIDs)
rm(trainActivityIDs)

# Add source indicator to datasets prior to merge (to allow them to be used in analysis or split again later), then merge together
testData$Source <- "Test"
trainData$Source <- "Training"
combinedData <- rbind(trainData, testData)
rm(testData)
rm(trainData)

# Filter new data set to only include means and standard deviations
# From the features_info.txt file, mean() and std() are described as:
# mean(): Mean value
# std(): Standard deviation
# For some reason, the brackets are not tested in the like query, so had to explicitly exclude meanFreq.

combinedData <- combinedData[,which((names(combinedData) %like% "mean()" & !names(combinedData) %like% "meanFreq") | names(combinedData) %like% "std()" | names(combinedData) %in% c("SubjectID", "ActivityName"))]

