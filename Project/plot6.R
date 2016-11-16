#How have emissions from motor vehicle sources changed from 1999–2008 
#in Baltimore City?
#Reference the data loading script to ensure the data is available to plot
source("dataLoad.R")

##subset to Baltimore City and Losa Angeles County data only
dataMary <- subset(data, fips == "24510")
dataCali <- subset(data, fips == "06037")
remove(data)

#add short names to data from codes
dataSCC <- merge(dataMary, codes[, c("SCC","Short.Name")], by = "SCC", all.x = TRUE)
dataSCC1 <- merge(dataCali, codes[, c("SCC","Short.Name")], by = "SCC", all.x = TRUE)
remove(dataMary)
remove(dataCali)
remove(codes)

#extract vehicle from motor observations
dataVeh <- subset(dataSCC, grepl("veh", dataSCC$Short.Name, 
                                 ignore.case = TRUE))
dataVeh1 <- subset(dataSCC1, grepl("veh", dataSCC1$Short.Name, 
                                 ignore.case = TRUE))
remove(dataSCC)
remove(dataSCC1)

#group the data by year
dataGrp <- group_by(dataVeh, year)
dataGrp1 <- group_by(dataVeh1, year)
remove(dataVeh)
remove(dataVeh1)

#Summarize the data by years and sum of emissions
dataFinal <- summarize(dataGrp, total = sum(Emissions, na.rm = TRUE))
dataFinal1 <- summarize(dataGrp1, total = sum(Emissions, na.rm = TRUE))
remove(dataGrp)
remove(dataGrp1)

#Plot 6 - Open png graphic device and set size
png(file="plot6.png", width = 480, height = 480, units = "px")

#Create initial plot of emissions over time

library(ggplot2)
ggp <- ggplot(dataFinal, aes(x = year, y = total)) + geom_line(aes(color = "Baltimore City"))
ggp + 
        geom_line(data = dataFinal1, aes(x = year, y = total, color = "Los Angeles County")) +
        labs(x = "Years", y = "Emissions") +
        theme(legend.title=element_blank()) +
        ggtitle("Los Angeles County versus Baltimore City Emissions")

#Turn off the png graphics device
dev.off()
