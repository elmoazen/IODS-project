# Assignment 3 Data wrangling
# Author: Ramy Elmoazen
# Date: Wednesday 16-11-2022
# Data Source: Course:This data approach student achievement in secondary education of two Portuguese schools. 
#The data attributes include student grades, demographic, social and school related features) 
#it was collected by using school reports and questionnaires. 



# Access dplyr package
library("dplyr")

# Access ggplot2  package
library(ggplot2)
# Access readr package 
library(readr)

# Read the CSV file 
math<-read.table("data/student-mat.csv", sep=";", header=TRUE)
por<-read.table("data/student-por.csv", sep=";", header=TRUE)
# Explore the dimensions of the math data
dim(math) 
str(math)
# Explore the structure of the por data
dim(por) 
str(por)


# TASK: Join the two data sets using all other variables EXCEPT "failures", "paid", "absences", "G1", "G2", "G3" 

#List non-identifier variables
free_cols<-(c("failures", "paid", "absences", "G1", "G2", "G3"))

# List identifiers by subtracting the non-identifiers from all variables
join_cols <- setdiff(colnames(por), free_cols)

#join the two data sets by the filtered identifiers (join_colls)
math_por <- inner_join(math, por, by = join_cols, suffix = c(".math", ".por"))

#Explore the structure and dimensions of the joined data. join_cols
dim(math_por) 
str(math_por)

# create a new data frame with only the joined columns 
alc<- select(math_por, all_of(join_cols))

#Get rid of the duplicate records in the joined data set.
for(col_name in free_cols) {two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {alc[col_name] <- round(rowMeans(two_cols))} 
  else {alc[col_name] <- first_col}
  }
#Thus, if the first of the two selected columns is not numeric, add the first column to the `alc` data frame. 

#Create alc_use column for average weekday & weekend alcohol consumption 
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#Create high_use column for more than 2 average alcohol consumption 
alc <- mutate(alc, high_use = alc_use > 2)

#Glimpse at the joined and modified data
glimpse(alc)

# Write CSV file for the output file
write_csv(alc,"data/alc.csv")

# Read the CSV file 
Read_alc<- read_csv("data/alc.csv")


