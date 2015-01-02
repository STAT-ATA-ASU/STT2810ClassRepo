# Categorical DV, Categorical IV, Categorical 3rd Variable
# Print out a table
ftable(NESARC$TAB12MDX, NESARC$ETHRACE2A, NESARC$SEX)

# Print out column percentages, which tells you the proportion of people with
# ND according to ethnicity and sex
prop.table(ftable(NESARC$TAB12MDX, NESARC$ETHRACE2A, NESARC$SEX),2)

# Make a barplot of the last 5 rows of the table (corresponding to people with ND)
barplot(prop.table(ftable(NESARC$TAB12MDX, NESARC$ETHRACE2A, NESARC$SEX),2)[6:10,],
        beside=T,main="Prevalence of Nicotine Depedende (ND) by Ethnicity and 
        Gender", ylab="Percentage of people with ND", names=c("Female","Male"),
        legend.text=c("White","Black","Native American","Asian","Hispanic"))

# Quantitative DV, Categorical IV, Categorical 3rd Variable
SmkQuant.byEthSex <- by(NESARC$S3AQ3C1[!is.na(NESARC$S3AQ3C1)], 
        list(NESARC$ETHRACE2A[!is.na(NESARC$S3AQ3C1)], 
        NESARC$SEX[!is.na(NESARC$S3AQ3C1)]), mean)

# Print out means of Smoking Quantity by Ethnicity and Sex
SmkQuant.byEthSex

# Plot the means in a barplot
barplot(SmkQuant.byEthSex, beside=T, main="Smoking Quantity by Ethnicity and Sex",
        ylab="Number of Cigarettes", names=c("Female","Male"), legend.text=
        c("White","Black","Native American","Asian","Hispanic"), args.legend=
        list(x="bottomleft",bty="n"))

