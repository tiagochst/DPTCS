# -%-%-%-%-%-%-%-%-%-%-%-%-%-%-%
# INFMDI 348  
# Project on Data Mining
# Date:22/06/2012 
# Paris,France  
# Group: 
# - Anthony CLERBOUT
# - Livia RIBEIRO 
# - Tiago CHEDRAOUI SILVA 
# -%-%-%-%-%-%-%-%-%-%-%-%-%-%-%

library("tm")
library("cluster")
library("clusterSim")

# Loads data to memory, remove spaces, make all lowercase
corpus <- Corpus(DirSource("./corpus"))
corpus <- tm_map(corpus, stripWhitespace)
corpus <- tm_map(corpus, tolower)

# Remove stopwords (less informative, high frequency)
corpus <- tm_map(corpus, removeWords, stopwords("english"))

dtm <- DocumentTermMatrix(corpus,control = list(minWordLength = 2, minDocFreq = 5))

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
km <- kmeans(normA, 3, nstart = 1)
print("Result: (n=1)")
km$size
km$tot.withinss

km <- kmeans(normA, 3, nstart = 10)
print("Result:")
km$size
km$tot.withinss


# Question 4

# Apply kmeans for different number of k (Nbk)
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

ClusterPurity <- function(cluster, cluster.size){
# Input: 
#  Cluster: Vector with the number of the cluster a sample belongs
#  Cluster.size: number of samples in each cluster
# OutPut: vector of purity of each cluster

 Purity <- rep(NA, max(cluster))

 for (i in 1: max(cluster)){

   idx <- which(cluster == i) # which samples belong to cluster i
   g21 <-  length(which(idx < 391 )) # which g21 points belongs to cluster i
   g51 <- length(which(idx > 390 & idx < 718 )) # same for g51 
   g61 <- length(which(idx > 717 & idx < 1088)) # same for g61 
   g9 <- length(which(idx > 1087 & idx < 1122)) # same for g9

   Purity[i] <- max(g9, g51, g61, g21) / cluster.size[i]
 }
 return(Purity)
}

ClusterEntropy <- function(cluster, cluster.size){
# Input: 
#  Cluster: Vector with the number of the cluster a sample belongs
#  Cluster.size: number of samples in each cluster
# OutPut: vector of purity of each cluster

 Entropy <- rep(NA, max(cluster))

 for(i in 1: max(cluster)){

   idx <- which(cluster == i) # which samples belong to cluster i
   g21 <-  length(which(idx < 391 )) # which g21 points belongs to cluster i
   g51 <- length(which(idx > 390 & idx < 718 )) # same for g51 
   g61 <- length(which(idx > 717 & idx < 1088)) # same for g61 
   g9 <- length(which(idx > 1087 & idx < 1122)) # same for g9 

   # probability of belonging to cluster i
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

   Entropy[i] <- sum(s21, s51, s61, s9)*(-1)
 }
 return(Entropy)
}


# Comparing results

# which words are more representative for each cluster?
# sXX Frequency of a word in a cluster

# Documents of group 21
g21 <- clean.A[1:390,]

# Frequency of words in Documents of group 21
s21 <- apply(g21, 2, FUN = sum)
s21 <- as.matrix(s21)

# Number of documents with a given word
NbDoc21 <- g21
NbDoc21[NbDoc21>0] <- 1
NbDoc21 <- apply(NbDoc21, 2, FUN = sum)

# Documents of group 51
g51 <- clean.A[391:717,]

# Frequency of words in Documents of group 51
s51 <- apply(g51, 2, FUN = sum)
s51 <- as.matrix(s51)

# Number of documents with a given word
NbDoc51 <- g51
NbDoc51[NbDoc51>0] <- 1
NbDoc51 <- apply(NbDoc51, 2, FUN = sum)

# Documents of group 61
g61 <- clean.A[718:1087,]

# Frequency of words in Documents of group 61
s61 <- apply(g61, 2, FUN = sum)
s61 <- as.matrix(s61)

# Number of documents with a given word
NbDoc61 <- g61
NbDoc61[NbDoc61>0] <- 1
NbDoc61 <- apply(NbDoc61, 2, FUN = sum)

# Documents of group 9
g9 <- clean.A[1088:1121,]

# Frequency of words in Documents of group 9
s9 <- apply(g9, 2, FUN = sum)
s9 <- as.matrix(s9)

# Number of documents with a given word
NbDoc9 <- g9
NbDoc9[NbDoc9 > 0] <- 1
NbDoc9 <- apply(NbDoc9, 2, FUN = sum)


# auxiliare for compairison
maxs21 <- 0
maxs51 <- 0
maxs9  <- 0
maxs61 <- 0

# vector with idx of representative words 
res21 <- NULL
res51 <- NULL
res61 <- NULL
res9 <- NULL

