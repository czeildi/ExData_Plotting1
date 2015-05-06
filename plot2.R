library(plyr)
library(dplyr) #this is necessary for the use of mutate

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", as.is = TRUE)
data <- mutate(data, Date = as.Date(Date, "%d/%m/%Y"))
data <- subset(data, subset = Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))

#combining date and time columns into one column
data <- mutate(data, DateTime = as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S"))

#opening a connection for plotting to png file
png(file = "plot2.png", width = 480, height = 480)

plot(data$DateTime,data$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$DateTime, data$Global_active_power, type = "l")

#closing device
dev.off()
