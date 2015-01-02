# 1. Change working directory to your student folder on P drive
# ALWAYS DO THIS WHEN YOU START RSTUDIO
setwd("P:/QAC/qac201/STUDENTS/Section2/aselya")
# Or go to Tools -> Set Working Directory -> Choose Directory

# 2. Basic assignment
x <- 2 + 3

# 3. Check that it worked
x

# 4. Other variable assignment with different mathematical operations
x2 <- 3*5
x3 <- 10/2
x4 <- 4^3

# 5. Basic functions with 0 or 1 inputs
x2 <- sqrt(4)
x2  # Notice since we used the name "x2" twice, we wrote over the first value
ls()
x.random <- rnorm(100)

# 6. Function c() for concatenation
#  Can take any number of inputs, and binds them together into one object
sbj.age <- c(18, 21, 19, 17)
keep.vars <- c("age", "race", "gender")  # "" indicates "strings"

# 7. Function rep() for repeating
#  First input is what you want to repeat
#  Second input is how many times you want to repeat it
gender <- rep("male", 5)

# 8. Exercise: In one line of code that combines c() and rep(), create:
#  a. one object containing "a a a a a b b b b b"
#  b. one object containing "a b a b a b a b a b"

# 9. Read in data from a text file
#  Use the function read.delim()
#  First input: filename (including filepath and extension) of the text file
#  Second input: header=T (tells R that the first row contains variable names)
#  Third input: sep="\t" (tells R what separates cells in the data)
mydata <- read.delim("P:/QAC/qac201/STUDENTS/Section2/aselya/NESARC_short.txt",
                     header=T, sep="\t")

# 10. Look at what you've imported above
#  Click on the name in the Workspace window
dim(mydata)
head(mydata)

# 11. Write out the dataset to a text file
#  You might do this after you've performed data management and need to write
#   out the data to use in another program or for others to use
# Use function write.table()
#  First input: what workspace object to write out
#  Second input: the filename including extension to write the data to.  Include
#   filepath if necessary (defaults to your working directory which you set to
#   your folder on P drive)
#  Third input: sep= (e.g. "\t" for tab-delimited, "," for .csv, etc.)
#  Fourth input: row.names=F (suppresses printing R's labels/numbering for the rows)
write.table(mydata, file="NESARC_data_out.txt",sep="\t", row.names=F)


# 12. Clear your workspace and load the shortened NESARC workspace from my folder
#  Go to the Workspace window and click Load -> Load Workspace and navigate to
#   STUDENTS/Section2/aselya/ and select NESARC_short.RData
#  Or type
load("P:/QAC/qac201/STUDENTS/Section2/aselya/NESARC_short.RData")

# 13. Save the workspace in your own folder
#  Go to the Workspace window and click Save -> Save Workspace As and navigate
#   to your own folder
#  Or type
save("P:/QAC/qac201/STUDENTS/Section2/aselya/NESARC_short.RData")


