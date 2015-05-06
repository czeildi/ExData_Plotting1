library(plyr)
library(dplyr)

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", as.is = TRUE)
data <- mutate(data, Date = as.Date(Date, "%d/%m/%Y"))
data <- subset(data, subset = Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

data <- mutate(data, DateTime = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))
png(file = "plot2.png", width = 480, height = 480)
par(pty = "s")
plot(data$DateTime,data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power, type = "l")
dev.off()
