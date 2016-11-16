#Of the four types of sources indicated by the type (point, nonpoint, onroad, 
#nonroad) variable, which of these four sources have seen decreases in emissions
#from 1999–2008 for Baltimore City? Which have seen increases in emissions from
#1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

#Reference the data loading script to ensure the data is available to plot
source("dataLoad.R")

##subset to Baltimore data only
dataMary <- subset(data, fips == "24510")

#Plot 2 - Open png graphic device and set size
png(file="plot3.png", width = 960, height = 480, units = "px")


#Create initial plot of emissions over time
library(ggplot2)
ggp <- ggplot(dataMary, aes(year, Emissions, fill = type))
ggp + 
        geom_point(aes(color = type)) + 
        facet_grid(. ~ type) +
        geom_smooth(method = "lm", se = FALSE, col = "blue")


#Turn off the png graphics device
dev.off()