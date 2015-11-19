## ---- echo = FALSE, message = FALSE--------------------------------------
knitr::opts_chunk$set(comment = NA, message = FALSE, warning = FALSE, fig.align = "center")
library(dplyr)
library(ggplot2)

## ----label = "READIN"----------------------------------------------------
firstpart <- "http://www1.appstate.edu/~arnholta/classes/"
secondpart <- "PDS/DATAandCODEBOOKS/NESARC/NESARC_pds.RData"
site <-paste0(firstpart, secondpart) 
con <- url(site)
load(con)
NESARC[1:6, 1:10] # show first six rows and first 10 columns
rm(NESARC) # removing NESARC

## ----eval = FALSE--------------------------------------------------------
## install.packages("devtools", dependencies = TRUE)
## devtools::has_devel()

## ----eval = FALSE--------------------------------------------------------
## devtools::install_github('alanarnholt/PDS')

## ------------------------------------------------------------------------
library(PDS)

## ------------------------------------------------------------------------
gapminder[1:5, 'incomeperperson']

## ----eval = FALSE--------------------------------------------------------
## install.packages("dplyr")

## ----eval = FALSE--------------------------------------------------------
## if (packageVersion("devtools") < 1.6) {
##   install.packages("devtools")
## }
## devtools::install_github("hadley/lazyeval")
## devtools::install_github("hadley/dplyr")

## ----label = "RENAME"----------------------------------------------------
library(dplyr)
# Create a data frame tbl see ?tbl_df
NESARCtbl <- tbl_df(NESARC)
NESARC <- rename(NESARCtbl, UniqueID = IDNUM, EthanolConsumption = ETOTLCA2, 
                 Ethnicity = ETHRACE2A)
NESARC[1:5, 1:5]

## ----label = "CodeMissing"-----------------------------------------------
NESARC$S3AQ3B1[NESARC$S3AQ3B1 == 9] <- NA
summary(NESARC$S3AQ3B1)  # Note that 9 still appears
NESARC$S3AQ3B1 <- factor(NESARC$S3AQ3B1)[, drop = TRUE]
summary(NESARC$S3AQ3B1)  # Unused level no longer appears

## ----label = "Freq"------------------------------------------------------
NESARC$S3AQ3B1 <- factor(NESARC$S3AQ3B1, 
                         labels = c("Every Day", "5 to 6 Days/week", 
                                    "3 to 4 Days/week", "1 to 2 Days/week", 
                                    "2 to 3 Days/month", "Once a month or less"))
summary(NESARC$S3AQ3B1)
xtabs(~S3AQ3B1, data = NESARC) # Note how the NA's are not printed

## ----label = "ggSmoke", fig.width = 10, fig.wdith = 5--------------------
library(ggplot2)
ggplot(data = NESARC, aes(x = S3AQ3B1)) + 
  geom_bar(fill = "lightgray") + 
  labs(x = "Smoking Frequency") +
  theme_bw() 

## ----label = "ggSmoke2", fig.width = 10, fig.wdith = 5-------------------
ggplot(data = na.omit(NESARC[ , "S3AQ3B1", drop = FALSE]), aes(x = S3AQ3B1)) + 
  geom_bar(fill = "lightgray") + 
  labs(x = "Smoking Frequency") +
  theme_bw() 

## ----label = "Summary1"--------------------------------------------------
summary(NESARC$S4AQ4A1)

## ----label = "recodeNO"--------------------------------------------------
NESARCre <- NESARC
NESARCre$S4AQ4A1[is.na(NESARCre$S4AQ4A1)] <- 2
summary(NESARCre$S4AQ4A1)
NESARCre$S4AQ4A1 <- factor(NESARCre$S4AQ4A1)
summary(NESARCre$S4AQ4A1)
rm(NESARCre)  # remove NESARCre and newly created S4AQ4A1

