# Set your working directory if you haven't already
# Tools -> Set Working Directory -> Choose Directory -> (navigate to
#  your folder on P drive)

# 1. Simple logical statements
1 == 1
1 != 1
2 < 3
2 <= 2
3 > 2
3 >= 4

# 2. Logical statements with workspace variables
x1 <- 5
x2 <- 8

x1 == 10
x2 > 5

# 3. Logical statements closer to data management
x3 <- rnorm(100,mean=5,sd=2)
# Check what values in x3 are above the mean (5)
x3 > 5

# 4. Same thing with a uniform distribution between 1 and 10
x4 <- runif(100,min=1,max=10)
x4 > 5

# 5. Can join multiple logical statements with "and" (&) or "or" (|)
x3 > 4 & x3 < 6  # To get the middle values
x3 < 2 | x3 > 8 # To get the extreme upper or lower values

# 5. Exercises: create your own variables and test different logical statements

# 6. Combine logical statements with subsetting.
#  If x3 is a data variable, select only those observations that are greater than
#   the mean (5)
x3[x3 > 5]

# 7. Load NESARC_short.RData from my folder

# 8. Create a new dataset that subsets nesarc.data to only people with major depr.
nesarc.depr <- nesarc.data[nesarc.data$MajorDep12mo==1,]
#  - You need a new name for the subset (nesarc.depr) because OTHERWISE
#  IT WILL OVERWRITE YOUR ORIGINAL DATASET
#  - "nesarc.data" appears twice, once because it's the object that you're
#  subsetting, and a second time because it's required in your logical statement
#  - You need $ to tell R where to access the data variable "MajorDep12mo" 
#  (i.e. from the dataset nesarc.data)
#  - You need the comma within the brackets because what you're subsetting
#  (nesarc.data) has two dimensions
#  - The logical statement goes before the comma because you're subsetting
#  rows (observations)

# 9. Exercise: Try this with your own dataset
#  Clear your workspace, load your personal .RData workspace, and create a subset
#  of your data based on an available variable.  Then try subsetting based on
#  2 variables simultaneously

# EXERCISE FOR YOUR OWN PROJECT ( Assignment 6):
#  1. clear your workspace
#  2. open a new .R script file and save it to your folder
#  3. load the .RData workspace from the Studies folder
#  4. save a copy of the .RData workspace to your own folder
#  5. create your own var.keep variable, i.e. subsett your dataset based on 
#   variables that you identified in your personal codebook
#  6. Create a subsetted dataset with your var.keep object
#  7. Write out the subsetted dataset to your folder
#  8. Submit your .R file with these commands, and the output of 3 freq. tables
#  For help, see my example code in P:/QAC/qac201/Programs/R/ and the file
#    "Creating Your Own Data Set in R.R"

