# Regressions

##########################################################################
# Linear Regression (DV is Quantitative)

library (ggplot2)
library (MASS)   # for the pairs function

# Load mtcars data and look at the documentation
data(mtcars)
help(mtcars)

# I am interested in what characteristics of a car are associated with lower gas mileage.


# Bivariate case: IV=weight (quantitative)
car.wt.lm <- lm(mpg ~ wt, data=mtcars)
summary(car.wt.lm)

# Illustrate the regression graphically:
ggplot (mtcars, aes(x = wt, y = mpg)) + 
  geom_point (shape = 1) +
  geom_smooth (method = lm, se = FALSE)     # remove ", se = FALSE" to show 95% confidence region

# look back at earlier examples to see what else you can do with this graph


# Another bivariate case: IV=transmission type (categorical)
car.trans.lm <- lm(mpg ~ am, data=mtcars)
summary(car.trans.lm)

# instead of +/- 1 SD, now plot confidence intervals (if mult = 1.96) or standard error bars (if mult = 1)
# in a normal distribution, 95% of the values within 1.96 standard errors of the population mean
# mention type of error bar in your graph or axes titles

ggplot (mtcars, aes(x = am, y = mpg)) + 
  stat_summary(fun.y="mean", geom="bar", color = "red", fill = "pink") +
  stat_summary(fun.data = mean_cl_normal, aes(width = 0.2), geom="errorbar", mult = 1.96, color = "red") +   # uses Hmisc
  geom_smooth (method = lm, aes (group = 1), se = FALSE, color = "red")        

# use EITHER confidence interval band for regression line OR standard error bars (NOT both)
# usually do NOT see regression lines on bar graphs ...


# Multivariate case: Can include multiple IV's, and they can be
#  quantitative, categorical, or a mixture of each



pairs (mtcars[,c("mpg", "wt", "am")])     
# plot scatterplot matrices for all variables of interest first


car.mult.lm <- lm(mpg ~ wt + am, data=mtcars)
summary(car.mult.lm)


car.mult.lm2 <- lm(mpg ~ wt + am + hp, data=mtcars)
summary(car.mult.lm2)

# compare the two models
anova(car.mult.lm, car.mult.lm2, test = "Chisq")
AIC(car.mult.lm)   
AIC(car.mult.lm2)       # the model with the smaller AIC (here, car.mult.lm2) 
                        #  is the 'better' model
# This tells us that it was good to have added hp to our model.  


#Was it good to have added am?  (am was non-significant, 
# but it also shows that same overall information using model comparison)
anova(car.wt.lm, car.mult.lm, test = "Chisq")
# No - this is not significant so the two models are not different from one 
# another, so choose the one with the smaller number of predictors



# Results of interest: Coefficient estimate, standard error, p-value, adjusted R^2
