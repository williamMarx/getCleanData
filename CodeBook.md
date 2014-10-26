getCleanData CodeBook
============

CodeBook for Getting and Cleaning Data course project on Coursera.

### Data overview

This project creates tidy data from the Human Activity Recognition Using Smartphones Data Set. This data set associates measurements taken from the accelerometers and gyroscopes of the Samsung Galaxy S smartphone with different types of human motion. See http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones for more information, including the source data.

#### Variables in tidy data set (tidyActivityData.txt)

1. Subject: the individual performing the trial. 30 total.

2. Activity: what the subject was doing. 6 total: walking, walking upstairs, walking downstairs, sitting, standing, laying.

3. Features: measurements taken while a subject was doing an activity. 66 total, all representing averages for a given subject and activity.

#### Key data transformations

1. Test and train data are combined into single data frames using rbind.

2. Features data is filtered using grepl to include ONLY mean and standard deviation values.

3. Data frames for subject, activity, and included features are combined into one master data frame using cbind.

4. The master data frame is further processed using colMeans within a nested for loop to calculate averages of feature data for each subject performing each activity. These averages are added to a final tidy data frame.

5. Finally, the tidy data is output to a .txt file.