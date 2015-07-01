## Read IMF WEOdata 
## Ming-Jer Lee
## mingjerli@gmail.com

rm(list=ls())
library(jsonlite)
download.file(url="http://www.imf.org/external/pubs/ft/weo/2015/01/weodata/WEOApr2015all.xls",destfile = "WEOApr2015all.xls")
WEO = read.delim("WEOApr2015all.xls",header = TRUE, nrows = 8316, stringsAsFactors = FALSE)
WEOtidy=WEO

for(i in 1:length(WEOtidy)){
  print(i)
  WEOtidy[which(grepl("n[:/:]a",WEOtidy[,i])),i] = ""
  WEOtidy[which(grepl("--",WEOtidy[,i])),i] = ""
}
for(i in 10:length(WEOtidy)){
  WEOtidy[,i] = as.numeric(gsub(",","",WEOtidy[,i]))
}

# Some Examples for comparison
toJSON(WEOtidy[1:6, 31:40], pretty=TRUE)
toJSON(WEO[1:6, 31:40], pretty=TRUE)
toJSON(WEOtidy[which(WEOtidy$WEO.Country.Code=="512"), c(1:5,21:40)], pretty=TRUE)
toJSON(WEO[which(WEO$WEO.Country.Code=="512"), c(1:5,21:40)], pretty=TRUE)
WEO_json = toJSON(WEO, pretty=TRUE)
WEOtidy_json = toJSON(WEOtidy, pretty=TRUE)
