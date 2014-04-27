#Preparing and downloading the file to the local machine
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Dataset.zip")
unzip(zipfile="./Dataset.zip")

#At this point you should have a folder called "UCI HAR Dataset" on your working directory.
#You should de-level all the content of "test" and "train" so that all of them will be on the same working directory.
#Otherwise the following codes won't work i.e. you have to move the working directory interchangeably when reading the data.


#Read the training and testing data
trainingData <- read.table(file="x_train.txt")
testingData <- read.table(file="X_test.txt")

#Read the features names and then assign them to be the column names of the training and testing data.
#Previously trainingData and testingData have no descriptive column names so they need column renaming.
#We get the column names from the "features.txt" as it contains all the feature names.
features <- read.table(file="features.txt")
colnames(trainingData) <- features$V2
colnames(testingData) <- features$V2

#Extracts only the measurements on the mean and standard deviation for each measurement.
#Using the "grep" function to search for the column name that contains words "mean()" or "std()".
grep <- grepl(pattern="mean()|std()", names(trainingData))
trainingData <- trainingData[, grep]
testingData <- testingData[, grep]

#Read the "subject" and "activity" columns then bind them into the data. Do it separately for each training and testing data
trainingSubject <- read.table(file="subject_train.txt")
colnames(trainingSubject) <- "subject"
trainingActivity <- read.table(file="y_train.txt")
colnames(trainingActivity) <- "activity"
trainingData <- cbind(trainingSubject, trainingActivity, trainingData)

testingSubject <- read.table(file="subject_test.txt")
colnames(testingSubject) <- "subject"
testingActivty <- read.table(file="y_test.txt")
colnames(testingActivty) <- "activity"
testingData <- cbind(testingSubject, testingActivty, testingData)


#Merge the training and testing data into one data frame
completeData <- rbind(trainingData, testingData)

#Group the data into combinations of two levels i.e. "subject" and "activity"
#Subject has 30 levels and activity has 6 levels, so their combination will create 180 levels
group <- split(completeData, list(completeData$subject, completeData$activity), drop=TRUE)
dfrm <- data.frame()

#For each level, calculate its mean using 'lapply' function and then add it into the data frame
#The data frame "dfrm" will contain a new independent tidy data set with the average of each
#variable for each activity and each subject

for(x in names(group)){
  newRow <- as.data.frame(lapply(group[[x]], mean))
  dfrm <- rbind(dfrm, newRow)  
}

#Order the data frame by "subject" and "activity" if there is a tie to make the data looks better.
dfrm <- dfrm[order(dfrm$subject, dfrm$activity),]

#Finally, write the data into the "AverageDataSet.txt" file for further need.
write.table(dfrm, file="../AverageDataSet.txt")
