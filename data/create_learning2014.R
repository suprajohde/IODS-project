## 1)

## Tiina Autio
## 30.1.2017
## This is the create_learning file for W2 data wrangling exercise

## 2)

learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

dim(learning2014) ## 183 obs 60 variables
str(learning2014) ## age, attitude, points, gender + other fields "Aa, Ab..."

## 3)

## selecting data

## Deep ~d_sm+d_ri+d_ue
## Surf ~su_lp+su_um+su_sb
## Stra ~st_os+st_tm

deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

deep_columns <- select(learning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

surface_columns <- select(learning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

strategic_columns <- select(learning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(strategic_columns)

library(dplyr)

select_col <-c("gender", "Age", "Attitude", "deep", "stra", "surf", "Points")

analysis_dataset <- select(learning2014, one_of(select_col))
analysis_dataset

## column names
colnames(analysis_dataset)[2] = "age"
colnames(analysis_dataset)[3] = "attitude"
colnames(analysis_dataset)[7] = "points"

colnames(analysis_dataset)

## filtering points > 0
analysis_dataset <- filter(analysis_dataset, points > 0)
str(analysis_dataset) ## 166 7

## 4) 

## saving analysis dataset

setwd("~/Documents/IODS-project")
write.csv(analysis_dataset, "learning2014.csv")

learning2014testi <- read.csv("~/Documents/IODS-project/learning2014.csv", sep=",", header=TRUE)
str(learning2014testi[-1]) ## deleting first column (row numbers)



