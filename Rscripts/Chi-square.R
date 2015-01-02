# Set your working directory
#  Tools -> Set Working Directory -> Choose Directory

# Chi-square test of Nicotine Dependence (DV) by Major Depression (IV)
# H0: There is no relationship between Nicotine Dependence and Major Depression
# Ha: There is a relationship between Nicotine Dependence and Major Depression

# Use the function chisq.test(DV, IV) 
ND.chisq <- chisq.test(nesarc.subset$NDLife, nesarc.subset$MajorDep12mo)

# Overall result:
ND.chisq

# Expected cell counts:
ND.chisq$expected

# Observed cell counts:
ND.chisq$observed

# Residuals (like z-scores):
ND.chisq$residuals


# Another example: Nicotine Dependence by Race/Ethnicity
ND.race.chisq <- chisq.test(nesarc.subset$NDLife, nesarc.subset$ETHRACE2A)
ND.race.chisq
ND.race.chisq$expected
ND.race.chisq$observed
ND.race.chisq$residuals