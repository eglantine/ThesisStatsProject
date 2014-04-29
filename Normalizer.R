punctNorm <- function(x) {
  x<- gsub(" - ","\\. ",x)
  x<- gsub(" ?/ ?","\\. ",x)
  x<- gsub("\\.[^ ]","\\. ",x)
  x <- gsub("\\[|\\]","",x)
  x <- gsub("(.*)\\..+","\\1",x)
  x <- gsub("(.*) \\(.+","\\1",x)  
}

commaNorm <- function(x) {
  if (grepl("(.+), (.*)$",x) == TRUE & grepl(" et ",x) == FALSE){
    paste0(gsub("(.+), (.*)$","\\1 et \\2",x))
  } else {
    paste0(x)
  }
}

capNorm <- function(x) {
  s <- strsplit(as.character(x),"\\. ")[[1]]
  paste0(toupper(substring(s, 1, 1)),tolower(substring(s, 2)),
         sep="", collapse=". ")
}

# Création et normalisation d'une table de noeuds
setwd("~/R/ThesisStatsProject/Couples Dir.Dis/")
du <- read.table("Pairs uniques directeurs_disciplines_v2.csv", stringsAsFactors=F,skip=1)
du <- du[duplicated(du$V1),]

du$V2<-as.character(lapply(du$V2,punctNorm))
du$V2<-as.character(lapply(du$V2,commaNorm))
du$V2<-as.character(lapply(du$V2,capNorm))

DisNodes <- table(du$V2)
DisNodes <- data.frame(DisNodes)
names(DisNodes) <- c("Id","Freq")
file.name <- paste0("Disciplines - noeuds - ",Sys.Date(),".csv")
setwd("~/R/ThesisStatsProject/Tables de noeuds/Disciplines/")
write.table(DisNodes,file.name,row.names=F)

# Normalisation d'une table de liens
setwd("~/R/ThesisStatsProject/Table de liens/Disciplines/")
Liens=read.table("Table de liens complète.csv", stringsAsFactors=F)
Liens$Target<-as.character(lapply(Liens$Target,punctNorm))
Liens$Target<-as.character(lapply(Liens$Target,commaNorm))
Liens$Target<-as.character(lapply(Liens$Target,capNorm))

Liens$Source<-as.character(lapply(Liens$Source,punctNorm))
Liens$Source<-as.character(lapply(Liens$Source,commaNorm))
Liens$Source<-as.character(lapply(Liens$Source,capNorm))

setwd("~/R/ThesisStatsProject/Table de liens/Disciplines/")
file.name <- paste0("Table de liens normalisée ",Sys.Date(),".csv")
write.table(Liens,file.name,row.names=F)
