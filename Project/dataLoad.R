library(dplyr)
#Clear the environment
rm(list = ls())

#Ensure there is a data folder in the working directory to store the files
if(!exists("./data")){dir.create("./data")}
if(!exists("./data/pm25")){dir.create("./data/pm25")}

#Set variable for working data directory
dataDir <- "./data/pm25"

#Set the file location
fileLoc <- "./data/exdata%2Fdata%2FNEI_data.zip"

#Unzip the data file to the pm25 subdirectory
unzip(fileLoc, exdir = dataDir)

#Load the PM25 data into R
data <- readRDS("./data/pm25/SummaryScc_PM25.rds")

#Load the mapping data
codes <- readRDS("./data/pm25/Source_Classification_Code.rds")