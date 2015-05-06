library(plyr)
library(dplyr) #necessary for the use of mutate

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", as.is = TRUE)
data <- mutate(data, Date = as.Date(Date, "%d/%m/%Y"))
data <- subset(data, subset = Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

#combining date and time into one column
data <- mutate(data, DateTime = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))

#opening device for plotting to png file
png(file = "plot3.png", width = 480, height = 480)

plot(data$DateTime, data$Sub_metering_1, type = "l", col = "black", ylab = "Energy sub metering", xlab=  "")
lines(data$DateTime, data$Sub_metering_2, type = "l", col = "red")
lines(data$DateTime, data$Sub_metering_3, type = "l", col = "blue")
legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = c(1,1,1), col = c("black","red","blue"),lwd = c(2,2,2), cex= 0.5)

#closing device
dev.off()
