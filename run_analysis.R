library(data.table)
library(reshape2)

# Load the data from the web and extract them
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "out.zip")
unzip("out.zip")
file.remove("out.zip")

# Read the data in
# y* : labels
# s* : subject, who performed activity
features   <- fread("UCI HAR Dataset/features.txt")
activities <- fread("UCI HAR Dataset/activity_labels.txt")

xtest <- fread("UCI HAR Dataset/test/X_test.txt")
ytest <- fread("UCI HAR Dataset/test/y_test.txt")
stest <- fread("UCI HAR Dataset/test/subject_test.txt")

xtrain <- fread("UCI HAR Dataset/train/X_train.txt")
ytrain <- fread("UCI HAR Dataset/train/y_train.txt")
strain <- fread("UCI HAR Dataset/train/subject_train.txt")

# Merge train, test
data <- rbind(xtest, xtrain)

# Rename the columns
colnames(data) <- features$V2

# Filter mean, std
data <- subset(data, T, grep("-(std|mean)[(][)]", colnames(data)))

# Aggregate the mean of the features over activity and subject
summary <- aggregate(data, 
                    list(activity = rbind(ytest, ytrain)$V1,
                         subject = rbind(stest, strain)$V1),
                    mean)

# Reformat activities as variables and features as measurements
summary <- dcast(melt(summary,
                      id.vars = c("subject", "activity")),
                subject + variable ~ activity,
                value.var = "value")

# Use descriptive column names
colnames(summary)[2] = "feature"
colnames(summary)[-(1:2)] = gsub("[^a-z]", "", tolower(activities$V2))

# Write table
write.table(summary, "summary.txt", row.names = F)