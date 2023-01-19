#Download and reading the files
#setting working directory
#Download
fileUrl <- " https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileUrl, destfile = "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip")
unzip(zipfile = "./exam/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", exdir ="./exam")
#reading training data
x_train <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/train/subject_train.txt")
#reading testing data
x_test <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/test/subject_test.txt")
#reading feature data
features <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/features.txt")
activity_labels <- read.table("./getting and cleaning data/exam/UCI HAR Dataset/activity_labels.txt")
#assiging column names
colnames (x_train) <- features[,2]
colnames(x_test) <- features[,2]
colnames(y_train) <- "activityID"
colnames(y_test) <- "activityID"
colnames(subject_test) <- "subjectID"
colnames(subject_train) <- "subjectID"
colnames(activity_labels) <- c("activityID","activityType")
#step1-merging
mtrain <- cbind(x_train,y_train,subject_train)
mtest <- cbind(x_test,y_test,subject_test)
dataset <- rbind(mtrain,mtest)
dim(dataset)
#step2-Extracts only the measurements on the mean and standard deviation for each measurement. 
columnnames <- colnames(dataset)
x<- (grepl("activityID",columnnames) | grepl("subjectID", columnnames) | grepl ("mean..",columnnames) | grepl("std..",columnnames))
result <- dataset[,x==TRUE]
#step3-Uses descriptive activity names to name the activities in the data set
dataset_descriptive <- merge(dataset, activity_labels, by="activityID")
#step4-Appropriately labels the data set with descriptive variable names
#has been done in pervious section
#step5-From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidyDataSet1 <- aggregate(.~subjectID + activityID , dataset_descriptive, mean)
tidyDataSet2 <- arrange(tidyDataSet, subjectID, activityID)
tidyDataSet_subset3 <- select(tidyDataSet,subjectID, activityID)
#writing tidyDataSet
write.table(tidyDataSet,"tidyDataSet", row.names = FALSE)
