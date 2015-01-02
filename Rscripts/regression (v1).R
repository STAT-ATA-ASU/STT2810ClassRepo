# Set your working directory
#  Tools -> Set Working Directory -> Choose Directory

# Load my example workspace
load("P:/QAC/qac201/STUDENTS/section6/aselya/NESARC_short.RData")

################################################################
# Linear/Multiple Regression
################################################################

# Bivariate case (Linear regression)
NDcount.lm <- lm(NDScount ~ GenAnx12mo, data=nesarc.subset)
summary(NDcount.lm)

# Multivariate case (multiple regression)
NDcount.3var.lm <- lm(NDScount ~ GenAnx12mo + MajorDep12mo, data=nesarc.subset)
summary(NDcount.3var.lm)

# Add another control variable (3 IV's)
NDcount.4var.lm <- lm(NDScount ~ GenAnx12mo + MajorDep12mo + Age, data=nesarc.subset)
summary(NDcount.4var.lm)


################################################################
# Logistic Regression
################################################################

# Bivariate case
ND.glm <- glm(NDLife ~ SocialPhob12mo, data=nesarc.subset, family="binomial")
summary(ND.glm)

# Multivariate case (2 IV's; controlling for major depression)
ND.3var.glm <- glm(NDLife ~ SocialPhob12mo + MajorDep12mo, data=nesarc.subset, family="binomial")
summary(ND.3var.glm) # Is this a case of confounding?

# Multivariate case (2 IV's; general anxiety disorder and social phobia)
ND.genanx.glm <- glm(NDLife ~ GenAnx12mo + MajorDep12mo, data=nesarc.subset, family="binomial")
summary(ND.genanx.glm)

# Interpreting results:
#  Coefficients in summary(my.glm) are the log-odds of the outcome
ND.genanx.glm$coefficients
#  Convert to odds ratio (more easily interpretable) by exponentiating
exp(ND.genanx.glm$coefficients)


################################################################
# Testing Moderation in Regression
################################################################

# Use * in your "formula" input to specify a moderation
# E.g. nicotine dependence (DV) as a function of major depression,
#  moderated by race
ND.mod.glm <- glm(NDLife ~ MajorDep12mo * race.coll, data=nesarc.subset,
                  family="binomial")
summary(ND.mod.glm)
