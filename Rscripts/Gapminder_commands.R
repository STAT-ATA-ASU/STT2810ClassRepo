# Load Gapminder data
load("P:/QAC/qac201/Studies/Gapminder/Data/gapminder_pds.RData")

#################################################################################
# DATA MANAGEMENT
#################################################################################
freq(as.ordered(gapminder_pds$incomeperperson))
incomegroup <- rep(NA, 289)
incomegroup[gapminder_pds$incomeperperson <= 744.239] <- 1
incomegroup[gapminder_pds$incomeperperson > 744.239 & 
              gapminder_pds$incomeperperson <= 2549.558] <- 2
incomegroup[gapminder_pds$incomeperperson > 2549.558 & 
              gapminder_pds$incomeperperson <= 9425.326] <- 3
incomegroup[gapminder_pds$incomeperperson > 9425.326] <- 4
freq(incomegroup)
gapminder_pds$incomegroup <- as.factor(incomegroup)

#################################################################################
# UNIVARIATE STATISTICS (QUANTITATIVE VARIABLES ONLY)
#################################################################################

# Urban rate
mean(gapminder_pds$urbanrate, na.rm=T)
sd(gapminder_pds$urbanrate, na.rm=T)
summary(gapminder_pds$urbanrate, na.rm=T)


# Internet use rate
mean(gapminder_pds$internetuserate, na.rm=T)
sd(gapminder_pds$internetuserate, na.rm=T)
summary(gapminder_pds$internetuserate, na.rm=T)


#################################################################################
# GRAPHING
#################################################################################

# Bivariate scatterplot (Q -> Q)
plot(gapminder_pds$urbanrate, gapminder_pds$internetuserate,
     main="Internet Users by Urban Population Rate",
     xlab="Urban Population Rate", ylab="Internet Users per 100 people", pch=13)
abline(lm(gapminder_pds$internetuserate ~ gapminder_pds$urbanrate))

# Bivariate barplot (C -> Q)
by(gapminder_pds$hivrate, gapminder_pds$incomegroup, mean, na.rm=T)
barplot(by(gapminder_pds$hivrate, gapminder_pds$incomegroup, mean, na.rm=T),
     main="HIV Rate by Income Group among Countries in Gapminder", ylab=
     "HIV Rate per 100 people", xlab="Income Quartile")


#################################################################################
# BIVARIATE STATISTICS
#################################################################################

# Pearson correlation
cor.test(gapminder_pds$internetuserate, gapminder_pds$urbanrate)

cor.test(gapminder_pds$internetuserate, gapminder_pds$incomeperperson)


#################################################################################
# MODERATION
#################################################################################

# Moderation- Pearson correlation
by(gapminder_pds, gapminder_pds$incomegroup, function(x) 
    cor.test(x$internetuserate, x$urbanrate))




# plot for R slides
par(mfrow=c(2,2))
by(gapminder_pds, gapminder_pds$incomegroup, function(x) 
  list(plot(x$urbanrate, x$internetuserate, ylab="Internet Use Rate",
            xlab="Urban Rate"),
    abline(lm(x$internetuserate ~ x$urbanrate))))