## ----label = "CollapseHS"------------------------------------------------
NESARC$HS_DEGREE <- factor(ifelse(NESARC$S1Q6A %in% c("1", "2", "3", "4", "5", "6", "7"), 
                                  "No", "Yes"))
summary(NESARC$HS_DEGREE)

## ----label = "CUT1"------------------------------------------------------
NESARC$AGEfac <- cut(NESARC$AGE, breaks = c(18, 30, 50, Inf), 
                     labels = c("Young Adult", "Adult", "Older Adult"), 
                     include.lowest = TRUE)
summary(NESARC$AGEfac)

## ----label = "CUT2"------------------------------------------------------
NESARC$S3AQ3C1fac <- cut(NESARC$S3AQ3C1, breaks = c(0, 5, 10, 15, 20, 100), 
                         include.lowest = TRUE)
summary(NESARC$S3AQ3C1fac)

## ----label = "Agg1"------------------------------------------------------
NESARC$DepressLife <- factor(ifelse( (NESARC$MAJORDEPLIFE == 1 | NESARC$DYSLIFE == 1), 
                                     "Yes", "No"))
summary(NESARC$DepressLife)

## ----label = "PANIC"-----------------------------------------------------
NESARC$PPpanic <- factor(ifelse( (NESARC$APANDX12 == 1 | NESARC$APANDXP12 == 1 | 
                                    NESARC$PANDX12 == 1 | NESARC$PANDXP12 == 1 ), 
                                 "Yes", "No"))
summary(NESARC$PPpanic)

## ----label = "DEPsym"----------------------------------------------------
NESARC$AllDeprSymp <- factor(ifelse( (NESARC$S4AQ4A1 == 1 & NESARC$S4AQ4A2 == 1 & 
                                        NESARC$S4AQ4A3 == 1 & NESARC$S4AQ4A4 == 1 & 
                                        NESARC$S4AQ4A5 == 1 & NESARC$S4AQ4A6 == 1 & 
                                        NESARC$S4AQ4A7 == 1 & NESARC$S4AQ4A8 == 1 & 
                                        NESARC$S4AQ4A9 == 1 & NESARC$S4AQ4A10 == 1 & 
                                        NESARC$S4AQ4A11 == 1 & NESARC$S4AQ4A12 == 1 & 
                                        NESARC$S4AQ4A13 == 1 & NESARC$S4AQ4A14 == 1 & 
                                        NESARC$S4AQ4A15 == 1 & NESARC$S4AQ4A16 == 1 & 
                                        NESARC$S4AQ4A17 == 1 & NESARC$S4AQ4A18 == 1 & 
                                        NESARC$S4AQ4A19 == 1), "Yes", "No"))
summary(NESARC$AllDeprSymp)

## ------------------------------------------------------------------------
sdf <- NESARC %>%
  select(contains("S4AQ4A"))
sdf[] <- lapply(sdf, as.character)
sdf[] <- lapply(sdf, as.numeric)
myfix <- function(x){ifelse(x %in% c(2, 9), 0, ifelse(x == 1, 1, NA))}
nsd <- apply(sdf, 2, myfix)
nsd <- as.data.frame(nsd)
nsd$NDS <- apply(nsd, 1, sum, na.rm = FALSE)
xtabs(~NDS, data = nsd)

## ------------------------------------------------------------------------
mysum <- function(x){sum(x == 1)}
myadd <- function(x){apply(x, 1, mysum)}
ndf <- NESARC %>%
  select(contains("S4AQ4A"))
nDS <- myadd(ndf)
ndf <- cbind(ndf, nDS)
xtabs(~nDS, data = ndf)    

## ------------------------------------------------------------------------
summary(NESARC$S4AQ4A1)
levels(NESARC$S4AQ4A1)
table(as.numeric(NESARC$S4AQ4A1))

## ------------------------------------------------------------------------
summary(NESARC$S4AQ4A1)
levels(NESARC$S4AQ4A1)
table(as.numeric(levels(NESARC$S4AQ4A1))[NESARC$S4AQ4A1])

