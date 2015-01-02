############  R set-up
# options (digits = 2)
library(ggplot2)
#install.packages("MASS")
library (MASS)  # contains the "survey" dataset



############  get the data
data(survey)
?survey
# RQ: Is exercise related to smoking habits? (Exercise is my DV here)


############  data management
# telling R what order the factor levels should be in (for output)
survey$Smoke <- factor(survey$Smoke, 
                       levels = c("Never", "Occas", "Regul", "Heavy"))
survey$Exer <- factor(survey$Exer,
                      levels = c("None", "Some", "Freq"))


############  descriptive statistics of the categorical variables we are using here
summary(survey)

# frequency distribution (with proportions and graphs then tables)
freq(survey$Smoke)
freq(survey$Exer)

table(survey$Smoke)
table(survey$Exer)

table(survey$Smoke, survey$Exer)  #contingency table
# Smoke is my IV and is on the x-axis
    # FYI tip:
    #  if you have three categorical variables:
    #  use ftable as the function name for better formatting
    #  ftable(survey$Smoke, survey$Exer, survey$Sex, survey$Fold)


# conditional percentages: probability of the levels of DV within each level of IV
prop.table(table(survey$Smoke, survey$Exer),1)
# Interpretation: My IV is Smoking. I want to know the distribution of exercise 
#                 within each level of smoking.  So for Smoking = Never, I see that
#                 the different exercise possibilities sum to 100% of the never smoked.
#                 (compare to proportion bar graph)


############  graphs {SOME of the possible ways to plot this data}
# stacked bar chart - COUNTS within each group
ggplot(survey[!is.na(survey$Smoke) & !is.na(survey$Exer),],
       aes(x=Smoke, fill=as.factor(Exer))) +
  geom_bar(stat = "bin", position = "stack") +   
  labs(x = "Smoking", y = "Frequency") +
  ggtitle ("Relationship between Smoking and Exercise") +
  theme_bw()



# stacked bar chart - PROPORTIONS within each group
# ** with groups that have different numbers of observations, 
#  USE PROPORTIONS BUT need to make it clear if some groups 
#  have very different sample sizes than others!
ggplot(survey[!is.na(survey$Smoke) & !is.na(survey$Exer),],
       aes(x=Smoke, fill=as.factor(Exer))) +
  geom_bar(stat = "bin", position = "fill") +   
  labs(x = "Smoking", y = "Frequency") +
  ggtitle ("Relationship between Smoking and Exercise") +
  theme_bw()


# facetted bar graphs (one panel for each level of facetted variable)
ggplot(survey[!is.na(survey$Smoke) & !is.na(survey$Exer),],
       aes(x=Exer)) +
  facet_wrap (~ Smoke) + 
  geom_bar(stat = "bin") +   
  labs(x = "Exercise", y = "Frequency") +
  ggtitle ("Relationship between Smoking and Exercise") +
  theme_bw()





############ Chi-Square Test of Independence

chi.out <- chisq.test(survey$Exer, survey$Smoke)
# Warning: Chi-squared approximation may be incorrect (expected n are too small here)

chi.out
        # OUTPUT:
        # Pearson's Chi-squared test
        # 
        # data:  survey$Exer and survey$Smoke
        # X-squared = 5.5, df = 6, p-value = 0.4828

  # Interpretation: Exercise and smoking are independent of (aka, not related to), 
  #                 CHI_SQUARE_SYMBOL(6) = 5.5, p = .48.


summary(chi.out)
chi.out$observed 
chi.out$expected  # Each cell's expected count = (row total * col total) / total N
chi.out$residuals   # Tells you which cells are significantly different than expected by chance
  # in a 2x2 design, residuals > |1.96| indicate that cell has an observed number of cases that
  #    is significantly different from what would be expected by chance
  # looking at residuals does NOT tell you which levels of the categorical variable are different




##################
##  post hoc Chi-Square Tests
# Bonferroni Adjustment to significance level: divide alpha by number of possible 
#    comparisons (note that it is possible comparisons and not just the number you run)

# IF you had a significant chi-square test, you would follow this up with post hoc tests.
 

# Post Hoc Tests: look at subsets of your data ... 
# to be most interpretable, need to just have two levels to response variable BUT this depends on
#   exactly what you want to say
# e.g., is proportion of frequent vs. not frequent exercisers different for never vs. heavy smokers
# subset to look at one pair of groups for a binary response at a time


#### ***IF AND ONLY IF (i.e., IFF)*** your Chi-Square is significant, 
####    do Post Hoc Tests of pairwise comparisons
# here, you would compare the distribution of exercise for 
#     Never vs. Occas, Never vs. Regul, Never vs. Occassional, Never vs. Heavy,
#     Occas vs. Regul, Occas vs. Heavy, Regul vs. Heavy
#   to control for your Type I Error Rate, apply the Bonferroni correction to your alpha level
#   divide your original alpha by the number of possible pairwise comparisons
#    here, if using alpha = .05, the new significance level to use is .05 / 7 = .007
#    the observed p value for our pairwise comparisons (based on subsetted chi squares) must be < .007
#    to be significant


## examples of some of the above tests:
## note that we subset both variables (so they have the same number of rows), and we
##   apply the logical indexing to the rows.  The column is already given so don't need that added
##   inside the brackets also.

chi.out1 <- chisq.test(survey$Exer[survey$Smoke == "Never" | survey$Smoke == "Occas"], 
                      survey$Smoke[survey$Smoke == "Never" | survey$Smoke == "Occas"])
chi.out1
chi.out1$observed
# Here, you could indicate whether or not exercise patterns were different for never smoked 
#   vs occasional smoked. Note that because there are three levels of the response variable,
#   we still don't know exactly where the difference lies.  Depending on your RQ, you may not need that.


chi.out2 <- chisq.test(survey$Exer[survey$Smoke == "Never" | survey$Smoke == "Heavy"], 
                       survey$Smoke[survey$Smoke == "Never" | survey$Smoke == "Heavy"])
chi.out2
chi.out2$observed



################## MODERATION
# Is the relationship between smoking and exercise (DV) different for different sexes (3rd var)?

##### subsetting approach:


# both of these next lines are equivalent (just two different syntaxes)
chisq.test(survey[survey$Sex == "Male","Exer"], survey[survey$Sex == "Male", "Smoke"])
chisq.test(survey[survey$Sex == "Male",]$Exer, survey[survey$Sex == "Male",]$Smoke)

chisq.test(survey[survey$Sex == "Female",]$Exer, survey[survey$Sex == "Female",]$Smoke)
chisq.test(survey[survey$Sex == "Female","Exer"], survey[survey$Sex == "Female", "Smoke"])

# see if the output is any different for the different levels of the 3rd variable that you subsetted the data on ...


#### "by" approach:
# the "x" stays as it is.  Put in your title_of_dataset and variables
# by(title_of_dataset, title_of_dataset$ThirdVariable, function(x)
#   list(chisq.test(x$CategoricalResponse , x$CategorialExplanatory),
#        chisq.test(x$CategoricalResponse,
#                   x$CategoricalExplanatory)$residuals))         # note addition of $ (error in iBook)

by(survey, survey$Sex, function(x)
  chisq.test(x$Exer, x$Smoke))


# want to run more than 2 functions?
by(survey, survey$Sex, function(x)
  list(
    chisq.test(x$Exer, x$Smoke),
    chisq.test(x$Exer, x$Smoke)$residuals))         #note addition of $ (error in iBook)


