N <- 10^2
x1 <- rnorm(N) 
x2 <- 1 + x1 + rnorm(N)
plot(0) 
plot(0,1) 
plot(x1) 
plot(x1,x2) # scatter plot x1 on the horizontal axis and x2 on the vertical axis
plot(x2 ~ x1) # the same but using a formula (x2 as a function of x1)
methods(plot) # show all the available methods for plot (depending on the number of loaded packages).
