## Read IMF WEOdata 
## Ming-Jer Lee
## mingjerli@gmail.com

rm(list=ls())
library(jsonlite)
download.file(url="http://www.imf.org/external/pubs/ft/weo/2015/01/weodata/WEOApr2015all.xls",destfile = "WEOApr2015all.xls")
WEO = read.delim("WEOApr2015all.xls",header = TRUE, nrows = 8316, stringsAsFactors = FALSE)
WEOdata=WEO

for(i in 1:length(WEOdata)){
  print(i)
  WEOdata[which(grepl("n[:/:]a",WEOdata[,i])),i] = ""
  WEOdata[which(grepl("--",WEOdata[,i])),i] = ""
}
for(i in 10:length(WEOdata)){
  WEOdata[,i] = as.numeric(gsub(",","",WEOdata[,i]))
}

# Some Examples
toJSONsubset = function(df, rows, cols, ...){
  toJSON(df[rows, cols], ...)
}
toJSONsubset(WEOdata, 1:6, 31:40, pretty=TRUE)
toJSONsubset(WEO, 1:6, 31:40, pretty=TRUE)
toJSONsubset(WEOdata, which(WEOdata$WEO.Country.Code=="512"), c(1:5,21:40), pretty=TRUE)
toJSONsubset(WEO, which(WEOdata$WEO.Country.Code=="512"), c(1:5,21:40), pretty=TRUE)
