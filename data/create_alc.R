## Tiina Autio
## 10.2.2017
## This is the create_alc file for W3 data wrangling exercise
## Data source: UCI Machine Learning Repository, Student Alcohol consumption

## Read both student-mat.csv and student-por.csv into R (from the data folder) 
## and explore the structure and dimensions of the data. (1 point)
student_math <- read.csv("~/Documents/IODS-project/data/student-mat.csv", sep=";", header=TRUE)
student_por <- read.csv("~/Documents/IODS-project/data/student-por.csv", sep=";", header=TRUE)

dim(student_math)
str(student_math)

dim(student_por)
str(student_por)

colnames(student_math)
colnames(student_por)

## Join the two data sets using the variables "school", "sex", "age", "address", "famsize", 
## "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet" as (student) 
## identifiers. Keep only the students present in both data sets. Explore the structure 
## and dimensions of the joined data. (1 point)

library(dplyr)

join_by <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

math_por <- inner_join(student_math, student_por, by = join_by, suffix = c(".math", ".por") )

colnames(math_por)

glimpse(math_por)

alc <- select(math_por, one_of(join_by))

colnames(alc)
dim(alc)
str(alc)
glimpse(alc)

## Either a) copy the solution from the DataCamp exercise The if-else structure to combine 
## the 'duplicated' answers in the joined data, or b) write your own solution to achieve this 
## task. (1 point)

notjoined_columns <- colnames(student_math)[!colnames(student_math) %in% join_by]

# for every column name not used for joining...
for(column_name in notjoined_columns) {
  # select two columns from 'math_por' with the same original name
  two_columns <- select(math_por, starts_with(column_name))
  # select the first column vector of those two columns
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # take a rounded average of each row of the two columns and
    # add the resulting vector to the alc data frame
    alc[column_name] <- round(rowMeans(two_columns))
  } else { # else if it's not numeric...
    # add the first column vector to the alc data frame
    alc[column_name] <- first_column
  }
}

glimpse(alc)

## Take the average of the answers related to weekday and weekend alcohol consumption to create
## a new column 'alc_use' to the joined data. Then use 'alc_use' to create a new logical column
## 'high_use' which is TRUE for students for which 'alc_use' is greater than 2 (and FALSE 
## otherwise). (1 point)

library(ggplot2)

alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)
alc <- mutate(alc, high_use = alc_use > 2)



## Glimpse at the joined and modified data to make sure everything is in order. The joined 
## data should now have 382 observations of 35 variables. Save the joined and modified data 
## set to the ‘data’ folder, using for example write.csv() or write.table() functions. (1 point)

dim(alc)
str(alc)
glimpse(alc)

setwd("~/Documents/IODS-project/data")
write.csv(alc, "create_alc.csv")
