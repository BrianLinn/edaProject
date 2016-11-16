#Reference the data loading script to ensure the data is available to plot
source("dataLoad.R")

#group the data by year
dataGrp <- group_by(data, year)

#Summarize the data by years and sum of emissions
dataFinal <- summarize(dataGrp, total = sum(Emissions, na.rm = TRUE))
remove(dataGrp)

#Plot 1 - Open png graphic device and set size
png(file="plot1.png", width = 480, height = 480, units = "px")

#Create initial plot of Global_active_power over time as hist
plot(dataFinal, type = "l", col = "red", main = "Emissions Over Time",
     xlab = "Years", ylab = "Total Emissions",  
     ylim=c(3000000,8000000))

#Turn off the png graphics device
dev.off()