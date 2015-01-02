############  R set-up
# options (digits = 2)
library(ggplot2)


############  get the data
# data(InsectSprays)  # R has built in datasets that are good for examples
?InsectSprays
# RQ: Does the type of insect spray used affect the count of insects?


############  descriptive statistics
summary(InsectSprays)
tapply (InsectSprays$count, InsectSprays$spray, mean)
tapply (InsectSprays$count, InsectSprays$spray, sd)
tapply (InsectSprays$count, InsectSprays$spray, length)



############  graphs
# boxplot (showing variation in values) and mean
# categorical IV with quantitative DV
ggplot(InsectSprays[!is.na(InsectSprays$spray) & !is.na(InsectSprays$count),], 
        aes(x = spray, y = count)) + 
  geom_boxplot() +
  stat_summary(fun.y=mean, colour="darkred", geom="point", 
               shape=18, size=4) + 
  labs(x = "Spray", y = "Average # of Insects") +
  ggtitle ("Insect Counts with Different Sprays") + 
  theme_bw()



# bargraph of means  NEW: ADDED +/- 1 standard deviation ERROR BARS
# categorical IV with quantitative DV
ggplot(InsectSprays[!is.na(InsectSprays$spray) & !is.na(InsectSprays$count),]
        , aes(x = spray, y = count)) + 
  stat_summary(fun.y="mean", geom="bar", fill = "lightblue") +
  stat_summary(fun.y = mean,
               fun.ymin = function(x) mean(x) - sd(x), 
               fun.ymax = function(x) mean(x) + sd(x), 
               geom = "pointrange",
               color = "blue") +
  labs(x = "Spray", y = "Average # of Insects (+/- 1 SD)") +
  ggtitle ("Insect Counts with Different Sprays") + 
  theme_bw()





############ one-way ANOVA
# unless you have sample sizes that are very small and have other violations, 
#  fairly robust against violations of normality

# first, check homogeneity of variance assumption
   # null hypothesis here is variances are all equal
   # WANT TO RETAIN THE NULL HYPOTHESIS!!! ... good to go if NOT SIGNIFICANT

bartlett.test(count ~ spray, data=InsectSprays)  
        # OUTPUT:
        # Bartlett test of homogeneity of variances
        # 
        # data:  count by spray
        # Bartlett's K-squared = 26, df = 5, p-value = 9.085e-05

  # Interpretation: VIOLATED homogeneity of variance assumption.
  # aov function may not be the best option for an ANOVA (other functions exist)
# HERE THOUGH, I've chosen to proceed DESPITE having violated the assumption!
#   ... that is NOT how you should proceed with your analyses




aov.out <- aov(count ~ spray, data=InsectSprays)
summary(aov.out)

        # OUTPUT:
        #               Df Sum Sq Mean Sq F value Pr(>F)    
        #   spray        5   2669     534    34.7 <2e-16 ***
        #   Residuals   66   1015      15                   
        # ---
        #   Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
  # Interpretation: There are significant differences among the different samples,
  #                 field units, F(5,66) = 34.7, p < .001.




TukeyHSD (aov.out)  # find out which groups are different from each other
        # OUTPUT:        
        # Tukey multiple comparisons of means
        # 95% family-wise confidence level
        # 
        # Fit: aov(formula = count ~ spray, data = InsectSprays)
        # 
        # $spray
        #       diff   lwr  upr p adj
        # B-A   0.83  -3.9  5.5  1.00
        # C-A -12.42 -17.1 -7.7  0.00
        # D-A  -9.58 -14.3 -4.9  0.00
        # E-A -11.00 -15.7 -6.3  0.00
        # F-A   2.17  -2.5  6.9  0.75
        # C-B -13.25 -17.9 -8.6  0.00
        # D-B -10.42 -15.1 -5.7  0.00
        # E-B -11.83 -16.5 -7.1  0.00
        # F-B   1.33  -3.4  6.0  0.96
        # D-C   2.83  -1.9  7.5  0.49
        # E-C   1.42  -3.3  6.1  0.95
        # F-C  14.58   9.9 19.3  0.00
        # E-D  -1.42  -6.1  3.3  0.95
        # F-D  11.75   7.1 16.4  0.00
        # F-E  13.17   8.5 17.9  0.00
    # Interpretation: The count of insects in Groups A, B, and F were each significantly different 
    #                 from that of Groups C, D, and E (Tukey's HSD, p < .001), but Groups A, B, and 
    #                 F did not differ from one another (p > .05).  {This would be accompanied by 
    #                 a graph or table showing means and SD. With only a few groups, those numbers
    #                 could be reported in the text.}
    # the reported p values are already adjusted to control for multiple comparisons




###### Interactions and Moderation
# first, add a third variable

InsectSprays$thirdVar <- sample(1:2,72, replace = TRUE)
     # puts in a randomly selected whole number in range 1-2, 72 times
InsectSprays$thirdVar <- factor(InsectSprays$thirdVar, levels = c(1,2), labels = c("Group A", "Group B"))
summary(InsectSprays)
# YOUR ACTUAL VALUES WILL DIFFER BECAUSE IT IS A RANDOM SAMPLE!!

##### subsetting approach:
aovA.out <- aov(count ~ spray, data=InsectSprays[InsectSprays$thirdVar == "Group A",])
aovB.out <- aov(count ~ spray, data=InsectSprays[InsectSprays$thirdVar == "Group B",])

summary(aovA.out)
summary(aovB.out)
# look at means to see if the direction of the effects (and strength) is the same (same = no moderation) to interpret
# same or different significant levels




##### 'by' approach:
# by(title_of_dataset, title_of_dataset$ThirdVariable, function(x)
#   list(aov(QuantitativeResponse ~ CategoricalExplanatory, data=x),
#        summary(aov(Quantitative Response~ CategoricalExplanatory,
#                    data=x))))

by(InsectSprays, InsectSprays$thirdVar, function(x)
  summary(aov(count ~ spray, data = x)))

# here I ask it for the ANOVA table and TukeyHSD posthoc tests for each level of gender
by(InsectSprays, InsectSprays$thirdVar, function(x)
  list(summary(aov(count ~ spray, data = x)),
       TukeyHSD(aov(count ~ spray, data = x))))




# statistically correct approach of interaction (for those of you who already know this concept)
# This lets us answer more questions about the relationships among these three variables.
# ***we will get to this later in the course***
aovInt.out <- aov(count ~ spray * thirdVar, data=InsectSprays)
summary(aovInt.out)

# spray:thirdVar is the interaction effect ... if this is significant, then
#   do follow-up tests (one-way ANOVA simple effects analyses (control alpha) and/or pairwise comparisons (control alpha))
# you know if spray has a significant main effect or not.  
# you also find out if there is a significant main effect of thirdVar (that is, does thirdVar have an effect independent of spray)



