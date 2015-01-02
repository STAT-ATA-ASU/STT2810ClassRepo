# Set your working directory
#  Tools -> Set Working Directory -> Choose Directory -> Your folder on P drive

# Load one of R's built-in datasets
#  Fertility and socio-economic indicators in Swiss provinces
data(swiss)
#  Look at the documentation:
help(swiss)

# 1. Create a subset called swiss.subset1 that only includes the variables
#  Fertility, Agriculture, and Infant.Mortality

# 2. Create a subset called swiss.subset2 that includes ALL variables from
#  the original swiss dataset, but only has observations with Infant.Mortality
#  of 20% or higher

# ON THE ORIGINAL swiss DATASET:

# 3. Make a new categorical string variable called "Religion"
#  based on the existing quantitative variable "Catholic":
#  If the majority of a province is Catholic, label it "Catholic"
#  If the Catholic population is 50% or less, label it "Protestant"
#  Be sure to attach it to the swiss dataset

# 4. Make a new quantitative variable for general educational achievement,
#  by aggregating the variables "Examination" and "Education"
#  Be sure to attach it to the swiss dataset

# 5. Make a new categorical Agriculture variable by categorizing the existing
#  numeric variable "Agriculture."  Dichotomize this variable into two 
#  roughly equal groups (hint: use freq() to decide the cut point)

