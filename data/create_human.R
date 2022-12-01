#Human Development Index (HDI)
# Author: Ramy Elmoazen

#The health dimension is assessed by life expectancy at birth, 
#the education dimension is measured by mean of years of schooling for adults aged 25 years and more 
#and expected years of schooling for children of school entering age. 
# The standard of living dimension is measured by gross national income per capita. 
#The HDI uses the logarithm of income, to reflect the diminishing importance of income with increasing GNI.


#load required packages
library (readr)
library(dplyr)
library(tidyr)
library(stringr)

# Read in the “Human development” and “Gender inequality” data sets.
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")

gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(hd); dim(hd)

str(gii); dim(gii)

summary(hd)

summary(gii)

hd <- rename(hd,  HDI = "Human Development Index (HDI)",         
             Life.Exp = "Life Expectancy at Birth",   Edu.Exp = "Expected Years of Education",          
             Edu.Mean = "Mean Years of Education",          
             GNI  = "Gross National Income (GNI) per Capita",
             GNI.Minus.Rank = "GNI per Capita Rank Minus HDI Rank") 
gii <- rename(gii,
              GII.Rank = "GII Rank", GII = "Gender Inequality Index (GII)",               
              Mat.Mor = "Maternal Mortality Ratio",                    
              Ado.Birth = "Adolescent Birth Rate",                        
              Parli.F = "Percent Representation in Parliament",        
              Edu2.F = "Population with Secondary Education (Female)", 
              Edu2.M = "Population with Secondary Education (Male)",  
              Labo.F = "Labour Force Participation Rate (Female)",     
              Labo.M = "Labour Force Participation Rate (Male)")

#Mutate the “Gender inequality” data and create two new variables. 
#The first: ratio of F to M with second edu (i.e. edu2F / edu2M).
#The second: ratio of labor participation of F to M  (i.e. labF / labM)
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M, Labo.FM = Labo.F / Labo.M)

##JOINING THE DATASETS

#Join together the two datasets using the variable Country as the identifier
human <- inner_join(hd, gii, by = "Country")

# call  the joined dataset
glimpse(human)

#diminsion of the joined dataset
dim(human)
# Write CSV file for the output file
write_csv(human,"data/human.csv")

# Read the CSV file 
human_CSV<- read_csv("data/human.csv")


#Read data again 
human <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human1.txt", 
                    sep =",", header = T)



# remove the commas from GNI and print out a numeric version of it
human$GNI <- gsub(",", "", human$GNI) %>% as.numeric

# OR(easier and deletenote) human$GNI<-str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric()

# columns to keep
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# select the 'keep' columns
human <- select(human, one_of(keep))

# print out a completeness indicator of the 'human' data
include<-complete.cases(human)

# print out the data along with a completeness indicator as the last column
human_<- data.frame(human, comp = "include")

# filter out all rows with NA values
human_ <- filter(human, include)


# look at the last 10 observations of human
tail(human_, n=10)

# define the last indice we want to keep
last <- nrow(human_) - 7

# choose everything until the last 7 observations
human_ <- human_[1:last, ]

# add countries as rownames
rownames(human_) <- human_$Country

#delete country  column
human_ <- select(human_, -Country)

# Write CSV file for the output file
write.csv(human_,"data/human.csv",row.names=TRUE)


# Read the CSV file 
human_CSV<- read.csv("data/human.csv",row.names=1)

