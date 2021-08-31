R

b = read.csv("2015-06-12_Bevolking__postcode__2013__edited.csv",sep=";")
b[1:5,]
c = read.csv("2015-06-12_Bevolking__postcode__2012__edited.csv",sep=";")
c[1:5,]


# # # Attempts to make b a key-value list
# # # tmp = b
# # # # c = split(tmp, as.list(tmp$Postcode, tmp$Gemiddelde.huishoudensgrootte))
# # # c = split(tmp, tmp$Postcode, tmp$Gemiddelde.huishoudensgrootte)
# # # # zipcode.list <- as.list(as.data.frame(t(b)))
# # # # zipcode.list <- as.list(b)
example string

inputstring = "3071 SL"
zipcodenumber = substr(inputstring, 1, 4)
zipcodenumber = as.numeric(zipcodenumber)
zipcodenumber

index = which(b$Postcode == zipcodenumber)
huishoudengrootte = b[index,11]
huishoudengrootte 

q('no')