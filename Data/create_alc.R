# title: RStudio Exercise 3 R script file for Data Wrangling
# source: UCI Machine Learning Repository, Student Alcohol consumption data
# author: Sofia Oja
# date: 9 helmikuuta 2017

# set working directory
setwd("~/GitHub/IODS-project")

# read CSV into R
math <- read.csv(file="Data/student-mat.csv", header=TRUE, sep=";")
por <- read.csv(file="Data/student-por.csv", header=TRUE, sep=";")

# stucture of the new dataset
str(math)
str(math)

# dimension of the new dataset
dim(por)
dim(por)

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# join the two datasets by the selected identifiers
math_por <- inner_join(math, por, by = join_by)

# stucture of the new dataset
str(math_por)

# dimension of the new dataset
dim(math_por)

# print out the column names of 'math_por'
colnames(math_por)

# create a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(math)[!colnames(math) %in% join_by]

# print out the columns not used for joining
notjoined_columns

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

# glimpse at the new combined data
glimpse(alc)

# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# initialize a plot of alcohol use
g1 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# define the plot as a bar plot and draw it
g1 + geom_bar()

# define a new logical column 'high_use'
alc <- mutate(alc, high_use = alc_use > 2)

# initialize a plot of 'high_use'
g2 <- ggplot(data = alc, aes(x = alc_use, fill = sex))

# draw a bar plot of high_use by sex
g2 + geom_bar() + facet_wrap("sex")

# glimpse at the new combined data
glimpse(alc)

# write CSV in R
write.csv2(alc, file = "data/alcjoinedmodified.csv")
