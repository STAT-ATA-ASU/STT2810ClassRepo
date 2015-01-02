# Major Depression Status -> Smoking Quantity
# First print out a table of means
by(NESARC$S3AQ3C1, NESARC$MAJORDEP12, mean)

# Need to subset both DV and IV to exclude any NA's in the DV
by(NESARC$S3AQ3C1[!is.na(NESARC$S3AQ3C1)], 
   NESARC$MAJORDEP12[!is.na(NESARC$S3AQ3C1)], mean)

# Store the results to a workspace variable
SmkQuant.byMD <- by(NESARC$S3AQ3C1[!is.na(NESARC$S3AQ3C1)], 
   NESARC$MAJORDEP12[!is.na(NESARC$S3AQ3C1)], mean)

# Print out the table
SmkQuant.byMD

# View a barplot of mean Smoking Quantity (DV) by Major Depression (MD) status (IV)
barplot(SmkQuant.byMD, main="Mean Smoking Quantity (DV) by Major Depression
   Status (IV)", names=c("No MD","MD"), ylab="Number of cigarettes")

# If IV has more than 2 levels:
SmkQuant.bySmkFreq <- by(NESARC$S3AQ3C1[!is.na(NESARC$S3AQ3C1)], 
   NESARC$S3AQ3B1[!is.na(NESARC$S3AQ3C1)], mean)

# Print out the means table
SmkQuant.bySmkFreq

# View a barplot of mean Smoking Quantity (DV) by Smoking Frequency (IV)
barplot(SmkQuant.bySmkFreq, main="Mean Smoking Quantity (DV) by Major Depression
   Status (IV)", names=c("30","20-24","12-16","4-8","2-3","<=1"), ylab="Number
   of cigarettes", xlab="Smoking Frequency (# Days smoked in the past month)")