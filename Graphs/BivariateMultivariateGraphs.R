#### 
library(PDS)
library(dplyr)
DF <- tbl_df(NESARC) %>%
  filter(S3AQ1A ==1 & S3AQ3B1 == 1 & CHECK321 == 1 & AGE <= 25) %>% 
  select(contains("S3AQ8"))
myfix <- function(x){ifelse(x %in% c(2, 9), 0, ifelse(x == 1, 1, NA))}
###
DF2 <- as.data.frame(apply(DF, 2, myfix))
DF2$NumberNicotineSymptoms <- apply(DF2, 1, sum, na.rm = TRUE)
nesarc <- tbl_df(NESARC) %>% 
  filter(S3AQ1A ==1 & S3AQ3B1 == 1 & CHECK321 == 1 & AGE <= 25) %>% 
  rename(Ethnicity = ETHRACE2A, Age = AGE, MajorDepression = MAJORDEPLIFE, 
         Sex = SEX, TobaccoDependence = TAB12MDX, DailyCigsSmoked = S3AQ3C1,
         AlcoholAD = ALCABDEPP12DX) %>% 
  select(Ethnicity, Age, MajorDepression, TobaccoDependence, DailyCigsSmoked, Sex, AlcoholAD)
nesarc <- data.frame(nesarc, NumberNicotineSymptoms = DF2$NumberNicotineSymptoms)
nesarc <- tbl_df(nesarc)
# Code 99 properly
nesarc$DailyCigsSmoked[nesarc$DailyCigsSmoked == 99] <- NA
# Create smoking categories
nesarc$DCScat <- cut(nesarc$DailyCigsSmoked, breaks = c(0, 5, 10, 15, 20, 98), include.lowest = FALSE)
# Label factors
nesarc$Ethnicity <- factor(nesarc$Ethnicity, 
                           labels = c("Caucasian", "African American", 
                                      "Native American", "Asian", "Hispanic"))
nesarc$TobaccoDependence <- factor(nesarc$TobaccoDependence, 
                                   labels = c("No Nicotine Dependence", 
                                              "Nicotine Dependence"))
nesarc$Sex <- factor(nesarc$Sex, labels =c("Female", "Male"))
nesarc$MajorDepression <- factor(nesarc$MajorDepression, 
                                 labels =c("No Depression", "Yes Depression"))
nesarc$AlcoholAD <- factor(nesarc$AlcoholAD, labels = c("No Alcohol", "Alcohol Abuse", "Alcohol Dependence", "Alcohol Abuse and Dependence"))
#
dim(nesarc)

## Graphs
library(ggplot2)
ggplot(data = nesarc, aes(x = MajorDepression, fill = TobaccoDependence)) + 
  geom_bar(position = "fill") +
  theme_bw() + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") + 
  scale_fill_manual(values = c("green", "red"), name = "Tobacco Addiction Status")
### reorder levels
levels(nesarc$TobaccoDependence)
nesarc$TobaccoDependence <- factor(nesarc$TobaccoDependence, 
                                   levels = c("Nicotine Dependence", "No Nicotine Dependence"))
levels(nesarc$TobaccoDependence)
### redo graph
ggplot(data = nesarc, aes(x = MajorDepression, fill = TobaccoDependence)) + 
  geom_bar(position = "fill") +
  theme_bw() + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") + 
  scale_fill_manual(values = c("red", "green"), name = "Tobacco Addiction Status")
### reverse legend 
ggplot(data = nesarc, aes(x = MajorDepression, fill = TobaccoDependence)) + 
  geom_bar(position = "fill") +
  theme_bw() + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") + 
  scale_fill_manual(values = c("red", "green"), name = "Tobacco Addiction Status") + 
  guides(fill = guide_legend(reverse = TRUE))
##### Multivariate Graphs
ggplot(data = nesarc, aes(x = MajorDepression, fill = TobaccoDependence)) + 
  geom_bar(position = "fill") +
  theme_bw() + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") + 
  scale_fill_manual(values = c("red", "green"), name = "Tobacco Addiction Status") + 
  guides(fill = guide_legend(reverse = TRUE)) + 
  facet_grid(Sex ~ .)
##
ggplot(data = nesarc, aes(x = MajorDepression, fill = TobaccoDependence)) + 
  geom_bar(position = "fill") +
  theme_bw() + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") + 
  scale_fill_manual(values = c("red", "green"), name = "Tobacco Addiction Status") + 
  guides(fill = guide_legend(reverse = TRUE)) + 
  facet_grid(Sex ~ Ethnicity)
