## Quelques statistiques sur les titres de thèses et les disciplines
setwd("~/R/ThesisStatsProject/Sources/")
fileName <- "data.csv"
data <- read.csv(fileName,sep=";",quote="",skip=1)

# Distribution de la longueur des titres de thèses
data$Length <- nchar(as.character(data$X.Titre.))
hist(data$Length,
     main="Longueur des titres de thèse",
     xlab="Nombre de caractères",
     ylab="Fréquence",
     col="darkmagenta",
     border="white")

# Nombres de thèses par discipline
Count <- table(data$X.Discipline.)
Count <- data.frame(Count)

# Moyenne de caractères par discipline
Mean <- tapply(data$Length,data$X.Discipline., mean, na.rm=T)
Mean <- data.frame(Mean)
Mean <- Mean[order(Mean$Mean),]
Mean <- Mean[1:nrow(Mean)-1]
barplot(tail(Mean,n=15),names.arg=tail(names(Mean),n=15),las=1,horiz=T,border="white",col="darkmagenta",cex.names=0.8,main="Titres les plus longs, en moyenne, 
        par discipline")

# Médianes de caractères par discipline
Median <- tapply(data$Length,data$X.Discipline., median, na.rm=T)
Median <- data.frame(Median)
Median <- Median[order(Median$Median),]
Median <- Median[1:nrow(Median)-1]
barplot(tail(Median,n=5),names.arg=tail(names(Median),n=5),las=1,horiz=T,border="white",col="darkmagenta",cex.names=0.8,main="Médianes des longueurs les plus élevées")

# Variance
Sigma <- tapply(data$Length,data$X.Discipline., sd, na.rm=T)
Sigma <- data.frame(Sigma)
Sigma <- Sigma[order(Sigma$Sigma),]
Sigma <- Sigma[1:nrow(Sigma)-1]
barplot(tail(Sigma,n=15),names.arg=tail(names(Sigma),n=15),las=1,horiz=T,border="white",col="darkmagenta",cex.names=0.8,main="Titres les plus longs, en moyenne, 
        par discipline")

# Plus long titre par discipline
MaxChar <- tapply(data$Length,data$X.Discipline., max, na.rm=T)
MaxChar <- data.frame(MaxChar)
MaxChar <- MaxChar[order(MaxChar$MaxChar),]

# Titre le plus court par discipline
MinChar <- tapply(data$Length,data$X.Discipline., min, na.rm=T)
MinChar <- data.frame(MinChar)
MinChar <- MinChar[order(MinChar$MinChar),]
MinChar <- MinChar[1:nrow(MinChar)-1]

# Titres les plus courts
subset <- data[data$Length<=10,]
subset$X.Titre.[order(subset$Length)]

# Tableau des co-directions
directeur <- data$X..Directeur.de.these..
directeur <- as.character(directeur)
# Les directeurs étant séparés par des virgules, il faut découper la cellule
dir <- strsplit(directeur,",")
maxLen <- max(sapply(dir, length))
dir <- t(sapply(dir, function(x)
  c(x, rep(NA, maxLen - length(x)))
))
dir <- data.frame(dir,stringsAsFactors=F)

# Proportion de thèses codirigées
codir <- dir[!is.na(dir$X2),]
nrow(codir)/nrow(data)*100
