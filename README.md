# Getting-and-Cleaning-Data

##Course Project

##Introduction
The file was manually downloaded and unzippe. The UCI HAR Dataset folder and it's contents were placed in the project folder for this assignment.

The script run_analysis was sectioned into 3 major sections: 
1. Reading data from files
2. Merging the data together
3. Subsetting and tidying data


##Reading data from files
In this portion of the code, all the relevant files were read into the variables into R. Files such as x_train, y_train, x_test, y_test, activity_labels, features, subject_test.
After they were read into R, they editing of column names were done to some of them. y_train and y_test columns were named LabelID because these are the labels for the activities. 
subject_train and subject_test column was named subjectID because the data in this file represented the 30 subjects in this test. Act_labels columns were named LabelID and ActivityNames because 
this file represented the 6 activities the subjects had to perform.


##Merging the data together
This portion of the code, various files were merged together first before they could be merged to the bigger files such as x_train and x_test. Subject_train and subject_test were rbind and called subjects 
together to mirror the length of the dataset that would be created when x_train and x_test are merged together and called newdf. The same was done to y_train and y_test and called labels. x_train and x_test 
were rbind together (x_train on top of x_test). The column names of the newdf dataframe were added by using the features vector and colnames on newdf. newdf and labels were cbind together and called newdt.
newdt was cbind to subjects to give the dataframe access to the subjects of this experiment. Finally, newdt was merged with ..act labels.. not sure about this part.

##Subsetting and tidying data
The final portion of the code does the final preparation before it is writtent to a text file. First, it subsets the data frame by using columns that only gives mean and standard deviation values. A text file was created and loadedd into a vector called "new_act_labels" that contains the new deconstruction column names for the subsetted columns. They are passed into the data frame via colnames function. 
The data frame is them split on the subjectID and LabelID's and column means are taken across all the columns. The resultant would be a list and has to be converted back to a data frame. There are two nested data.frame functions. The first one converts it into a data.frame but it would have been flipped, rows are columns and columns are rows. The second data.frame call in comnbination with the parameter "t" returned it to its original form.
The labelID is now removed by merging the labels data frame with the allColMeans data frame to show the activity names and the columns. Column 1 was removed because there is no longer a need for the labelID.
The values for the means and standard deviation were of varying lengths, so across these columns values, each one was rounded to 8 significant figures for uniformity.
Finally, the data frame was written to a text file called allmeans.txt