getCleanData
============

Repository for Getting and Cleaning Data course project on Coursera. This project creates tidy data from the Human Activity Recognition Using Smartphones Data Set (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

### To use this project:

1. load the run_analysis.R file

2. place the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip in your working directory

3. make sure you have the plyr package installed and loaded

4. run the function runAnalysis()

5. tidy data will be output to a .txt file in your working directory

#### runAnalysis() function

This script contains the function runAnalysis(), which does all of the processing for this project. Here's how runAnalysis() works:

-First, the function loads data from the subject, activity, and features text files into data frames, for both the test and train data. Test and train data are combined into single data frames. Features data is filtered for mean and standard deviation items.

-Second, the data frames for subject, activity, and relevant features are combined into one master data frame.

-Third, the master data is further processed to present averages of feature data for each subject performing each activity.

-Finally, the tidy data is output to a .txt file.