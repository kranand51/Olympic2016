# file <- "~/Documents/R/medals.html"
# page <- readChar(file,file.info(file)$size)

library(RCurl) 
theurl <- "http://www.london2012.com/medals/medal-count/"
page <- getURLContent(theurl, useragent="Mozilla/5.0 (Windows NT 6.1; rv:15.0) Gecko/20120716 Firefox/15.0a2")


# Remove html tags:
page <- gsub("<(.|\n)*?>","",page)
# Remove newlines and tabs:
page <- gsub("\\n","",page)

# match table:
page <- regmatches(page,regexpr("(?<=Total).*(?=Detailed)",page,perl=TRUE))

# Extract country+medals+rank
codes <-regmatches(page,gregexpr("\\d+[^\\r]*\\d+",page,perl=TRUE))[[1]]
codes <- codes[seq(1,length(codes)-2,by=2)]

# Extract country and medals:
Names <- gsub("\\d","",codes)
Medals <- sapply(regmatches(codes,gregexpr("\\d",codes)),function(x)x[(length(x)-2):length(x)])

# Create data frame:
data.frame(
  Country = Names,
  Gold = as.numeric(Medals[1,]),
  Silver = as.numeric(Medals[2,]),
  Bronze = as.numeric(Medals[3,]))
