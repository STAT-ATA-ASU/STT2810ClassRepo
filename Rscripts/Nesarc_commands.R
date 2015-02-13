#################################################################################
# LOAD DATASET
#################################################################################
# load("P:/QAC/qac201/Studies/NESARC/Data/NESARC_pds.RData")
library(PDS)  # Load the PDS package
#################################################################################
# CREATING A DATA SUBSET FOR MY OWN PROJECT
#################################################################################
# Subset to people 25 or younger who smoked in the last 12 months
nesarc.subset <- NESARC[!is.na(NESARC$CHECK321)  & !is.na(NESARC$AGE) &
                          NESARC$CHECK321 == 1 & NESARC$AGE <=25,]


#################################################################################
# LABELING VARIABLES AND RUNNING FREQUENCY TABLES
#################################################################################
# Add labels to variables
library(Hmisc)
label(nesarc.subset$TAB12MDX) <- "Tobacco Dependence past 12 Months"
label(nesarc.subset$CHECK321) <- "Smoked Cigarettes in the Past 12 Months"
label(nesarc.subset$S3AQ3B1) <- "Usual Smoking Quantity"
label(nesarc.subset$S3AQ3C1) <- "Usual Smoking Frequency"

# Get frequency distributions for variables
library(descr)
freq(nesarc.subset$TAB12MDX)
freq(nesarc.subset$CHECK321)
freq(as.ordered(nesarc.subset$S3AQ3B1))
freq(as.ordered(nesarc.subset$S3AQ3C1))
freq(as.ordered(nesarc.subset$AGE))

#################################################################################
# DATA MANAGEMENT
#################################################################################
# Code in missing data (NA)
nesarc.subset$S3AQ3B1[nesarc.subset$S3AQ3B1==9] <- NA
freq(nesarc.subset$S3AQ3B1)

nesarc.subset$S3AQ3C1[nesarc.subset$S3AQ3C1==99] <- NA
freq(nesarc.subset$S3AQ3C1)


# Code in valid data


# Re-label variables with more logical values
USFREQ <- rep(NA, 1706)  # Reverse categories
USFREQ[nesarc.subset$S3AQ3B1 == 1] <- 6
USFREQ[nesarc.subset$S3AQ3B1 == 2] <- 5
USFREQ[nesarc.subset$S3AQ3B1 == 3] <- 4
USFREQ[nesarc.subset$S3AQ3B1 == 4] <- 3
USFREQ[nesarc.subset$S3AQ3B1 == 5] <- 2
USFREQ[nesarc.subset$S3AQ3B1 == 6] <- 1
USFREQ <- as.factor(USFREQ)
nesarc.subset$USFREQ <- USFREQ

USFREQMO <- rep(NA, 1706) # Make quantitative version of "Usual Smoking Frequency"
USFREQMO[nesarc.subset$S3AQ3B1 == 1] <- 30
USFREQMO[nesarc.subset$S3AQ3B1 == 2] <- 22
USFREQMO[nesarc.subset$S3AQ3B1 == 3] <- 14
USFREQMO[nesarc.subset$S3AQ3B1 == 4] <- 6
USFREQMO[nesarc.subset$S3AQ3B1 == 5] <- 2.5
USFREQMO[nesarc.subset$S3AQ3B1 == 6] <- 1
freq(USFREQMO)
nesarc.subset$USFREQMO <- as.factor(USFREQMO)

# Creating secondary variables
NUMCIGMO_EST <- USFREQMO * nesarc.subset$S3AQ3C1
nesarc.subset$NUMCIGMO_EST <- NUMCIGMO_EST
freq(as.ordered(nesarc.subset$NUMCIGMO_EST))

PACKSPERMONTH <- NUMCIGMO_EST/20
freq(as.ordered(PACKSPERMONTH))
nesarc.subset$PACKSPERMONTH <- PACKSPERMONTH

SMOKEGRP <- rep(NA, 1706)
SMOKEGRP[nesarc.subset$TAB12MDX == 1] <- 1
SMOKEGRP[nesarc.subset$TAB12MDX == 0 & !is.na(nesarc.subset$S3AQ3B1) & nesarc.subset$S3AQ3B1 == 1] <- 2
SMOKEGRP[nesarc.subset$TAB12MDX == 0 & !is.na(nesarc.subset$S3AQ3B1) & nesarc.subset$S3AQ3B1 != 1] <- 3
freq(SMOKEGRP)
nesarc.subset$SMOKEGRP <- as.factor(SMOKEGRP)

USQUAN <- rep(NA, 1706)
USQUAN[nesarc.subset$S3AQ3C1 <= 5] <- 3
USQUAN[nesarc.subset$S3AQ3C1 > 5 & nesarc.subset$S3AQ3C1 <= 10] <- 8
USQUAN[nesarc.subset$S3AQ3C1 > 10 & nesarc.subset$S3AQ3C1 <= 15] <- 13
USQUAN[nesarc.subset$S3AQ3C1 > 15 & nesarc.subset$S3AQ3C1 <= 20] <- 18
USQUAN[nesarc.subset$S3AQ3C1 > 20] <- 37
USQUAN[nesarc.subset$S3AQ3B1!=1] <- 0  # Non-daily smokers get 0
freq(USQUAN)
nesarc.subset$USQUAN <- as.factor(USQUAN)


