## Loading the library

library(dplyr)

## Downloading the file

if(!file.exists("./data")){dir.create("./data")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")

## Unzip dataSet to /data directory

unzip(zipfile="./data/Dataset.zip",exdir="./data")


#### 1. Merges the training and the test sets to create one data set.

## The below code will read the train and test data 
x_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
colnames(x_test) <- features[,2]

y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
colnames(y_test) <- c('ActivityID')

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
colnames(subject_test) <- c('SubjectID')

x_train <- read.table("./data/UCI HAR Dataset/train/X_Train.txt")
colnames(x_train) <- features[,2]

y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
colnames(y_train) <- c('ActivityID')

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
colnames(subject_train) <- c('SubjectID')

features <- read.table("./data/UCI HAR Dataset/features.txt")

activity_Lables <- read.table("./data/UCI HAR Dataset/activity_labels.txt")

## Giving column names to activity_Labels
colnames(activity_Lables) <- c('ActivityID','Activity_Type')

## Combining test and train columns
test <- cbind(subject_test,x_test,y_test)
train <- cbind(subject_train,x_train,y_train)

## Merging train and test data rows
combined <- rbind(test,train)


#### 2. Extracts only the measurements on the mean and standard deviation for each measurement.

columns <- colnames(combined)

columnsneeded <- (grepl("ActivityID" , columns) | 
                  grepl("SubjectID" , columns) | 
                  grepl("mean.." , columns) | 
                  grepl("std.." , columns) 
                  )

extractedcolumns <- combined[,columnsneeded == TRUE]

#### 3. Uses descriptive activity names to name the activities in the data set

columntWithActivityNames <- merge(extractedcolumns, activity_Lables,
                            by='ActivityID',
                            all.x=TRUE)

columntWithActivityNames$ActivityID <- factor(columntWithActivityNames$ActivityID, levels = activity_Lables[,1], labels = activity_Lables[,2])

columntWithActivityNames <- select(columntWithActivityNames,-Activity_Type)

##View(columntWithActivityNames)

#### 4. Appropriately labels the data set with descriptive variable names.

fullcolumnname <- colnames(columntWithActivityNames)

fullcolumnname <- gsub("^f", "frequencyDomain", fullcolumnname)
fullcolumnname <- gsub("^t", "timeDomain", fullcolumnname)
fullcolumnname <- gsub("Acc", "Accelerometer", fullcolumnname)
fullcolumnname <- gsub("Gyro", "Gyroscope", fullcolumnname)
fullcolumnname <- gsub("Mag", "Magnitude", fullcolumnname)
fullcolumnname <- gsub("Freq", "Frequency", fullcolumnname)
fullcolumnname <- gsub("mean", "Mean", fullcolumnname)
fullcolumnname <- gsub("std", "StandardDeviation", fullcolumnname)

## Removing redundant words.
fullcolumnname <- gsub("BodyBody", "Body",fullcolumnname)

## Putting new names to the extractedcolumns dataset

colnames(columntWithActivityNames) <- fullcolumnname

#### 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

tidydata <- aggregate(. ~SubjectID + ActivityID, columntWithActivityNames, mean)

#### Writing tidy data to a txt file

write.table(tidydata, file = "Tidy_Data.txt", row.names = FALSE)

