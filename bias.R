install.packages("SimDesign")
library(SimDesign)

actual.temp <- c(68.3, 70, 72.4, 71, 67, 70)
predicted.temp <- c(67.9, 69, 71.5, 70, 67, 69)

bias(actual.temp, predicted.temp)
