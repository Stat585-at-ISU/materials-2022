# Option 1

fizzbuzz1 <- function(x) {
  # we assume x is a single number
  div3 <- (x %% 3) == 0
  div7 <- (x %% 7) == 0

  if (div3 & div7) return("fizzbuzz")
  if (div3) return("fizz")
  if (div7) return("buzz")
  return(x)
}

fizzbuzz <- function(a, b) {
  # we assume a and b are integer values

  idx <- a:b
  result <- rep(NA, length(idx))
  for (i in 1:length(idx))
    result[i] <- fizzbuzz1(idx[i])

  result
}

fizzbuzz(1,10)

###########
# Option 2

fizzbuzz_no_iter <- function(a, b) {
  lower <- min(a, b)
  upper <- max(a, b)

  if (lower == upper) return(fizzbuzz1(lower))

  return( c(fizzbuzz1(lower), fizzbuzz_no_iter(lower+1, upper)))
}

fizzbuzz_no_iter(1, 10)

##########
# Option 3

fizzbuzz_vector <- function(a, b) {
  # create a vector with numbers from a to b
  x <- seq.int(from = min(a,b), to = max(a,b))
  res <- x

  res[x %% 3 == 0] <- "fizz"
  res[x %% 7 == 0] <- "buzz"
  res[(x %% 3 == 0) & (x %% 7 == 0)] <- "fizzbuzz"

  res
}

fizzbuzz_vector(1,10)

