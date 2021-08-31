R
# library(ggmap)
# library(gdata)

library(forecast)
library(car)

# read data
# remove data that you cant use
data = read.csv(file = "https://raw.githubusercontent.com/AileenNielsen/TimeSeriesAnalysisWithPython/master/data/AirPassengers.csv", header = TRUE, stringsAsFactors = FALSE)

# Get an impression of the data
head(data)
str(data)

# Filter out all NA (inner join like)
subset_not_na = !(is.na(data$Month) | is.na(data$X.Passengers))
if(sum(!subset_not_na) > 0){
    print("Removing NA")
    data = data[subset_not_na,]
}

# Basic plots
passengers = data$X.Passengers

plot(passengers)
hist(passengers)
lines(passengers)

# Timeseries analysis using ARIMA
timeseries = ts(passengers, frequency = 12)
tsdisplay(timeseries)

arimafit1 = auto.arima(timeseries)
summary(arimafit1)
tsdisplay(residuals(arimafit1))
plot(forecast(arimafit1, h = 48))

# Box-Cox transforms
powerTransform(passengers)
tsdisplay(bcPower(passengers, 0.15))
tsdisplay(log(passengers))

timeseries.log = ts(log(passengers), frequency = 12)
tsdisplay(timeseries.log)
arimafit2 = auto.arima(timeseries.log)
summary(arimafit2)
tsdisplay(residuals(arimafit2))
plot(exp(forecast(arimafit2, h = 48)))


# # # # OLD CODE
# data$Longitude = as.numeric(data$Longitude)
# subset_not_na = !(is.na(data$Longitude) | is.na(data$Latitude))
# data = data[subset_not_na,]
x = 1:length(passengers)
testmodel = lm(passengers~x)
plot(passengers)
lines(testmodel$fitted.values)
