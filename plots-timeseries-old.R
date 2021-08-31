R
library(ggmap)
library(gdata)

# read data
# remove data that you cant use 
data = read.csv(file = "", stringsAsFactors = FALSE)
data$Longitude = as.numeric(data$Longitude)
subset_not_na = !(is.na(data$Longitude) | is.na(data$Latitude))
data = data[subset_not_na,]

# create date-time data, sort data on order
data$Date = as.Date(as.character(data$Date), format = "%d.%m.%Y", origin = "20000101")
data = data[order(data$Date),]

# Extract year month day and weekday
Year = format(data$Date, "%Y")
Month = format(data$Date, "%m")
Day = format(data$Date, "%d")
Weekday = format(data$Date, "%A")
Week = format(data$Date, "%W")
data = cbind(data, Year, Month, Day, Weekday)
attach(data)

sum(Weekday == "maandag")/length(Weekday)
sum(Weekday == "dinsdag")/length(Weekday)
sum(Weekday == "woensdag")/length(Weekday)
sum(Weekday == "donderdag")/length(Weekday)
sum(Weekday == "vrijdag")/length(Weekday)
sum(Weekday == "zaterdag")/length(Weekday)
sum(Weekday == "zondag")/length(Weekday)

Avg_thefts_months = 1:12
Months = c("01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12")
Avg_thefts_months[1] = sum(Month == "01")/length(Month)
Avg_thefts_months[2] = sum(Month == "02")/length(Month)
Avg_thefts_months[3] = sum(Month == "03")/length(Month)
Avg_thefts_months[4] = sum(Month == "04")/length(Month)
Avg_thefts_months[5] = sum(Month == "05")/length(Month)
Avg_thefts_months[6] = sum(Month == "06")/length(Month)
Avg_thefts_months[7] = sum(Month == "07")/length(Month)
Avg_thefts_months[8] = sum(Month == "08")/length(Month)
Avg_thefts_months[9] = sum(Month == "09")/length(Month)
Avg_thefts_months[10] = sum(Month == "10")/length(Month)
Avg_thefts_months[11] = sum(Month == "11")/length(Month)
Avg_thefts_months[12] = sum(Month == "12")/length(Month)
plot(Avg_thefts_months)

Years = 2000:2013

Week_Avg = 1:52
for(i in 1:9){
  tmpweek = print(paste("0", i, sep=""))
  Week_Avg[i] = sum((Week == tmpweek )/length(Week))  
}

for(i in 10:52){
  Week_Avg[i] = sum((Week == i)/length(Week))
}

# pdf("./plots/timeseries/percentage-thefts-per-week.pdf", bg = "transparent")
plot(Week_Avg, xlab = "Week number", ylab = "% thefts", ylim = c(0, 0.025), main = "Percentage of thefts per week")
# # xlim = c(0, 0.025)
# lines(Week_Avg)
abline(h = mean(Week_Avg))
abline(h = mean(Week_Avg) + 2*sd(Week_Avg), lty = 2, col = "red")
abline(h = mean(Week_Avg) - 2*sd(Week_Avg), lty = 2, col = "red")
# dev.off()

counter = 0
TS_Years = 2004:2013
Weekly_data = 1:(length(TS_Years) * 52)
Weekly_data 

for(j in 1:length(TS_Years)){
  counter = 52 * (j - 1)
  print(counter)
  for(i in 1:9){
    tmpweek = paste("0", i, sep="")
    Weekly_data[counter + i] = sum((Week == tmpweek) & (Year == TS_Years[j]))
  }
  for(i in 10:52){
    Weekly_data[counter + i] = sum((Week == i) & (Year == TS_Years[j]))
  }
}

plot(Weekly_data)

plot(diff(Weekly_data))

myts = ts(Weekly_data, frequency = 52)

# install.packages("forecast")
library(forecast)

# fit = arima(myts, c(3,0,3))
# fit = Arima(myts, c(2,0,2))

fit = auto.arima(myts)
summary(fit)
tsdisplay(residuals(fit))
# plot(forecast(fit, h = 104))

# # fit = Arima(myts)
# fit$coef
# acf(fit$residuals)
# 
# plot(myts)
# points(fit$x)





# Create selections on the expertise amounts that you want to filter on
# newdata = cbind(data, Date_create=as.Date(as.character(data$Date), format = "%d.%m.%Y", origin = "20000101"))
# # # Expertise_Amount_sorted = sort(data$Expertise_Amount)
# # # n = length(data$Expertise_Amount)
# # # b = 15
# # # round(n / b)
# # # seqrange = seq(from = min(Expertise_Amount), by = round((max(Expertise_Amount) - min(Expertise_Amount)) / b), to = max(Expertise_Amount))
# # # 
# # # seqquantile = seq(from = 0, by = round(n / b), to = n)
# # # startsequence2 = which(Expertise_Amount_sorted >= 25e3)[1]
# # # seqquantile2 = seq(from = startsequence2, by = round((n - startsequence2) / b), to = n)
# # # 
# # # seqquantile = c(seqquantile, seqquantile2)
# # # seqquantile = c(seqquantile2)
# # # 
# # # amounts_range = seqrange
# # # amounts_quantile = Expertise_Amount_sorted[seqquantile]

