## Download and unzip file

# Setup variables for file download
fn <- "UCIdata.zip"
url <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dir <- "UCI HAR Dataset"

# File download verification. If it does not exist, download to the working directory.
if(!file.exists(fn)){
  download.file(url,fn) 
}

# File unzip.
if(!file.exists(dir)){
  unzip("UCIdata.zip", files = NULL, exdir=".")
}


## Read Data
train <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\train\\X_train.txt")
test <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\test\\X_test.txt")
volunteers_train <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\train\\subject_train.txt")
activities_train <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\train\\y_train.txt")
volunteers_test <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\test\\subject_test.txt")
activities_test <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\test\\y_test.txt")
features <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\features.txt")
activity_label <- read.table("D:\\projetos\\data-science\\UCI HAR Dataset\\activity_labels.txt")


## 1. Merge the training and test datasets
dataset <- rbind(train, test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement.
ms <- grep("mean()|std()", features[, 2])
dataset <- dataset[,ms]


## 4. Appropriately labels the data set with descriptive variable names.
clean_names <- sapply(features[, 2], function(x) {gsub("[()]", "",x)})
names(dataset) <- clean_names[ms]

# merge volunteers train and volunteers test sets, give descriptive label
volunteers <- rbind(volunteers_train,volunteers_test)
setnames(volunteers, c("V1"), c("Volunteers"))

# merge activities train and activities test sets, give descriptive label
activities <- rbind(activities_train,activities_test)
setnames(activities, c("V1"), c("Activities"))

# merge (column bind) activies, volunteers, and dataset
dataset <- cbind(activities, volunteers, dataset)

## 3. Uses descriptive activity names to name the activities in the data set
for (i in 1:6){
  dataset[dataset$Activities == i,]$Activities<-as.character(activity_label$V2[i])
}


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#reshape2 package
if (!"reshape2" %in% installed.packages()) {
  install.packages("reshape2")
}
library("reshape2")

# molten data
b <- melt(dataset,(id.vars=c("Volunteers","Activities")))
# reshape a molten data into a data frame
dataset2 <- dcast(b, Volunteers + Activities ~ variable, mean)
# write data the tidy data
write.table(dataset2, "tidy_data.txt", sep = ",")
