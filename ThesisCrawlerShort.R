# Collecte les données et fournit des statistiques de base

library(RCurl)
setwd("~/R/ThesisStatsProject/Sources/")

## Crawl des données
# Nombre de pages à crawler
homepage <- getURL("http://www.theses.fr/?q=*:*&start=0&status=&access=&prevision=&filtrepersonne=")
split.homepage <- strsplit(homepage,split="\n")
split.homepage<- unlist(split.homepage)
line <- split.homepage[grep("\"sNbRes\"",split.homepage)]
thesis.number <- as.integer(gsub(".+> ([0-9]+).+","\\1",line))

# Crawl
i <- 1:round(thesis.number/1000)+1
i <- i*1000
URL <-paste0("http://www.theses.fr/?q=&fq=dateSoutenance:[1965-01-01T23:59:59Z%2BTO%2B2013-12-31T23:59:59Z]&checkedfacets=&start=",i,"&sort=none&status=&access=&prevision=&filtrepersonne=&zone1=titreRAs&val1=&op1=AND&zone2=auteurs&val2=&op2=AND&zone3=etabSoutenances&val3=&zone4=dateSoutenance&val4a=&val4b=&type=&lng=&checkedfacets=&format=csv")

j <-1
SERP <- 1

file.name <- paste0("Données theses.fr crawlées le ",as.character(Sys.Date()),".csv")

for(j in 1:length(URL)){
  if(j%%15==0){
    print(paste(
      as.character(Sys.time()),
      " : ", 
      round(i/nrow(URL)*100,digits=2),
      " %"))
  }
  SERP[j] <- getURL(URL[j])
  write.csv(SERP,file.name,append=F)
}
data <- read.csv(file.name,sep=";",quote="",skip=1)