# Plotting tools setup
hollandmap = get_map(location='Holland',zoom=7)
plotmap = ggmap(hollandmap)

options(scipen=999) # needed for consistent filenaming


# Plot all the geo-plots
# amounts = sort(c(10^(0:6), 10^(1:7)/2))
amounts = amounts_quantile
N = length(Months)

for(j in 1:length(Years)){
  for(i in 1:N){
    #   setup filename for storage of plot
    fnamepre = "./plots/plot-Year-months-"
    fnamepost = ".jpg"
    fname = paste(fnamepre, Years[j], "-" , Months[i] ,fnamepost, sep = "")
    print(fname)
    
    #   Select which datapoints you will use (expertise > ...) 
  #   subset = (data$Expertise_Amount > amounts[i]) & 
    subset = (data$Year == Years[j]) & (data$Month == Months[i])
    
    #   go plot
    geo_data = data.frame(Latitude = data$Latitude[subset],Longitude = data$Longitude[subset])
    
    #   write plot to jpeg file
    if(sum(subset) > 100) {
      jpeg(fname)
      print(plotmap + geom_point(data = geo_data,aes(x = Longitude,y = Latitude),color="red",size=3,alpha=0.5))
      dev.off()  
    }
  }
}




TS_Years = 2000:2013
Monthly_data = 1:(length(TS_Years) * 12)

for(j in 1:length(TS_Years)){
  counter = 12 * (j - 1)

  for(i in 1:length(Months)){
      Monthly_data[counter + i] = sum((data$Year == TS_Years[j]) & (data$Month == Months[i]))
    }
}

# Monthly_data
myts2 = ts(Monthly_data, frequency = 12, start = c(2000,01), end = c(2013,12))
# pdf("./plots/timeseries/TS-monthly-2000.pdf", bg = "transparent")
plot(myts2, main = "Burglary and theft claims per month", xlab = "Year", ylab = "Number of claims")
# PEAK: 2302
# Afterwards: 1394
# Difference: 908
# dev.off()

# plot(diff(myts2))
# plot(diff(diff(myts2)))


fit2 = auto.arima(myts2)
summary(fit2)
tsdisplay(residuals(fit2))
fore_fit2 = forecast(fit2, h = 24)
plot(fore_fit2)


fit2 = Arima(myts2, seasonal = c(6,2,0))
summary(fit2)
acf(fit2$residuals)

# fit3 = Arima(myts2, order = c(0,1,0), seasonal = c(0,0,1))
fit3 = Arima(myts2, order = c(0,1,0))
summary(fit3)
acf(fit3$residuals)

tsdisplay(diff(myts2,12))
tsdisplay(diff(diff(myts2,12)))

fit4 = Arima(myts2, order = c(0,1,0), seasonal = c(0,1,0))
summary(fit4)
tsdisplay(residuals(fit4))

# Adding a nonseasonal component
fit5 = Arima(myts2, order = c(0,1,0), seasonal = c(0,1,4))
summary(fit5)
tsdisplay(residuals(fit5))



TS_Years = 2004:2013
Monthly_data = 1:(length(TS_Years) * 12)

for(j in 1:length(TS_Years)){
  counter = 12 * (j - 1)

  for(i in 1:length(Months)){
      Monthly_data[counter + i] = sum((data$Year == TS_Years[j]) & (data$Month == Months[i]))
    }
}



myts3 = ts(Monthly_data, frequency = 12, start = c(2004,01), end = c(2013,12))
# pdf("./plots/timeseries/TS-ACF-PACF-monthly-2004.pdf", bg = "transparent")
tsdisplay(myts3, main = "Burglary and theft claims per month", xlab = "Year", ylab = "Number of claims")
# dev.off()
# pdf("./plots/timeseries/TS-ACF-PACF-monthly-2004-diff.pdf", bg = "transparent")
tsdisplay(diff(myts3,12), main = "Diff burglary/theft claims", xlab = "Year", ylab = "Number of claims")
# dev.off()
# pdf("./plots/timeseries/TS-ACF-PACF-monthly-2004-diff-diff.pdf", bg = "transparent")
tsdisplay(diff(diff(myts3,12)), main = "Diff-diff burglary/theft claims", xlab = "Year", ylab = "Number of claims")
# dev.off()


ts_fit6 = Arima(myts3, order = c(0,0,0), seasonal = c(0,0,0))
summary(ts_fit6)
tsdisplay(residuals(ts_fit6))

# ts_fit7 = Arima(myts3, order = c(1,1,1), seasonal = c(1,0,1))
ts_fit7 = Arima(myts3, order = c(1,1,1), seasonal = c(1,0,1))
summary(ts_fit7)
tsdisplay(residuals(ts_fit7))

ts_fit8 = Arima(myts3, order = c(0,1,3), seasonal = c(1,1,3))
summary(ts_fit8)
tsdisplay(residuals(ts_fit8))

