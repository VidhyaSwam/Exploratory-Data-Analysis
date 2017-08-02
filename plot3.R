## Set the working directory
setwd("C:/Users/hsrirama/Documents/Personal/Coursera/Course 4 - Exploratory Data Analysis/Project")

## Unzip the file into 'data' folder if file doesn't exists
if (!file.exists("./data/household_power_consumption.txt")) {unzip("exdata%2Fdata%2Fhousehold_power_consumption.zip", exdir = "data")}

## Pull entire dataset into a data frame variable
my_data <- read.table("data/household_power_consumption.txt", sep = ";", header=TRUE) 

## load the lubridate library to use the date functions
library(lubridate)

## filter to pull only the required data into another data frame
req_data <- subset (my_data, dmy(Date) >= dmy("01-02-2007") & dmy(Date) <= dmy("02-02-2007"))

## Open a PNG file handler
png("plot3.png", width=480, height=480)

## Draw the HISTOGRAM into the PNG file
## Need to convert the 'Sub Metering 1, 2 & 3' to numeric to get the required plot format
esm1 <- as.numeric(req_data$Sub_metering_1)
esm2 <- as.numeric(req_data$Sub_metering_2)
esm3 <- as.numeric(req_data$Sub_metering_3)
dt <- strptime(paste(req_data$Date,  req_data$Time, sep =" "), "%d/%m/%Y %H:%M:%S")

plot(dt, esm1, type="l", ylab="Energy sub metering", xlab="",ylim = c(0,40))
lines(dt, esm2, type="l", col="red")
lines(dt, esm3, type="l", col="blue")

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

## Close the file
dev.off()
