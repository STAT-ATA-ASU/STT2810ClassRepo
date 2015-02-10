# Alan
# 2/10/15
library(PASWR2)
head(EPIDURAL)
treatment
kg
EPIDURAL$kg[EPIDURAL$kg < 95]
EPIDURAL[1:5, 1:3]
library(dplyr)
epi <- EPIDURAL %>%
  rename(Weight = kg, Height = cm) %>%
  mutate(BMI = Weight/(Height/100)^2) %>%
  filter(BMI <= 30 & (doctor == "Dr. A" | doctor == "Dr. B"))
epi
dim(epi)

