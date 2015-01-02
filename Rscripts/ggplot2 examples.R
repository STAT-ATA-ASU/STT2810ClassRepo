## Example of univariate, bivariate, and multivariate graphs in ggplot2



### LIBRARIES BEING USED and some general set-up
library (descr)
#install.packages("ggplot2")
library (ggplot2)
options (digits = 2)


### IMPORTANT: All of these graphs need cleaned up - titles, labels, etc.
### ****See your other handouts for how to add arguments to the functions to do that.****
### What to pay attention to here is where the DV (response variable) goes 
###    and where the IV (explanatory variable) goes
###  and what type of graph structure is produced.




### Create some sample data to use in the examples in this file

# This sample data set has 12 subjects (ID column has their unique identifiers).  
# They are in either their junior or senior year of school.
# They rated their interest level on both a task and the task's topic area. 
#   As these are ratings, they are actually on an ordinal scale!
# I've made the decision to treat the interest ratings as quantitative
#   variables here, with higher scores indicating higher levels of interest.
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




################################################################# 
#####################  UNIVARIATE GRAPHS    ##################### 
#################################################################
# These are frequency distributions.  
# These work for a categorical variable or a quantitative variable.

#frequency distributions for a categorical OR quantitative variable
ggplot(d, aes(x=taskInterest)) + 
  geom_bar(stat="bin", binwidth = 1)            

# if it had been a categorical variable, the output would look different:
ggplot(d, aes(x=as.factor(taskInterest))) + 
  geom_bar(stat="bin", binwidth = 1)            

# if you don't want to plot NAs, use na.omit(dataframeName) 
ggplot(na.omit(d), aes(x=as.factor(taskInterest))) + 
  geom_bar(stat="bin", binwidth = 1)   


# let's reformat some:
ggplot(na.omit(d), aes(x=as.factor(taskInterest))) + 
  geom_bar(stat="bin", binwidth = 1) +
  labs(x = "Level of Task Interest (5 = extremely interested)", y = "Frequency") +
  ggtitle ("Frequency Distribution of Task Interest") +
  theme_bw()

# and change colors:
ggplot(na.omit(d), aes(x=as.factor(taskInterest))) + 
  geom_bar(stat="bin", binwidth = 1, fill = "blue") +
  labs(x = "Level of Task Interest (5 = extremely interested)", y = "Frequency") +
  ggtitle ("Frequency Distribution of Task Interest") +
  theme_bw()


# and change where the bins are located for a quantitative variable:
# using breaks argument overrides binwidth argument

ggplot(na.omit(d), aes(x=taskInterest)) + 
  geom_bar(stat="bin", breaks = seq(.5, 5.5, 1), fill = "blue") +    
  labs(x = "Level of Task Interest (5 = extremely interested)", y = "Frequency") +
  ggtitle ("Frequency Distribution of Task Interest") +
  theme_bw()




################################################################# 
#####################   BIVARIATE GRAPHS    ##################### 
#################################################################
# Put your DV (response var) on the y-axis and 
#  put your IV(explanatory var) on the x-axis.


################################################################# 
# plotting two quantitative variables = a scatterplot
################################################################# 
ggplot(d, aes(x=taskInterest, y=topicInterest)) +
  geom_point(shape=1, size = 4)

# What shapes can I use?
#      > ? shape            Run the example code at the bottom of the help file. (count L->R from bottom)


# cleaning it up some:
ggplot(d, aes(x=taskInterest, y=topicInterest)) +
  geom_point(shape=16, size = 4, color = "red") +   
  labs(x = "Level of Task Interest (5 = high)", y = "Level of Topic Interest (5 = high)") +
  ggtitle ("Relationship between Task Interest and Topic Interest") +
  theme_bw()



# adding a line of best fit:
ggplot(d, aes(x=taskInterest, y=topicInterest)) +
  geom_point(shape=16, size = 4, color = "red") +   
  stat_smooth(method="lm", se=FALSE) +
  labs(x = "Level of Task Interest (5 = high)", y = "Level of Topic Interest (5 = high)") +
  ggtitle ("Relationship between Task Interest and Topic Interest") +
  theme_bw()



