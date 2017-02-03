# Sofia 020217 Regression and model validation excercise
# title: New R script file for Data Wrangling created 310117
# author: Sofia Oja
# date: 31 tammikuuta 2017

# read the data into memory
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)

# the dimensions of the data
# output: [1] 183  60
dim(lrn14)


# the structure of the data
# output:
# 'data.frame':	183 obs. of  60 variables:
# $ Aa      : int  3 2 4 4 3 4 4 3 2 3 ...
# $ Ab      : int  1 2 1 2 2 2 1 1 1 2 ...
str(lrn14)

# access the dplyr library
library(dplyr)

# read the data into memory
#JYTOPKYS2 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-meta.txt", sep="\t", header=TRUE)

# questions related to deep, surface and strategic learning
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

# columns related to deep learning and create column 'deep' by averaging
deep_columns <- select(lrn14, one_of(deep_questions))
lrn14$deep <- rowMeans(deep_columns)

# columns related to surface learning and create column 'surf' by averaging
surface_columns <- select(lrn14, one_of(surface_questions))
lrn14$surf <- rowMeans(surface_columns)

# columns related to strategic learning and create column 'stra' by averaging
strategic_columns <- select(lrn14, one_of(strategic_questions))
lrn14$stra <- rowMeans(strategic_columns)

# handful of columns to keep
keep_columns <- c("gender","Age","Attitude", "deep", "stra", "surf", "Points")

# 'keep_columns' to create a new dataset
learning2014 <- select(lrn14, one_of(keep_columns))

# rows where points is greater than zero
learning2014 <- filter(learning2014, Points > 0)

# see the stucture of the new dataset
str(learning2014)

# write CSV in R
write.csv(learning2014, file = "data/learning2014.csv")

# read CSV into R
MyData <- read.csv(file="data/learning2014.csv", header=TRUE, sep=",")

# stucture of the new dataset
str(MyData)
head(MyData)
