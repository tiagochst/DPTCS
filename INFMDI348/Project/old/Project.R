# Acessing column by name A[,"nome"]
# save.image("RSession.Rda")
# load a saved R session from "RSession.Rda"
# load("RSession.Rda")

#http://www.stat.sc.edu/~hitchcock/chapter6_R_examples.txt
#http://www-users.cs.umn.edu/~kumar/dmbook/ch8.pdf

# Tm pkg should be installed
library("tm")
library("cluster")
library("clusterSim")

# my working directory verify with getwd()
setwd('/home/tiago/Documentos/paristech/DPTCS/INFMDI348/Project')

# Loads data to memory, remove spaces, make all lowercase
corpus <- Corpus(DirSource("./corpus"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, tolower)

# Remove stopwords (less informative, high frequency)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

dtm <- DocumentTermMatrix(corpus,control=list(minWordLength=2, minDocFreq=5))

#dtmTfIdf <-  DocumentTermMatrix(corpus, control = list(weighting = weightTfIdf,                                          minWordLength =  2, minDocFreq = 5))   

A <- as.matrix(dtm)
#A <- as.matrix(dtmTfIdf)

# Times a word appeared in whole docuemnts
# OBS: sum.A = words (row) vs sum (col)
sum.A <- apply(A, 2, FUN = sum)
sum.A <- as.matrix(sum.A)

# Words with low frequence are not important
hist.A <- sum.A[-c(which( sum.A > 1000 | sum.A < 5 )), ]

# Plotting histogram
setEPS()
postscript("Histogram.eps")
barplot(hist.A, xlab="Words",ylab="Frequency")
dev.off()

# Words with low frequence are not important
# OBS: sum.A = docs vs words
clean.A <- A[, -c(which( sum.A > 1000 | sum.A < 5 ))]

# Normalisation
normA <- clean.A%*%t(clean.A)
normA <- sqrt(normA)
normA <- 1/normA
normA <- clean.A*diag(normA) # linha ou coluna?

# Question 3
km <- kmeans(normA, 3, nstart = 10)
km$size
km$tot.withinss

# Question 4
Nbk <- 10

km <- lapply(1:Nbk, function(i) kmeans(normA, i, nstart = 3))

SSE <- rep(NA, Nbk)
WSSE <- rep(NA, Nbk)
BSSE <- rep(NA, Nbk)
SIL <- rep(NA, Nbk)
DB <- rep(NA, Nbk)


for (i in 2:Nbk) {
  DB[i] <- index.DB(normA, km[[i]]$cluster)$DB
}

for (i in 2:Nbk) {
  SIL[i] <- summary(silhouette(km[[i]]$cluster, dist(normA)))$avg.width
}

# Hartigan Calculus
HT <- rep(NA, Nbk)
for (i in 1:Nbk-1) {
  HT[i] <- (((km[[i]]$tot.withinss / km[[i+1]]$tot.withinss)) - 1) * (nrow(normA) - i - 1)
}

# Calinki and Harabasz (1974)
CH <- rep(NA, Nbk)
for (i in 2:Nbk) {
  CH[i] <- (km[[i]]$betweenss / (i - 1) ) / (km[[i]]$tot.withinss / (nrow(normA) - i))
}

# SS
SS <- rep(NA, Nbk)
for (i in 2:Nbk) {
  SS[i] <- (km[[i]]$tot.withinss / km[[i]]$betweenss) * i
}

setEPS()
postscript("SSEerror.eps")
plot(WSSE, type = "o", main = "", ylab = "SSE", xlab = " Number of clusters (K)")
dev.off()

setEPS()
postscript("HT.eps")
plot(HT, type = "o", main = "", ylab = "HT", xlab = " Number of clusters (K)")
dev.off()

setEPS()
postscript("CH.eps")
plot(CH, type = "o", main = "", ylab = "CH", xlab = " Number of clusters (K)")
dev.off()


setEPS()
postscript("DB.eps")
plot(DB, type = "o", main = "", ylab = "DB", xlab = " Number of clusters (K)")
dev.off()

setEPS()
postscript("SIL.eps")
plot(SIL, type = "o", main = "", ylab = "SIL", xlab = " Number of clusters (K)")
dev.off()


# Improving results

#calculate tfidf
wA <- normA
wA[wA>0] <- 1
idf <- log2(nrow(normA)/diag(t(wA)%*%wA))
wA <- normA*idf

# Question 3
km.wA <- kmeans(wA, 5, nstart = 1)
km.wA$size
km.wA$tot.withinss


# Question 5
# Grupo 9: 34 docs (km[[4]]$cluster)[1088:1121]
# Grupo 21: 390 docs (km[[4]]$cluster)[1:390]
# Grupo 51: 370 docs(km[[4]]$cluster)[391:717]
# Grupo 61: 370 docs (km[[4]]$cluster)[718:1087]

#Idea:
# 1 - Para cada cluster eu vejo qual o grupo que mais tem arquivos
# Divido pelo numero de arquivos no cluster

# km cluster Ordem grupos 21 51 61 9 
# km length = 1121

ClusterPurity <- function(cluster,cluster.size){
 Purity <- rep(NA, max(cluster))

 for(i in 1: max(cluster)){
   idx <- which(cluster == i)
   g21 <-  length(which(idx < 391 ))
   g51 <- length(which(idx > 390 & idx < 718 ))
   g61 <- length(which(idx > 717 & idx < 1088))
   g9 <- length(which(idx > 1087 & idx < 1122))
   Purity[i] <- max(g9,g51,g61,g21)/ cluster.size[i]
 }
 return(Purity)
}

ClusterEntropy <- function(cluster,cluster.size){
 Entropy <- rep(NA, max(cluster))

 for(i in 1: max(cluster)){
   idx <- which(cluster == i)
   g21 <-  length(which(idx < 391 ))
   g51 <- length(which(idx > 390 & idx < 718 ))
   g61 <- length(which(idx > 717 & idx < 1088))
   g9 <- length(which(idx > 1087 & idx < 1122))

   p21 <- g21 / cluster.size[i] 
   p51 <- g51 / cluster.size[i] 
   p61 <- g61 / cluster.size[i] 
   p9 <- g9 / cluster.size[i] 

   if( p21 == 0)
     s21 <- 0
   else
     s21 <- p21*log2(p21)
   if( p51 == 0)
     s51 <- 0
   else
     s51 <- p51*log2(p51)
   if( p61 == 0)
     s61 <- 0
   else
     s61 <- p61*log2(p61)
   if( p9 == 0)
     s9 <-  0
   else
     s9 <- p9*log2(p9)

   
   print("Interation")
   print(i)
   print("--------------")
   print(p21)
   print(p51)
   print(p61)
   print(p9)

   Entropy[i] <- sum(s21,s51,s61,s9)
 }
 return(Entropy)
}