# Treating ordinal data as if it were quantitative introduces some issues:
# fixing overlapping points:
ggplot(d, aes(x=jitter(taskInterest), y=topicInterest)) +
  geom_point(shape=16, size = 4, color = "red") +   
  stat_smooth(method="lm", se=FALSE) +
  labs(x = "Level of Task Interest (5 = high)", y = "Level of Topic Interest (5 = high)") +
  ggtitle ("Relationship between Task Interest and Topic Interest") +
  theme_bw()

ggplot(d, aes(x=jitter(taskInterest), y=jitter(topicInterest))) +
  geom_point(shape=16, size = 4, color = "red") +   
  stat_smooth(method="lm", se=FALSE) +
  labs(x = "Level of Task Interest (5 = high)", y = "Level of Topic Interest (5 = high)") +
  ggtitle ("Relationship between Task Interest and Topic Interest") +
  theme_bw()

ggplot(d, aes(x=jitter(taskInterest,.9), y=jitter(topicInterest,.2))) +
  geom_point(shape=16, size = 4, color = "red") +   
  stat_smooth(method="lm", se=FALSE) +
  labs(x = "Level of Task Interest (5 = high)", y = "Level of Topic Interest (5 = high)") +
  ggtitle ("Relationship between Task Interest and Topic Interest") +
  theme_bw()







################################################################# 
# plotting means of different groups
# a categorical explanatory var (IV) and quantitative response var (DV)
################################################################# 

# plotting means of a quantitative DV with a categorical IV
ggplot(d, aes(x=taskInterestChange, y=taskInterest)) + 
  stat_summary(fun.y="mean", geom="bar")

# a little bit of clean up ...
ggplot(na.omit(d), aes(x=taskInterestChange, y=taskInterest)) + 
  stat_summary(fun.y="mean", geom="bar", color = "red", fill = "pink")





################################################################# 
# plotting frequency distributions of different groups
# Both explanatory and response variable are categorical (WITH > 2 levels)
#  (the IV can be quantitative or categorical here, but if quantitative, bin it)
################################################################# 
# stacked bar chart - COUNTS within each group
ggplot(na.omit(d), aes(x=year, fill=as.factor(taskInterest))) +
  geom_bar(stat = "bin", position = "stack") +   
  labs(x = "Year", y = "Frequency") +
  ggtitle ("Relationship between Task Interest and Year") +
  theme_bw()

# grouped bar chart
ggplot(na.omit(d), aes(x=year, fill=as.factor(taskInterest))) +
  geom_bar(stat = "bin", position = "dodge") +   
  labs(x = "Year", y = "Frequency") +
  ggtitle ("Relationship between Task Interest and Year") +
  theme_bw()

# stacked bar chart - PROPORTIONS within each group
# ** with groups that have different numbers of observations, USE PROPORTIONS

ggplot(na.omit(d), aes(x=year, fill=as.factor(taskInterest))) +
  geom_bar(stat = "bin", position = "fill") +   
  labs(x = "Year", y = "Proportion of Group") +
  ggtitle ("Relationship between Task Interest and Year") +
  theme_bw()




# ANOTHER WAY TO PLOT distributions when BOTH variables are categorical
ggplot(na.omit(d), aes(x = taskInterestChange)) +
  facet_wrap (~ year) + 
  geom_bar(stat = "bin") +   
  labs(x = "Task Interest Change", y = "Frequency") +
  ggtitle ("Relationship between Task Interest and Year") +
  theme_bw()


# example: quantitative variable on x-axis and categorical variable 
# (again, not a useful graph with this limited dataset)
ggplot(na.omit(d), aes(x = taskInterest)) +
  facet_wrap (~ year) + 
  geom_bar(stat = "bin", breaks = seq(.5, 5.5, 1)) +   
  labs(x = "Task Interest", y = "Frequency") +
  ggtitle ("Relationship between Task Interest and Year") +
  theme_bw()

