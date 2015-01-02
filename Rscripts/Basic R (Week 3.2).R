##### Jennifer Cooper

#### Working in a group of 3, go through the following script, 
#### reading the comments and trying out the examples and exercises as you go. Add your code
#### to the script.

#### You will need to open two datasets - the caterpillar one in order to run the examples AND
#### the dataset that you have selected for your project.

#### This script takes you from loading a previously saved dataframe, to 
#### examining your variables, to classes of variables, to basic indexing, 
#### and then to frequency tables. There are other little things included as well.

#### At each step where you are to write your own code, there are two exclamation marks (!!) 
#### in a comment. Most of the code you write should be about YOUR dataset.

#### Once your group has finished working through this script together, save the 
#### R file (this script) and email it to each other so you have it for your notes.
#### Save your data files and scripts in your student folder.

#### At that point, you can either a) move onto the Data Management script or 
#### b) work on the frequency tables assignment.


#### Remember: Trial and Error is good. Prolonged crashing and burning isn't needed - ask questions.






###########################################################################
###########################################################################
#################             LOAD YOUR DATA              ################# 
###########################################################################
###########################################################################

#### LOAD YOUR DATASET (The dataset is either a workspace or a .Rda file.)
#### You can load a dataset in one of three ways:
#### a) using syntax.  The command below uses the folder structure on a PC.  
####    It will be different on a mac.
#### b) using the working directory as shown in the video (Session > Set Working 
####    Directory > browse to folder) and then by opening the data file shown in 
####    the files tab in one of the windows in RStudio.
#### c) By navigating to the file in the folder structure outside of R Studio, 
####    opening it, and if necessary, selecting the program (R Studio) to use.

# Use the file in the study's data folder with the extension .RData or .Rda


#### FILE LOCATIONS (and code to run if on a PC)
load("P:/QAC/qac201/Studies/Caterpillar/Data/Caterpillar.RData")

## Also load one of the following datasets by 
## !! uncommenting that line of code.

# load("P:/QAC/qac201/Studies/AddHealth/Data/AddHealth_pds.RData")   
# load("P:/QAC/qac201/Studies/Gapminder/Data/gapminder.RData")
# load("P:/QAC/qac201/Studies/MarsCrater/Data/marscrater_pds.RData")
# load("P:/QAC/qac201/Studies/NESARC/Data/NESARC_pds.RData")
 

CaterpillarOrig <- Caterpillar        # good practice to make it easy to go back to an earlier version

## !! make an original (back-up) copy of YOUR dataset


###########################################################################
###########################################################################
#################           EXAMINE YOUR VARIABLES        ################# 
#################           also goes over factors        ################# 
###########################################################################
###########################################################################

#### FYI, in R, there is a maximum number of rows that will be output to the screen - so at this
#### point, with all the variables still in the file, you won't see everything.  Nor will you see
#### all the rows when you do     View(dataFrameName)      because there are more observations than
#### R will display there.

View(Caterpillar)                     # view of dataset doesn't update on its own; 
                                      # close tab and re-run command after changing any 
                                      # of the variables.
names (Caterpillar)
length(Caterpillar)                   # number of variables
nrow (Caterpillar)                    # number of observations

## !! Find the names of the variables in YOUR dataset.  
## !! Look through how the rows and columns are structured after using the view function.
## !! How many rows are there? This is equal to the number of observations in your dataset.
## !! How many variables are there in your dataset?

#### the summary function
#### For factors (aka, categorical variables), R outputs the number of observations in each category.
#### For quantitative variables, it gives you the minimum, mean, and maximum, along w the 25th, 50th (mode), 
#### and 75th percentiles.  Those are the values on the variable for which 25% (or 50 or 75%) of 
#### the other observations are below. For character strings, this function gives you the number of
#### valid (i.e., not missing) observations on that variable.  For all of these classes, 
#### the output also gives the number of observations that are missing, but the Caterpillar 
#### dataset doesn't seem to have any missing values.


summary(Caterpillar$numberlvs)
## !! Run the summary function on a quantitative variable from your dataset.


summary(Caterpillar$host2)
summary(as.factor(Caterpillar$host2))
## !! How is the information you get about the host2 variable different 
## in the output that comes from the two preceding lines of code?


## I used the as.factor () function to temporarily turn this variable from a vector of 
## character strings to a factor.  In some datasets, your variables are already going to be factors.
## In the caterpillar set, the categorical variables have not been saved as factors yet. For your
## analyses, you might need to turn character variables into factors where needed.

## !! Why is making it a factor in the above line of code only temporary?




#### Let's make the rest of the categorical variables in the Caterpillar dataframe into factors.
## assignment (the R term for storing something in a variable)
## Here, I am telling it to take what is on the RHS (right-hand-side) and store it in the variable 
## named on the LHS (left-hand-side).  In this case, it is OVERWRITING what was originally there.
## This is a situation that you would usually want to avoid when re-coding variables.  (But that's
## also why you have a record of your code and a back-up copy of the original dataframe.)
#### The assignment operation here means that you are actually changing the dataframe.  You have
#### to tell it that you want the site variable inside the dataframe Caterpillar.

