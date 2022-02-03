# Libraryscrapping.r
# scrpping required libraries in the wd and install

setwd(dirname(rstudioapi::getSourceEditorContext()$path))
rm(list=ls())
dev.off()


library(stringr)
library(tools)

# multiple input
temp.Rmd = list.files(pattern="*.Rmd$")
temp.name <-list()
for (i in 1:length(temp.Rmd)){
  temp.name <- append(temp.name, readLines(temp.Rmd[i]))
}

# extract library name
## key1 ="^library\\(.*\\)$"
stock1 <- grep("^library\\([[:alpha:]]+\\)$", temp.name, value = T)
stock1 <- gsub("library\\(","", stock1)
stock1 <- sapply(strsplit(stock1, split='[^[:alpha:]]', perl=TRUE), function(x) (tail(x, n=1)))

## key2 ="[^[:alpha:]]*[[:alpha:]]+[::]{2}[[:alpha:]]+[[:punct:]]?"
stock2 <- as.character(as.vector(str_extract_all(temp.name,"[^[:alpha:]]*[[:alpha:]]+[::]{2}[[:alpha:]]+[[:punct:]]?", simplify =T)))
stock2 <- sapply(strsplit(stock2, split='::', fixed=TRUE), function(x) (x[1]))
stock2 <- sapply(strsplit(stock2, split='[^[:alpha:]]', perl=TRUE), function(x) (tail(x, n=1)))

# construct charator vector
package.required <- unique(append(stock1,stock2))

# Extend to dependent library
package.required <- unique(as.vector(unlist(package_dependencies(package.required))))
package.required <- package.required[package.required!=("")]
package.required <- package.required[!is.na(package.required)]

# install package
print(package.required)
for (name.packages in package.required) {
  if(!is.element(name.packages, installed.packages()[,1])){
    install.packages(name.packages)
    print(paste("library installed",name.packages))}
  else {print(paste("library installed",name.packages))}
}
