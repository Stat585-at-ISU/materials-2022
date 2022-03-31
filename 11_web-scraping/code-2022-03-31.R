library(rvest)
library(tidyverse)
url <- "http://www.nytimes.com/elections/results/iowa"
html <- read_html(url)
tables <- html_table(html)
head(tables[[2]])

ia_results <- tables[[2]] %>% mutate(
  Trump = parse_number(Trump),
  Clinton = parse_number(Clinton)
)

ia_results %>% str()

url <- "https://www.nytimes.com/elections/2016/results/minnesota"
html <- read_html(url)
tables <- html_table(html)
head(tables[[2]])

mn_results <- tables[[2]] %>% mutate(
  Trump = parse_number(Trump),
  Clinton = parse_number(Clinton)
)

url <- "https://www.nytimes.com/interactive/2020/11/03/us/elections/results-iowa.html"
html <- read_html(url)
tables <- html_table(html)

ia_results_2020 <- tables[[2]]
ia_results_2020 <- ia_results_2020[,-(4:5)]

url <- "http://www.baseball-reference.com/players/a/"
html <- read_html(url)
players <- html %>% html_nodes("b a") %>% html_text()
links <- html %>% html_nodes("b a") %>% html_attr("href")

url <- "https://www.baseball-reference.com/players/a/abadfe01.shtml"
html <- read_html(url)
html %>% html_nodes(".stats_pullout") %>% html_text()
html %>% html_nodes(".p2") %>% html_text()

statistics <- html %>% html_nodes("span strong") %>% html_text()
career <- html %>% html_nodes(".stats_pullout p:nth-child(3)") %>% html_text()
lastseason <- html %>% html_nodes(".stats_pullout p:nth-child(2)") %>% html_text()
