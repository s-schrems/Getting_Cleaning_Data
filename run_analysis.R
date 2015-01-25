library(reshape2)

setwd("~/Data_Science_Trek/Classes/3_Getting_and_Cleaning Data/Course_Project")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "dataset.zip", method = "curl")
unzip("dataset.zip")

#load data that is necessary to work with the data files
labels <- read.table("./UCI HAR Dataset/activity_labels.txt")[,2]
colNames <- read.table("./UCI HAR Dataset/features.txt")[,2]
UseColNames <- grepl("mean|std", features)

#read in testing data and combine data
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
names(x_test) <- colNames
x_test <- x_test[, UseColNames]
y_test[,2] <- labels[y_test[,1]]
names(y_test) <- c("ActivityID", "ActivityLabel")
names(subject_test) <- "Subject"

test_dta <- cbind(as.data.table(subject_test), y_test, x_test)
head(test_dta, n = 2)

#read in training data and combine data... basically do the same thing as we just did only 
#on the training data sets.  should prob figure out how to do this over a loop b/c code is 
#identical except for the test/train difference in directory, files, and naming

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
names(x_train) <- colNames
x_train <- x_train[,UseColNames]
y_train[,2] <- labels[y_train[,1]]
names(y_train) <- c("ActivityID", "ActivityLabel")
names(subject_train) <- "Subject"

train_dta <- cbind(as.data.table(subject_train), y_train, x_train)
head(train_dta, n = 2)

full_dta <- rbind(test_dta, train_dta)
head(full_dta, n = 2)

IDLabels <- c("Subject", "ActivityID", "ActivityLabel")
dtaLabels <- setdiff(colnames(full_dta), IDLabels)
meltdata <- melt(full_dta, id = IDLabels, measure.vars = dtaLabels)

FinalDta <- dcast(meltdata, Subject + ActivityLabel ~ variable, mean)

write.table(FinalDta, file = "FinalDta.txt", row.name = FALSE)



