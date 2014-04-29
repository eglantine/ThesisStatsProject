# Statistiques sur les co-directions de thèses
setwd("~/R/ThesisStatsProject/Sources/")
fileName <- "data.csv"
data <- read.csv(fileName,sep=";",quote="",skip=1)

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

# Proportion de thèses codirigées
codir <- directeurs[!is.na(directeurs$X2),]
codir$data.X..Discipline..<- NULL
nrow(codir)/nrow(data)*100

# Nombre de thèses par nombre de co-directions
n <-1
k <-1
for (k in 1:ncol(codir)) {
  n[k] <- nrow(codir[!is.na(codir[,k]),])
}
n

# Nombre de collaborations (coefficient binomial)
n[2]+n[3]*3+n[4]*6+n[5]*10+n[6]*15+n[7]*21

# Thèses avec le plus grand nombre de directeurs
dirf <- data.frame(directeur, data$X..Titre.., data$X..Discipline..)
dirf[!is.na(dirf$X7),]
