## Set the working directory
setwd("C:/Users/hsrirama/Documents/Personal/Coursera/Course 4 - Exploratory Data Analysis/Project")

## Unzip the file into 'data' folder if file doesn't exists
if (!file.exists("./data/household_power_consumption.txt")) {unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = "data")}

## Pull entire dataset into a data frame variable
my_data <- read.table("data/household_power_consumption.txt", sep = ";", header=TRUE, dec=".", stringsAsFactors=FALSE) 

## load the lubridate library to use the date functions
library(lubridate)

## filter to pull only the required data into another data frame
req_data <- subset (my_data, dmy(Date) >= dmy("01-02-2007") & dmy(Date) <= dmy("02-02-2007"))

## Draw the HISTOGRAM into the PNG file
## Need to convert the 'Sub Metering 1, 2 & 3' to numeric to get the required plot format
gap <- as.numeric(req_data$Global_active_power)

esm1 <- as.numeric(req_data$Sub_metering_1)
esm2 <- as.numeric(req_data$Sub_metering_2)
esm3 <- as.numeric(req_data$Sub_metering_3)

voltage <- as.numeric(req_data$Voltage)
grd <- as.numeric(req_data$Global_reactive_power)

dt <- strptime(paste(req_data$Date,  req_data$Time, sep =" "), "%d/%m/%Y %H:%M:%S")

## Open a PNG file handler
png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

## Section 1 
plot(dt, gap, type="l", ylab="Global Active Power", xlab="", cex=0.2)

## Section 2
plot(dt, voltage, type="l", ylab="Voltage", xlab="datetime")

## Section 3
plot(dt, esm1, type="l", ylab="Energy sub metering", xlab="")
lines(dt, esm2, type="l", col="red")
lines(dt, esm3, type="l", col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col = c("black", "red", "blue"), bty="o")

## Section 4
plot(dt, grd, type="l", ylab="Global_reactive_power", xlab="datetime")

## Close the file
dev.off()
