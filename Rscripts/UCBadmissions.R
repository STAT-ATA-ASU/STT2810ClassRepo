## UCBAdmissions
## 3/4/15
?UCBAdmissions
library(dplyr)
UCB <- as.data.frame(UCBAdmissions)
UCB <- tbl_df(UCB)
UCB
T1 <- xtabs(Freq ~ Gender, data = UCB)
T1
# Break down of graduate applicants by gender
prop.table(T1)
# Table of Gender by Admit
T2 <- xtabs(Freq ~ Gender + Admit, data = UCB)
T2
# are the events Gender and Admit mathematically independent?
chisq.test(T2)$exp
chisq.test(T2)
prop.table(T2, 1)
# Of all male applicants, 44% admitted. 30 % of female applicants admitted.
# Gender discrimination?
library(vcd)
M1 <- matrix(c(25, 25, 25, 25), nrow = 2, byrow = 2)
M1
mosaic(M1)
mosaic(M1, shade = TRUE)
M2 <- matrix(c(10, 40, 30, 20), nrow = 2, byrow = 2)
M2
E <- chisq.test(M2)$exp
E
(M2 - E)^2/E
chisq.test(M2, correct = FALSE)
mosaic(M2)
mosaic(M2, shade = TRUE)
# Revisit T2
mosaic(T2, shade = TRUE)
# Consider The Department
T3 <- xtabs(Freq ~ Admit + Gender + Dept, data = UCB)
T3
prop.table(T3, c(2, 3))
UCB$Admit <- factor(UCB$Admit, labels = c("Yes", "No"))
mosaic(~ Dept + Gender + Admit, data = UCB, shade = TRUE)
