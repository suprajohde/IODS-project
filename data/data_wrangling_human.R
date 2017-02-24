## Tiina Autio
## W5 Data Wrangling
## Data source: http://hdr.undp.org/en/content/human-development-index-hdi

human <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header = TRUE, sep = ",")

names(human)
str(human)
summary(human)

library(stringr)
library(dplyr)

## mutating the data
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric 
str(human$GNI)

## excluding unneeded variables
keep <- c( "Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human_ <- dplyr::select(human, one_of(keep))

## removing all rows with missing values
human_ <- filter(human_, complete.cases(human_) == TRUE)

## removing regions
last <- nrow(human_) - 7
human_ <- human_[1: (as.numeric(last)), ]

## defining row names and removing country column
rownames(human_) <- human_$Country
human_final <- select(human_, -Country)

dim(human_final)
str(human_final)
glimpse(human_final)

## saving human data

setwd("~/Documents/IODS-project/data")
write.csv(human_final, "human_data.csv")
