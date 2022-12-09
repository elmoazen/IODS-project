# Assignment 2 Analysis of longitudinal data
#Data wrangling
# Author: Ramy Elmoazen
# Date: Wednesday 7-12-2022

# access packages readr and dplyr
library(readr) 
library(dplyr)
library(tidyr)

# Read BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)

# read in the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

#write data sets to files in the data-folder.
write.csv(BPRS, "data/BPRS.csv", row.names = FALSE)
write.csv(RATS, "data/ RATS.csv", row.names = FALSE)

# names of variables and structure of BPRS
colnames(BPRS)
str(BPRS)


# Convert categorical variables in BPRS to factors. 
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
str(BPRS)

# Convert categorical variables in RATS to factors.
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)
str(RATS)


# CONVERSION TO LONG FORM AND ADD A VARIABLE

# Convert BPRS to long form
BPRSL <-  pivot_longer(BPRS, cols = -c(treatment, subject),
        names_to = "weeks", values_to = "bprs") %>% arrange(weeks)

# Extract the week number
BPRSL <-  BPRSL %>% 
  mutate(week = as.integer(substr(weeks, start=5, stop=5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)


# Convert RAT data to long form
RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD, 3, 4))) %>% arrange(Time)

# Glimpse the data
glimpse(RATSL)


# Compare BPRS variable names, summary and structure 
names(BPRS); names(BPRSL)
summary(BPRS); summary(BPRSL)
str(BPRS); str(BPRSL)

# Compare RATS variable names, summary and structure 
names(RATS); names(RATSL)
summary(RATS); summary(RATSL)
str(RATS); str(RATSL)

# Create csv files for new long datasets
write.csv(BPRSL, "data/BPRSL.csv", row.names = FALSE)
write.csv(RATSL, "data/RATSL.csv", row.names = FALSE)


