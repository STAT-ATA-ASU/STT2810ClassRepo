library(descr)
# Basic default plot
freq(NESARC$ETHRACE2A)

# Add main title
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample")

# Add x- and y-axis labels
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample", 
     xlab="Race/Ethnicity", ylab="Number of people")

# Add names for each level of ETHRACE2A
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample", 
    xlab="Race/Ethnicity", ylab="Number of people", names=c("White","Black",
    "Native American","Asian","Hispanic"))

# Change colors of the bars
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample", 
    xlab="Race/Ethnicity", ylab="Number of people", names=c("White","Black",
    "Native American","Asian","Hispanic"), col="steelblue")

# Change colors of the bars, using one color for each bar
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample", 
    xlab="Race/Ethnicity", ylab="Number of people", names=c("White","Black",
    "Native American","Asian","Hispanic"), col=c("red","green","blue","yellow",
    "pink"))

# Change colors of the bars using one of R's automatic color schemes
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample", 
    xlab="Race/Ethnicity", ylab="Number of people", names=c("White","Black",
    "Native American","Asian","Hispanic"), col=rainbow(5))

# Remove names and add a legend for the color-coding
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample", 
    xlab="Race/Ethnicity", ylab="Number of people", names=NA, col=rainbow(5), 
    legend.text=c("White","Black", "Native American","Asian","Hispanic"))

# Place the legend in an appropriate position on the plot
freq(NESARC$ETHRACE2A, main="Histogram of Race/Ethnicity in NESARC sample", 
    xlab="Race/Ethnicity", ylab="Number of people", names=NA, col=rainbow(5), 
    legend.text=c("White","Black", "Native American","Asian","Hispanic"),
    args.legend=list(x="top"))