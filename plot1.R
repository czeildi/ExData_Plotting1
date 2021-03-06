library(plyr)
library(dplyr) #this is necessary for the use of mutate

data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, na.strings = "?", as.is = TRUE)
data <- mutate(data, Date = as.Date(Date, "%d/%m/%Y"))
data <- subset(data, subset = Date %in% c(as.Date("2007-02-01"),as.Date("2007-02-02")))
png(file = "plot1.png", width = 480, height = 480)
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab  = "Frequency")
dev.off()
