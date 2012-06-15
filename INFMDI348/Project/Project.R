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

dtm <- DocumentTermMatrix(corpus,control = list(minWordLength = 2, minDocFreq = 10))

A <- as.matrix(dtm)

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
# OBS: sum.A = freq.words (col) vs words(row)
clean.A <- A[, -c(which( sum.A > 1000 | sum.A < 5 ))]

# Normalisation
normA <- clean.A%*%t(clean.A)
normA <- sqrt(normA)
normA <- 1/normA
normA <- clean.A*diag(normA) # linha ou coluna?

# Question 3
km <- kmeans(normA, 3, nstart = 10)
print("Result:")
km$size
km$tot.withinss


# Question 4
Nbk <- 10

km <- lapply(1:Nbk, function(i) kmeans(normA, i, nstart = 10))

WSSE <- rep(NA, Nbk)
BSSE <- rep(NA, Nbk)

for (i in 1:Nbk) {
  WSSE[i] <- km[[i]]$tot.withinss
  BSSE[i] <- km[[i]]$betweenss
}


# Sillhouette method
SIL <- rep(NA, Nbk)
for (i in 2:Nbk) {
  SIL[i] <- summary(silhouette(km[[i]]$cluster, dist(normA)))$avg.width
}

# Hartigan Calculus
HT <- rep(NA, Nbk)
for (i in 2:Nbk-1) {
  HT[i] <- ((((km[[i]])$tot.withinss / km[[i+1]]$tot.withinss)) - 1) * (nrow(normA) - i - 1)
}

setEPS()
postscript("SSEerror.eps")
plot(WSSE, type = "o", main = "", ylab = "SSE", xlab = " Number of clusters (K)")
dev.off()

setEPS()
postscript("BETESS.eps")
plot(BSSE, type = "o", main = "", ylab = "", xlab = " Number of clusters (K)",col="red")
par(new=TRUE)
plot(WSSE, type = "o",col="blue", xlab = " Number of clusters (K)")
dev.off()

setEPS()
postscript("HT.eps")
plot(HT, type = "o", main = "", ylab = "HT", xlab = " Number of clusters (K)")
dev.off()

setEPS()
postscript("SIL.eps")
plot(SIL, type = "o", main = "", ylab = "SIL", xlab = " Number of clusters (K)")
dev.off()


# Question 5
# Grup 9: 34 docs (km[[4]]$cluster)[1088:1121]
# Grup 21: 390 docs (km[[4]]$cluster)[1:390]
# Grup 51: 370 docs(km[[4]]$cluster)[391:717]
# Grup 61: 370 docs (km[[4]]$cluster)[718:1087]

#Idea:
# 1 - Para cada cluster eu vejo qual o grupo que mais tem arquivos
# Divido pelo numero de arquivos no cluster

# km cluster Ordem grupos 21 51 61 9 
# km length = 1121

ClusterPurity <- function(cluster, cluster.size){
 Purity <- rep(NA, max(cluster))

 for (i in 1: max(cluster)){
   idx <- which(cluster == i)
   g21 <-  length(which(idx < 391 ))
   g51 <- length(which(idx > 390 & idx < 718 ))
   g61 <- length(which(idx > 717 & idx < 1088))
   g9 <- length(which(idx > 1087 & idx < 1122))
   Purity[i] <- max(g9, g51, g61, g21) / cluster.size[i]
 }
 return(Purity)
}

ClusterEntropy <- function(cluster, cluster.size){
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

   if (p21 == 0)
     s21 <- 0
   else
     s21 <- p21 * log2(p21)
   if (p51 == 0)
     s51 <- 0
   else
     s51 <- p51 * log2(p51)
   if (p61 == 0)
     s61 <- 0
   else
     s61 <- p61 * log2(p61)
   if (p9 == 0)
     s9 <-  0
   else
     s9 <- p9 * log2(p9)

   Entropy[i] <- sum(s21, s51, s61, s9)
 }
 return(Entropy)
}


# Comparing results

# which words are more representative for each cluster?
# sXX Frequency of a word in a cluster

g21 <- clean.A[1:390,]
s21 <- apply(g21, 2, FUN = sum)
s21 <- as.matrix(s21)

g51 <- clean.A[391:717,]
s51 <- apply(g51, 2, FUN = sum)
s51 <- as.matrix(s51)

g61 <- clean.A[718:1087,]
s61 <- apply(g61, 2, FUN = sum)
s61 <- as.matrix(s61)


g9 <- clean.A[1088:1121,]
s9 <- apply(g9, 2, FUN = sum)
s9 <- as.matrix(s9)

NbDoc21 <- g21
NbDoc21[NbDoc21>0] <- 1
NbDoc21 <- apply(NbDoc21, 2, FUN = sum)

NbDoc51 <- g51
NbDoc51[NbDoc51>0] <- 1
NbDoc51 <- apply(NbDoc51, 2, FUN = sum)

NbDoc61 <- g61
NbDoc61[NbDoc61>0] <- 1
NbDoc61 <- apply(NbDoc61, 2, FUN = sum)

NbDoc9 <- g9
NbDoc9[NbDoc9 > 0] <- 1
NbDoc9 <- apply(NbDoc9, 2, FUN = sum)


maxs21 <- 0
maxs51 <- 0
maxs9  <- 0
maxs61 <- 0