################################################################# 
# one possible example: a categorical DV (two levels) and quantitative IV
################################################################# 
# make the categorical DV into two categories.
# **IMPORTANT** Use 0 = no and 1 = yes.  
# ** Doing this (0 = no, 1 = yes) lets the mean of the variable EQUAL
#    the proportion of 'yes' responses in the variable.

# line graph of taskInterestChange = increase across taskInterest (quantitative)
d$interestIncreased <- NA
d$interestIncreased[d$taskInterestChange == "increase"] <- 1
d$interestIncreased[d$taskInterestChange == "decrease" |
                      d$taskInterestChange == "stay the same"] <- 0




# Here, the plotted point is the percentage of observations in that level of 
# taskInterest who said that there interest would increase.
ggplot(na.omit(d), aes(x=taskInterest, y = interestIncreased)) +
  stat_summary(fun.y="mean", geom="point", color = "red", size = 4) +
  geom_line ()


################################################################# 
####################   MULTIVARIATE GRAPHS  #################### 
#################################################################

# Using facet or assigning a variable to fill or to color works for
# scatterplots, line graphs, bar graphs, etc.
# You can also assign the 3rd variable to shape or size of points.

# multivariate plotting in THE SAME GRAPH:
ggplot(na.omit(d), aes(x=year, y=taskInterest, fill = taskInterestChange)) + 
  stat_summary( fun.y="mean", geom="bar", position = "dodge")

# multivariate plotting in DIFFERENT PANELS:
ggplot(na.omit(d), aes(x=taskInterestChange, y=taskInterest)) + 
  facet_wrap(~ year) +
  stat_summary(fun.y="mean", geom="bar")


# WITH FOUR VARIABLES  
# *** this example isn't useful with this data, but shows how the syntax would work
ggplot(na.omit(d), aes(x=topicInterest, y=taskInterest)) + 
  facet_wrap(~ year + taskInterestChange) +
  stat_summary(fun.y="mean", geom="bar")

# Another way to do multivariate graphing, is to use logical subsetting and 
# give the graphing command a subsetted dataset each time.  
#  Ask us to work with you on this.





#######################################################  
#########    Other Useful Tips for Your Plots #########
#######################################################  

######### BEFORE PLOTTING:

# set the levels of your factor SO that it stays in the order you want
# compare the following plots (same code, but changed variable in between)

ggplot(na.omit(d), aes(x=taskInterestChange, y=taskInterest)) + 
  stat_summary(fun.y="mean", geom="bar", color = "red", fill = "pink")
d$taskInterestChange <- factor(d$taskInterestChange, 
                               levels = c("decrease", "stay the same", "increase"))
ggplot(na.omit(d), aes(x=taskInterestChange, y=taskInterest)) + 
  stat_summary(fun.y="mean", geom="bar", color = "red", fill = "pink")


######### ADD TO THE PLOTTED GRAPH:
#  coord_flip()     # switch which variable is on which axis

# work with the legend ...
# work with the color scales ...

#more formatting options:
ggplot(na.omit(d), 
       aes(x=taskInterestChange, y=taskInterest, fill = year)) + 
  stat_summary( fun.y="mean", geom="bar", position = "dodge") +
  labs(x = "Prediction of Change in Interest", y = "Mean Task Interest") +
  ggtitle ("Interest Ratings by Year and Predicted Change") + 
  theme_classic () + scale_fill_manual(values=c("red", "green"))
# unlikely that you will have a group that has no observations, 
#   but if you do, look at expand.grid()
#


######### AFTER PLOTTING:
# If not all of your labels show up in the plot window, make the window bigger
#   before you click export and copy the graph to the clipboard.

# When you click export, and choose to copy the graph, you can change the
#    size of the graph. Select to maintain the ratio, and then use the lower
#    right-hand shaded triangle to make the plotted area smaller.
# This will make the fonts relatively larger.