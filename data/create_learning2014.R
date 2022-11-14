# Assignment 2 Daara wrangling
# Author: Ramy Elmoazen
# Date: Wednesday 9-11-2022
# Data Source: Course: 
# Johdatus yhteiskuntatilastotieteeseen, syksy 2014
#(Introduction to Social Statistics, fall 2014 - in Finnish),
#international survey of Approaches to Learning, made possible by Teachers' 
#Academy funding for KV in 2013-2015. 

# Access tidyverse package
library(tidyverse)
# Access GGally package
library("GGally")
# Access dplyr package
library("dplyr")
# Access the gglot2 library
library(ggplot2)


# read the data into memory
learn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt",
                    sep="\t", header=TRUE)
# Explore the dimensions of the data
dim(learn14) 
#Comment: It shows 60 variables and 183 entries

# Explore the structure of the data
str(learn14)
#Comment: All variable are quantitative data except the gender which is categorical data


# Select variable from deep Questions and create column
deep_q <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
learn14$deep <- rowMeans(learn14[, deep_q])

# Select variable from surfcae Questions and create column
surface_q <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
learn14$surf <- rowMeans(learn14[, surface_q])

#Select variable from strategic Questions and create column
strategic_q <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
learn14$stra <- rowMeans(learn14[, strategic_q])

# create column 'attitude' by scaling the column "Attitude"
learn14$attitude <- learn14$Attitude / 10

#Create New dataset from selected variables
learning2014 <- learn14[, c("gender","Age","attitude", "deep", "stra", "surf", "Points")]

# change the name of "Age" to "age"
colnames(learning2014)[2] <- "age"  

# change the name of "Points" to "points"
colnames(learning2014)[7] <- "points" 

# Select Only exam points greater than zero
learning2014<-filter(learning2014, points>0)

# Write CSV file for the output file
write_csv(learning2014,"learning2014.csv")

# Read the CSV file 
learning2014<-read_csv("learning2014.csv")
