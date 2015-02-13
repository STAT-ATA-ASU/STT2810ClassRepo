# Load Gapminder data
# load("P:/QAC/qac201/Studies/Gapminder/Data/gapminder_pds.RData")
# There are erros in this script....ATA 1/02/15
# What follow is for downloading from a url

# site <- "http://www1.appstate.edu/~arnholta/classes/PDS/DATAandCODEBOOKS/GapMinder/gapminder.RData"
# con <- url(site)
# load(con)
# head(gapminder)

library(PDS)
#################################################################################
# DATA MANAGEMENT
library(descr)
#################################################################################
freq(as.ordered(gapminder$incomeperperson))
incomegroup <- rep(NA, 289)
incomegroup[gapminder$incomeperperson <= 744.239] <- 1
incomegroup[gapminder$incomeperperson > 744.239 & 
              gapminder$incomeperperson <= 2549.558] <- 2
incomegroup[gapminder$incomeperperson > 2549.558 & 
              gapminder$incomeperperson <= 9425.326] <- 3
incomegroup[gapminder$incomeperperson > 9425.326] <- 4
freq(incomegroup)
gapminder$incomegroup <- as.factor(incomegroup)

#################################################################################
# UNIVARIATE STATISTICS (QUANTITATIVE VARIABLES ONLY)
#################################################################################

# Urban rate
mean(gapminder$urbanrate, na.rm=T)
sd(gapminder$urbanrate, na.rm=T)
summary(gapminder$urbanrate, na.rm=T)


# Internet use rate
mean(gapminder$internetuserate, na.rm=T)
sd(gapminder$internetuserate, na.rm=T)
summary(gapminder$internetuserate, na.rm=T)


#################################################################################
# GRAPHING
#################################################################################

# Bivariate scatterplot (Q -> Q)
plot(gapminder$urbanrate, gapminder$internetuserate,
     main="Internet Users by Urban Population Rate",
     xlab="Urban Population Rate", ylab="Internet Users per 100 people", pch=13)
abline(lm(gapminder$internetuserate ~ gapminder$urbanrate))

# Bivariate barplot (C -> Q)
by(gapminder$hivrate, gapminder$incomegroup, mean, na.rm=T)
barplot(by(gapminder$hivrate, gapminder$incomegroup, mean, na.rm=T),
     main="HIV Rate by Income Group among Countries in Gapminder", ylab=
     "HIV Rate per 100 people", xlab="Income Quartile")


#################################################################################
# BIVARIATE STATISTICS
#################################################################################

# Pearson correlation
cor.test(gapminder$internetuserate, gapminder$urbanrate)

cor.test(gapminder$internetuserate, gapminder$incomeperperson)


#################################################################################
# MODERATION
#################################################################################

# Moderation- Pearson correlation
by(gapminder, gapminder$incomegroup, function(x) 
    cor.test(x$internetuserate, x$urbanrate))




# plot for R slides
par(mfrow=c(2,2))
by(gapminder, gapminder$incomegroup, function(x) 
  list(plot(x$urbanrate, x$internetuserate, ylab="Internet Use Rate",
            xlab="Urban Rate"),
    abline(lm(x$internetuserate ~ x$urbanrate))))

