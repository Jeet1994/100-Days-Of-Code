library(plyr)

set.seed(7)

d <- data.frame(year = rep(2000:2003, each = 4),
                 count = round(runif(16, 0, 20)))
print(d)

ddply(d, "year", function(x) {
  mean.count <- mean(x$count)
  sd.count <- sd(x$count)
  cv <- sd.count/mean.count
  data.frame(cv.count = cv)
})

#########################################
ddply(d, "year", function(x) {
  mean.count <- mean(x$count)
  cv <- mean.count
  data.frame(cv.count = cv)
})

ddply(d, "year", summarise, mean.count = mean(count)) #In this line doing the same as the above function, but with "Summarise"

ddply(d, "year", transform, total.count = sum(count)) #Using transform method to get more info in the table.

ddply(d, "year", mutate, mu = mean(count), sigma = sd(count),
      cv = sigma/mu)


