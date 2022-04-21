library(lubridate)
birthday <- ymd("2022-05-01")
birthday - today()

wday(birthday, label=TRUE)

wday(ymd("2014-05-01"), label=TRUE)


days <- seq.Date(from=ymd("2010-01-01"), to = ymd("2021-12-31"), by = 1)
thirteens <- days[mday(days)==13]
table(wday(thirteens, label=TRUE))

########

library(stringr)
passwords <- readLines("http://bit.ly/585-passwords")
