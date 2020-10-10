The script run_analysis.R first gets the required dataset and unzips it. After this, it : 

1. Assigns the following data frames : 
* features - A data frame with 561 rows and 2 columns, containing a list all features.
* activities - A data frame with 6 rows and 2 columns, containing the class labels and their activity name.
* subject_test - A data frame with 2947 rows and 1 column, containing the subjects who performed the activity in the test sample.
* subject_train - A data frame with 7352 rows and 1 column, containing the subjects who performed the activity in the train sample.
* x_test - A data frame with 2947 rows and 561 columns, containing the time and frequency domain features data in the test sample.
* x_train - A data frame with 7352 rows and 561 columns, containing the time and frequency domain features data in the train sample.
* y_test - A data frame with 2947 rows and 1 column, containing the test activity labels.
* y_train - A data frame with 7352 rows and 1 column, containing the train activity labels.

2. Merges the training and the test sets to create one data set each : 
* merged_sub - a data frame with 10299 rows and 1 column, a result of merging subject_test and subject_train using rbind().
* merged_x - a data frame with 10299 rows and 561 columns, a result of merging x_test and x_train using rbind().
* merged_y - a data frame with 10299 rows and 1 column, a result of merging y_test and y_train using rbind().
* merged_data - a data frame wth 10299 rows and 563 columns, a result of merging merged_sub, merged_y and merged_x using cbind().

3. Extracts only the measurements on the mean and standard deviation for each measurement : 
* msdata - a data frame with 10299 rows and 88 columns, a result of extracting only the features whose names contain either "mean" or "std".

4. Uses descriptive activity names to name the activities in the data set : 
 Replacing the values in the 'a_code' column with the name of the activity corresponding to the a_code in the 'activities' data frame. The 6 activities are :
 * WALKING
 * WALKING_UPSTAIRS
 * WALKING_DOWNSTAIRS
 * SITTING
 * STANDING
 * LAYING

5. Appropriately labels the data set with descriptive variable names :
* The first column is renamed to 'Subject'.
* The second column is renamed to 'Activity'.
* The 'mean' in all the column names is changed to 'Mean'.
* The 'std' in all the column names is changed to 'Standard Deviation'.
* The 'Acc' in all the column names is changed to 'Accelerometer'.
* The 'Gyro' in all the column names is changed to 'Gyroscope'.
* Every column name that started with 't' is changed to start with 'Time'.
* Every column name that started with 'f' iss changed to start with 'Frequency'.
* The 'Mag' in all the column names is changed to 'Magnitude'.
* The 'tbody' in all the column names is changed to 'TimeBody'.

6. From the data set in above step, creates a second, independent tidy data set with the average of each variable for each activity and each subject :
* TidyDataSet - a data frame with 180 rows and 88 columns, a result of grouping the 'msdata' data frame by subject and activity, and taking the mean of the rest of the features

7. Writing the tidy data set to a text file : 
Writes the 'TidyDataSet' to a text file using write.table().





