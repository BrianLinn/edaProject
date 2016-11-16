#How have emissions from motor vehicle sources changed from 1999–2008 
#in Baltimore City?
#Reference the data loading script to ensure the data is available to plot
source("dataLoad.R")

##subset to Baltimore data only
dataMary <- subset(data, fips == "24510")

#add short names to data from codes
dataSCC <- merge(dataMary, codes[, c("SCC","Short.Name")], by = "SCC", all.x = TRUE)
remove(dataMary)


#extract vehicle from motor observations
dataVeh <- subset(dataSCC, grepl("veh", dataMotor$Short.Name, 
                                    ignore.case = TRUE))
remove(dataSCC)

#group the data by year
dataGrp <- group_by(dataVeh, year)
remove(dataVeh)

#Summarize the data by years and sum of emissions
dataFinal <- summarize(dataGrp, total = sum(Emissions, na.rm = TRUE))
remove(dataGrp)

#Plot 5 - Open png graphic device and set size
png(file="plot5.png", width = 480, height = 480, units = "px")

#Create initial plot of emissions over time
plot(dataFinal, type = "l", col = "red", 
     main = "Motor Vehicle Emissions Over Time - Baltimore City, Maryland",
     xlab = "Years", ylab = "Motor Vehicle Emissions")

#Turn off the png graphics device
dev.off()
