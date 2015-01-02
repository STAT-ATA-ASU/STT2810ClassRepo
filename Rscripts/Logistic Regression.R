# Regressions

##########################################################################
# Logistic Regression (DV is Binary Categorical)

# Load infertility data
data(infert)
help(infert)

# I am interested in what factors are associated with infertility.
#  First, since I need a binary DV, I categorize the number of spontaneous
#  abortions to 0 vs. any:

infert$spon.bin <- 1
infert$spon.bin[infert$spontaneous==0] <- 0

# Bivariate case: Is age associated with infertility?
#  Can't use a linear regression (bc there is not a linear relationship between X and Y)

ggplot(infert, aes(x = age, y = spon.bin)) +
  geom_point (shape = 1) +
  stat_smooth(method="glm", family="binomial", se = FALSE)  
# stat_smooth appears to be really picky about how you set up your factor!  
#  e.g., (all NAs, then values, then as.factor doesn't work)
# the regression code will run either way (as will the scatterplot)

#  Problems with using a linear regression with a binary DV:
#  - Seriously violates assumptions of a linear model (normality of residuals)
#  - Predicted values for DV can be outside of the possible values 0 and 1
#  (See video from Chapter 17)

# Solution: Use logistic regression to model the log odds of DV being 1


# one quantitative IV
infert.glm1 <- glm(spon.bin ~ age, data=infert, family="binomial")
summary(infert.glm1)
exp(coef(infert.glm1)) # exponentiated coefficients
exp(confint(infert.glm1)) # 95% CI for exponentiated coefficients

#Age is significant associated with infertility; with a 1 year increase in age,
#the estimated odds of spontaneous abortion decrease by a factor of 0.945, 95% OR[.90, .99].
#That is, the relative odds of a spontaneous abortion are about 5% less for each one year 
#increase in age.


# try another model:
# two quantitative IVs
infert.glm2 <- glm(spon.bin ~ age + induced, data=infert, family="binomial")
summary(infert.glm2)
exp(coef(infert.glm2))
exp(confint(infert.glm2))

# Controlling for induced, a 1 year increase in age reduces the relative odds of an 
# abortion by approximately 7%, OR = .93, 95% CI[0.88, 0.98], p = .007.  An increase
# in the number of prior induced abortions {you'd probably want this variable to have been a factor instead}
# decreases the relative odds of an abortion by a factor of 0.45.


# Advanced FYI: if you wanted to see if there is a different effect of age for different levels
# of induced abortion, you would use an interaction in your model.

# Is glm2 significantly better than glm1?  Adding parameters can come at a cost.
anova (infert.glm1, infert.glm2, test = "Chisq")

AIC(infert.glm1)   
AIC(infert.glm2)       # the model with the smaller AIC (here, infert.glm2) 
#  is the 'better' model
# This tells us that it was good to have added induced to our model.  


# try another model:
# two quantitative and one categorical (with 3 levels) IVs

summary (infert$education)  # FYI: education has 3 levels

infert.glm3 <- glm(spon.bin ~ age + induced + education, data=infert, family="binomial")
summary(infert.glm3)
  # neither 6-11 or 12+ years of education are significantly different from 0-5 years of education
exp(coef(infert.glm3))
exp(confint(infert.glm3))   # notice that the 95% CI now include the value of 1 (indicates that not significant)

  # but did adding the variable education overall make a difference (i.e., improve the fit)?
anova (infert.glm2, infert.glm1, test = "Chisq")   # compare two models that differ by only one term
AIC(infert.glm2)   
AIC(infert.glm3)       
   # the model with the smaller AIC (here, infert.glm2 is better so NO, adding education didn't help) 

#### BUT, notice that the effects of age and induced have changed slightly.... 
# if this were a "large enough" change, then we would know that education was a confound



# try another model, one categorical IV:
infert$case <- factor(infert$case, levels = c(0,1), labels = c("control", "case"))  # from codebook

infert.glm4 <- glm(spon.bin ~  case, data=infert, family="binomial")
summary(infert.glm4)
# as you go from control to case, the change in log odds is 1.45.

exp(coef(infert.glm4))
exp(confint(infert.glm4))   

#The odds of a spontaneous abortion for individuals with case status are 4.27 times the odds of a spontaneous
#abortion for individuals in the control group, 95%CI[2.46, 7.56].


#### keep going with model building, adding variables to:
# a) see if they are significant confounders
# b) control for the effects of that third variable (even if non-significant)
# c) develop the best model for your data (use model comparison)
# and so forth ...

