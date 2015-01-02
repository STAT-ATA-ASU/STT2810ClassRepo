# Set your working directory to your folder on P drive
#  Tools -> Set Working Directory -> Choose Directory -> browse to your folder

# Load my example nesarc workspace
load("P:/QAC/qac201/STUDENTS/section6/aselya/NESARC_short.RData")

# Customize the variable names
# First, load the "reshape" library
library(reshape)
# Use the function rename()
#  First input: the object that contains variables you want to rename (i.e. 
#   your dataset)
#  Second input: a list (using c()) of the form old.variable.name="new.variable.name"
#   for each variable you want to rename
#  Must store it in a workspace object (otherwise it prints to screen). Here,
#   we are over-writing nesarc.subset with only the name changes
nesarc.subset <- rename(nesarc.subset,c(CHECK321="SmkStatus", ETHRACE2A="Race"))

#################################################
#  DATA MANAGEMENT
#################################################

# 1. Code in NA's (missing data) where a certain value means "missing"
nesarc.subset$Over100Cigs[nesarc.subset$Over100Cigs==9] <- NA
# We are overwriting those occurrences of Over100Cigs for which Over100Cigs
#  is 9, and replacing them with NA (missing)


# 2. Code in valid data (e.g. legitimate skips) where you can deduce it
nesarc.subset$smkQuant[nesarc.subset$SmkStatus==1] <- 0
# We are overwriting the missing values of smkQuant for those observations who
#  are nonsmokers with a value of 0


# 3. Categorical-to-categorical recode
#  Code "Sex" as "M" and "F" instead of 1 and 2. From codebook, 1=Male
sex.char <- rep(NA, 1000)  # Initialize variable- length must match # observations in your dataset
sex.char[nesarc.data$Sex==1] <- "M"  # Code in the levels one at a time
sex.char[nesarc.data$Sex==2] <- "F"
sex.char <- as.factor(sex.char)  # Make sure this is stored as a categorical variable
nesarc.subset$sex.char <- sex.char  # Attach to your data subset

# Collapse race/ethnic categories "3" and "4 into one level
race.coll <- rep(NA, 1000)
race.coll[nesarc.subset$Race==1] <- 1  # Level 1 stays the same in new variable
race.coll[nesarc.subset$Race==2] <- 2  # Level 2 also stays the same
race.coll[nesarc.subset$Race==5] <- 3  # Level 5 is now level 3
race.coll[nesarc.subset$Race==3 | nesarc.subset$Race==4] <- 4  # Collapse levels 3 and 4 into new level 4
race.coll <- as.factor(race.coll)  # Make this a categorical variable
nesarc.subset$race.coll <- race.coll  # Attach new variable to your subet


