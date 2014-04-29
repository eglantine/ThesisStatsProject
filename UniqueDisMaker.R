# Crée le fichier des pairs directeur-discipline

setwd("~/R/ThesisStatsProject/Sources/")
fileName <- "Données theses.fr crawlées le 2014-04-19.csv"
data <- read.csv(fileName,sep=";",quote="",skip=1)

directeur <- data$X..Directeur.de.these..
directeur <- as.character(directeur)
directeur <- strsplit(directeur,",")
maxLen <- max(sapply(directeur, length))
directeurs <- t(sapply(directeur, function(x)
  c(x, rep(NA, maxLen - length(x)))
))
directeurs <- data.frame(directeurs,stringsAsFactors=F)
directeurs <- data.frame (directeurs, data$X..Discipline..)
directeurs <- directeurs[!is.na(directeurs$X1),]

# Nombre de directeurs par thèse
simpleCountMaker=function(x){
  i <- 1
  j <- 1
  count <- NULL
  progress <- round(nrow(x)/20)
  
  for (i in 1:nrow(x)) {
    if(i%%progress==0){
      print(paste(
        as.character(Sys.time()),
        " : ", 
        round(i/nrow(x)*100,digits=2),
        " %"))
    }
    
    for (j in 2:ncol(x)) {
      if (is.na(x[i,j])) {
        count[i] <- j
        break
      }
    }   
  }
  count <- count-1
  count[is.na(count)] <- ncol(x)
  return(count) 
}
count <- simpleCountMaker(directeurs)
directeurs <- data.frame(directeurs, count)

# Mise à plat : tous les couples possibles directeur/discipline (une ligne = un directeur d'une thèse)
# Compter 40 minutes

twoVarsPairMaker=function(x, y, count){
  i <- 1
  j <- 1
  name <- NULL
  dis <- NULL
  index <- 1
  progress <- round(sum(count)/200)
  
  for (i in 1:nrow(x)) {
    if(i%%progress==0){
      print(paste(
        as.character(Sys.time()),
        " : ", 
        round(i/nrow(x)*100,digits=2),
        " %"))
    }
    
    for (j in 1:count[i]) {
      name[index] <- x[i,j]
      dis[index] <- as.character(y[i])
      index <- index+1
    }
  }
  return(data.frame(name,dis))
}

unique.dirdis <- twoVarsPairMaker(directeurs,directeurs$data.X..Discipline..,count)
unique.dirdis <- unique.dirdis[order(unique.dirdis$name),]
setwd("~/R/ThesisStatsProject/Couples Dir.Dis/")
fileName <- paste0("Couples directeur-discipline - ",Sys.Date(),".csv")
write.table(unique.dirdis,fileName,row.names=F)