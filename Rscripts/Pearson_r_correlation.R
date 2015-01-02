# Set your working directory
#  Tools -> Set Working Directory -> Choose Directory

# Pearson r correlation test between number of Nicotine Dependence symptoms (DV)
#  and smoking quantity (IV)
# Use function cor.test(DV, IV) 
ND.cor <- cor.test(nesarc.subset$NDScount, nesarc.subset$smkQuant)

# Look at the results
ND.cor



# Another example: smoking quantity (DV) as a function of age (IV)
SQ.cor <- cor.test(nesarc.subset$smkQuant, nesarc.subset$Age)
SQ.cor
