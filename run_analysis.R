##read data

subject_test <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/test/subject_test.txt")
subject_train <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/train/subject_train.txt")
X_test <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/test/X_test.txt")
X_train <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/train/X_train.txt")
y_test <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/test/y_test.txt")
y_train <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/train/y_train.txt")

activity_labels <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./Coursera/Data_Science_with_R/Course3/UCI HAR Dataset/features.txt")

##1.Merges the training and the test sets to create one data set.
dataset <- rbind(X_test, X_train)

##2.Extracts only the measurements on the mean and standard deviation for each measurement.
head(features)
features
MeanorStd <- grep("mean()|std()", features[,2])
extracted <- dataset[,MeanorStd]

##remove "()" from features variable names
featurenames_clean <- gsub("()", "", features[,2])
names(dataset) <- featurenames_clean[MeanorStd]

head(dataset)

subject <- rbind(subject_test, subject_train)
head(subject)
names(subject) <- "subject"

activity <- rbind(y_test, y_train)
names(activity) <- "activity"

dataset <- cbind(subject, activity, dataset)

##3.Uses descriptive activity names to name the activities in the data set
activity_group <- factor(dataset$activity)
head(activity_labels)
levels(activity_group) <- activity_labels[,2]
dataset$activity <- activity_group

