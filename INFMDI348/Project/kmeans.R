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

# Example of empty Clustering

# Point used for the exemple:
# (0,10) (1,10) (11,0) (1.5,0)
# (2,0) (2,-1) (1,0)
data <- array( c(0, 10, 1, 10, 11, 0, 1.5, 0, 2, 0, 2, -1, 1, 0), dim = c(2, 7))

# Chosing 3 initial centers 
# c1 = (0,10)
# c2 = (1,10)
# c3 = (11,0)
centers <- array(dim = c(2, 3))
centers[, 1] <- data[, 1]  
centers[, 2] <- data[, 2] 
centers[, 3] <- data[, 3] 

# What is the initial situation? 
setEPS()
postscript("InitialPoints.eps")
plot(data[1, ],data[2, ],type = "p", pch = 20,
     col = "blue",xlab = 'x', ylab = 'y', cex = 2.6)
points(centers[1, ],centers[2, ],type = "p", pch = 9,col = "purple", cex = 2.6)
dev.off()

# Running Algo
centers <- myKmean(data, centers, 100)

myKmean <- function(x, centers, maxIt){
  count = 0

  while(1) {

    # Definition of groups
    r <- array(dim = c(3, 7))
    for (i in 1:7) {
      r[, i]= findGroup(x[, i],centers)
    }

    # Centers Updating
    oldCenters = centers # For future comparasion

    # Nb of points in each cluster
    pointsInGroup <- array(data = 0, dim = c(3))
    # Sum of values
    sumInGroup <- array(data = 0, dim = c(2, 3))

    # Calculate New center
    for (k in 1:3) {
      for (i in 1:7) {
        pointsInGroup[k] = pointsInGroup[k] + (r[k, i])
        sumInGroup[, k] = sumInGroup[, k] + (r[k, i]) * x[, i]
      }
      if (pointsInGroup[k] > 0) {
        centers[, k] = sumInGroup[, k] / pointsInGroup[k]
      }
    }

    # Ploting results
    #devSVG(paste(count,'Empty.svg'))
    setEPS()
    postscript(paste(count,'Empty.eps'))
    plot(x[1,], x[2,], type = "p", pch = 25,
         col = "white", xlab = "x", ylab = "y", cex = 2.6)
    points(x[1, which(r[1, ] == 1)], x[2, which(r[1, ] == 1)],
           type = "p", pch = 20, col = "blue", cex = 2.6)
    points(x[1, which(r[2, ] == 1)], x[2, which(r[2, ] == 1)],
           type = "p", pch = 20, col = "black", cex = 2.6)
    points(x[1, which(r[3, ] == 1)], x[2, which(r[3, ] == 1)],
           type = "p", pch = 20, col = "red", cex = 2.6)
    points(centers[1, ], centers[2, ],
           type = "p", pch = 9,col = "purple", cex = 2.6)
    box()
    dev.off()

    
    # Centers didn't change: End of Algo
    if( sum( oldCenters - centers) == 0){
      break 
    }
    else if(count > maxIt){
      break
    }
    count <- count + 1
  }
  return (centers)
}

findGroup <- function(p, centers){
  # Search for which group the point is 
  # Input: point 
  # Output: vector r:
  # r = 1 if the point belongs to the group   
  # r = 0 otherwise

  min = Inf
  min_idx = 1

  for (i in 1:3) {
    dist <- euclDist(p, centers[, i])
  
    if(dist < min) {
      min = dist
      min_idx = i
    }
  }
  
  r <- c(seq(0, 0, length = 3))
  r[min_idx] = 1
  return (r)
}

euclDist <- function(p1, p2){
  # Calculate de euclidian distance between two points of dimension n
  # Input: Vectors X and Y of dimension n
  # Output: euclidian distance
  return(sqrt (sum((p1 - p2)^2)))
}

