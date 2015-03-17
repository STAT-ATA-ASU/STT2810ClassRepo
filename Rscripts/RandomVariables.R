### Alan Arnholt
### 3/17/15
N <- 3
stuff <- 1:N
n <- 2
omega <- expand.grid(draw1 = stuff, draw2 = stuff)
omega
xbar <- apply(omega, 1, mean)
xbar
NS <- cbind(omega, xbar)
NS
xtabs(~xbar, data = NS)
library(MASS)
fractions(xtabs(~xbar, data = NS)/(N^n))
Pxbar <- fractions(xtabs(~xbar, data = NS)/(N^n))
Pxbar
MU <- sum(stuff)/N
VAR <- sum((stuff - MU)^2)*1/N
fractions(c(MU, VAR))
MUxbar <- MU
VARxbar <- VAR/n
fractions(c(MUxbar, VARxbar))
# Formula Approach
VARxbar2 <- sum((xbar - MUxbar)^2)*1/(N^n)
fractions(VARxbar2)
# MU
sum(unique(xbar)*Pxbar)
# VAR again
sum((unique(xbar) - MUxbar)^2*Pxbar)

