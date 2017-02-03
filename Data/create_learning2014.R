#Sofia 020217 Regression and model validation excercise

lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

#The dataset contains 183 observations and 60 variables (columns) (n,d: n=183, d=60)
dim(lrn14)

#Sturcture of the data shows accurately the variables and the number of observations/variable.
str(lrn14)

library(dplyr)
colnames(learning2014)[2] <- "age"
colnames(learning2014)[3] <- "attitude"
colnames(learning2014)[7] <- "points"

keep_columns <- c("gender","age","attitude", "deep", "stra", "surf", "points")
learning2014 <- filter(learning2014, points > 0)
dim(learning2014)

# Write CSV in R
write.csv(learning2014, file = "Data/learning2014.csv")

# Read CSV into R
MyData <- read.csv(file="Data/learning2014.csv", header=TRUE, sep=",")

str(MyData)

head(MyData)