## ----label = "CompositeFactor"-------------------------------------------
summary(NESARC$S4AQ4A1)
levels(NESARC$S4AQ4A1)
table(as.numeric(NESARC$S4AQ4A1))
NESARC$S4AQ4A1num <- as.numeric(levels(NESARC$S4AQ4A1))[NESARC$S4AQ4A1]
xtabs(~S4AQ4A1num, data = NESARC)
NESARC$S4AQ4A1num[NESARC$S4AQ4A1num == 2 | NESARC$S4AQ4A1num == 9] <- 0
xtabs(~S4AQ4A1num, data = NESARC)
NESARC$S4AQ4A2num <- as.numeric(levels(NESARC$S4AQ4A2))[NESARC$S4AQ4A2]
NESARC$S4AQ4A2num[NESARC$S4AQ4A2num == 2 | NESARC$S4AQ4A2num == 9] <- 0
NESARC$S4AQ4A3num <- as.numeric(levels(NESARC$S4AQ4A3))[NESARC$S4AQ4A3]
NESARC$S4AQ4A3num[NESARC$S4AQ4A3num == 2 | NESARC$S4AQ4A3num == 9] <- 0
NESARC$S4AQ4A4num <- as.numeric(levels(NESARC$S4AQ4A4))[NESARC$S4AQ4A4]
NESARC$S4AQ4A4num[NESARC$S4AQ4A4num == 2 | NESARC$S4AQ4A4num == 9] <- 0
NESARC$S4AQ4A5num <- as.numeric(levels(NESARC$S4AQ4A5))[NESARC$S4AQ4A5]
NESARC$S4AQ4A5num[NESARC$S4AQ4A5num == 2 | NESARC$S4AQ4A5num == 9] <- 0
NESARC$S4AQ4A6num <- as.numeric(levels(NESARC$S4AQ4A6))[NESARC$S4AQ4A6]
NESARC$S4AQ4A6num[NESARC$S4AQ4A6num == 2 | NESARC$S4AQ4A6num == 9] <- 0
NESARC$S4AQ4A7num <- as.numeric(levels(NESARC$S4AQ4A7))[NESARC$S4AQ4A7]
NESARC$S4AQ4A7num[NESARC$S4AQ4A7num == 2 | NESARC$S4AQ4A7num == 9] <- 0
NESARC$S4AQ4A8num <- as.numeric(levels(NESARC$S4AQ4A8))[NESARC$S4AQ4A8]
NESARC$S4AQ4A8num[NESARC$S4AQ4A8num == 2 | NESARC$S4AQ4A8num == 9] <- 0
NESARC$S4AQ4A9num <- as.numeric(levels(NESARC$S4AQ4A9))[NESARC$S4AQ4A9]
NESARC$S4AQ4A9num[NESARC$S4AQ4A9num == 2 | NESARC$S4AQ4A9num == 9] <- 0
NESARC$S4AQ4A10num <- as.numeric(levels(NESARC$S4AQ4A10))[NESARC$S4AQ4A10]
NESARC$S4AQ4A10num[NESARC$S4AQ4A10num == 2 | NESARC$S4AQ4A10num == 9] <- 0
NESARC$S4AQ4A11num <- as.numeric(levels(NESARC$S4AQ4A11))[NESARC$S4AQ4A11]
NESARC$S4AQ4A11num[NESARC$S4AQ4A11num == 2 | NESARC$S4AQ4A11num == 9] <- 0
NESARC$S4AQ4A12num <- as.numeric(levels(NESARC$S4AQ4A12))[NESARC$S4AQ4A12]
NESARC$S4AQ4A12num[NESARC$S4AQ4A12num == 2 | NESARC$S4AQ4A12num == 9] <- 0
NESARC$S4AQ4A13num <- as.numeric(levels(NESARC$S4AQ4A13))[NESARC$S4AQ4A13]
NESARC$S4AQ4A13num[NESARC$S4AQ4A13num == 2 | NESARC$S4AQ4A13num == 9] <- 0
NESARC$S4AQ4A14num <- as.numeric(levels(NESARC$S4AQ4A14))[NESARC$S4AQ4A14]
NESARC$S4AQ4A14num[NESARC$S4AQ4A14num == 2 | NESARC$S4AQ4A14num == 9] <- 0
NESARC$S4AQ4A15num <- as.numeric(levels(NESARC$S4AQ4A15))[NESARC$S4AQ4A15]
NESARC$S4AQ4A15num[NESARC$S4AQ4A15num == 2 | NESARC$S4AQ4A15num == 9] <- 0
NESARC$S4AQ4A16num <- as.numeric(levels(NESARC$S4AQ4A16))[NESARC$S4AQ4A16]
NESARC$S4AQ4A16num[NESARC$S4AQ4A16num == 2 | NESARC$S4AQ4A16num == 9] <- 0
NESARC$S4AQ4A17num <- as.numeric(levels(NESARC$S4AQ4A17))[NESARC$S4AQ4A17]
NESARC$S4AQ4A17num[NESARC$S4AQ4A17num == 2 | NESARC$S4AQ4A17num == 9] <- 0
NESARC$S4AQ4A18num <- as.numeric(levels(NESARC$S4AQ4A18))[NESARC$S4AQ4A18]
NESARC$S4AQ4A18num[NESARC$S4AQ4A18num == 2 | NESARC$S4AQ4A18num == 9] <- 0
NESARC$S4AQ4A19num <- as.numeric(levels(NESARC$S4AQ4A19))[NESARC$S4AQ4A19]
NESARC$S4AQ4A19num[NESARC$S4AQ4A19num == 2 | NESARC$S4AQ4A19num == 9] <- 0
NESARC$NumDepSym <- NESARC$S4AQ4A1num + NESARC$S4AQ4A2num + NESARC$S4AQ4A3num + 
  NESARC$S4AQ4A4num + NESARC$S4AQ4A5num + NESARC$S4AQ4A6num + NESARC$S4AQ4A7num + 
  NESARC$S4AQ4A8num + NESARC$S4AQ4A9num + NESARC$S4AQ4A10num + NESARC$S4AQ4A11num + 
  NESARC$S4AQ4A12num + NESARC$S4AQ4A13num + NESARC$S4AQ4A14num + NESARC$S4AQ4A15num + 
  NESARC$S4AQ4A16num + NESARC$S4AQ4A17num + NESARC$S4AQ4A18num + NESARC$S4AQ4A19num
