# Back in Class!
library(MASS)
?Cars93
str(Cars93)
# quantitative first
hist(Cars93$Price)
hist(Cars93$Price, xlab = "Price in thousands of Dollars", main = "You Put Something Here", col = "red")
plot(density(Cars93$Price), main = "You put something here")
#  ggplot2
library(ggplot2)
ggplot(data = Cars93, aes(x = Price)) + 
  geom_histogram()
#
ggplot(data = Cars93, aes(x = Price)) + 
  geom_histogram(fill = "pink", binwidth = 3)
#
ggplot(data = Cars93, aes(x = Price)) + 
  geom_density()
ggplot(data = Cars93, aes(x = Price)) + 
  geom_density(fill = "pink") + 
  labs(x = "Price in thousands of dollars", title = "You put something here") +
  theme_bw()
# shape 
# center
md <- median(Cars93$Price)
# spread
iqr <- IQR(Cars93$Price)
c(md, iqr)
qs <- quantile(Cars93$Price)
qs
qs[4]
qs[2]
qs[4] - qs[2]
# categorical next
T1 <- xtabs(~Origin, data = Cars93)
T1
T2 <- prop.table(T1)
T2
barplot(T2)
T3 <- xtabs(~Origin + AirBags, data = Cars93)
T3
T4 <- prop.table(T3, 2)
T4
barplot(T4)
# ggplot2 approach
ggplot(data = Cars93, aes(x = Origin)) + geom_bar()
# bivariate categorical
ggplot(data = Cars93, aes(x = Origin, fill = AirBags)) + 
  geom_bar(position = "fill")
# multivariate categorical
ggplot(data = Cars93, aes(x = Origin, fill = AirBags)) + 
  geom_bar(position = "fill") + 
  facet_grid(.~ DriveTrain)
# bivariate quantitative
ggplot(data = Cars93, aes(x = Weight, y = Horsepower)) + 
  geom_point() 
# multivariate quantitative
ggplot(data = Cars93, aes(x = Weight, y = Horsepower, color = DriveTrain)) + 
  geom_point() +
  stat_smooth() +
  facet_grid(.~AirBags) +
  theme_bw()