for(i in 1:ncol(clean.A)){

  # Does i word significantly represents cluster 21?  	
  if(s21[i]/sum(s21[i], s51[i], s61[i], s9[i]) > 0.70 ){

    res21 <- c(res21, i) # save word

    # Does i word appears in a great part of documents inside the cluster
    # and has a high frequency?	 
    #(Nb docs has the word * freq in cluster)/Nb of docs in the cluster
    aux <- s21[i] * (NbDoc21[i])/ nrow(g21)

    if(maxs21 < aux){
      maxs21 <- aux
      mot21 <- rownames(s21)[i]
    }
  }

  # Does i word significantly represents cluster 51?  	
  if(s51[i]/sum(s21[i], s51[i], s61[i ], s9[i ]) > 0.70){

    res51 <- c(res51, i)
    # (Nbdoc * freq)/Nb tot doc
    aux <- s51[i] * (NbDoc51[i])/nrow(g51)

    if(maxs51 < aux){
      maxs51 <- aux
      mot51 <- rownames(s21)[i]
    }

  }
  
  # Does i word significantly represents cluster 61?  	
  if(s61[i]/sum(s21[i], s51[i], s61[i ], s9[i ]) > 0.70){

    res61 <- c(res61, i)

    # (Nbdoc * freq)/Nb tot doc
    aux <- s61[i] * (NbDoc61[i])/ nrow(g61)

    if(maxs61 < aux){
      maxs61 <- aux
      mot61 <- rownames(s21)[i]
    }

  }
  
  # Does i word significantly represents cluster 9?  	
  if(s9[i]/sum(s21[i], s51[i], s61[i], s9[i]) > 0.70){

    res9 <- c(res9, i)

    # (Nbdoc * freq)/Nb tot doc
    aux <- s9[i] * (NbDoc9[i]) / nrow(g9)

    if(maxs9 < aux){
      maxs9 <- aux
      mot9 <- rownames(s21)[i]
    }

  }
}

# Which is the document with the highest value for the more representative word
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

# And if we consider all representative words?
# Which doc has more representative words
sum.normA <- as.matrix(apply(normA[,res9],1, FUN = sum))
idx11 <- matrix(which(sum.normA == max(sum.normA) ))[1,1]

sum.normA <- as.matrix(apply(normA[,res21],1, FUN = sum))
idx22 <- matrix(which(sum.normA == max(sum.normA) ))[1,1]

sum.normA <- as.matrix(apply(normA[,res51],1, FUN = sum))
idx33 <- matrix(which(sum.normA == max(sum.normA) ))[1,1]

sum.normA <- as.matrix(apply(normA[,res61],1, FUN = sum))
idx44 <- matrix(which(sum.normA == max(sum.normA) ))[1,1]

ptm <- proc.time()
kmfixe <- kmeans(normA, 4, centers = rbind(normA[idx11,],normA[idx22,],normA[idx33,],normA[idx44,]))
timefixe <- ((proc.time()- ptm)[2])

ClusterEntropy(kmfixe$cluster,kmfixe$size )
ClusterPurity(kmfixe$cluster,kmfixe$size )
kmfixe$tot.withinss
kmfixe$size

# Kmeans analyses 
kmeansAnal <- function(matrix, ntimes, cluster.nb){

  ptm <- proc.time()
  km.ale <- kmeans(normA, cluster.nb, nstart = ntimes)
  timeale <- ((proc.time()- ptm)[2])

  print("Entropy")
  print("------------------------------------")
  print(ClusterEntropy(km.ale$cluster,km.ale$size ))
  print("Purity")
  print("------------------------------------")
  print(ClusterPurity(km.ale$cluster,km.ale$size ))
  print("Time")
  print("------------------------------------")
  print(timeale)
  print("SSE")
  print("------------------------------------")
  print(km.ale$tot.withinss)
  print("Size clusters")
  print("------------------------------------")
  print(km.ale$size)
  return (km.ale)
}

km <- kmeansAnal(normA,1,4)
km <- kmeansAnal(normA,2,4)
km <- kmeansAnal(normA,5,4)
km <- kmeansAnal(normA,10,4)
km <- kmeansAnal(normA,20,4)

km5 <- kmeansAnal(normA,10,5)
km3 <- kmeansAnal(normA,10,6)


tfidf <- function(matrix){
# Calculate tf-idf
# inverse document frequency factor is incorporated which
# diminishes the weight of terms that occur very frequently
# in the collection and increases the weight of terms that occur rarely.
# Input: matrix with frequencies (docs vs words)

  # times of documents with a word
  ndoc <- apply(matrix > 0, 2, FUN = sum)
  idf <- log(nrow(matrix)/as.matrix(ndoc))
  return (matrix * c(idf))
}

tfnormA <- tfidf(normA)
kmeansAnal(tfnormA,10,4)