ts_fit6 = Arima(myts3, order = c(2,1,2), seasonal = c(1,1,0))
summary(ts_fit6)
tsdisplay(residuals(ts_fit6))

ts_fit9 = Arima(myts3, order = c(3,1,0), seasonal = c(1,1,0))
summary(ts_fit9)
tsdisplay(residuals(ts_fit9))

ts_fit9 = Arima(myts3, order = c(3,1,0), seasonal = c(1,1,0))
summary(ts_fit9)
# Series: myts3 
# ARIMA(3,1,0)(1,1,0)[12]                    
# 
# Coefficients:
#           ar1     ar2      ar3     sar1
#       -0.1410  0.0214  -0.2031  -0.3448
# s.e.   0.0956  0.0975   0.0990   0.0922
# 
# sigma^2 estimated as 12940:  log likelihood=-659.2
# AIC=1328.41   AICc=1329   BIC=1341.77
# 
# Training set error measures:
#                     ME    RMSE      MAE       MPE     MAPE      MASE
# Training set -13.41986 107.415 75.19145 -1.616478 5.779423 0.3467411
#                      ACF1
# Training set -0.009136961
# pdf("./plots/timeseries/TS-ACF-PACF-monthly-2004-ARIMA-310-110.pdf", bg = "transparent")
tsdisplay(residuals(ts_fit9), main = "Burglary/theft claims: ARIMA o=(3,1,0) s=(1,1,0)", xlab = "Year", ylab = "Number of claims")
# dev.off()


library(forecast)
magicfit = auto.arima(myts3)
summary(magicfit)
# Series: myts3 
# ARIMA(0,1,1)(1,1,1)[12]                    
# 
# Coefficients:
#           ma1    sar1     sma1
#       -0.1135  0.1706  -0.6617
# s.e.   0.0976  0.1917   0.1759
# 
# sigma^2 estimated as 12402:  log likelihood=-658.3
# AIC=1324.6   AICc=1324.99   BIC=1335.29
# 
# Training set error measures:
#                     ME     RMSE      MAE       MPE     MAPE     MASE
# Training set -15.55124 105.1596 75.86041 -1.692334 5.763145 0.349826
#                     ACF1
# Training set -0.01961043
tsdisplay(residuals(magicfit))


fore = forecast(magicfit, h = 24)


# jpeg("./forecast-2-years-2.jpeg")
pdf("./plots/timeseries/TS-Forecast-monthly-2004-ARIMA-310-110.pdf", bg = "transparent")
plot(forecast(ts_fit9, h = 24), main = "Forecast on burglary and theft claims, ARIMA (3,1,0) (1,1,0)", xlab = "Year", ylab = "Number of claims")
# plot(as.ts(c(fore$x, fore$mean)))
dev.off()

# jpeg("./forecast-2-years.jpeg")
# pdf("./plots/timeseries/TS-Forecast-monthly-2004-ARIMA-011-111-magic.pdf", bg = "transparent")
plot(forecast(magicfit, h = 24), main = "Forecast on burglary and theft claims, ARIMA (0,1,1) (1,1,1)", xlab = "Year", ylab = "Number of claims")
# dev.off()

# TS_Years = 2000:2013
# Monthly_data = 1:(length(TS_Years) * 12)
# 
# for(j in 1:length(TS_Years)){
#   counter = 12 * (j - 1)
# 
#   for(i in 1:length(Months)){
#       Monthly_data[counter + i] = sum((data$Year == TS_Years[j]) & (data$Month == Months[i]))
#     }
# }
# 
# 
# myts4 = ts(Monthly_data, frequency = 12)
# tsdisplay(myts4)
# tsdisplay(diff(myts4))
# 
# fitss = auto.arima(myts4)
# tsdisplay(residuals(fitss))



































TS_Years = 2005:2013
Monthly_Expertise_data = 1:(length(TS_Years) * 12)

for(j in 1:length(TS_Years)){
  counter = 12 * (j - 1)

  for(i in 1:length(Months)){
      Monthly_Expertise_data[counter + i] = sum(data$Expertise_Amount[(data$Year == TS_Years[j]) & (data$Month == Months[i])])
    }
}

plot(Monthly_Expertise_data)
# dev.off()
myts_exp = ts(Monthly_Expertise_data, frequency = 12)
tsdisplay(myts_exp)
tsdisplay(diff(myts_exp,12))
 
magicfit_exp = auto.arima(myts_exp)
summary(magicfit_exp)
tsdisplay(residuals(magicfit_exp))
plot(forecast(magicfit_exp, h = 24))


# # fit_exp = Arima(myts_exp, order = c(1,0,1), seasonal = c(0,0,0))
# fit_exp = Arima(myts_exp, order = c(0,0,2), seasonal = c(3,1,1))
# fit_exp = Arima(myts_exp, order = c(1,0,2), seasonal = c(0,1,1))
fit_exp = Arima(myts_exp, order = c(2,0,2), seasonal = c(0,1,1))
summary(fit_exp)
tsdisplay(residuals(fit_exp))
plot(forecast(myts_exp, h = 24))

q('no')