# 4. Categorical-to-quantitative recode
# Make a new variable that is a sum of all 20 nicotine dependence symptom variables
#  First, make sure the new variables are coded in a sensible way.  The original
#  coding is 1=Yes, 2=No, but to be able to sum the different variables, we have to
#  recode so that 0=No and 1=Yes.
#  Also make sure the scales of the variables you are summing match!
nesarc.subset$ND01[nesarc.subset$ND01==2] <- 0
nesarc.subset$ND02[nesarc.subset$ND02==2] <- 0
nesarc.subset$ND03[nesarc.subset$ND03==2] <- 0
nesarc.subset$ND04[nesarc.subset$ND04==2] <- 0
nesarc.subset$ND05[nesarc.subset$ND05==2] <- 0
nesarc.subset$ND06[nesarc.subset$ND06==2] <- 0
nesarc.subset$ND07[nesarc.subset$ND07==2] <- 0
nesarc.subset$ND08[nesarc.subset$ND08==2] <- 0
nesarc.subset$ND09[nesarc.subset$ND09==2] <- 0
nesarc.subset$ND10[nesarc.subset$ND10==2] <- 0
nesarc.subset$ND11[nesarc.subset$ND11==2] <- 0
nesarc.subset$ND12[nesarc.subset$ND12==2] <- 0
nesarc.subset$ND13[nesarc.subset$ND13==2] <- 0
nesarc.subset$ND14[nesarc.subset$ND14==2] <- 0
nesarc.subset$ND15[nesarc.subset$ND15==2] <- 0
nesarc.subset$ND16[nesarc.subset$ND16==2] <- 0
nesarc.subset$ND17[nesarc.subset$ND17==2] <- 0
nesarc.subset$ND18[nesarc.subset$ND18==2] <- 0
nesarc.subset$ND19[nesarc.subset$ND19==2] <- 0
nesarc.subset$ND20[nesarc.subset$ND20==2] <- 0
# Also, make the assumption that NA's are legitimate skips, i.e. those
#  participants do not smoke and do not experience nicotine dependence symptoms
nesarc.subset$ND01[nesarc.subset$ND01==9 | is.na(nesarc.subset$ND01)] <- 0
nesarc.subset$ND02[nesarc.subset$ND02==9 | is.na(nesarc.subset$ND02)] <- 0
nesarc.subset$ND03[nesarc.subset$ND03==9 | is.na(nesarc.subset$ND03)] <- 0
nesarc.subset$ND04[nesarc.subset$ND04==9 | is.na(nesarc.subset$ND04)] <- 0
nesarc.subset$ND05[nesarc.subset$ND05==9 | is.na(nesarc.subset$ND05)] <- 0
nesarc.subset$ND06[nesarc.subset$ND06==9 | is.na(nesarc.subset$ND06)] <- 0
nesarc.subset$ND07[nesarc.subset$ND07==9 | is.na(nesarc.subset$ND07)] <- 0
nesarc.subset$ND08[nesarc.subset$ND08==9 | is.na(nesarc.subset$ND08)] <- 0
nesarc.subset$ND09[nesarc.subset$ND09==9 | is.na(nesarc.subset$ND09)] <- 0
nesarc.subset$ND10[nesarc.subset$ND10==9 | is.na(nesarc.subset$ND10)] <- 0
nesarc.subset$ND11[nesarc.subset$ND11==9 | is.na(nesarc.subset$ND11)] <- 0
nesarc.subset$ND12[nesarc.subset$ND12==9 | is.na(nesarc.subset$ND12)] <- 0
nesarc.subset$ND13[nesarc.subset$ND13==9 | is.na(nesarc.subset$ND13)] <- 0
nesarc.subset$ND14[nesarc.subset$ND14==9 | is.na(nesarc.subset$ND14)] <- 0
nesarc.subset$ND15[nesarc.subset$ND15==9 | is.na(nesarc.subset$ND15)] <- 0
nesarc.subset$ND16[nesarc.subset$ND16==9 | is.na(nesarc.subset$ND16)] <- 0
nesarc.subset$ND17[nesarc.subset$ND17==9 | is.na(nesarc.subset$ND17)] <- 0
nesarc.subset$ND18[nesarc.subset$ND18==9 | is.na(nesarc.subset$ND18)] <- 0
nesarc.subset$ND19[nesarc.subset$ND19==9 | is.na(nesarc.subset$ND19)] <- 0
nesarc.subset$ND20[nesarc.subset$ND20==9 | is.na(nesarc.subset$ND20)] <- 0
# Now, create a new variable to sum the others:
NDcount <- rep(0, 1000)  # Initialize it to 0 instead of NA for summing
NDcount <- nesarc.subset$ND01 + nesarc.subset$ND02 + nesarc.subset$ND03 +
  nesarc.subset$ND04 + nesarc.subset$ND05 + nesarc.subset$ND06 + nesarc.subset$ND07 +
  nesarc.subset$ND08 + nesarc.subset$ND09 + nesarc.subset$ND10 + nesarc.subset$ND11 +
  nesarc.subset$ND12 + nesarc.subset$ND13 + nesarc.subset$ND14 + nesarc.subset$ND15 +
  nesarc.subset$ND16 + nesarc.subset$ND17 + nesarc.subset$ND18 + nesarc.subset$ND19 +
  nesarc.subset$ND20
nesarc.subset$NDcount <- NDcount  # Attach to your dataset


# Quantitative-to-categorical recode
age.group <- rep(NA, 1000)
age.group[nesarc.data$Age < 21] <- 1  # Under 21 is age group 1
age.group[nesarc.data$Age >= 21 & nesarc.data$Age < 30] <- 2  # 21-29 is group 2
age.group[nesarc.data$Age >= 30 & nesarc.data$Age < 50] <- 3  # 30's-40's is group 3
age.group[nesarc.data$Age >= 50] <- 4  # 50 and older is group 4
age.group <- as.factor(age.group)  # Categorize age group
nesarc.subset$age.group <- age.group



