#Across the United States, how have emissions from coal combustion-related 
#sources changed from 1999–2008?

#Reference the data loading script to ensure the data is available to plot
source("dataLoad.R")

#add short names to data from codes
dataSCC <- merge(data, codes[, c("SCC","Short.Name")], by = "SCC", all.x = TRUE)

#Extract only the observations for Coal
dataCoal <- subset(dataSCC, grepl("Coal", dataSCC$Short.Name,
                                  ignore.case = TRUE))
remove(dataSCC)

#Extract only coal observations for combustion
dataComb <- subset(dataCoal, grepl("Combust", dataCoal$Short.Name, 
                                   ignore.case = TRUE))
remove(dataCoal)

#group the data by year
dataGrp <- group_by(dataComb, year)
remove(dataComb)

#Summarize the data by years and sum of emissions
dataFinal <- summarize(dataGrp, total = sum(Emissions, na.rm = TRUE))
remove(dataGrp)

#Plot 4 - Open png graphic device and set size
png(file="plot4.png", width = 480, height = 480, units = "px")

#Create initial plot of emissions over time
plot(dataFinal, type = "b", col = "red", main = "Coal Combustion Emissions Over Time",
     xlab = "Years", ylab = "Coal Combustion Emissions")

#Turn off the png graphics device
dev.off()
