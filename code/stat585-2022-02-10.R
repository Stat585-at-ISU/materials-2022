loglikpois <- function(lambda, x) {
  # returns the log likelihood value of poisson x
  # with parameter lambda
  stopifnot(lambda > 0, is.numeric(x))

  n <- length(x)
  L <- -n*lambda + log(lambda)*sum(x)

  return(L)
}

X <- c(1, 3, 2, 3, 0, 1, 0, 1, 3, 3)
loglikpois(1,X)
loglikpois(2,X)
loglikpois(0,X)
loglikpois(1, c("red", "blue"))

for (i in 1:10) {
  print(loglikpois(i,X))
}

result <- rep(NA,length=10)
for (i in 1:10) {
  result[i] <- loglikpois(i,X)
}
result

lambdas <- seq(1,10, by=0.1)
result <- rep(NA,length=length(lambdas))
for (i in 1:length(lambdas)) {
  result[i] <- loglikpois(lambdas[i],X)
}

qplot(x=lambdas, y = result)


fizzbuzz <- function(x) {

  if (x %% 21 == 0) return("fizzbuzz")
  if (x %% 3 == 0) return("fizz")
  if (x %% 7 == 0) return("buzz")

  return(x)
}


fizzbuzz(1)
fizzbuzz(3)
fizzbuzz(7)
fizzbuzz(21)

for (i in 1:25) {
  cat(fizzbuzz(i))
  cat(" ")
}

n <- 10
fb <- rep(NA, n)
for (i in 1:n) {
  fb[i] <- fizzbuzz(i)
}

fizzbuzz(1:10)
