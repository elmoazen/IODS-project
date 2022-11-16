# Assignment 3 Data wrangling
# Author: Ramy Elmoazen
# Date: Wednesday 16-11-2022
# Data Source: Course:This data approach student achievement in secondary education of two Portuguese schools. 
#The data attributes include student grades, demographic, social and school related features) 
#it was collected by using school reports and questionnaires. 

# Access tidyverse package
library(tidyverse)
# Access GGally package
library("GGally")
# Access dplyr package
library("dplyr")
# Access the gglot2 library
library(ggplot2)

# Read the CSV file 
math<-read.table("data/student-mat.csv", sep=";", header=TRUE)
por<-read.table("data/student-por.csv", sep=";", header=TRUE)
# Explore the dimensions of the data
dim(math) 
str(math)
# Explore the structure of the data

