getStats <- function(url) {
  cat(url)
  cat("\n")
  html <- read_html(url)
  stats <- html %>% html_nodes("span strong") %>% html_text()
  season <- html %>% html_nodes(".stats_pullout p:nth-child(2)") %>% html_text()
  career <- html %>% html_nodes(".stats_pullout p:nth-child(3)") %>% html_text()

  if (is.na(as.numeric(season[1]))) {
    cat("Season: ")
    cat(season[1])
    cat("\n")
    career <- season
    season <- as.character(rep(NA, length(season)))
  }

  dframe <- tibble(statistics = stats[-1],
                   season = season[-1],
                   career = career[-1])

  dframe %>% mutate(
    season = parse_number(season),
    career = parse_number(career)
  )
}

url <- "https://www.baseball-reference.com/players/a/abadfe01.shtml"
getStats(url)

url <- "http://www.baseball-reference.com/players/a/"
html <- read_html(url)
players <- html %>% html_nodes("b a") %>% html_text()
links <- html %>% html_nodes("b a") %>% html_attr(name="href")

base_url <- "http://www.baseball-reference.com"
activeA <- tibble(players=players, source = paste0(base_url, links))

head_activeA <- head(activeA, 20) %>%
  mutate(
    data = source %>% purrr::map(.f = getStats)
  )

