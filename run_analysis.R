# download.file()

## --- Reading data from files --- ##

#all the training data
x_train <- read.table("./G-C-D/Project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./G-C-D/Project/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./GCD/Project/UCI HAR Dataset/train/subject_train.txt")

#all the test data
x_test <- read.table("./G-C-D/Project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./G-C-D/Project/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./G-C-D/Project/UCI HAR Dataset/test/subject_test.txt")

#getting column names
act_labels <- read.table("./G-C-D/Project/UCI HAR Dataset/activity_labels.txt")
features <- read.table("./G-C-D/Project/UCI HAR Dataset/features.txt")
new_act_labels <- read.table("./G-C-D/Project/new_activity_labels.txt")

names(y_train) <- "LabelID"
names(y_test) <- "LabelID"
names(subject_train) <- "SubjectID"
names(subject_test) <- "SubjectID"
names(act_labels) <- c("LabelID", "ActivityNames")

## --- Merging data --- ##

#training and test data
subjects <- rbind(subject_train, subject_test)
labels <- rbind(y_train, y_test)                                        #<- adding labelID
newdata <- rbind (x_train, x_test)                                      #<- merging train and test
names(newdata) <- features[,2]                                          #<- adding column names
newdt <- cbind (labels, newdata)                                        #<- merging labels with new
newdf <- cbind(subjects, newdt)                                         #<- merging subjectID



## --- Subsetting and Tidying --- ##

#creating a vector of column indices that would represent the mean and sd - 
mean_sd_cols <- c(1:8,42:47,82:87,122:127,162:167,202:203,215:216,228:229,241:242,
                  254:255,267:272,346:351,425:430,504:505,517:518,530:531,543:544)


sub_newdf <- newdf[,mean_sd_cols]
colnames(sub_newdf) <- new_act_labels[,1]

#splits and does means on columns
allColMeans <- sapply (split(sub_newdf[,1:68], list(sub_newdf$SubjectID, sub_newdf$LabelID)), colMeans)

allColMeans_inv <- data.frame(t(data.frame(allColMeans)), row.names = NULL) #<- flips rows and columns

allColMeans_inv <- merge(act_labels, allColMeans_inv, by.x = "LabelID", by.y = "LabelID") #<- merging labelNames -- may need to move

allColMeans_inv <- allColMeans_inv[, 2:69]

#This is rounding all values to 8 significant figures
for (i in 1:nrow(allColMeans_inv)) 
{
  
  for (j in 2:ncol(allColMeans_inv))
  {
    allColMeans_inv[i, j] <- round(allColMeans_inv[i, j], digits = 8)
  }
  
}

write.table(allColMeans_inv, file = "./G-C-D/Project/allmeans.txt", row.names = FALSE)