xtabs(~NumDepSym, data = NESARC)

## ----label = "SUB1"------------------------------------------------------
NESARCsub1 <- NESARC %>%
  filter(S3AQ1A == 1 & CHECK321 == 1 & S3AQ3B1 == "Every Day" & AGE <= 25)
dim(NESARCsub1)

## ----label = "SUB2"------------------------------------------------------
NESARCsub2 <- NESARC[NESARC$S3AQ1A == 1 & NESARC$CHECK321 == 1 & 
                       NESARC$S3AQ3B1 == "Every Day" & NESARC$AGE <= 25  & 
                       !is.na(NESARC$S3AQ1A == 1 & NESARC$CHECK321 == 1 & 
                       NESARC$S3AQ3B1 == "Every Day" & NESARC$AGE <= 25), ]
dim(NESARCsub2)

## ----label = "SUB3"------------------------------------------------------
NESARCsub3 <- subset(NESARC, subset = S3AQ1A == 1 & CHECK321 == 1 & 
                       S3AQ3B1 == "Every Day" & AGE <= 25)
dim(NESARCsub3)

## ----label = "ggNV"------------------------------------------------------
ggplot(data = NESARC, aes(x = AGE)) + 
  geom_histogram(binwidth = 5, fill = "lightgray") + 
  theme_bw()  
