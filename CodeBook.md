#Code Book


This code book will describe the information of the data before and after transformation done using run_analysis.R.

=================
##Original Data
The original data can be obtained on https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. The full description of the data can be seen on http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones. The title of this data set is "Human Activity Recognition Using Smartphones Data Set" and in general this data set contains the records of 30 different subjects when using a smartphones on their daily lives.
The original data has:
* 10299 observations
* 561 fields

==============
#Transformed Data
The data is transformed into the desired tidy data with following actions:
* Reads training and testing data separately.
* Renames all of the column names using descriptive names obtained from "features.txt"
* Extracts only the measurements on the mean and standard deviation for each measurement (use 'grep' function).
* Reads and binds the "subject" and "activity" columns into the data.
* Merges training and testing data.
* Creates new independent tidy data set with the average of each variable for each activity and each subject.

The transformed data has:
* 180 observations
* 81 Fields

The reduction of number of observations is caused because observations are densed into levels (subject and activity). There are 6 levels of activity and 30 levels of subject which make 30 x 6 = 180 observations only. The reduction of number of fields is due to the removal of undesired measurements (measurements which contain no value of mean or standard deviation of each measurement). 

