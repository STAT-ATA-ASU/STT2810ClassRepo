# Alan Arnholt
# 11/03/15
# Auto from ISLR
library(ISLR)
?Auto
str(Auto)
library(ggplot2)
ggplot(data = Auto, aes(x = factor(cylinders), y = mpg)) +
  geom_boxplot()
ggplot(data = Auto, aes(x = horsepower, y = weight)) + 
  geom_point()
ggplot(data = Auto, aes(x = horsepower, y = displacement)) + 
  geom_point()
ggplot(data = Auto, aes(x = displacement, y = acceleration, color = factor(origin))) + 
  geom_point() + geom_smooth(method = lm)