for(i in 1:ncol(clean.A)){

  if(s21[i]/sum(s21[i], s51[i], s61[i], s9[i]) > 0.10 ){

    # (Nbdoc * freq)/Nb tot doc
    aux <- s21[i] * (NbDoc21[i])/ nrow(g21)

    if(maxs21 < aux){
      maxs21 <- aux
      mot21 <- rownames(s21)[i]
    }
  }

  if(s51[i]/sum(s21[i], s51[i], s61[i ], s9[i ]) > 0.10){

    # (Nbdoc * freq)/Nb tot doc
    aux <- s51[i] * (NbDoc51[i])/nrow(g51)

    if(maxs51 < aux){
      maxs51 <- aux
      mot51 <- rownames(s21)[i]
    }

  }
  
  if(s61[i]/sum(s21[i], s51[i], s61[i ], s9[i ]) > 0.10){

    # (Nbdoc * freq)/Nb tot doc
    aux <- s61[i] * (NbDoc61[i])/ nrow(g61)

    if(maxs61 < aux){
      maxs61 <- aux
      mot61 <- rownames(s21)[i]
    }

  }
  
  if(s9[i]/sum(s21[i], s51[i], s61[i], s9[i]) > 0.10){

    # (Nbdoc * freq)/Nb tot doc
    aux <- s9[i] * (NbDoc9[i]) / nrow(g9)

    if(maxs9 < aux){
      maxs9 <- aux
      mot9 <- rownames(s21)[i]
    }

  }
}

#idx1 <- matrix(which((clean.A[,mot9]) == max(g9[,mot9]) ))[1,1]
#idx2 <- matrix(which((clean.A[,mot21]) == max(g21[,mot21]) ))[1,1]
#idx3 <- matrix(which((clean.A[,mot51]) == max(g51[,mot51]) ))[1,1]
#idx4 <- matrix(which((clean.A[,mot61]) == max(g61[,mot61]) ))[1,1]

idx1 <- matrix(which(normA[,mot9] == max(normA[,mot9]) ))[1,1]
idx2 <- matrix(which(normA[,mot21] == max(normA[,mot21]) ))[1,1]
idx3 <- matrix(which(normA[,mot51] == max(normA[,mot51]) ))[1,1]
idx4 <- matrix(which(normA[,mot61] == max(normA[,mot61]) ))[1,1]


ptm <- proc.time()
kmfixe <- kmeans(normA, 4, centers = rbind(normA[idx1,],normA[idx2,],normA[idx3,],normA[idx4,]))
timefixe <- ((proc.time()- ptm)[2])

ClusterEntropy(kmfixe$cluster,kmfixe$size )
ClusterPurity(kmfixe$cluster,kmfixe$size )
kmfixe$tot.withinss
kmfixe$size

resultPam <- pam(normA,4)
ClusterEntropy(resultPam$clustering,resultPam$clusinfo[,1] )
ClusterPurity(resultPam$clustering,resultPam$clusinfo[,1] )


ptm <- proc.time()
km.ale <- kmeans(normA, 4, nstart = 1)
timeale <- ((proc.time()- ptm)[2])

ClusterEntropy(km.ale$cluster,km.ale$size )
ClusterPurity(km.ale$cluster,km.ale$size )
timeale
km.ale$tot.withinss
km.ale$size


km.ale2 <- kmeans(normA, 2, nstart = 2)
ClusterEntropy(km.ale2$cluster,km.ale2$size )
ClusterPurity(km.ale2$cluster,km.ale2$size )

km.ale20 <- kmeans(normA, 20, nstart = 2)
ClusterEntropy(km.ale20$cluster,km.ale20$size )
ClusterPurity(km.ale20$cluster,km.ale20$size )

mean(ClusterPurity(km.ale20$cluster,km.ale20$size ))
mean(ClusterPurity(km.ale2$cluster,km.ale2$size ))
mean(ClusterPurity(kmfixe$cluster,kmfixe$size ))

weighted.mean(ClusterEntropy(km.ale20$cluster,km.ale20$size ),km.ale20$size  )
weighted.mean(ClusterEntropy(km.ale2$cluster,km.ale2$size ),km.ale2$size  )
weighted.mean(ClusterEntropy(kmfixe$cluster,kmfixe$size ),kmfixe$size )



weighted.mean(ClusterPurity(km.ale20$cluster,km.ale20$size ),km.ale20$size )
weighted.mean(ClusterPurity(kmfixe$cluster,kmfixe$size ),kmfixe$size )

# Time of execution
# inutile
time <- rep(NA, Nbk)
for (i in 1:Nbk) {
  ptm <- proc.time()
  kmeans(normA, i, nstart = 2)
  time[i] <- ((proc.time()- ptm)[2])
}


dtmTfIdf <-  DocumentTermMatrix(corpus, control = list(weighting =
                                          weightTfIdf,minWordLength =  2,
                                          minDocFreq = 5))

ATfIdf <- as.matrix(dtmTfIdf)
ATfIdf <- ATfIdf[, -c(which( sum.A > 1000 | sum.A < 5 ))]

ptm <- proc.time()
kmTfIdf <- kmeans(ATfIdf, 4, nstart = 5)
#kmTfIdf <- kmeans(ATfIdf, 4, centers = rbind(ATfIdf[idx1,],ATfIdf[idx2,],ATfIdf[idx3,],ATfIdf[idx4,]))
timeale <- ((proc.time()- ptm)[2])

ClusterEntropy(kmTfIdf$cluster,kmTfIdf$size )
ClusterPurity(kmTfIdf$cluster,kmTfIdf$size )
timeale
kmTfIdf$tot.withinss
kmTfIdf$size
