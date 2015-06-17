# GCD_project
Getting and Cleaning Data project

In this document I will give a description of what run_analysis.R is doing, according to the course project request (following)

"Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement. Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names. 
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject"


1) I went to the directory where the data have been downloaded and unzipped. The path in the script is set for my mac and it needs to be modified according to where you have your UCI HAR Dataset, that is anyway loaded in the github repo.

2) after checking I created a character vector with of names for the 561 variables. The first passage names<- read.table("features.txt", stringsAsFactors = FALSE) gave me a dataframe and then I extracted the vector of names (each single variable had a name)

3) as a preliminary work I  read each file and studied it. In total I read six files, either from the test or the train directory

4) from this exploratory phase I can see that X_test and X_train have each 561 variables and the other file have only 1 variable so I first guessed that the two Xs are the ones to be merged, but reading the forum I realized that also subjects and labels should have been incorporated. 

5) I inserted the names separately for the test_set and for the train set 

6) With the cbind funcion I created two dataframes, for test and train directory respectively

7) I had two data.frame, each of the same 563 variables and, as expected, with a different number of rows. With the rbind function I created a data.frame from the two smaller ones.

- until point 7 I complied to the first task required -


8) Now I had to extract only the variables with mean or std in the names. At first I tried with dplyr but it gave me back an error message, so I decided to proceed with the base package functions.

9) With the help of grep function I succeeded - global_mean<- global[, grep("mean", names(global))] - . I had to do four different files and then combine them with the cbind function and I ended up with a dataframe of 10299 observation and 81 variables

- point 8 and 9 completed the second task required -

10) to name the activities in the data set with descriptive activity names, I extracted a vector from the dataframe (the column with the activities) and then, with the gsub function I did the six substitution needed. After this step I overwrited the column global_label with the new character vector label, using cbind.

-point 10 completed the third task required - 

11) I decided to leave the variables names as they are because the codebook could be sufficient (and better) to clarify each single variable

- point 11 refer to the fourth task required - 

12) the last task required was performed using dplyr with the functions "group_by (with to variables to group by: subject and activity) and summarise_each.

- point 12 completed the last task - 

13) to upload the result the write.table function was employed, as indicated


