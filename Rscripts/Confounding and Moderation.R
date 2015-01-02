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
#  controlling for weight, that means weight is a confounder _WHEN_ your RQ was about
#  the relationship between transmission type and gas mileage.


###########################################################################
# Moderation
# I am examining gas mileage as a function of transmission type, weight, 
#  and the interaction between transmission type and weight

# This is the more statistically correct approach, as opposed to subsetting your data.
#   ** Both approaches tell you if the effect of 1 IV is different at 
#   different levels of the other IV.
cars.mod.lm <- lm(mpg ~ am * wt, data=mtcars)
summary(cars.mod.lm)

# Main terms show that manual transmissions have higher gas mileage,
#  and heavier cars have lower gas mileage.  The interaction term indicates
#  that, among automatic cars, weight is more strongly associated with 
#  lower gas mileage.  WITH AN INTERACTION, CAN'T INTERPRET OTHER TERMS IN THE SAME WAY
#  ANYMORE --- NEED TO LOOK AT THE GRAPH to interpret the interaction.

# Plot this. (Quantitative DV, Quantitative IV, categorical 3rd variable
#  means I follow Q-Q-C plotting)

ggplot (mtcars, aes(x = wt, y = mpg, group = am, color = am)) +          # put the quantitative variable in the group placeholder 
  geom_point (shape = 1) +
  geom_smooth (method = lm, se = FALSE) 

# From the graph, you see that:
# The association between weight and gas mileage is stronger (i.e. more negative)
#  for manual cars than for automatic cars  [using ?mtcars gives you the codebook info]

