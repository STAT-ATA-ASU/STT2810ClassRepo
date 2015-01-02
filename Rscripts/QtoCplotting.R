# Age of Smoking Initation -> Nicotine Dependence
# Wrong approach- too many levels to be informative
table(NESARC$S3AQ2A1, NESARC$TAB12MDX)
plot(table(NESARC$S3AQ2A1, NESARC$TAB12MDX), main="Nicotine Dependence by 
     Age of Smoking Initiation", xlab="Age of Smoking Initiation (Years)",
     ylab="Nicotine Dependence")

# For graphing purposes, need to categorize Age (IV) into meaningful groups
# Based on literature, early smoking initiation is very dangerous, but
# initiation in adulthood is less risky
Age.group <- rep(NA,43093)
Age.group[NESARC$S3AQ2A1 < 10] <- 1
Age.group[NESARC$S3AQ2A1 >= 10 & NESARC$S3AQ2A1 <16] <- 2
Age.group[NESARC$S3AQ2A1 >= 16 & NESARC$S3AQ2A1 <21] <- 3
Age.group[NESARC$S3AQ2A1 >= 21] <- 4
Age.group <- as.factor(Age.group)

# Can use Excel to graph, after copying over the information from the 2nd row of:
prop.table(table(NESARC$TAB12MDX, Age.group),2)

# Advanced: Instead, proceed with graphing as in C -> C
barplot(prop.table(table(NESARC$TAB12MDX,Age.group),2)[2,], main="Prevalence of
     Nicotine Dependence by Age of Smoking Initiation", xlab="Age of Smoking 
     Initiation (Years)", ylab="Prevalence of Nicotine Dependence")


