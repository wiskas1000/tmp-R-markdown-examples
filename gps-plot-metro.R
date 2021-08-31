R
library(ggmap)
library(gdata)

data = read.csv2("./gps-locaties-metro.csv")

#plot map of Netherlands
rotterdammap = get_map(location='Rotterdam',zoom=7)
plotmap = ggmap(rotterdammap)

i=1
for (i in seq(1,n)){

  gemeente = numberclaims$Var1[i]
  LL = geocode(paste(gemeente,'Netherlands'))
  geo_data[i,] = data.frame(Latitude = LL[,2],Longitude = LL[,1])
  t = bevolking_gemeente[bevolking_gemeente[,1]==gemeente,4]
  s[i] = numberclaims$Freq[i]/1000
}
plotmap = plotmap+geom_point(data=geo_data,aes(x=Longitude,y=Latitude),color="red",size=s,alpha=0.5)
png('./claims_per_muncipality.png')
plotmap
dev.off()
