setwd("~/R/ThesisStatsProject/Sources/")
fileName <- "Données theses.fr crawlées le 2014-04-19.csv"
data <- read.csv(fileName,sep=";",quote="",skip=1)

## CO-DIRECTIONS
# Tableau des co-directions
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

codir <- directeurs[!is.na(directeurs$X2),]
codir$data.X..Discipline..<- NULL

# Nombre de co-directeurs

NAcountMaker= function(x){
  i <- 1
  j <- 1
  count <- NULL
  for (i in 1:nrow(x)) {
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

count <- NAcountMaker(codir)

# Génération des liens (couples de co-directeurs)
# Compter 1 minute
NApairMaker = function(x,count){
  i <- 1
  j <- 1
  k <- 1
  index <- 1
  first <- NULL
  second <- NULL
  progress <- round(nrow(x)/10)
  for (i in 1:nrow(x)) {
    if(i%%progress==0){
      print(paste(
        as.character(Sys.time()),
        " : ", 
        round(i/nrow(x)*100,digits=2),
        " %"))
    }
    
    if (count[i]==2) {
      first[index] <- x[i,1]
      second[index] <- x[i,2]
      index <- index+1
    } else {
      for (j in 1:(count-1)[i]) {
        for (k in (j+1):count[i]) {
          first[index] <- x[i,j]
          second[index] <- x[i,k]
          index <- index+1
        }
      }
    }
  }  
  data.frame(first, second)
}

pairs <- NApairMaker(codir,count)
setwd("~/R/ThesisStatsProject/Table de liens/Directeurs/")
pairs.file.name <- paste0("Paires de directeurs le ",Sys.Date(),".csv")
write.table(pairs,pairs.file.name,row.names=F)