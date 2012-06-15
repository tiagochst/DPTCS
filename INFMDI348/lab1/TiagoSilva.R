#----------------------------------
# INFMDI348 - P4 2012
# Tiago Chedraoui Silva
# tiagochst [at] gmail.com
#---------------------------------

#---------------------------------
# Exercise 1: premiers pas dans R
#---------------------------------

FirstSteps <- function () {
  # Do actions asked by Exercise 1
  help.start()
  demo(graphics)
  setwd('/stud/users/promo13/silva/INFMDI/IntroR')
  install.packages('arules')
  library('arules')
  q()
}

#---------------------------------------
# Exercise 2: Manipulation des données
#---------------------------------------

DataHandling <- function () {

  # 2.1
  mydata <- read.table('http://perso.telecom-paristech.fr/~mahrsi/cours/datamining/data/airquality.dat',header = TRUE)

  # 2.2
  help(airquality)

  # 2.3
  summary(mydata)

  # 2.4
  mean(mydata$Temp)
  median(mydata$Temp)
  sd(mydata$Temp) % ecart type
  quantile(mydata$Temp)
  range(mydata$Temp)

  # 2.6
  mydata[2,]
  mydata[,3]
  mydata[c(1,4,7),]
  mydata[2:5,]
  mydata[, -c(1,2)]
  mydata[mydata$Temp>70,]

  # 2.7
  hist(mydata$Temp,nclass =15)
}

#2.5
EcartType <- function(donnes){
 N <- length(donnes)
 dc <- donnes - mean(donnes)
 return (sqrt(sum(dc^2)/(N-1)))
} 


#---------------------------------------
# Exercise 3: Programmation avec R
#---------------------------------------

# 3.1
FactRec <- function(n) {
  if(n==1)
    return (1)
  return (FactRec(n-1)*n)
}

Fact <- function(n){
  fact = 1
  while(n!=1){
    fact=fact*n
    n = n-1
  }
  return (fact)
}

# 3.2
SumInt <- function(n){
  sum = 0
  for (i in 0:n){
    sum = sum + i
  }
  return (sum)
}


# 3.3
Prime <- function(n){
  # Is n prime?
  
  if(n<2)
    return (FALSE)
  
  div = 0 # number of numbers that divides n
  for(i in 1:sqrt(n)){

    if(n%%i==0) # divisable?
      div = div + 1
    if(div>1)
      return (FALSE)
  }
  return (TRUE)
}

AllPrimes <- function(){
  # Returns all prime numbers between 0 and 100
  m <- matrix(c(1:100), nrow = 1, ncol = 100)
  m <- apply(m,2 ,FUN = Prime)
  return (which(m==TRUE))
}

#---------------------------------------
# Exercise 4: lois de probabilité
#---------------------------------------

# 4.1
RandSample <- function(){

  # Lois de poisson
  sol <- rpois(10,3.2) 
  print('Random Sample Poisson(lambda = 3.2)')
  print(paste('Solution:',sol))

  # Lois binomiale
  sol <- rbinom(10,100,0.5)
  print('Random Sample Normal')
  print(paste('Solution:',sol))

  # Lois normale réduite 
  sol <- rnorm(10)
  print('Random Sample Binomial(100,0.5)')
  print(paste('Solution:',sol))

}

# 4.2
Proba <- function(){

  # Compute P(45 < X < 55) for X Binomial(100,0.5)
  sol <- sum(dbinom(46:54, 100, 0.5)) # 0.6317
  print('Compute P(45 < X < 55) for X Binomial(100,0.5)')
  print(paste('Solution:',sol)) 

  # Computer P(X>4) for Poisson(labmda=3.2)
  sol <- 1 - ppois(4,2.7) # 0.1371
  print('Computer P(X>4) for Poisson(labmda=3.2)')
  print(paste('Solution:',sol))

  # Computer P(X>1.96) for Normal
  sol <- 1- pnorm(1.96) # 0.025
  print('Computer P(X>1.96) for Normal')
  print(paste('Solution:',sol))
}

# 4.3
FindXNorm <- function(){
  qnorm(0.975) #1.96
}
