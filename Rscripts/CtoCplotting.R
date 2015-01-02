# First print out a table of counts
table(NESARC$TAB12MDX, NESARC$MAJORDEP12)

# Print out cell percentages
prop.table(table(NESARC$TAB12MDX, NESARC$MAJORDEP12))

# Print out row percentages
prop.table(table(NESARC$TAB12MDX, NESARC$MAJORDEP12),1)
# Tells you the percentage of people who have Major Depression, split up by
# whether they are nicotine dependent

# Print out column percentages
prop.table(table(NESARC$TAB12MDX, NESARC$MAJORDEP12),2)
# Tells you the percentage of people who are Nicotine Dependent, split up
# by Major Depression- This is our question!

# Can use Excel to plot the values from the 2nd row (i.e. the
# percentages of people with Nicotine Dependence)
prop.table(table(NESARC$TAB12MDX, NESARC$MAJORDEP12),2)

# Advanced: Plot in R
# Extract the 2nd row of prop.table of column percentages and put it in a barplot
barplot(prop.table(table(NESARC$TAB12MDX, NESARC$MAJORDEP12),2)[2,], 
        main="Nicotine Dependence by Major Depression (MD) Status", 
        names=c("No MD","MD"), ylab="Prevalence of Nicotine Dependence")

# If IV has more than 2 levels:
table(NESARC$TAB12MDX, NESARC$S3AQ3B1)

# Column percentages, i.e. Nicotine Dependence status by smoking frequency
prop.table(table(NESARC$TAB12MDX, NESARC$S3AQ3B1))
# Can plot the numbers from the 2nd row (people with ND) using Excel

# Advanced: Plot in R
# Make a barplot showing Nicotine Dependence percentages by smoking frequency
barplot(prop.table(table(NESARC$TAB12MDX, NESARC$S3AQ3B1),2),beside=T,
        main="Nicotine Dependence (ND) by Smoking Frequency", xlab="Smoking
        Frequency (Days smoked per month)", ylab="Percentage of Nicotine Dependence",
        names=c("30","20-24","12-16","4-8","2-3","<= 1"),legend.text=c("No ND","ND"))

# Advanced: Plot in R, but only plot prevalence of ND (having bars for both ND and
# no ND is redundant, since they add to 100%)
# Do this by only barplotting the 2nd row of prop.table()
barplot(prop.table(table(NESARC$TAB12MDX, NESARC$S3AQ3B1),2)[2,],
        main="Nicotine Dependence (ND) by Smoking Frequency", xlab="Smoking
        Frequency (Days smoked per month)", ylab="Percentage of Nicotine Dependence",
        names=c("30","20-24","12-16","4-8","2-3","<= 1"))