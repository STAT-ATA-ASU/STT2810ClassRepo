library(ISLR)
?Auto
str(Auto)

library(ggplot2)
ggplot(data = Auto, aes( x = weight, y = horsepower)) +
  geom_point() + 
  geom_smooth(method = lm)

mod <- lm(horsepower ~ weight, data = Auto)
summary(mod)

cor(Auto$weight, Auto$horsepower)
cor.test(Auto$weight, Auto$horsepower)
