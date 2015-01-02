# Confounding
data(mtcars)
mtcars$am <- as.factor(mtcars$am)
# I am examining whether car weight is a confounder of the relationship
#  between transmission type and gas mileage
# First test whether the bivariate association is significant:
trans.lm <- lm(mpg ~ am, data=mtcars)
summary(trans.lm)
# Now test the confounder
trans.wt.lm <- lm(mpg ~ am + wt, data=mtcars)
summary(trans.wt.lm)
# Since 1) transmission type was associated with mpg in the bivariate case,
#  and 2) did not remain significant in the multivariate case after 
#  controlling for weight, that means weight is a confounder.


###########################################################################
# Moderation
# I am examining gas mileage as a function of transmission type, weight, 
#  and the interaction between transmission type and weight
cars.mod.lm <- lm(mpg ~ am * wt, data=mtcars)
summary(cars.mod.lm)
# Main terms show that manual transmissions have higher gas mileage,
#  and heavier cars have lower gas mileage.  The interaction term indicates
#  that, among automatic cars, weight is more strongly associated with 
#  lower gas mileage.
# Plot this. (Quantitative DV, Quantitative IV, categorical 3rd variable
#  means I follow Q-Q-C plotting)
plot(mtcars$wt, mtcars$mpg, type="n",
     main="Transmission type moderates the relationship between \n Weight and Gas Mileage",
     ylab="Miles/Gallon", xlab="Weight (1000 lbs)")
points(mtcars$wt[mtcars$am==0], mtcars$mpg[mtcars$am==0], col="green")
points(mtcars$wt[mtcars$am==1], mtcars$mpg[mtcars$am==1], col="blue")
# Add trend lines from bivariate regressions for each kind of transmission
abline(lm(mpg ~ wt, data=mtcars[mtcars$am==0,]), col="green")
abline(lm(mpg ~ wt, data=mtcars[mtcars$am==1,]), col="blue")
# Add legend
legend("topright",c("Automatic","Manual"),col=c("green","blue"),pch=1, lty=1)
# The association between weight and gas mileage is stronger (i.e. more negative)
#  for manual cars than for automatic cars


###########################################################################
# Exercises

# 1. Load the data on air quality measurements in NY
data(airquality)
help(airquality)

# 2. Examine the ozone concentration (DV) as a function of temperature,
#  wind, and the interaction between temperature and wind

# 3. What do the results tell you?  Is there moderation?  If so, 
#  explain the moderation by interpreting the coefficients and/or 
#  multivariate plot

# 4. Categorize the "Month" variable:
airquality$Month <- as.factor(airquality$Month)

# 5. Examine whether the relationship between Ozone (DV) and Month (IV)
#  is confounded by temperature.

# 6. Load data on fertility in Swiss provinces and look at documentation
data(swiss)
help(swiss)

# 7. Examine whether the relationship between fertility (DV) and 
#  % of males in agriculture (IV) is confounded by education
#  beyond primary school