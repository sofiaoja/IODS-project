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
