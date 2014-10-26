runAnalysis <- function() {
    
##create data frames for each column of data


##subject data
    
##load the subject_test.txt file into a data frame
subjectTest <- read.table("./test/subject_test.txt", header = FALSE)

##load the subject_train.txt file into a data frame
subjectTrain <- read.table("./train/subject_train.txt", header = FALSE)

##combine the test and train subject data into a single data frame
subject <- rbind(subjectTest, subjectTrain)

##give the data frame a meaningful column name
names(subject) <- "subject"


##activity data

##load the y_test.txt file into a data frame
activityTest <- read.table("./test/y_test.txt", header = FALSE)

##load the y_train.txt file into a data frame
activityTrain <- read.table("./train/y_train.txt", header = FALSE)

##combine the test and train activity data into a single data frame
activity <- rbind(activityTest, activityTrain)

##give the data frame a meaningful column name
names(activity) <- "activityCode"


##features data
##load the features.txt data
features <- read.table("./features.txt", header = FALSE)

##change feature names to strings
features$V2 <- as.character(features$V2)

##grab indeces of all mean() and std() elements
indeces <- which(apply(features, 1, function(x) any(grepl("mean\\(\\)|std\\(\\)",x))))
indeces <- as.numeric(indeces)

##load the X_test.txt file into a data frame
dataTest <- read.table("./test/X_test.txt", header = FALSE)

##load the X_train.txt file into a data frame
dataTrain <- read.table("./train/X_train.txt", header = FALSE)

##combine the test and train activity data into a single data frame
data <- rbind(dataTest, dataTrain)

##remove all columns not in indeces so that only mean and std data remain
data <- data[indeces]

##rename column names to something human-readable
names(data) <- features$V2[indeces]


##master data

##bind the subject, activity, and features data frames into a master data frame
master <- cbind(subject, activity, data)


##final tidy data
##create new data frame to hold the final averaged data
##by removing all rows from a copy of the master
final <- master[which(is.na(master$subject)), ]

##make a vector of unique values from subject column of master data frame
uniqueSubjects <- unique(master$subject)
uniqueSubjects <- sort(as.numeric(uniqueSubjects))

##get a vector of unique activities from activity column of master data frame
uniqueActivities <- unique(master$activityCode)
uniqueActivities <- sort(as.numeric(uniqueActivities))

##for each unique subject, for each activity type (if it exists),
##take the averages of all means and standard deviations,
##and append the results to the final tidy data frame
for (subject in uniqueSubjects) {
    ##subset by subject
    subjectData <- master[master$subject == subject,]
    
    for (activity in uniqueActivities) {
        ##subset again by activity
        activityData <- subjectData[subjectData$activityCode == activity,]
        if (nrow(activityData) > 0) {
        ##take column averages
        activityAverages <- colMeans(activityData)
        ##append column averages to final tidy data frame
        final <- rbind(final, activityAverages)
        }
    }
}


##clean up formatting of final tidy data frame

##fix column names in final data frame, which were corrupted during rbind process
colNames <- names(master)
names(final) <- colNames

##translate activity codes into activity names

##join activity labels data with final tidy data
##note: join requires plyr package
activityLabels <- read.table("./activity_labels.txt", header = FALSE)
names(activityLabels) <- c("activityCode", "activity")
final <- join(final, activityLabels, by = "activityCode")

##replace activityCode with activity
final[2] <- final[ncol(final)]
final$activity <- NULL
colnames(final)[2] <- "activity"

##lastly, use write.table() to output the final tidy data frame as a text file
write.table(final, file="./tidyActivityData.txt", row.name = FALSE)
}