# Set your working directory
#  Tools -> Set Working Directory -> Choose Directory -> Your folder on P drive

#######################################################################
# Post-hoc tests: ANOVA
#######################################################################

# Run an ANOVA for the chick weight data
data(chickwts)
chickwts.aov <- aov(weight ~ feed, data=chickwts)
summary(chickwts.aov)

# Which feeds are related to different chick weights?

# Manually look for pairwise comparisons between different feeds, using a t-test
#  Function t.test has two inputs: t.test(group1DV, group2DV)
t.test(chickwts$weight[chickwts$feed=="linseed"],
       chickwts$weight[chickwts$feed=="meatmeal"])
# Results show a significant difference for this particular comparison
#  (p=.02933; mean of linseed = 218 grams, mean of meatmeal = 276 grams)

# BUT, after doing all pairwise comparisons (among 6 types of feed), we have
#  performed 15 tests and inflated our chances of a Type 1 error.
#  Therefore, we must use a Bonferroni correction to reduce alpha
#  Bonferroni correction: alpha/# tests
.05/15  # new alpha is .003- thus linseed vs. meatmeal is actually not significant!


# Use an existing function to perform the pairwise comparisons
#  Function is TukeyHSD(my.aov)
#  Prints out every possible pairwise comparison, and the difference in means
#  Automatically adjusts the p-value for you
TukeyHSD(chickwts.aov)  


#######################################################################
# Post-hoc tests: Chi-square test
#######################################################################

# Load my example NESARC dataset
load("P:/QAC/qac201/STUDENTS/Section2/aselya/NESARC_short.RData")

# Run a chi-square test of nicotine dependence (yes/no) by race/ethnicity
NDeth.chisq <- chisq.test(nesarc.subset$NDLife, nesarc.subset$ETHRACE2A)
NDeth.chisq

# Which races differ in terms of prevalence of nicotine dependence?

# Manually look for pairwise comparisons between different races
#  Run new chi-sqare tests, on data subsetted to include only those two races
NDeth.1vs2.chisq <- chisq.test(nesarc.subset$NDLife[nesarc.subset$ETHRACE2A==1 | nesarc.subset$ETHRACE2A==2],
      nesarc.subset$ETHRACE2A[nesarc.subset$ETHRACE2A==1 | nesarc.subset$ETHRACE2A==2])
#  Or, alternatively, make a new subset first that only includes each pair of races,
#  and run a chi-square test on each of those new subsets
race1vs2.subset <- nesarc.subset[nesarc.subset$ETHRACE2A==1 | nesarc.subset$ETHRACE2A==2,]
NDeth.1vs2.chisq <- chisq.test(race1vs2.subset$NDLife, race1vs2.subset$ETHRACE2A)

#  The difference between race 1 (Black) and 2 (Hispanic) in prevalence of 
#  nicotine dependence is significant at p=.02965 at the "individual level"

#  BUT, with 5 race groups, there are a total of 10 pairwise comparisons you must do
#  Adjust alpha:
.05/10  # New alpha is .005

# Thus, Black and Hispanic are not significantly different from each other
#  at the "family-wise" level


#######################################################################
# Moderation (Interaction): ANOVA
#######################################################################

# Main question is # of ND symptoms by major depression status, and 
#  the moderation question is whether this relationship differs by gender

# Run your statistical test within every level of your 3rd variable (sex)
#  This means running the test on a subset of your data that includes only males,
#  and then running another test on another subset that includes only females
ND.aov.M <- aov(NDScount ~ MajorDep12mo, data=nesarc.subset[nesarc.subset$Sex==1,])
ND.aov.F <- aov(NDScount ~ MajorDep12mo, data=nesarc.subset[nesarc.subset$Sex==2,])
summary(ND.aov.M)
summary(ND.aov.F)

# To look at the differences between no depression and depression:
TukeyHSD(ND.aov.M)
TukeyHSD(ND.aov.F)

# There is no relationship between ND and depression for males, but there is 
#  a strong relationship among females: This means sex moderates the relationship.
#  Another way of saying this is: there is an interaction between depression
#  and sex 


#######################################################################
# Moderation (Interaction): Chi-square test
#######################################################################

# Does the relationship between nicotine dependence (yes/no) and depression
#  (yes/no) differ by gender?

# Run chi-square tests, on different subsets for Male and Female
ND.chisq.M <- chisq.test(nesarc.subset$NDLife[nesarc.subset$Sex==1], nesarc.subset$MajorDep12mo[nesarc.subset$Sex==1])
ND.chisq.F <- chisq.test(nesarc.subset$NDLife[nesarc.subset$Sex==2], nesarc.subset$MajorDep12mo[nesarc.subset$Sex==2])

#  Look at the results:
ND.chisq.M
ND.chisq.F


#######################################################################
# Moderation (Interaction): Pearson correlation
#######################################################################

# Does the relationship betwen smoking quantity (DV) and age (IV)
#  differ by gender?
SQage.cor.M <- cor.test(nesarc.subset$smkQuant[nesarc.subset$Sex==1], nesarc.subset$Age[nesarc.subset$Sex==1])
SQage.cor.F <- cor.test(nesarc.subset$smkQuant[nesarc.subset$Sex==2], nesarc.subset$Age[nesarc.subset$Sex==2])

# Look at the results
SQage.cor.M
SQage.cor.F