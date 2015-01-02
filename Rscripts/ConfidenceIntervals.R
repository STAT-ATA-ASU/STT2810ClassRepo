load("P:/QAC/qac201/STUDENTS/Section2/aselya/NESARC_short.RData")
# Logistic regression
NDLife.logreg <- glm(NDLife ~ smkFreq + Age + Sex + Education, data=nesarc.subset, family="binomial")
summary(NDLife.logreg)

# True odds ratio is uncertain due to sampling

# Best estimate of the odds ratio is exp(coefficient):
exp(NDLife.logreg$coefficients)

# The standard error reflects the uncertainty in the odds ratio,
#  but when converting to odds ratios, you need to report the
#  95% confidence interval instead of the standard error

# Explanation of 95% confidence interval on a normal distribution:
#  95% of the population falls between +/- 1.96 standard deviations
hist(rnorm(10000))
abline(v=1.96, col="red")
abline(v=-1.96, col="red")

# So the 95% confidence interval is specified by
#  the mean +/- 1.96* standard error

# 95% confidence interval of smkFreq in the logistic regression:
summary(NDLife.logreg)
exp(-.500210 + 1.96*0.112505) # Upper bound of confidence interval
exp(-.500210 - 1.96*0.112505) # Lower bound of confidence interval

# The true population odds ratio has a 95% change of falling within this range