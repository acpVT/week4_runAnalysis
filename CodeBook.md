# CodeBook

## To use:
1. Download and run the R script

## Data Source
All data is available at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. This is a source for data on Human Activity Recognition Using Smarthphone data set
This data was obtained from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

## run_anlaysis.R
This script does the following:
1. Downloads the data and reads the training and test data, features, and variable names.
2. Merges all data into one data set
3. Extracts only the measurments needed
4. Renaming the data variables appropriatley 
5. Writing the output to a new .txt file

## Variables
1. subjectTrain, featuresTrain, and activityTrain hold the training data downloaded
2. subjectTest, featuresTest, activityTest hold the test data downloaded
3. extractedData holds the final dataset
4. activity, features, and activity hold the merged data
5. colnames holds the correct variable names