Caterpillar$site <- as.factor(Caterpillar$site)            
Caterpillar$host2 <- as.factor(Caterpillar$host2) 
Caterpillar$birdtreatment <- as.factor(Caterpillar$birdtreatment)            
Caterpillar$cat_species <- as.factor(Caterpillar$cat_species)          

#### You can also run the summary function on an entire dataframe.
summary(Caterpillar)

## !!How is the information you get about host2 different when you run summary(Caterpillar) and 
## when you run summary(Caterpillar$host2)?

## !! Run the summary function on a categorical variable from your dataset.  
## If it is not already a factor, turn your chosen variable into one.



###########################################################################
###########################################################################
#################        SUBSETTING YOUR VARIABLES        ################# 
#################            also more on factors         ################# 
###########################################################################
###########################################################################

## Here, the goal is to reduce the number of columns that are in your dataframe.
## Because you have a record of all your code, you can always re-run all the following
## steps later if/WHEN you decide that you need to have more variables.

var.keep <- c("ID", "site", "host2", "birdtreatment", "numberlvs", "cat_species")
myCat <- Caterpillar[,var.keep]

summary(CaterpillarOrig)     # compare the output of the function summary on both dataframes
summary(myCat)

## !! Among you and your partners, choose a set of 5 variables, including the unique identifier, 
##    from your dataset.  Create a new dataframe that has only those variables in it.
##    At least one of the variables should be quantitative and at least one of them should be a 
##    factor.

#### STEPPING ASIDE FOR A MOMENT TO COVER MORE ON FACTORS in some of the dataframes.
      ## Many statistics programs require dummy coding (in which, for example, YearInSchool,
      ## would become 4 separate variables: Frosh, Soph, Jr, Sr, and each of those variables would be coded
      ## as 0 or 1, with a 1 indicating that a student was in that particular year.)  R is able to do 
      ## that invisibly behind the scenes. Thus in R, you would use ONE variable, titled YearInSchool.  It would 
      ## be a factor and it would have 4 different values (Frosh, Soph, Jr, Snr). In R, you can actually use strings
      ## in quotation marks as the values of a factor.  This makes the analyses and data management much more
      ## intuitive, but it does add some extra steps.

      ## Because the datasets are set up to be used in any of the sections, they use dummy variables and they 
      ## don't have strings as the values on the factor variables.  It makes things much easier down the line to 
      ## re-label the factor levels now. Some terminology: a factor has values and those values come from a set of levels.  
      ## Another way of thinking about this:

      hairColor <- c(1, 2, rep(3, 5), 4, rep(2, 5), 3, rep (1,2))
      ## codebook: brown = 1, black = 2, gray = 3, blond = 4
          ## !! I introduced a new function here: rep()    
          ##    Look at the contents of the variable hairColor (type it at the command prompt)  
          ##    How many observations are there?  (What function(s) could you use to tell you how many observations there are?)
          ##    How does the function rep () work?  If you're not sure, type "? rep" without quotation marks at the command prompt to access help.
      ## when set up this way, R treats hairColor as a numeric variable.  
      ## !! What would you expect from summary(hairColor)?  (try it)
      ## !! make hairColor into a factor. Run the summary function again to make sure hairColor is now a factor.

        ## This still isn't particularly useful ... we want to add the labels from the codebook to the variable itself.

###################### RELABELING FACTOR LEVELS ###################### 
## 1) find out the existing levels of the variables.  (This won't work if the variable is not a factor)
levels (hairColor)
## 2) The new levels must be in the same order as the previously existing levels.
## 3) Use the assignment operator to assign a new vector of strings (your new labels) to "levels(varName)".
levels(hairColor) = c("Brown", "Black", "Gray", "Blond")

## !! How can you check to see if it worked? (There are multiple ways to do this.)


## !! Add the labels based on the codebook information to at least one of the categorical variables you have in YOUR dataset.


## FYI: I'll help you deal with moving from multiple dummy variables to a single variable as necessary when it comes up. Depending on 
## what you are doing with your data, it may or may not be necessary.


## !! Run the summary function on your dataframe (the one with the reduced number of variables 
##    that has the categorical variable as a factor with meaningful labels)





###########################################################################
###########################################################################
#################                BASIC INDEXING           ################# 
#################            also more on factors         ################# 
###########################################################################
###########################################################################

#### This is built from the material covered in class on Monday and the readings/videos for that class.

myCat$site       # refers to this one variable in the dataframe
myCat[,3]        # also refers to this one variable (site) in the dataframe
myCat [2,3]      # refers to the single value in the 2nd row, 3rd column value
myCat$site [2]   # gives the 2nd value of the variable site in the dataframe Caterpillar
myCat [2,]       # refers to the 2nd row in the dataframe, all variables
myCat [2:3, 1:4]  # gives you the 2nd and 3rd rows in the data frame, with the 1st, 2nd, 3rd, and 4th variables for each

