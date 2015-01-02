# 1. Set your working directory to your folder on P drive
# Tools -> Set Working Directory -> Choose Directory -> (navigate to
#  your folder on P drive)

# 1. Load NESARC_short.RData in my folder
load("P:/QAC/qac201/STUDENTS/section6/aselya/NESARC_short.RData")

# 2. Print out the first column of the dataset
nesarc.data[,1]

# 3. Print out the first row of the dataset
nesarc.data[1,]

# 4. Print out the "Age" variable in the dataset
nesarc.data[,3]
# or,
nesarc.data[,"Age"]

# 5. Print out Race for the first 10 participants
nesarc.data[1:10,"Age"]

# 6. Print out the first 4 variables for the first 10 participants
nesarc.data[1:10,1:4]
# or,
nesarc.data[1:10, c("IDnum","Race","Age","Sex")]


# 7. EXERCISES
#  a. Print out the 20th row of the dataset

#  b. Print out the 5th column of the dataset

#  c. Print out all variables for the 10th observation

#  d. Print out the unique id variable for all subjects

#  e. Print out all variables for the first 5 subjects

#  f. Print out (in one step) 2 variables you like

#  g. Print out (in one step) 2 variables you like, for the first 10 observations



# 8. Subsetting a dataset
# First create an object concatenating the names (strings) of all the variables  
#  that you want to keep
var.keep <- c("IDnum", "Sex", "SmkStatus", "NDScount", "smkFreq", "smkQuant")
# Create a new dataset with a new name (so you don't overwrite the original)
#  and assign to it the original dataset subsetted by the desired variables
nesarc.subset <- nesarc.data[,var.keep]

# 9. Looking at your data
#  load the "descr" library
library(descr)
freq(nesarc.data$Age)
freq(as.ordered(nesarc.data$Age))  # For cumulative percentage 

freq(nesarc.data$Race)  # Might help you with data decisions

# 10. Write out the results of the frequency tables to a text file
write(capture.output(freq(as.ordered(nesarc.data$Age))),file="Age_table.txt")
