# run_analysis.R  
  
#install the dplyr packages
library(dplyr)  
  
#read train_X and train_Y, merge into train_Data#  
setwd("D:/2、Biostatistics/6R-Statistics/Coursea/3、Getting and Cleaning Data/WEEK3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")  
a <- list.files(pattern=".*.txt")  
train_Data <- do.call(cbind,lapply(a, read.table))  
#read test_X and test_Y, merge into test_Data#  
setwd("D:/2、Biostatistics/6R-Statistics/Coursea/3、Getting and Cleaning Data/WEEK3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test")  
b <- list.files(pattern=".*.txt")  
test_Data <- do.call(cbind,lapply(b, read.table))  
#merge two data table into one dataset#  
dataset <- rbind(train_Data, test_Data)  
#get the mean and standard deviation of all column.  
apply(train_Data, 1, mean)  
apply(train_Data, 1, std)  
apply(test_Data, 1, mean)  
apply(test_Data, 1, std)  
  
#change the labels of Y from 1 to 6 to the corresponding activities. 
dataset$V1[dataset$V1 == 1] <-"WALKING"  
dataset$V1[dataset$V1 == 2] <-"WALKING UPSTAIRS"  
dataset$V1[dataset$V1 == 3] <- "WALKING_DOWNSTAIRS"  
dataset$V1[dataset$V1 == 4] <- "SITTING"  
dataset$V1[dataset$V1 == 5] <- "STANDING"  
dataset$V1[dataset$V1 == 6] <- "LAYING"  
  
# read the labels.
features <- read.table("D:/2、Biostatistics/6R-Statistics/Coursea/3、Getting and Cleaning Data/WEEK3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt")  
feature <- rbind(features[,c(1,2)], matrix(c(562,"activity", 563, "subject"), nrow = 2, byrow = TRUE))  
#assign the labels to all the columns of dataset. 
colnames(dataset) <- feature[,2]  
  
#get a new data for the means of different activities.  
act_mean <- aggregate(dataset$activity, dataset, mean)  
#means of different subjects form a new data.
sub_mean <- aggregate(act_mean$subject, act_mean, mean)  
new_table <- sub_mean[,c(564,565)]  
  
#generate a new table. 
write.table(new_table, file = "D:/2、Biostatistics/6R-Statistics/Coursea/3、Getting and Cleaning Data/WEEK3/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/new_table.txt", row.name = F, quote = F)
