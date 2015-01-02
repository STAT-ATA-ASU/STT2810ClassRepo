
### LIBRARIES BEING USED and some general set-up
library (descr)
library (ggplot2)
options (digits = 2)


### IMPORTANT: All of these graphs need cleaned up - titles, labels, etc.
### ****See your other handouts for how to add arguments to the functions to do that.****
### What to pay attention to here is where the DV goes and where the IV goes
###  and what type of graph structure is produced.




### Create some sample data to play with here

# This sample data set has 12 subjects (ID column has their unique identifiers).  
# They are in either their junior or senior year of school.
# They rated their interest level on both a task and the task's topic area. 
# Their interest ratings are going to be treated quantitatively here, with higher 
# scores indicating higher levels of interest.
# They indicated if they thought their interest level in the task would decrease, 
# increase, or stay the same. This is a categorical factor with 3 levels.

ID <- 1:12
year <- c("junior", "senior", "senior", "junior", "junior", "senior", 
          "junior", "senior", "senior", "junior", "junior", "senior")
taskInterest <- c(4,4,1,1,2,5,4,3,3,5,5,NA)
topicInterest <- c(5,5,2,2,3,2,2,1,4,4,4,4)
taskInterestChange <- c("stay the same", "decrease", "increase", "increase", "increase", 
            "decrease", "stay the same", "stay the same", "decrease", 
            "increase", "increase", NA)

d <- data.frame (ID, year, taskInterest, topicInterest, taskInterestChange)



###%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%###
#########                ggplot2 GRAPHICS              ##########
###%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%###


#frequency distributions for a categorical OR quantitative variable
ggplot(d, aes(x=taskInterest)) + 
  geom_bar(stat="bin", binwidth = 1)


# Put your DV on the y-axis and your IV on the x-axis.
# THe third variable can be named under fill (other options exist).


# plotting two quantitative variables
ggplot(d, aes(x=taskInterest, y=topicInterest)) +
  geom_point(shape=1, size = 4)


# plotting means of a quantitative DV with a categorical IV
ggplot(d, aes(x=taskInterestChange, y=taskInterest)) + 
  stat_summary(fun.y="mean", geom="bar")

# multivariate plotting in different panels:
ggplot(d, aes(x=taskInterestChange, y=taskInterest)) + 
  facet_wrap(~ year) +
  stat_summary(fun.y="mean", geom="bar")


# multivariate plotting in the same graph:
ggplot(d, aes(x=taskInterestChange, y=taskInterest, fill = year)) + 
  stat_summary( fun.y="mean", geom="bar", position = "dodge")


### EXAMPLES OF SOME OF THE FORMATTING POSSIBILITIES IN GGPLOT2
ggplot(na.omit(d[,c("taskInterestChange", "taskInterest", "year")]), 
               aes(x=taskInterestChange, y=taskInterest, fill = year)) + 
  stat_summary( fun.y="mean", geom="bar", position = "dodge") +
  labs(x = "Prediction of Change in Interest", y = "Mean Task Interest") +
  ggtitle ("Interest Ratings by Year and Predicted Change") + 
  theme_classic () + scale_fill_manual(values=c("red", "green"))


# ! IF you encounter the situation that one of your groups is completely missing,
# as is shown in this example here, then, talk with us about the function expand.grid
# It isn't something you need to know how to fix since it is unlikely to occur

###%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%###
#########                BASE R GRAPHICS              ##########
###%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%###

#################################################### 
######### Plotting Frequency Distributions ######### 
#################################################### 

# freq() produces a bar graph, it will run on 
# both quant and categ variables but is most appropriate for categ variables
# from the package descr
freq(d$taskInterestChange)



# hist() produces a histogram will only run on quantitative variables
hist(d$taskInterestChange)




#######################################################  
######### Plotting two quantitative variables ######### 
####################################################### 

plot (taskInterest ~ topicInterest, data = d)       
# putting taskInterest before the tilde tells R to treat it as the DV and 
#    put it on the y-axis
# note how basic (and unlabelled!) the graph is
# because we name the dataset as an argument to the function, 
#    you don't need the $ notation





