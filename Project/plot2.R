#Reference the data loading script to ensure the data is available to plot
source("dataLoad.R")

##subset to Baltimore data only
dataMary <- subset(data, fips == "24510")

#group the data by year
dataGrp <- group_by(dataMary, year)
remove(dataMary)

#Summarize the data by years and sum of emissions
dataFinal <- summarize(dataGrp, total = sum(Emissions, na.rm = TRUE))
remove(dataGrp)

#Plot 2 - Open png graphic device and set size
png(file="plot2.png", width = 480, height = 480, units = "px")

#Create initial plot of emissions over time
plot(dataFinal, type = "l", col = "red", 
     main = "Emissions Over Time - Baltimore City, Maryland",
     xlab = "Years", ylab = "Total Emissions",  
     ylim=c(1000,4000))

#Turn off the png graphics device
dev.off()
