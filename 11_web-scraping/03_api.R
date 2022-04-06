## ----setup, include=FALSE, message=FALSE, warning = FALSE-------------------
knitr::opts_chunk$set(echo = TRUE, dpi= 300)
options(width=60)
library(tidyverse)


## ----eval = FALSE-----------------------------------------------------------
## httr::POST(
##   url = NULL,
##   config = list(),
##   ...,
##   body = NULL,
##   encode = c("multipart", "form", "json", "raw"),
##   handle = NULL
## )


## ----eval = FALSE-----------------------------------------------------------
## curl -d "grant_type=client_credentials&client_id={CLIENT-ID}&
## client_secret={CLIENT-SECRET}" https://api.petfinder.com/v2/oauth2/token


## ---- echo = F, include = F-------------------------------------------------
library(rvest)
library(xml2)

## ---- eval = F--------------------------------------------------------------
library(rvest)
library(xml2)
key <- # Your key here
secret <- # Your secret here
endpoint <- 'oauth2/token'
url <- "https://api.petfinder.com/v2/"
req <- httr::POST(paste0(url, endpoint),
                  body = list("grant_type"="client_credentials",
                              "client_id" = key,
                              "client_secret" = secret),
                  encode="json"
)

## ---- echo = F, include = F-------------------------------------------------
save(req, file = "Request.Rdata")
load("Request.Rdata")


## ---------------------------------------------------------------------------
token <- httr::content(req)$access_token


## ----eval=FALSE-------------------------------------------------------------
## curl -H "Authorization: Bearer {YOUR_ACCESS_TOKEN}"
## GET https://api.petfinder.com/v2/{CATEGORY}/
##   {ACTION}?{parameter_1}={value_1}&{parameter_2}={value_2}


## ----eval= FALSE------------------------------------------------------------
## animals?type=cat&good_with_children=true&location=50010


## ----eval = FALSE-----------------------------------------------------------
## httr::GET(url = NULL, config = list(), ..., handle = NULL)


## ---- eval = F--------------------------------------------------------------
# Now get actual data
req_data <- httr::GET(
  paste0(url, "animals?type=dog&location=50010"),
  httr::add_headers(Authorization = paste0('Bearer ', token, sep = ''))
  )

## ---- echo = F, include = F-------------------------------------------------
save(req_data, file = "DataRequest.Rdata")
load("DataRequest.Rdata")


## ---------------------------------------------------------------------------
ames_dogs <- httr::content(req_data, as = "parsed")
str(ames_dogs)


## ----eval = FALSE-----------------------------------------------------------
## url_dogs <- "https://bit.ly/3tU4dKG" # download the file to your drive
## load("<your file path>/DataRequest.Rdata")


## ---------------------------------------------------------------------------
library(xml2)
getBreedInfo <- function(breed) {
  res <- "unknown"
  if (breed$unknown == "TRUE") return(res)
  res <- breed[1]
  if (breed[2] != "NULL") res <- paste(res, breed[2], sep=", ")
  if (breed[3] == "TRUE") res <- paste(res, "Mix", sep=", ")
  return(res)
}

dog_to_df <- function(x) {
  tibble(
    name = x$name,
    breed = getBreedInfo(x$breeds),
    age = x$age,
    sex = x$sex,
    id = x$id,
    shelterID = x$shelterId,
    pics = list(x$photos)
  )
}

ames_dog_df <- ames_dogs$animals %>% purrr::map_df(dog_to_df)


## ---------------------------------------------------------------------------
ames_dog_df


## ----  fig.show = 'all', out.width="10%"------------------------------------
purrr::map_chr(ames_dog_df$pics, .f = function(x) {
    if (length(x) == 0) return(NA)
    x[[1]]$full
  }) %>%
  na.omit() %>%
  knitr::include_graphics()


## ---------------------------------------------------------------------------
jsonlite::read_json("https://api.weather.gov/points/41.9906,-93.6189")


## ---------------------------------------------------------------------------
get_weather <- function(lat, lon) {
  checkmate::assert_number(lat)
  checkmate::assert_number(lon)
  url <- sprintf("https://api.weather.gov/points/%f,%f", lat, lon)
  initialjson <- jsonlite::fromJSON(url)

  if (!checkmate::check_subset("properties", names(initialjson)) |
      !checkmate::check_subset("forecastHourly", names(initialjson$properties))) {
    stop("No Information Found. Check Latitude/Longitude values.")
  }

  hourlyforecast <- jsonlite::fromJSON(initialjson$properties$forecastHourly)

  res <- hourlyforecast$properties$periods
  checkmate::check_data_frame(res)
  res
}


## ---------------------------------------------------------------------------
amesweather <- get_weather(42, -93.6) %>%
  mutate(startTime = lubridate::ymd_hms(startTime, tz = "America/Chicago"))


## ----echo=FALSE, fig.height = 3.5-------------------------------------------
# Add icons for every 6 hour interval
maxtemp <- max(amesweather$temperature)
icons <- amesweather %>% filter(row_number() %% 6 == 1)
icon_lst <- purrr::map2(
  icons$icon, icons$startTime,
  ~cowplot::draw_image(.x, x = .y, y = maxtemp - 3, width = lubridate::hours(6), height = 6))

ggplot() +
  icon_lst +
  geom_line(aes(x = startTime, y = temperature), data = amesweather)


