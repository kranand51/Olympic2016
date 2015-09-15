library(XML)
url="http://stats.espncricinfo.com/ci/engine/stats/index.html?class=1;team=6;template=results;type=batting"
#Note I can also break the url string and use paste command to modify this url with parameters
tables=readHTMLTable(url)
tables$"Overall figures"

#Now see this- since I only got 50 results in each page, I look at the url of next page

table1=tables$"Overall figures"
url="http://stats.espncricinfo.com/ci/engine/stats/index.html?class=1;page=2;team=6;template=results;type=batting"
tables=readHTMLTable(url)
table2=tables$"Overall figures"

#Now I need to join these two tables vertically

table3=rbind(table1,table2)
