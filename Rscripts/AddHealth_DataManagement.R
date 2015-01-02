# Load AddHealth Data
load("P:/QAC/qac201/Studies/AddHealth/Data/AddHealth_pds.RData")

H1GI4 <- as.numeric(as.character(AddHealth$H1GI4))
H1GI6A <- as.numeric(as.character(AddHealth$H1GIA))
H1GI6B <- as.numeric(as.character(AddHealth$H1GI6B))
H1GI6C <- as.numeric(as.character(AddHealth$H1GI6C))
H1GI6D <- as.numeric(as.character(AddHealth$H1GI6D))

NUMETHNIC <- H1GI4 + H1GI6A + H1GI6B + H1GI6C + H1GI6D

ETHNICITY <- rep(NA, 6504)
ETHNICITY[NUMETHNIC >=2] <- 1
ETHNICITY[H1GI4 == 1] <- 2
ETHNICITY[H1GI6A == 1] <- 3
ETHNICITY[H1GI6B == 1] <- 4
ETHNICITY[H1GI6C == 1] <- 5
ETHNICITY[H1GI6D == 1] <- 6
AddHealth$ETHNICITY <- as.factor(ETHNICITY)