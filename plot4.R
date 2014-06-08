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
# combine the date and time for DTG
data.1$Date <- data.1[, paste(Date, Time, sep=" ")]
data.1[, Time:=NULL]
x <- strptime(data.1$Date, format="%Y-%m-%d %H:%M:%S")
# make room
rm(data)
gc()
# re-classify columns as numeric
for (i in 2:length(names(data.1))){
    data.1[[i]] <- as.numeric(data.1[[i]])
}
# 
data <- as.data.frame(data.1)
data$Date <- x
rm(x)
## end formatting and data loading nonsense
# write to file
png(filename="plot4.png", width = 480, height = 480)
# set the canvas for 4 plots
par(mfrow = c(2, 2))
par(mar = c(4, 4, 2.5, 1))

# upper left - global active power by date/time
with(data, plot(Date, Global_active_power, type = "n",
                xlab = "", ylab = "Global Active Power"))
with(data, lines(Date, Global_active_power))

# upper right - voltage by date.time
with(data, plot(Date, Voltage, type = "n",
                xlab = "datetime",
                ylab = "Voltage"))
with(data, lines(Date, Voltage))

# lower left - plot 3
with(data, plot(Date, Sub_metering_1, type = "n",
                xlab = "", ylab = "Energy sub metering"))
with(data, lines(Date, Sub_metering_1, col="black"))
with(data, lines(Date, Sub_metering_2, col="red"))
with(data, lines(Date, Sub_metering_3, col="blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = c(2.5, 2.5, 2.5),
       col = c("black", "red", "blue"),
)

# lower right - global reactive power by date/time
with(data, plot(Date, Global_reactive_power, type = "n",
                xlab = "datetime",
                ylab = "Global_reactive_power"))
with(data, lines(Date, Global_reactive_power))

# close out the file
dev.off()