###################################################################################  
#########    Plotting Frequency Distribution WITHIN different categories   ########
#########    Quantitative DV (treated as categories) and Categorical IV    ########  
#########    Categorical DV and Categorical IV                             ########   
###################################################################################  

# Here, your y-axis is the proportion of responses on your DV that are falling into 
#  a specific level of the DV for that level of the IV.  LOOK AT THE OUTPUT TO PARSE THIS.

# because you are not plotting the raw data, you have to find the proportions first.

# My example treats the different levels of taskInterest as categorical here even though
# it could also be treated as a quantitative variable. With this syntax, R makes it 
# categorical.

# I'm breaking the command down into steps.
# TIP: By breaking down code into steps like this, it is easier to debug.
# It is also easier to update the code when it is in steps rather than 
#  one long, complicated line.


interestChangeTable <- table(d$taskInterest, d$taskInterestChange)  
  # this type of type is called a CROSSTABS, a two-dimensionsal frequency table.
  # Typical to put the DV first and the IV second.
  # It shows the values the variables takes even when it is a quantitative variable.
  # by assigning the TABLE OUTPUT to a variable, I can use it without repeating the syntax
  #  to create the table.
  # From this example, we see that 2 students with a rating of 1 said they would increase.

interestChangeTable       # running the syntax with just the name of the variable shows it

interestChangeTableProp2 <- prop.table(interestChangeTable, margin = 2)  
  # the 2 is the value passed to the argument 'margin' that is part of this function.
  # Using a value of 2 tells R to find column percentages.  Check that this is what you wanted.
  # here, it shows us that 67% of people who said they would stay the same had a rating of 4.


# The margin you select depends on the order you originally used in your initial table command
#  and what your question is.  Put the DV is first in the table command (putting it values in the rows)
#  and then you use the column (2) percentages.


barplot(interestChangeTableProp2[])
  # you could have also written barplot(interestChangeTableProp2[1:5,])  
  #   which tells it you want to plot all the rows
  # If your DV has only 2 levels, plot only one of the rows**



# as nested syntax:
barplot(prop.table(table(d$taskInterest, d$taskInterestChange), 2))

## !! Which do you find easier to write and to read - broken into steps or nested???


# WITH BETTER FORMATTING:





########################################################################  
#########    Plotting Means of DV WITHIN different categories   ########
#########    Quantitative DV and Categorical IV                 ########     
########################################################################  

# Because you are plotting the means (and not raw data), 
#    you have to find the means first.

# syntax from iBook.    by()
grpMeans <- by(d$topicInterest, d$taskInterestChange, mean, rm.na = TRUE)
  # NOT easy output to use!

# RECOMMENDED SYNTAX to get means:
grpMeans <- tapply (d$topicInterest, d$taskInterestChange, mean, rm.na = TRUE)
  # either output can go directly into the barplot command (or could nest the rhs syntax)
  # What this command says: apply the function mean to the DV topicInterest for EACH of
  #   the levels in the IV taskInterestChange


barplot(grpMeans)
  # Here, the example actually shows that people who said their interest would 
  #  decrease were the ones who had the highest mean interest rating in the task.





########################################################################  
#########                 Multivariate Graphing                 ########     
########################################################################  

# Your iBook has examples using ftable (like the table command, just with better formatting)
# This code builds on the previous syntax. 

grpMeansNew <- ftable(by(d$taskInterest, list(d$year, d$taskInterestChange), mean))
# BECAUSE it has 3 variables here, nesting the "by" syntax 
#   within the function ftable is what makes the output readable

barplot(ftable(by(d$taskInterest, list(d$year, d$taskInterestChange), mean))), beside = TRUE)
## *** NOTE THE IMPORTANCE OF the argument "beside" ****


# Another way to do multivariate graphing, is to use logical subsetting and 
# give the graphing command a subsetted dataset each time.  
# (This might be easier to think through). Ask us to work with you on this.!!



