
library (readr)
library(dplyr)

# Read in the “Human development” and “Gender inequality” data sets.
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")

gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv", na = "..")

str(hd); dim(hd)

str(gii); dim(gii)

summary(hd)

summary(gii)

hd <- rename(hd,  HDI = "Human Development Index (HDI)",         
             Life.Exp = "Life Expectancy at Birth",   edu.exp = "Expected Years of Education",          
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
