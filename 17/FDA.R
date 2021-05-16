library(fda)
library(tidyverse)
library(plotly)

# Function to simulate data
fake_curves <- function(n_curves = 100, n_points = 80, max_time = 100){
  ID <- 1:n_curves
  x <- vector(mode = "list", length = n_curves)
  t <- vector(mode = "list", length = n_curves)
  
  for (i in 1:n_curves){
    t[i] <- list(sort(runif(n_points,0,max_time)))
    x[i] <- list(cumsum(rnorm(n_points)) / sqrt(n_points))
  }
  df <- tibble(ID,t,x)
  names(df) <- c("ID", "Time", "Curve")
  return(df)
}


set.seed(123)
n_curves <- 40
n_points <- 80
max_time <- 100
df <- fake_curves(n_curves = n_curves,n_points = n_points, max_time = max_time)
head(df)


df_1 <- df %>% select(!c(ID,Curve)) %>% unnest_longer(Time) 
df_2 <- df %>% select(!c(ID,Time)) %>% unnest_longer(Curve)
ID <- sort(rep(1:n_curves,n_points))
df_l <- cbind(ID,df_1,df_2)
p <- ggplot(df_l, aes(x = Time, y = Curve, group = ID, col = ID)) +
  geom_line()
p

knots    = c(seq(0,max_time,5)) #Location of knots
n_knots   = length(knots) #Number of knots
n_order   = 4 # order of basis functions: for cubic b-splines: order = 3 + 1
n_basis   = length(knots) + n_order - 2;
basis = create.bspline.basis(rangeval = c(0,max_time), n_basis)
plot(basis)

argvals <- matrix(df_l$Time, nrow = n_points, ncol = n_curves)
y_mat <- matrix(df_l$Curve, nrow = n_points, ncol = n_curves)
W.obj <- Data2fd(argvals = argvals, y = y_mat, basisobj = basis, lambda = 0.5)

W_mean <- mean.fd(W.obj)
W_sd <- std.fd(W.obj)
# Create objects for the standard upper and lower standard deviation
SE_u <- fd(basisobj = basis)
SE_l <- fd(basisobj = basis)
# Fill in the sd values
SE_u$coefs <- W_mean$coefs +  1.96 * W_sd$coefs/sqrt(n_curves) 
SE_l$coefs <- W_mean$coefs -  1.96 * W_sd$coefs/sqrt(n_curves)
plot(W.obj, xlab="Time", ylab="", lty = 1)
## [1] "done"
title(main = "Smoothed Curves")
lines(SE_u, lwd = 3, lty = 3)
lines(SE_l, lwd = 3, lty = 3)
lines(W_mean,  lwd = 3)


