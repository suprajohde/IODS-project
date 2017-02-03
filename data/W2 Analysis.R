learning2014 <- read.table("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/learning2014.txt", sep=",", header=TRUE)

## analysing data dimensions and structure of the original data
dim(learning2014)
str(learning2014)


## Show a graphical overview of the data and show summaries of the variables in the data. Describe and interpret the outputs, commenting on the distributions of the variables and the relationships between them. (3 points)
library(ggplot2)
library(GGally)


## graphical overview based on gender
pairs(learning2014[-1], col=learning2014$gender)

## summary
summary(learning2014)

p <- ggpairs(learning2014, mapping = aes(col=gender, alpha=0.3), lower = list(combo = wrap("facethist", bins = 20)))
p

my_model <- lm(points ~ attitude , data = learning2014)
my_model <- lm(points ~ attitude + stra + deep, data = learning2014)
summary(my_model)

p1 <- ggplot(learning2014, aes(x = attitude, y = points, col=gender))

## printing three plots in one
my_model2 <- lm(points ~ attitude + stra + deep, data = learning2014)
par(mfrow = c(2,2))
plot(my_model2, c(1, 2, 5))

# define the visualization type (points)
p2 <- p1 + geom_point()

# add a regression line
p3 <- p2 + geom_smooth(method = "lm")

# add a main title and draw the plot
p4 <- p3 + ggtitle("Student's attitude versus exam points")

p4

# age vs. points
a1 <- ggplot(learning2014, aes(x = age, y = points, col=gender))

# define the visualization type (points)
a2 <- a1 + geom_point()

# draw the plot
a2

# add a regression line
a3 <- a2 + geom_smooth(method = "lm")

# add a main title and draw the plot
a4 <- a3 + ggtitle("Student's age versus exam points")

a4
## reading data

## Choose three variables as explanatory variables and fit a regression model where exam points is the target (dependent) variable. Show a summary of the fitted model and comment and interpret the results. Explain and interpret the statistical test related to the model parameters. If an explanatory variable in your model does not have a statistically significant relationship with the target variable, remove the variable from the model and fit the model again without it. (4 points)

## Using a summary of your fitted model, explain the relationship between the chosen explanatory variables and the target variable (interpret the model parameters). Explain and interpret the multiple R squared of the model. (3 points)

## Produce the following diagnostic plots: Residuals vs Fitted values, Normal QQ-plot and Residuals vs Leverage. Explain the assumptions of the model and interpret the validity of those assumptions based on the diagnostic plots. (3 points)

