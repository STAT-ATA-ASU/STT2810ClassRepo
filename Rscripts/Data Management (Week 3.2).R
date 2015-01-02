# "Data Management (Week 3.2).R", Cooper
# 9/17/14

# Work through the examples of data management tasks in this code, running these examples and then writing 
# code based on YOUR dataset to accomplish the data management tasks.

# !! Start with the dataset with just the variables you want to use and save both it and your script when you're done. 
# (Save the script as you go also.)


# Some general principles' to keep in mind: 
# - you don't want to destroy existing variables 
#    (In addition to not overwriting varibles, you have a back-up if something goes wrong and syntax you can re-run)
# - check that your code actually does what you want
#    (Look before you change a variable and after you change it. See if the results match what you expected logically.)
# - If you think your syntax is correct but you aren't getting what you want, make sure your variable names are correct.
# !! ADD YOUR OWN PRINCIPLES HERE 
#
#
#
#


########## OPEN THE DATASET FOR THE EXAMPLES
# FIRST, copy the file "hsData.Rda" and the script "Data Management (Week 3.2).R" into your student folder.
# Set your student folder as the working directory.

load ("hsData.Rda")          # the dataframe's name is d
# This is a subset of actual data, so it will have levels for the variables that aren't actually observed in this data.


############## Looking at the Data ############## 

dOrig <- d

summary(dOrig)       
summary (d)          # not very useful yet ... Run these two lines again after the data management tasks to compare them.



############## Managing the Data / Recoding Variables ###############
# Examples / Tasks below:
# 1. Rename a variable in your dataframe.
# 2. Convert a character vector into a factor with meaningful labels.
# 3. Convert blanks, white space, or some other character that represents missing values to NA
# 4. Add meaningful labels to a factor that has numeric codes (or labels you want to change) as its value levels.
# 5. Combine multiple variables into a new variable. (+ Side Trip)
# 6. Collapsing categories (i.e., levels) within a variable (into a new variable)
# 7. see other possible tasks in Ch 7 and in the pdf linked to from Ch 7
# 8. Be creative - what other management of your variable would help answer your questions? 
#    What else do you want to do with your variables? Come up with it conceptually even if 
#    you don't know how to code it (yet)!


# In each block of code, the actual work of making the change to the data is done in only some of the lines. The 
# other lines of code are there so that you know what the data looks like beforehand, you make your changes, and you
# check what the data looks like afterwards.  Know what you expect the outcome of your change to be and check that
# the code does what you wanted it to do.


# !! AFTER working through an example block of code, write code that does the same thing for one of YOUR 
#    variables, assuming that it is applicable to one of the variables you have chosen. If not, go onto the 
#    next example.
# !! The tasks below are the minimal amount you will want to do. You will likely find that you need to make more variables, adjust 
#    your variables in more ways (often more than once per variable), and will keep coming back to these steps as you proceed
#    further with your data analyses.  



# 1. RENAME A VARIABLE
        library (plyr)  # PUT this line ONCE at the beginning of your script. You need it to use the rename () function.
        
        d <- rename (d, c("Other.With.which.gender.do.you.identify." = "Gender_OTHER"))          # syntax: dataFrameName <- rename (dataFrameName, c("OldColName" = "newColName))
        
        
# !! 1. Rename at least one variable from YOUR dataset.




# 2. Convert a character vector into a factor with meaningful labels
        levels(as.factor(d$GENDER))
        summary(as.factor(d$GENDER))
        d$GENDER <- factor(d$GENDER, levels = c("1", "2", "3"), labels = c("M", "F", "Other"))     # the levels you put here are the levels that are currently there. The labels are whatever you want to call it.
        levels(d$GENDER)
        summary(d$GENDER)     # you should see the same distribution across the values as their was before making the conversion.


      # Another example of converting a character vector into a factor with meaningful labels
        levels(as.factor(d$REASON))
        summary(as.factor(d$REASON))
        d$REASON <- factor(d$REASON, levels = c("1", "2", "3", "4", "5"), labels = c("major requires", "grad requirements", "interesting", "important", "other"))  
        levels(d$REASON)
        summary(d$REASON)


#!! 2. Convert a character vector from YOUR dataset to a factor with meaningful labels. (Remember that this variable is INSIDE a dataframe).  








# 3. Convert blanks or white space to NA to represent missing values
        class (d$Gender_OTHER)                            # here, this function shows you the variable starts as a factor.  
                                                          # If it didn't (and if you didn't need to work with levels or labels),
                                                          # use d$Gender_OTHER <- as.factor((d$Gender_OTHER))
        summary(d$Gender_OTHER)                           # shows that a number of subjects did not have a response here ((WITH THIS DATA, that is because they were not asked this question))                                              
        d$Gender_OTHER[d$Gender_OTHER == ""] <- NA        # this dataset had a blank (not even whitespace) to represent missing. 
                                                          # If your dataset had the character sequence 99 to represent missing, replace "" with 99 or "99"
        d$Gender_OTHER <- droplevels(d$Gender_OTHER)      # it has converted to NA but still shows up as a levels ... thus you need to drop the unusued levels
        levels(d$Gender_OTHER)                            # this doesn't show the NAs but summary () does show how many NA values there are
        summary(d$Gender_OTHER)   


        # SIDE DISCUSSION OF LEGITIMATE SKIPS:
              # What do I do have a variable is missing and it is missing because the question was not asked?
              # (e.g., How many packs do you smoke a week? is not asked if the person said they have never smoked)
              
              # Two possible decisions:
              # A) Recode their NA to say it was as if they answered that they smoked 0 packs a week.
              # B) Leave it as NA.  When you report your analyses, say that these are looking at participants who smoked.
              # Make your decision based on what your research question is and what analyses you are doing.
              
              # Following option A:
              # syntax: dataframeName$varName [is.na(dataframeName$varName)] <- "0"    # replace with your variables and values
              # Following option B:
              # leave the values as NA and R automatically excludes them from most analyses


