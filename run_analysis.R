library(dplyr)
library(tidyr)

#Load Test data
test_data <- read.table("./data/X_test.txt")
test_subject <- read.table("./data/subject_test.txt", col.names = c("subjectID"))
test_labels <- read.table("./data/y_test.txt", col.names = c("label"))
test_data_full <-  cbind(test_subject, test_data, test_labels)

#Load Train data
train_data <- read.table("./data/X_train.txt")
train_subject <- read.table("./data/subject_train.txt", col.names = c("subjectID"))
train_labels <- read.table("./data/y_train.txt", col.names = c("label"))
train_data_full <- cbind(train_subject, train_data, train_labels)

#Load lookup table data
activity_labels <- read.table("./data/activity_labels.txt")
var_names <- read.table("./data/features.txt", stringsAsFactors = FALSE)

#Combine test and train data to create full data set
full_data <- rbind(test_data_full, train_data_full)


#Add headers for some variables
names(full_data)[grep("^V", names(full_data))] <- var_names$V2

#Select only variables involving only mean or std data
mean_and_std_data <- select(full_data, contains("mean") | contains("std")| subjectID | label)

#Tidy up variable names
names(mean_and_std_data) <- gsub("^f", "frequency", names(mean_and_std_data))
names(mean_and_std_data) <- gsub("^t", "time", names(mean_and_std_data))
names(mean_and_std_data) <- gsub("Acc", "acceleration", names(mean_and_std_data))
names(mean_and_std_data) <- gsub("Mag", "magnitude", names(mean_and_std_data))
names(mean_and_std_data) <- tolower(names(mean_and_std_data))

#Join tables to get activity labels
mean_and_std_data <- merge(x = mean_and_std_data, y = activity_labels, by.x = "label", by.y = "V1")


#Generate tidy data frame averaging data 
tidy_data <- mean_and_std_data %>%  
             select(-label) %>% 
             rename(activity = V2) %>% 
             group_by(activity, subjectid) %>% 
             summarise(across(starts_with("time")|starts_with("frequency")|starts_with("angle"), mean)) %>% 
             arrange(subjectid)
                      

write.table(tidy_data, "tidy_data.txt")





