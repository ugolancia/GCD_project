#go to the directory where the data have been 
#downloaded and unzipped
setwd("/Users/ugolancia/Desktop/github/Leek/UCI HAR Dataset")

#check
list.files()

#create a character vector of names for the 561 variables
names<- read.table("features.txt", stringsAsFactors = FALSE)

#extract a character vector from what is a data.frame
names<- names[, 2]
length(names)

#as a preliminary work try to read each file and study it
setwd("/Users/ugolancia/Desktop/github/Leek/UCI HAR Dataset/test")
list.files()
test_subjects<- read.table("subject_test.txt") 
str(test_subjects)

test_labels<- read.table("y_test.txt")
str(test_labels)

test_set<- read.table("X_test.txt")
str(test_set)



#let's read the other directory train
setwd("/Users/ugolancia/Desktop/github/Leek/UCI HAR Dataset/train")
train_subjects<- read.table("subject_train.txt")
train_set<- read.table("X_train.txt")
train_labels<- read.table("y_train.txt")

#from this exploratory phase I can see that X_test and X_train 
#have each 561 variables and the other file have only 1 variable
#so I first guess that the two Xs are the ones to be merged, 
#but reading the forum I realized that also subjects and labels 
#should have been incorporated

names(test_set)<- names
test_set[1:3, 1:5]

test_set <- cbind(test_subjects, test_labels, test_set)
test_set[1:3, 1:3]
names(test_set)[1:2]<- c("subject", "label")
dim(test_set)

setwd("/Users/ugolancia/Desktop/github/Leek/UCI HAR Dataset/train")
train_subjects<- read.table("subject_train.txt")
train_set<- read.table("X_train.txt")
train_labels<- read.table("y_train.txt")



names(train_set)<- names
train_set[1:3, 1:5]



train_set <- cbind(train_subjects, train_labels, train_set)
names(train_set)[1:2]<- c("subject", "label")

train_set[1:3, 1:3]

global<- rbind(test_set, train_set)



#let's try without dplyr


global_mean<- global[, grep("mean", names(global))]
#ok it worked...

global_std<- global[, grep("std", names(global))]

global_subject<- global[, grep("subject", names(global))]

global_label<- global[, grep("label", names(global))]

#now let's combine

glob_mean_std<- cbind(global_subject, global_label, global_mean, global_std)

#let's explore the result
glob_mean_std[1:4, 1:5]


#let's make a copy
x<- glob_mean_std



#it seems necessary to extract a vector (labels), make sub and 
#than cbind



label<- x$global_label
label<- gsub(1, "walking", label)
label<- gsub(2, "walking_upstairs", label)
label<- gsub(3, "walking_downstairs", label)
label<- gsub(4, "sitting", label)
label<- gsub(5, "standing", label)
label<- gsub(6, "laying", label)

#now we have to overwrite the column global_label with the new
#character vector label

subject<- x[, 1]
x_from_three<- x[, 3:81]

x<- cbind(subject, label, x_from_three )
x[1:3, 1:5]

global<- x
global[1:3, 1:7]

#let's now try with dplyr and summarize

library(dplyr)

x<-global
xtbl<- tbl_df(x)
xtbl

xsub<- group_by(xtbl, subject, label)
xsubmean<- summarise_each(xsub, funs(mean))

write.table(xsubmean, "/Users/ugolancia/Desktop/github/Leek/docs/final", sep = "\t", row.names = FALSE)
