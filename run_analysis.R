furl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
fname<- "data.zip"

#Downloading and unzipping the required file 
if(!file.exists(fname))
{
  download.file(furl, fname)
}
if(!file.exists("UCI HAR Dataset"))
{
  unzip(fname)
}

#Loading the required package
library(dplyr)

#Assigning the required data frames
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","attributes"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("a_code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$attributes)
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$attributes)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "a_code")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "a_code")

#Merging the training and the test sets to create one data set
merged_x<-rbind(x_train,x_test)
merged_y<-rbind(y_train,y_test)
merged_sub<-rbind(subject_train,subject_test)
merged_data<-cbind(merged_sub,merged_y,merged_x)

#Extracting only the measurements on the mean and standard deviation for each measurement
msdata<-select(merged_data,subject,a_code,contains("mean"),contains("std"))

#Adding descriptive activity names to name the activities in the data set
msdata$a_code<-activities[msdata$a_code,2]

#Appropriately labeling the data set with descriptive variable names
names(msdata)[1]<-"Subject"
names(msdata)[2]<-"Activity"
names(msdata)<-gsub("mean", "Mean", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("std", "Standard Deviation", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("Acc", "Accelerometer", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("Gyro", "Gyroscope", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("^t", "Time", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("^f", "Frequency", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("BodyBody", "Body", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("Mag", "Magnitude", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("tBody", "TimeBody", names(msdata), ignore.case = TRUE)
names(msdata)<-gsub("Freq[^u]", "Frequency", names(msdata), ignore.case = FALSE)

#Creating a second, independent tidy data set with the average of each variable for each activity and each subject
TidyDataSet<-msdata %>% group_by(Subject,Activity) %>% summarise_all(mean)

#Creating a text file containing tidy data set
write.table(TidyDataSet, "TidyData.txt", row.name=FALSE)