# x-axis labels are overlapping!
ggplot(data = nesarc, aes(x = MajorDepression, fill = TobaccoDependence)) + 
  geom_bar(position = "fill") +
  theme_bw() + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") + 
  scale_fill_manual(values = c("red", "green"), name = "Tobacco Addiction Status") + 
  guides(fill = guide_legend(reverse = TRUE)) + 
  facet_grid(Sex ~ Ethnicity) + 
  theme(axis.text.x  = element_text(angle = 85, vjust = 0.5)) 
## or
ggplot(data = nesarc, aes(x = MajorDepression, fill = TobaccoDependence)) + 
  geom_bar(position = "fill") +
  theme_bw() + 
  labs(x = "", y = "Fraction", 
       title = "Fraction of young adult daily smokers\nwith and without nicotine addiction\nby depression status") + 
  scale_fill_manual(values = c("red", "green"), name = "Tobacco Addiction Status") + 
  guides(fill = guide_legend(reverse = TRUE)) + 
  facet_grid(Ethnicity ~ Sex) + 
  theme(axis.text.x  = element_text(angle = 85, vjust = 0.5)) 

## Mosiac Plots
library(vcd)
mosaic(~TobaccoDependence + MajorDepression ,data = nesarc, shade = TRUE)
#####
## Boxplots and Violin Plots
ggplot(data = frustration, aes(x = Major, y = Frustration.Score)) +
  geom_boxplot() + 
  theme_bw() + 
  labs(x = "", y = "Frustration Score", title = "Frustration Score by\n Academic Major")
# Violin plots
ggplot(data = frustration, aes(x = Major, y = Frustration.Score)) +
  geom_violin() + 
  theme_bw() +
  labs(x = "", y = "Frustration Score", title = "Frustration Score by\n Academic Major")
#####
bymedian <- with(nesarc, reorder(Ethnicity, NumberNicotineSymptoms, median))
bymedian
#####
## Change legend title from bymedian to Ethnicity
ggplot(data = nesarc, aes(x = bymedian, y = NumberNicotineSymptoms, fill = bymedian)) + 
  geom_boxplot() + 
  theme_bw() + 
  labs(x= "", y = "Number of Nicotine Symptoms", fill = "Ethnicity")
####
## Change legend title from bymedian to Ethnicity
ggplot(data = nesarc, aes(x = bymedian, y = NumberNicotineSymptoms, fill = bymedian)) + 
  geom_violin() + 
  theme_bw() + 
  labs(x= "", y = "Number of Nicotine Symptoms", fill = "Ethnicity")
####  Scatterplot
####
library(PASWR2)
ggplot(data = GRADES, aes(x = sat, y = gpa)) + 
  geom_point(color = "lightblue") + 
  theme_bw() +
  labs(x = "SAT score", y = "First semester college Grade Point Average") +
  geom_smooth(method = "lm")
####
ggplot(data = nesarc, aes(x = DailyCigsSmoked, y = NumberNicotineSymptoms)) + 
  geom_point() + 
  theme_bw() + 
  geom_smooth(method = "lm")
####
ggplot(data = nesarc, aes(x = DailyCigsSmoked, y = NumberNicotineSymptoms)) + 
  geom_point() + 
  theme_bw() + 
  geom_smooth(method = "lm") + 
  facet_grid(Sex ~ Ethnicity)
##
ggplot(data = nesarc, aes(x = DailyCigsSmoked, y = NumberNicotineSymptoms)) + 
  geom_point(color = "lightblue") + 
  theme_bw() + 
  geom_smooth(method = "lm") + 
  facet_wrap(~Ethnicity)
# Versus
ggplot(data = nesarc, aes(x = DailyCigsSmoked, y = NumberNicotineSymptoms)) + 
  geom_point(color = "lightblue") + 
  theme_bw() + 
  geom_smooth(method = "lm") + 
  facet_grid(. ~ Ethnicity) + 
  labs(x = "Estimated Daily Cigarettes Smoked", y = "Number of Nicotine Symptoms")
# Versus
ggplot(data = nesarc, aes(x = DailyCigsSmoked, y = NumberNicotineSymptoms)) + 
  geom_point(color = "lightblue") + 
  theme_bw() + 
  geom_smooth(method = "lm") + 
  facet_grid(Ethnicity ~ .) + 
  labs(x = "Estimated Daily Cigarettes Smoked", y = "Number of Nicotine Symptoms")
#####
## Logistic Regression
library(ISLR)
library(ggplot2)
Default$defaultN <- ifelse(Default$default == "No", 0, 1)
Default$studentN <- ifelse(Default$student =="No", 0, 1)
ggplot(data = Default, aes(x = balance, y = defaultN)) + 
  geom_point(alpha = 0.5) + 
  theme_bw() + 
  stat_smooth(method = "glm", family = "binomial") +
  labs(y = "Probability of Default")