# Creating categories
AGEGROUP <- rep(NA, 1706)
AGEGROUP[nesarc.subset$AGE <= 20] <- 1
AGEGROUP[nesarc.subset$AGE > 20 & nesarc.subset$AGE <= 22] <- 2
AGEGROUP[nesarc.subset$AGE >22] <- 3
nesarc.subset$AGEGROUP <- as.factor(AGEGROUP)

PACKCATEGORY <- rep(NA, 1706)
PACKCATEGORY[nesarc.subset$PACKSPERMONTH <= 5] <- 3
PACKCATEGORY[nesarc.subset$PACKSPERMONTH > 5 & nesarc.subset$PACKSPERMONTH <= 10] <- 7
PACKCATEGORY[nesarc.subset$PACKSPERMONTH > 10 & nesarc.subset$PACKSPERMONTH <= 20] <- 15
PACKCATEGORY[nesarc.subset$PACKSPERMONTH > 20 & nesarc.subset$PACKSPERMONTH <= 30] <- 25
PACKCATEGORY[nesarc.subset$PACKSPERMONTH > 30] <- 58
freq(PACKCATEGORY)
nesarc.subset$PACKCATEGORY <- as.factor(PACKCATEGORY)

DAILY <- rep(NA, 1706)
DAILY[!is.na(nesarc.subset$S3AQ3B1) & nesarc.subset$S3AQ3B1 == 1] <- 1
DAILY[!is.na(nesarc.subset$S3AQ3B1) & nesarc.subset$S3AQ3B1 != 1] <- 0
freq(DAILY)
nesarc.subset$DAILY <- as.factor(DAILY)



#################################################################################
# GRAPHING
#################################################################################

# Univariate barplots (categorical variable)
freq(nesarc.subset$TAB12MDX, main="Nicotine Dependence (ND) in the Past 12 Months
     among Young Adult Smokers in NESARC", names=c("No ND", "ND"), ylab="Frequency")

# Univariate histograms (quantitative variable)
hist(nesarc.subset$NUMCIGMO_EST, main="Estimated # Cigarettes Smoked/Month among
     Young Adult Smokers in NESARC", xlab="Number of Cigarettes")

# Bivariate graph (C -> C Barplot)
table(nesarc.subset$TAB12MDX, nesarc.subset$PACKCATEGORY)
prop.table(table(nesarc.subset$TAB12MDX, nesarc.subset$PACKCATEGORY), 2)
barplot(prop.table(table(nesarc.subset$TAB12MDX, nesarc.subset$PACKCATEGORY), 2)[2,],
        main="Past-Year Nicotine Dependence Diagnosis by Smoking Quantity", 
        ylab="% Diagnosed", xlab="Packs of Cigarettes Smoked in the Past Month",
        col="maroon")

table(nesarc.subset$DAILY, nesarc.subset$ETHRACE2A)
prop.table(table(nesarc.subset$DAILY, nesarc.subset$ETHRACE2A), 2)
barplot(prop.table(table(nesarc.subset$DAILY, nesarc.subset$ETHRACE2A), 2)[2,],
        main="Rate of daily smoking by ethnic group among young adult
        Smokers in NESARC", ylab="Percent Daily Smoking", names=c("White", "Black",
        "Am. Ind/AK Nat.", "Asian", "Hisp./Lat."), col="orange")

#################################################################################
# UNIVARIATE STATISTICS (QUANTITATIVE VARIABLES ONLY)
#################################################################################

# Get the mean/average of a variable
mean(nesarc.subset$NUMCIGMO_EST, na.rm=T)

# Get the standard deviation
sd(nesarc.subset$NUMCIGMO_EST, na.rm=T)

# Get an overall summary
summary(nesarc.subset$NUMCIGMO_EST, na.rm=T)


#################################################################################
# BIVARIATE STATISTICS
#################################################################################

# ANOVA
numcig.aov <- aov(NUMCIGMO_EST ~ MAJORDEPLIFE, data=nesarc.subset)
summary(numcig.aov)
# Run follow-up descriptive statistics
by(nesarc.subset$NUMCIGMO_EST, nesarc.subset$MAJORDEPLIFE, mean, na.rm=T)

# ANOVA with multi-level explanatory variable
numcig.eth.aov <- aov(NUMCIGMO_EST ~ ETHRACE2A, data=nesarc.subset)
summary(numcig.eth.aov)
# Run follow-up descriptive statistics
by(nesarc.subset$NUMCIGMO_EST, nesarc.subset$ETHRACE2A, mean, na.rm=T)
# Tukey's post-hoc test 
TukeyHSD(numcig.eth.aov)


# Chi-Square Test of Independence
ND.chisq <- chisq.test(nesarc.subset$TAB12MDX, nesarc.subset$USFREQMO)
ND.chisq  # Overall summary
ND.chisq$observed   # Observed cell counts
ND.chisq$expected   # Expected (due to chance) cell counts
ND.chisq$residuals  # Pearson residuals (like z-scores; magnitude > 2 means a cell has a higher/lower cell count than is expected by chance)
# Post-hoc tests
.05/15  # Bonferroni correction for 15 pairwise comparisons is .003
ND.chisq.1vs2 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 1 | 
          nesarc.subset$USFREQMO == 2.5], 
          nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 1 | 
          nesarc.subset$USFREQMO == 2.5])
