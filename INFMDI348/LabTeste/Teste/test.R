# Using R in Emacs
# http://stats.blogoverflow.com/2011/08/using-emacs-to-work-with-r/
# M-x R
# Esc-p Previous Command (at command line)
# Esc-n Next Command (at command line)
# C-c C-v Get help on R/S object (enter name in
# C-c C-d Dump object or function to a Emacs buffer for editing
# C-c C-l Load file from buffer into R
# C-c C-f submit a Function in current buffer to R
# C-c C-j submit the current line in buffer to R
# C-c C-r submit the highlignted or marked region to R
# C-c TAB complete object/file name
# C-h m for help on ESS mode

library(maptools)
library(ggplot2)
library(RColorBrewer)
library(maps)

print('OI');

helloword <- function(){
  print('OI2');
}

myplot <- function (){
  N <- 10^2
  x1 <- rnorm(N) 
  x2 <- 1 + x1 + rnorm(N)
  plot(0) 
  plot(0,1) 
  plot(x1) 
                                        #  plot(x1,x2) # scatter plot x1 on the horizontal axis and x2 on the vertical axis
  plot(x2 ~ x1) # the same but using a formula (x2 as a function of x1)
  methods(plot) # show all the available methods for plot (depending on the
                                        # number of loaded packages).
  dev.off()
}

myplotsave4x4 <- function(){
  rnorm(50) 
  png("plottype.png")
  par(mfrow = c(2,2))
  plot(x1, type = "p", main = "points", ylab = "", xlab = "")
  plot(x1, type = "l", main = "lines", ylab = "", xlab = "")
  plot(x1, type = "b", main = "both", ylab = "", xlab = "")
  plot(x1, type = "o", main = "both overplot", ylab = "", xlab = "")
  dev.off()
}

                                        # Style http://google-styleguide.googlecode.com/svn/trunk/google-r-style.html
                                        # variables avg.clicks
                                        # fc CalculateAvgCLicks
                                        # kConstantName
                                        # indent 2 spaces
                                        # Do not place a space before a comma, but always place one after a comma. 
                                        # tabPrior <- table(df[df$daysFromOpt < 0, "campaignid"])

myplotlotlines <- function(){
  png("plotlines.png")
  x <- seq(0, 30, length=300)
  hx <- dgamma(x, shape=1, scale=1)

  gshape <- c(2, 5, 10, 15)
  colors <- c("red", "blue", "darkgreen", "gold")

  plot(x, hx, type="n", lty=2, lwd=2, xlab="x", ylab=expression(f(x)),
       main=expression(theta == 1), ylim=c(0,0.4), frame.plot=F)

  for (i in 1:4){
    lines(x, dgamma(x,shape=gshape[i], scale=1), lwd=2, col=colors[i])
  }

                                        # Inserting mathematical expressions

  text(3.5,.35 , expression(paste(alpha==2)))
  text(6.5,.18 , expression(paste(alpha==5)))
  text(11.5,.13 , expression(paste(alpha==10)))
  text(23,.05 , expression(paste(alpha==15)))
  dev.off()
}

myplotbar <- function(){
#  Generating Poisson random numbers with rates 1, 2, 3, and 4
#  and drawing the histograms and arranging them on a 2 x 2 matrix

  par(mfrow=c(2,2))
  lambda <- 1:4
  x <- 0:10
  
  for (i in lambda)
    {
      x1 <- dpois(x, lambda[i])
      barplot(x1, names.arg=c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10"), ylab=expression(P(x)), ylim=c(0,.4), col="lightgreen")
      title(main = substitute(lambda == i,list(i=i)))
    }
}

myplotbuble <- function(){
  crime <- read.csv("http://datasets.flowingdata.com/crimeRatesByState2005.tsv",  header=TRUE, sep="\t")
  symbols(crime$murder, crime$burglary, circles=crime$population)
  radius <- sqrt( crime$population/ pi )
  symbols(crime$murder, crime$burglary, circles=radius) 
  symbols(crime$murder, crime$burglary, circles=radius, inches=0.35, fg="white", bg="red", xlab="Murder Rate", ylab="Burglary Rate")
  text(crime$murder, crime$burglary, crime$state, cex=0.5)

}

mymap <- function(){
# setting up a map for the US and specify plotting parameters
  library(rgrs)
  require(rgdal)
  require(maptools)
  require(ggplot2)
  gpclibPermit()
  
  data(lyon)
  lyon@data$id <- rownames(lyon@data)
  lyon.points <- fortify.SpatialPolygonsDataFrame(lyon, region="id")
  lyon.map <-  ggplot() +
    geom_polygon(data=lyon.points, aes(long, lat, group=group), fill=NA, colour="black") +
      coord_map()
  lyon.map
}