# It is more helpful to use variable names because those won't change when you add or remove columns and when you re-sort the data.

myCat [c(2,4), c("ID", "cat_species")]  # gives you ID and cat_species values of the 2nd and 4th rows in the dataframe
myCat [myCat$ID == "C611-114", ]  # gives you all variables for the ID C611-114




## !! These are the exercises you started in class on Monday. It is more important to get to frequency tables than to work on this,
##    especially as I have now provided hints to the answers.  When working with indexing, you have to remember that you need to specify
##    which rows you want and which columns you want - those are two separate things.  Figuring out how to specify the rows that you want and
##    how to specify the columns that you want is dealing with the logic of what you want from your data. 
##    That's the important [and tricky] part here.

## !! So, take a look at the time. If it is before 5, you can work on these if you want.  Otherwise, look through them on your own and
##    jump down to the next section on frequency tables.


############# EXERCISES on basic indexing #############  
# 1. Find the species of the caterpillar whose ID is H630-57
# ANSWER HINT: combine two of the examples above:      myCat [myCat$ID == "C611-114", ]        and   myCat [c(2,4), c("ID", "cat_species")]  
#  There are multiple ways you could do this.

# 2. Find the ID numbers of the caterpillars in the species Zale lunifera
# ANSWER HINT:   In the example above:   myCat [myCat$ID == "C611-114", ]  
#   you asked it first for the row(s) in which the value of ID was C611-114.  THen you asked it for all the columns.
#  Here, you want to ask it for all the _columns_ in which the caterpillar species equals "Zale lunifera" (note capitalization) and
#  then you want it to output all the rows.

# 3. Create a dataframe that has only the observations that have more than the mean number of leaves
# ANSWER HINT: This is more complicated. To do this, you need to first use summary(myCat$numberlvs) to find the mean.  Then, you will
# write a statement to tell it which rows you want from the dataframe.  The rows you want are those whose number of leaves is more
# the value of the mean.  Previously we looked for myCat$ID == a value.  Now, you want myCat$numberLeaves > some number.  
#   FYI: numbers don't go in quotation marks if you want them treated as numbers.
#   The next step here is that you want all the columns that go with that row.
#   This question THEN involves assigning that subset of the data to a new variable.

#   4. Which caterpillar species is the most frequent in this subset (the one with observations having more than mean number of leaves)?
#     ANSWER HINT: using the commands as.factor () and summary () will give you this information.

# 5. figure out how you can use the function tail() to print the last 10 rows of your dataset

# 6. If you finish the above, play around with the code: hist(myCat$numberlvs) 
# to produce a more formatted histogram (a frequency distribution plot) of number of leaves



###########################################################################
###########################################################################
#################                FREQUENCY TABLES         ################# 
###########################################################################
###########################################################################
#install.packages("descr")          # only need to install a package on a computer once. If it can't find the library, uncomment and run this line.
#install.packages("Hmisc")

library (descr)                    # I would usually have put library statements at beginning of script
library(Hmisc)
 
freq(myCat$host2)                   # if cumulative percentages don't make sense, don't use as.ordered ()
freq(as.ordered(myCat$numberlvs))

## !! Create frequency tables for the variables your group is working with today

label(myCat$numberlvs) <- "Number of Leaves"        
       # the generated label will only work with functions inside Hmisc package
       # only labels the outputted table

freq(as.ordered(myCat$numberlvs))
freq(as.ordered(myCat$numberlvs), xlab = "Number of Leaves", ylab = "Frequency")  # label the graph



###########################################################################
###########################################################################
#################                Saving Your Work         ################# 
###########################################################################
###########################################################################

  # save your main datafile
  # !! This is the command for the PC.  Have one of us help you if you are on a mac.
save (myCat, file = "P:/QAC/qac201/STUDENTS/section6/jcooper01/myCat_saved.Rda")

  # next time, use  the following syntax to load the variable into your workspace
  # again, this is the filepath on a PC.  On a mac, you can navigate to it as discussed in the first part of this file.

load ("P:/QAC/qac201/STUDENTS/section6/jcooper01/myCat_saved.Rda")

# save your script using File, Save

# save your workspace, consisting of all the variables you have created
save.image(file="workspace1.RData")


## !! write the commands to save your datafile from today (if you want)
## !! definitely save the script with your added comments and email it to everyone in the group




############### HELPFUL KEYSTROKES (PC) ############### 

# Ctrl-Enter --- runs a line (or highlighted lines) of code from the script
# Esc --- if you have an command that is unfinished in the console that you want to discard.
#     --- will sometimes stop a command that is running
# up-arrow or down-arrow --- cycles through previous lines run in the console
# Ctrl-L --- clears the console





###########################################################################
###########################################################################
#################                WHAT TO DO NOW           ################# 
###########################################################################
###########################################################################

#Options:
# work on the frequency assignment
# work on the data management assignment --- but NOT until you have read the book chapter, read the handout, and watched the video in Ch 7