# !! 3. Write code (as needed) to have missing values in the desired variables in YOUR dataset be coded with NA





# 4. Add meaningful labels to a factor that has numeric codes for its values. Add meaningful labels to a factor with already existing levels or labels

      # EXAMPLE: numeric levels that need recoded to have meaningful labels
      levels(d$DEGREE)
      summary(d$DEGREE)
      d$DEGREE <- factor(d$DEGREE, levels = c("1", "2", "3", "4", "5", "6", "7", "8"), labels = c("HS", "Assoc", "BA", "MA", "doctorate", "cert", "No Deg", "Other"))  
      levels(d$DEGREE)
      summary(d$DEGREE)
      
      
      # EXAMPLE: Shorten the labels used.  (This, as well as elsewhere, can include the introduction of levels and labels 
      #          that were possible but weren't observed in your data.)
      levels(d$MAJOR_STATUS)
      summary(d$MAJOR_STATUS)
      d$MAJOR_STATUS <- factor(d$MAJOR_STATUS, levels = c("I do not know yet.", "My intended major is", "My current major is", "Other"), 
                               labels = c("unknown", "intended", "current", "other"))  
      levels(d$MAJOR_STATUS)
      summary(d$MAJOR_STATUS)

# !! 4. Add meaningful labels to the factors YOU are using in YOUR dataset.
        







# 5. Combine multiple variables into a new variable 
      # INTEREST1, INTEREST2, and INTEREST3 each measure a different part of a statstics course that someone may be interested in.
      # You can find their average to get an overall level of how interested someone is in the course.

        d$avgInterest <- (d$INTEREST1 + d$INTEREST2 + d$INTEREST3) / 3
        
        # This dataset in fact already had this variable, INTEREST.COMP
        
        # A SIDE TRIP INTO DECIMALS, EQUALITY, AND DISPLAY OF DECIMALS
                d$avgInterest == d$INTEREST.COMP   # but, when you run this, you get a vector that has Trues and Falses
                
                # let's look at the data to see what is going on ...
                d[,c("avgInterest", "INTEREST.COMP")]    # This prints out each row in our dataset for these two variables. They look the same.
                
                # The test for equality, ==  , is looking for an exact match.  The numbers actually have more digits than are shown in the output.
                
                options (digits = 22)                    # 22 is the max number for this value ... Usually, you will want to set digits to about 3
                d[,c("avgInterest", "INTEREST.COMP")]    
                options (digits = 3)                    
                d[,c("avgInterest", "INTEREST.COMP")]    



# !! 5. combine multiple variables into a new variable in YOUR dataset --- you can use average, sum, differences, rates, etc.








# 6. Collapsing categories (i.e., levels) within a variable (into a new variable)
    # Let's recode each of the majors that are listed under INTMAJOR (a student's intended major). You can have
    # however many levels you want in the new variable.
    # See more examples in the pdf linked to in Chapter 7.
    # Do NOT overwrite the existing variable(s). Rather, make a new one.

        d$dblMajor <- 0            # start by making a new variable in your dataframe.       another option is d$dblMajor <- rep(NA, nrow(d))
        d$dblMajor[d$INTMAJOR == "Chemical Engineering/Economic" | d$INTMAJOR == "Computer Engineering/Computer Sciences" | d$INTMAJOR == "Linguistics and Neuroscience" | d$INTMAJOR == "Sciences and Money"] <- 1
        summary (d$dblMajor)
        table(d$INTMAJOR, d$dblMajor)   # another way of looking at the data ... !! try switching which variable comes first
        
        # When you make the values all 0 to start with, then that is the default value UNLESS you change it when certain conditions are met.
        # When you make all the values NA to start with, you need to assign a value to every observation.
        # In either case, you NEED a principled / theoretical reason to categorize observations in the manner you used.  
        #    (Here, for instance, you might wonder if some of these really reflect potential double majors.)


##!! 6. make a new variable that consists of collapsed categories from one of your existing variables.





## !! How does the output from     summary(dOrig)     and     summary(d)      differ?
summary(dOrig)
summary(d)

## !! When you look at the output from summary(d), what other variables do you need to fix?  (There are at least two that need fixed.)



######### !! See ch 7 and pdf file linked to from chapter 7 for more examples of the type of data management tasks you can apply to your data.  
## (We've only gone through the section on "SUBSETTING YOUR DATA"  and are not yet into the statistical techniques that are after that.)


######### !! Be creative. Even if you don't know how to code it, what else do you want to do to your variables?