ggplot(data = NESARC, aes(x = AGE, y = ..density..)) + 
  geom_histogram(binwidth = 5, fill = "lightgray") + 
  theme_bw()  
ggplot(data = NESARC, aes(x = AGE, y = ..density..)) + 
  geom_histogram(binwidth = 5, fill = "lightgray") + 
  theme_bw() + 
  geom_density(fill = "yellow", alpha = 0.2)

## ----label = "Mini"------------------------------------------------------
MINI <- NESARC %>%
  select(S1Q24FT, S1Q24IN, S1Q24LB, SEX) %>%
  filter(S1Q24FT < 99, S1Q24IN < 99, S1Q24LB < 999) %>%
  mutate(Inches = (S1Q24FT*12 + S1Q24IN), 
         Sex = factor(SEX,  labels =c("Male", "Female"))) %>%
  rename(Weight = S1Q24LB)
MINI

## ----label = "WtHist"----------------------------------------------------
ggplot(data = MINI, aes(x = Inches)) + 
  geom_histogram(binwidth = 1, fill = "peachpuff") + 
  theme_bw()
ggplot(data = MINI, aes(x = Inches)) + 
  geom_density(aes(fill = Sex, color = Sex)) + 
  theme_bw() + 
  facet_grid(Sex ~ .) 
tapply(MINI$Inches, MINI$Sex, median)  

## ----label = "LastTwo"---------------------------------------------------
ggplot(data = MINI, aes(x = Inches, y = Weight, color = Sex)) + 
  geom_point(alpha = 0.1) + 
  stat_smooth(method = "lm") + 
  theme_bw() + 
  labs(y = "Weight (pounds)")
ggplot(data = MINI, aes(x = Inches, y = Weight)) + 
  geom_point(alpha = 0.1, aes(color = Sex)) +
  stat_smooth(method = "lm", aes(color = Sex)) + 
  facet_grid(Sex ~ .) + 
  theme_bw() + 
  labs(y = "Weight (pounds)")

## ----label = "ANOVAexp"--------------------------------------------------
my.aov <- aov(S3AQ3C1 ~ TAB12MDX, data = subset(NESARC, S3AQ3C1 < 99)) # Note S3AQ3C1 == 99 is NA
summary(my.aov)     
TukeyHSD(my.aov)
plot(TukeyHSD(my.aov))

## ----label = "qqP1"------------------------------------------------------
library(car)
qqPlot(my.aov)

## ----label = "REGexp"----------------------------------------------------
my.lm <- lm(Weight ~ Inches, data = MINI)
summary(my.lm)
confint(my.lm)  # Do not use this until you know your model is appropriate
my.lm2 <- lm(Weight ~ Inches + Sex + Inches:Sex, data = MINI)
summary(my.lm2)

## ----label = "qqP2"------------------------------------------------------
qqPlot(my.lm)
qqPlot(my.lm2)

## ------------------------------------------------------------------------
library(descr)
freq(ordered(MINI$Sex), plot = TRUE, col = c("blue","pink"), main = "Barplot of Gender")

## ----echo = TRUE, results = 'asis'---------------------------------------
library(xtable) # Must be loaded to call xtable
T1 <- xtable(freq(ordered(MINI$Sex), plot = FALSE), 
             caption = "Table 1: Frequency Table of `Sex`")
print(T1, type = "html", caption.placement = "top", html.table.attributes = 1, 
      timestamp = NULL)

## ----echo = TRUE, results = 'asis'---------------------------------------
library(knitr)
kable(freq(ordered(MINI$Sex), plot = FALSE), format = "markdown", 
      digits = 2, padding = 0)

## ----echo = TRUE, results = 'asis'---------------------------------------
library(knitr)
kable(freq(ordered(MINI$Sex), plot = FALSE), format = "html", digits = 2, 
      caption = "Table 2: Frequency Table of `Sex`")

