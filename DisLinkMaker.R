countMaker = function(x){
  i <- NULL
  count <- NULL
  progress <- round(nrow(x)/100)
  for (i in 1:nrow(x)){
    count[i] <- length(which(x[i,]>0))
    if(i%%progress==0){
      print(paste(
        as.character(Sys.time()),
        " : ", 
        round(i/nrow(x)*100,digits=2),
        " %"))
    }
  }
  return(count)
}

pairsMaker = function(x){
  i <- 1
  j <- 1
  k <- 1
  index <- 1
  first <- NULL
  second <- NULL
  progress <- round(nrow(x)/20)
  for (i in 1:nrow(x)){  
    if(i%%progress==0){
      print(paste(
        as.character(Sys.time()),
        " : ", 
        round(i/nrow(x)*100,digits=2),
        " %"))
    }
    v <- colnames(x[which(x[i,]>0)])
    if (length(v)==2) {
      first[index] <- v[1]
      second[index] <- v[2]
      index <- index+1
    } else {
      lengthmin <- length(v)-1
      for (j in 1:lengthmin) {
        for (k in (j+1):length(v)) {
          first[index] <- v[j]
          second[index] <- v[k]
          index <- index+1
        }
      }
    }
  }
  return(data.frame(first, second))
}

setwd("~/R/ThesisStatsProject/Couples Dir.Dis/")
du <- read.table("Couples directeur-discipline - 2014-04-19.csv", stringsAsFactors=F)
du <- du[duplicated(du$V1),]

# PARTIE 1
du1 <-(du[1:(nrow(du)/2),])
t1 <- table(du1$V1,du1$V2)
discipline.table <- as.data.frame.matrix(t1)
rm(t1)

count <- countMaker(discipline.table)
discipline.table$real.count <- count

discipline.pluri <- discipline.table[discipline.table$real.count>1,]
discipline.pluri$real.count <- NULL

disciplines.liens1 <- pairsMaker(discipline.pluri)

# PARTIE 2
du2 <-(du[(nrow(du)/2):(nrow(du)),])
t2 <- table(du2$V1,du2$V2)
discipline.table <- as.data.frame.matrix(t2)
rm(t2)

count <- countMaker(discipline.table)
discipline.table$real.count <- count

discipline.pluri <- discipline.table[discipline.table$real.count>1,]
discipline.pluri$real.count <- NULL

disciplines.liens2 <- pairsMaker(discipline.pluri)
disciplines.liens <- rbind(disciplines.liens1,disciplines.liens2)
names(disciplines.liens) <- c("Source","Target")
fileName <- paste0("Table de liens - ",Sys.Date(),".csv")
setwd("~/R/ThesisStatsProject/Table de liens/Disciplines/")
write.table(disciplines.liens,fileName)