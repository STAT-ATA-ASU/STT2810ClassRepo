# Regressions

##########################################################################
# Linear Regression (DV is Quantitative)

# Load mtcars data and look at the documentation
data(mtcars)
help(mtcars)

# I am interested in what characteristics of a car are associated with
#  lower gas mileage.
# Bivariate case: IV=weight (quantitative)
car.wt.lm <- lm(mpg ~ wt, data=mtcars)
summary(car.wt.lm)

# Illustrate the regression graphically:
plot(mtcars$wt, mtcars$mpg)
abline(car.wt.lm)

# Another bivariate case: IV=transmission type (categorical)
car.trans.lm <- lm(mpg ~ am, data=mtcars)
summary(car.trans.lm)
plot(mtcars$am, mtcars$mpg)
abline(car.trans.lm)

# Multivariate case: Can include multiple IV's, and they can be
#  quantitative, categorical, or a mixture of each
car.mult.lm <- lm(mpg ~ wt + am + hp, data=mtcars)
summary(car.mult.lm)
# Results of interest: Coefficient estimate, standard error, p-value, R^2


#########################################################################
# Logistic Regression (DV is Binary Categorical)

# Load infertility data
data(infert)
help(infert)

# I am interested in what factors are associated with infertility.
#  First, since I need a binary DV, I categorize the number of spontaneous
#  abortions to 0 vs. any:
spon.bin <- rep(NA, 248)
spon.bin[infert$spontaneous==0] <- 0
spon.bin[infert$spontaneous==1 | infert$spontaneous==2] <- 1
infert$spon.bin <- as.factor(spon.bin)

# Bivariate case: Is age associated with infertility?
#  Can't use a linear regression
plot(infert$age, infert$spon.bin)
#  Problems with using a linear regression with a binary DV:
#  - Seriously violates assumptions of a linear model (normality of residuals)
#  - Predicted values for DV can be outside of the possible values 0 and 1
#  (See video from Chapter 17)

# Solution: Use logistic regression to model the odds of DV being 1
infert.glm <- glm(spon.bin ~ age + induced + education, data=infert, 
                  family="binomial")
summary(infert.glm)

# Need extra steps for more easily interpretable results:
exp(infert.glm$coefficients) # for odds ratios (O.R.)
exp(confint(infert.glm)) # for 95% confidence intervals of O.R.


#######################################################################
# Exercises

# 1. Load data CO2 and look at the documentation
data(CO2)
help(CO2)

# 2. Run a regression of the plant's CO2 uptake (DV) as a function of 
#  treatment, CO2 concentration, and origin of the plant (IV's)

# 3. Which IV's are significantly associated with changes in CO2 uptake?
#   What are the coefficients?

# 4. Do plants from Quebec or Mississippi have higher CO2 uptake?

# 5. Load data Pima.tr and look at the documentation
library(MASS)
data(Pima.tr)
help(Pima.tr)

# 6. Run a regression of diabetes status (DV) as a function of bmi, age,
#  and glucose concentration

# 7. which IV's are significantly associated with diabetes?

# 8. What are the odds ratios for each IV? What are the confidence intervals
#  for each odds ratio?