rm(list=ls())
require(data.table)
dir <- "C:/Users/Kitt/Documents/GitHub/ExData_Plotting1/" 
if (getwd() != dir) setwd(dir)
# load data
data <- fread("household_power_consumption.txt")
# replace ? with NA
data[data == "?"] <- NA
# find target data by date
data.1 <- subset(data, Date == "1/2/2007" | Date == "2/2/2007")
data.1$Date <- as.Date(data.1$Date, format="%d/%m/%Y")
# make room
rm(data)
# re-classify columns as numeric
for (i in 3:length(names(data.1))){
    data.1[[i]] <- as.numeric(data.1[[i]])
}

# make the graph
png("plot1.png", width = 480, height = 480)
hist(data.1$Global_active_power, col="red", 
     xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()
