# Sofia 150217 RStudio Exercise 4: Clustering and Classification excercise
# title: New R script file for Data Wrangling created 150217
# author: Sofia Oja
# date: 15 helmikuuta 2017

# read the data into memory
# Human development
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
# Gender inequality
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# explore the hd dataset
# 195 obs. of  8 variables
str(hd)
dim(hd)
summary(hd)
# explore the gii dataset
# 195 obs. of  10 variables
str(gii)
dim(gii)
summary(gii)

# rename programmatically
library(reshape)
hd <- rename(hd, c(HDI.Rank="HDIRank"))
#hd <- rename(hd, c(Country="newname"))
hd <- rename(hd, c(Human.Development.Index..HDI.="HDI"))
hd <- rename(hd, c(Life.Expectancy.at.Birth="LifeExpectancyatBirth"))
hd <- rename(hd, c(Expected.Years.of.Education="ExpectedYearsofEducation"))
hd <- rename(hd, c(Mean.Years.of.Education="MeanYearsofEducation"))
hd <- rename(hd, c(Gross.National.Income..GNI..per.Capita="GNIperCapita"))
hd <- rename(hd, c(GNI.per.Capita.Rank.Minus.HDI.Rank="GNIperCapitaRankMinusHDIRank"))

gii <- rename(gii, c(GII.Rank="GIIRank"))
#gii <- rename(gii, c(Country="newname"))
gii <- rename(gii, c(Gender.Inequality.Index..GII.="GII"))
gii <- rename(gii, c(Maternal.Mortality.Ratio="MaternalMortalityRatio"))
gii <- rename(gii, c(Adolescent.Birth.Rate="AdolescentBirthRate"))
gii <- rename(gii, c(Percent.Representation.in.Parliament="PercentRepresentationinParliament"))
gii <- rename(gii, c(Population.with.Secondary.Education..Female.="PopulationwithSecondaryEducationFemale"))
gii <- rename(gii, c(Population.with.Secondary.Education..Male.="PopulationwithSecondaryEducationMale"))
gii <- rename(gii, c(Labour.Force.Participation.Rate..Female.="LabourForceParticipationRateFemale"))
gii <- rename(gii, c(Labour.Force.Participation.Rate..Male.="LabourForceParticipationRateMale"))

# access the 'tidyverse' packages dplyr and ggplot2
library(dplyr); library(ggplot2)

# define a new column edu2Fperedu2M
gii <- mutate(gii, edu2Fperedu2M = (gii$PopulationwithSecondaryEducationFemale / gii$PopulationwithSecondaryEducationMale))

# define a new column labFperlabM
gii <- mutate(gii, labFperlabM = (gii$LabourForceParticipationRateFemale / gii$LabourForceParticipationRateMale))

# access the dplyr library
library(dplyr)

# common columns to use as identifiers
join_by <- c("Country")

# join the two datasets by the selected identifiers
human <- inner_join(hd, gii, by = join_by) 

setwd("~/GitHub/IODS-project")

# write CSV in R
write.csv2(human, file = "data/human.csv")

# Sofia 210217 RStudio Exercise 5: Dimensionality Reduction Techniques excercise
# title: Continue with R script file for Data Wrangling created 210217
# author: Sofia Oja
# date: 21 helmikuuta 2017

# read CSV into R
human <- read.csv(file="http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human1.txt", header=TRUE, sep=",")

# explore the human dataset
# human data: 195 obs. of  19 variables
str(human)
dim(human)
summary(human)

# mutate GNI to numeric
human$GNI <- as.numeric(sub(",", ".", human$GNI, fixed = TRUE))

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
complete.cases(human)

# print out the data along with a completeness indicator as the last column
data.frame(human[-1], comp = complete.cases(human))

# filter out all rows with NA values
human_comp = data.frame(human[-1], comp = complete.cases(human))
human_ <- filter(human, human_comp$comp == TRUE)

# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$Country

# remove the Country variable
human_ <- select(human_, -Country)

# explore the human dataset
# human data: 155 obs. of  8 variables
str(human_)
dim(human_)

setwd("~/GitHub/IODS-project")

# write CSV in R
write.csv2(human_, file = "data/human2.csv")

# read CSV into R
#human_ <- read.csv(file="http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human2.txt", header=TRUE, sep=",")

# explore the human dataset
# human data: 155 obs. of  8 variables
#str(human_)
#dim(human_)
