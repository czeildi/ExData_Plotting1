library(plyr)
library(dplyr) #necessary for the use of mutate function

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", as.is = TRUE)
data <- mutate(data, Date = as.Date(Date, "%d/%m/%Y"))
data <- subset(data, subset = Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

#combining date and time columns into one column
data <- mutate(data, DateTime = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))

#opening connection with graphic device for plotting to png file
png(file = "plot4.png")

# for displaying 4 plots in a file
par(mfrow = c(2,2))

#1st plot
plot(data$DateTime,data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power, type = "l")

#2nd plot
plot(data$DateTime,data$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(data$DateTime, data$Voltage, type = "l")

#3rd plot
plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab=  "")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"),lwd = c(2,2,2), cex= 0.5)

#4th plot
plot(data$DateTime,data$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(data$DateTime, data$Global_reactive_power, type = "l")

#closing device
dev.off()