ND.chisq.1vs2

ND.chisq.1vs6 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 1 | 
                                                     nesarc.subset$USFREQMO == 6], 
                            nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 1 | 
                                                     nesarc.subset$USFREQMO == 6])
ND.chisq.1vs6

ND.chisq.1vs14 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 1 | 
                                                     nesarc.subset$USFREQMO == 14], 
                            nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 1 | 
                                                     nesarc.subset$USFREQMO == 14])
ND.chisq.1vs14
ND.chisq.1vs14$residuals

ND.chisq.1vs22 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 1 | 
                                                     nesarc.subset$USFREQMO == 22], 
                            nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 1 | 
                                                     nesarc.subset$USFREQMO == 22])
ND.chisq.1vs22
ND.chisq.1vs22$residuals

ND.chisq.1vs30 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 1 | 
                                                      nesarc.subset$USFREQMO == 30], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 1 | 
                                                      nesarc.subset$USFREQMO == 30])
ND.chisq.1vs30
ND.chisq.1vs30$residuals

ND.chisq.2vs6 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 6], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 6])
ND.chisq.2vs6

ND.chisq.2vs14 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 14], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 14])
ND.chisq.2vs14

ND.chisq.2vs22 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 22], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 22])
ND.chisq.2vs22

ND.chisq.2vs30 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 30], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 30])
ND.chisq.2vs30
ND.chisq.2vs30$residuals

ND.chisq.2vs14 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 14], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 2.5 | 
                                                      nesarc.subset$USFREQMO == 14])
ND.chisq.2vs14

ND.chisq.6vs14 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 6 | 
                                                      nesarc.subset$USFREQMO == 14], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 6 | 
                                                      nesarc.subset$USFREQMO == 14])
ND.chisq.6vs14

ND.chisq.6vs22 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 6 | 
                                                      nesarc.subset$USFREQMO == 22], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 6 | 
                                                      nesarc.subset$USFREQMO == 22])
ND.chisq.6vs22

ND.chisq.6vs30 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 6 | 
                                                      nesarc.subset$USFREQMO == 30], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 6 | 
                                                      nesarc.subset$USFREQMO == 30])
ND.chisq.6vs30

ND.chisq.14vs22 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 14 | 
                                                      nesarc.subset$USFREQMO == 22], 
                             nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 14 | 
                                                      nesarc.subset$USFREQMO == 22])
ND.chisq.14vs22

ND.chisq.14vs30 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 14 | 
                                                       nesarc.subset$USFREQMO == 30], 
                              nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 14 | 
                                                       nesarc.subset$USFREQMO == 30])
ND.chisq.14vs30
ND.chisq.14vs30$residuals

ND.chisq.22vs30 <- chisq.test(nesarc.subset$TAB12MDX[nesarc.subset$USFREQMO == 22 | 
                                                       nesarc.subset$USFREQMO == 30], 
                              nesarc.subset$USFREQMO[nesarc.subset$USFREQMO == 22 | 
                                                       nesarc.subset$USFREQMO == 30])
ND.chisq.22vs30
ND.chisq.22vs30$residuals


#################################################################################
# MODERATION
#################################################################################

# Chi-Square
nd.chisq <- chisq.test(nesarc.subset$TAB12MDX, nesarc.subset$USQUAN)
nd.chisq
table(nesarc.subset$TAB12MDX, nesarc.subset$USQUAN)
prop.table(table(nesarc.subset$TAB12MDX, nesarc.subset$USQUAN),2)
barplot(prop.table(table(nesarc.subset$TAB12MDX, nesarc.subset$USQUAN),2)[2,],
        main="Rate of Nicotine Dependence (ND) by Daily Smoking Quantity", 
        ylab="% with ND", xlab="Usual Number of Cigarettes Smoked per Day",
        col="burlywood")

# Moderation of above Chi-Square- automatically using the by() command
by(nesarc.subset, nesarc.subset$MAJORDEPLIFE, function(x) 
        list(chisq.test(x$TAB12MDX, x$USQUAN), 
          chisq.test(x$TAB12MDX, x$USQUAN)$residuals))

