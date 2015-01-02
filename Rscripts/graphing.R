###################################################
# GRAPHING IN R
##################################################

# Set your working directory
Tools -> Set Working Directory -> Choose Directory

# Load example NESARC dataset
load("P:/QAC/qac201/STUDENTS/Section2/aselya/NESARC_short.RData")

# Before plotting, look at some summary statistics
mean(nesarc.subset$smkQuant)   # need to remove NA's first using na.omit()
mean(na.omit(nesarc.subset$smkQuant))
sd(na.omit(nesarc.subset$smkQuant))
summary(na.omit(nesarc.subset$smkQuant))


# Frequency table and barplot- for categorical variables
library(descr)
freq(nesarc.subset$MajorDep12mo)
# Add some general graphing inputs to make your plot easier to understand
freq(nesarc.subset$MajorDep12mo, main="Lifetime Major Depression", 
     names=c("No Major Depression", "Major Depression"))

# Histogram- for quantitative variables
hist(nesarc.subset$smkQuant)
# Customize the labels
hist(nesarc.subset$smkQuant, main="Histogram of Smoking Quantity", 
     xlab="Cigarettes/Day")
# Also customize the "bins"
hist(nesarc.subset$smkQuant, main="Histogram of Smoking Quantity", 
     xlab="Cigarettes/Day", breaks=15)

# Exercise: Plot one categorical and one quantitative variable in your own dataset
#  using the appropriate function from above


################################################
# Bivariate associations
################################################

# Categorical -> Categorical: Cross-tabulation
# First, cross-tabulate your two variables
table(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo)  # Gives raw counts
# For row, column, or cell percentages, use this inside prop.table()
prop.table(table(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo)) # cell percentages
prop.table(table(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo),1) # row percentages
prop.table(table(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo),2) # column percentages

# Plot 2nd row of column percentage table, because you only want 
#  to plot the % of people who are nicotine dependent, and it's 
#  redundant to plot the 1st row (which shows people who are not 
#  nicotine dependent)
barplot(prop.table(table(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo),2)[2,], 
        main="Nicotine Dependence by Major Depression", 
        names=c("No Major Depression", "Major Depression"),
        ylab="Percent Nicotine Dependent")


# Categorical -> Quantitative: Calculate Group Means
#  Use by() to calculate the average DV by each level of IV
by(nesarc.subset$NDScount, nesarc.subset$MajorDep12mo, mean)
# Need to add the option na.rm=T
by(nesarc.subset$NDScount, nesarc.subset$MajorDep12mo, mean, na.rm=T)

# Plot these means as a barplot
barplot(by(nesarc.subset$NDScount, nesarc.subset$MajorDep12mo, mean, na.rm=T), 
        main="Number of Nicotine Dependence Symptoms 
        by Major Depression Status", 
        names=c("No Major Depression", "Major Depression"), 
        ylab="Number of Symptoms")

# Quantitative -> Quantitative: Scatterplot
plot(nesarc.subset$Age, nesarc.subset$smkQuant, main="Smoking Quantity by Age",
     xlab="Age (years)", ylab="Cigarettes/Day")


# Quantitative -> Categorical: create meaningful categories (just for plotting)
#  and proceed as Categorical -> Categorical above
# Make a categorical version of smoking quantity:
sq.cat <- rep(NA,1000)
sq.cat[nesarc.subset$smkQuant >= 1 & nesarc.subset$smkQuant <= 5] <- 3
sq.cat[nesarc.subset$smkQuant > 5 & nesarc.subset$smkQuant <=10] <- 8
sq.cat[nesarc.subset$smkQuant > 10 & nesarc.subset$smkQuant <= 15] <- 13
sq.cat[nesarc.subset$smkQuant > 15 & nesarc.subset$smkQuant <=20] <- 18
sq.cat[nesarc.subset$smkQuant > 20] <- 38
sq.cat <- as.factor(sq.cat)
nesarc.subset$sq.cat <- sq.cat

# Plot as C -> C above
# First make a cross-table:
table(nesarc.subset$NDLife, nesarc.subset$sq.cat)
# Now make a table of column percentages:
prop.table(table(nesarc.subset$NDLife, nesarc.subset$sq.cat),2)
# Now plot (can use barplot() or plot() for a line plot)
# If using plot(), 1st input (x) is levels(variable), and 2nd input
#  is the relevant values from the prop.table
plot(levels(nesarc.subset$sq.cat), prop.table(table(nesarc.subset$NDLife, 
     nesarc.subset$sq.cat),2)[2,], 
     main="Rate of Nicotine Dependence by Smoking Quantity", 
     ylab="% Nicotine Dependent", xlab="Cigarettes/Day", type="b")


############################################
# MULTIVARIATE PLOTTING
############################################

# 2 ways, depending on whether your DV is categorical or quantitative
#  If categorical, take the bivariate case and use ftable() instead of table()
#  If quantitative, use list() to bind together the two IV's inside by()

# Categorical DV:
# Make a 3-way cross-table
ftable(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo, nesarc.subset$EverDailySmk)
# Make a table with column percentages
prop.table(ftable(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo, 
      nesarc.subset$EverDailySmk), 2)
# Make a barplot of the last 2 rows (why the last 2?)
barplot(prop.table(ftable(nesarc.subset$NDLife, 
      nesarc.subset$MajorDep12mo, nesarc.subset$EverDailySmk), 2)[3:4,],
      beside=T,
      main="Rate of Nicotine Dependence by Major Depression and
      Daily Smoking Status", ylab="% Nicotine Dependent",
      names=c("Never Smoked Daily", "Smoked Daily"),
      legend=c("No Major Depression", "Major Depression"))


# Quantitative DV (and both IV's are categorical)
# First get the means
by(nesarc.subset$NDScount, list(nesarc.subset$MajorDep12mo, nesarc.subset$sq.cat),
      mean, na.rm=T)
barplot(by(nesarc.subset$NDScount, list(nesarc.subset$MajorDep12mo, 
      nesarc.subset$sq.cat), mean, na.rm=T), beside=T, 
      main="Number of Nicotine Dependence Symptoms by Major Depression
      and Smoking Quantity", ylab="# ND Symptoms",
      xlab="Cigarettes/Day", legend=c("No Major Depression", "Major Depression"))

# Customize placement of legend
barplot(by(nesarc.subset$NDScount, list(nesarc.subset$MajorDep12mo, 
      nesarc.subset$sq.cat), mean, na.rm=T), beside=T, 
      main="Number of Nicotine Dependence Symptoms by Major Depression
      and Smoking Quantity", ylab="# ND Symptoms",
      xlab="Cigarettes/Day", legend.text=c("No Major Depression", "Major Depression"),
      args.legend=list(x="topleft"), ylim=range(0,9))