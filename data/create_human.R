## Tiina Autio
## 18.2.2017
## create_human.R

## datasets

## Human development
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

## Gender inequality
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

## data structure, dimensions and summaries
dim(hd)
str(hd)
summary(hd)
colnames(hd)

dim(gii)
str(gii)
summary(gii)
colnames(gii)

## renaming columns
names(hd)[1:8] = c("rank", "country", "index", "life_exp", "edu_exp", "edu_mean", "gni_capita", "gni_capita_minus_rank")
colnames(hd)

names(gii)[1:10] =c("rank", "country", "index", "mat_mor", "birth_rate", "repres_parl", "sec_edu_fem", "sec_edu_male", "labour_fem", "labour_male")
colnames(gii)

## mutating gii
library(dplyr)

gii <- mutate(gii, sec_edu_rate = sec_edu_fem / sec_edu_male )
gii <- mutate(gii, labour_rate = labour_fem / labour_male )

## joining two datasets

join_by <- c("country")
human <- inner_join(hd, gii, by = join_by, suffix = c(".hd", ".gii") )

dim(human)
str(human)
glimpse(human)

## saving human data

setwd("~/Documents/IODS-project/data")
write.csv(human, "human.csv")

