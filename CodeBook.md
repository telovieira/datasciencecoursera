Code Book

##Check if the file "UCIdata.zip" is present in your working directory. If not, it will download and unzip the file

## Read Data
* train             : values of variables in train dataset
* test              : values of variables in test dataset
* volunteers_train  : subjects ID for train dataset
* activities_train  : activities ID for train dataset
* volunteers_test   : subjects ID for test dataset
* activities_test   : activities ID for test dataset
* features          : description of each variables in train and test datasets
* activity_label    : description of activities ID in train and test datasets

## 1. Merge the training and test datasets
* dataset           : row bind of train and test datasets

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
ms                  : a vector of mean and std labels pulled out from features dataset
dataset             : replace dataset with only mean and std variables

## 3. Uses descriptive activity names to name the activities in the data set
dataset$Activities  : rename activity IDs with activities names

## 4. Appropriately labels the data set with descriptive variable names.
clean_names         : clean feature names vector and setup names for column names of dataset
volunteers          : merge (row bind) volunteers train and volunteers test sets, give descriptive label
activities          : merge (row bind) activities train and activities test sets, give descriptive label
dataset             : merge (column bind) activies, volunteers, and dataset sets

## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
b                   : molten data using ID Volunteers + Activities
dataset2            : reshape a molten data (b) into a second data frame
write.table         : write tidy data, as "tidy_data.txt" using "," separator, to the current directory
