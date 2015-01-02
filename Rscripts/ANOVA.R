# Set your working directory
#  Tools -> Set Working Directory -> Choose Directory -> Select your folder

# Load a built-in dataset, chickwts
# data(chickwts)
# Look at the documentation
help(chickwts)

# H0: Chick weights are equal for all feed groups.
# Ha: Chick weights across feed groups are not all equal.

# Run an ANOVA and store the analysis object
#  Needs formula as input, of the form DV ~ IV ...
chick.aov <- aov(weight ~ feed, data=chickwts)

# Look at the summary of the ANOVA analysis
summary(chick.aov)



# Another example
#  Load the built-in dataset airquality
# data(airquality)
help(airquality)
#  H0: Ozone levels are the same across months
#  Ha: Ozone levels are not the same for all months

# First, need to categorize "Month"
airquality$Month <- as.factor(airquality$Month)
air.aov <- aov(Ozone ~ Month, data=airquality)
summary(air.aov)

