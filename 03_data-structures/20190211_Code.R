library(tidyverse)
library(jsonlite)

data(mtcars)

mtcars %>% 
  filter(row_number() <= 3) %>%
  toJSON(pretty = T)

jsonfile <- ' [{"P0010001":710231,"NAME":"Alaska","state":"02"},
 {"P0010001":4779736,"NAME":"Alabama","state":"01"},
{"P0010001":2915918,"NAME":"Arkansas","state":"05"},
{"P0010001":6392017,"NAME":"Arizona","state":"04"},
{"P0010001":37253956,"NAME":"California","state":"06"}]'

json_data <- fromJSON(jsonfile)
str(json_data)

surname_data_2010 <- fromJSON("https://api.census.gov/data/2010/surname?get=NAME,COUNT,PCTAIAN,PCTAPI,PCTBLACK,PCTHISPANIC,PCTWHITE&RANK=1:100")
surname_data_2000 <- fromJSON("https://api.census.gov/data/2000/surname?get=NAME,COUNT,PCTAIAN,PCTAPI,PCTBLACK,PCTHISPANIC,PCTWHITE&RANK=1:100")
surname_data_2010_df <- surname_data_2010[-1,] %>%
  as_tibble() %>%
  set_names(surname_data_2010[1,]) %>%
  mutate_at(2:8, as.numeric)
surname_data_2000_df <- surname_data_2000[-1,] %>%
  as_tibble() %>%
  set_names(surname_data_2000[1,]) %>%
  mutate_at(2:8, as.numeric)

library(rvest)
url <- "https://www.nytimes.com/elections/results/iowa-house-district-4"
doc <- read_html(url)
tables <- html_table(doc, fill=TRUE)
head(tables[[2]])

read_html(url) %>% 
  html_table(fill = T) %>% 
  magrittr::extract2(2)
