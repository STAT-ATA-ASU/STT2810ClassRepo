############  R set-up
options (digits = 2)
library (ggplot2)
#install.packages("MASS")
library (MASS)  # contains the "survey" dataset



############  get the data
data (survey) 
? survey
# RQ: Is a person's height related to their pulse? (PULSE is my DV here)


############  data management


############  descriptive statistics of the two quantitative variables we're using here
summary(survey)
summary(survey$Height)
summary(survey$Pulse)




############  graphs {SOME of the possible ways to plot this data}
# two quantitative variables

ggplot(survey[!is.na(survey$Height) & !is.na(survey$Pulse),],
       aes(x=Height, y=Pulse)) +
  geom_point(shape=16, size = 4, color = "red") +   
  stat_smooth(method="lm", se=FALSE) +
  labs(x = "Height (cm)", y = "Pulse (beats per min)") +
  ggtitle ("Relationship between Pulse and Height") +
  theme_bw()


# cleaning up above because of potential of overlapping points
#  the use of alpha here controls transparency (It is NOT the significance level) 
#  with alpha, darker sections have more points plotted on top of each other
# with a small amount of jitter (random noise), points are near where they actually are
# play around with different values of alpha and jitter for your data
ggplot(survey[!is.na(survey$Height) & !is.na(survey$Pulse),],
       aes(x=jitter(Height, 0), y=jitter(Pulse,0))) +        # turned off jitter by set to 0   
  geom_point(shape=16, size = 2, color = "red", alpha = .3) +   
  #stat_smooth(method="lm", se=FALSE) +
  labs(x = "Height (cm)", y = "Pulse (beats per min)") +
  ggtitle ("Relationship between Pulse and Height") +
  theme_bw()




############  Pearson Correlation
cor.test (survey$Height, survey$Pulse)
        # OUTPUT:
        # Pearson's product-moment correlation
        # 
        # data:  survey$Height and survey$Pulse
        # t = -1.1, df = 169, p-value = 0.275
        # alternative hypothesis: true correlation is not equal to 0
        # 95 percent confidence interval:
        #   -0.231  0.067
        # sample estimates:
        #   cor 
        # -0.084
# Interpretation: Height and pulse were not significantly correlated, r(169) = -.08, p = .28.





####### MODERATION
# by(title_of_dataset, title_of_dataset$ThirdVariable,
#    function(x) cor.test(~ QuantitaitveResponse +
#                           QuantitativeExplanatory, data=x))

# note the different syntax used within the cor.test function

### "by" syntax
by(survey, survey$Sex, function(x)
  cor.test (~ Height + Pulse, data = x))


### subsetting approach
# here would have to handle NAs first, but then it could work
# handle the NAs most easily by making a temporary copy of the dataset using !is.na 
#    on the variables you are analzying with that temporary dataset
