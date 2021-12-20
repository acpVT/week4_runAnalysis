'''
Coursera
Weeek4 - peer reviewed coding assingment
12/19/2021
'''

library(dplyr)
library(data.table)

## Download dataset and unzip file

if(!file.exists("./getcleandata")){dir.create("./getcleandata")}
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./getcleandata/projectdataset.zip")
unzip(zipfile = "./getcleandata/projectdataset.zip", exdir = "./getcleandata")

## Read features and activity labels from downloaded data

featureNames <- read.table("./getcleandata/UCI HAR Dataset/features.txt")
activityLabels <- read.table("./getcleandata/UCI HAR Dataset/activity_labels.txt", header = FALSE)

## Read the training data

subjectTrain <- read.table("./getcleandata/UCI HAR Dataset/train/subject_train.txt", header = FALSE)
activityTrain <- read.table("./getcleandata/UCI HAR Dataset/train/y_train.txt", header = FALSE)
featuresTrain <- read.table("./getcleandata/UCI HAR Dataset/train/X_train.txt", header = FALSE)

## Read the test data

subjectTest <- read.table("./getcleandata/UCI HAR Dataset/test/subject_test.txt", header = FALSE)
activityTest <- read.table("./getcleandata/UCI HAR Dataset/test/y_test.txt", header = FALSE)
featuresTest <- read.table("./getcleandata/UCI HAR Dataset/test/X_test.txt", header = FALSE)

## Merge data files

subject <- rbind(subjectTrain, subjectTest)
activity <- rbind(activityTrain, activityTest)
features <- rbind(featuresTrain, featuresTest)

## Find correct column names

colnames(features) <- t(featureNames[2])

colnames(activity) <- "Activity"
colnames(subject) <- "Subject"
completeData <- cbind(features,activity,subject)

## Find the measurments with mean and std. to subset the dataset

columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)

requiredColumns <- c(columnsWithMeanSTD, 562, 563)
dim(completeData)

## Subset the dataset

extractedData <- completeData[,requiredColumns]
dim(extractedData)

## Begin renaming activites to appropirate names

extractedData$Activity <- as.character(extractedData$Activity)
for (i in 1:6){
  extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
}

extractedData$Activity <- as.factor(extractedData$Activity)

names(extractedData)

## Rename acvities 
names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
names(extractedData)<-gsub("^t", "Time", names(extractedData))
names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
names(extractedData)<-gsub("angle", "Angle", names(extractedData))
names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))


extractedData$Subject <- as.factor(extractedData$Subject)
extractedData <- data.table(extractedData)

## Write tidy dataset to a new .txt file

tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
write.table(tidyData, file = "Tidy.txt", row.names = FALSE)



