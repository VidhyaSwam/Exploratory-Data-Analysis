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
png("plot2.png", width=480, height=480)

## Draw the HISTOGRAM into the PNG file
## Need to convert the 'Global_active_power' to numeric to get the required plot format
gap <- as.numeric(req_data$Global_active_power)/1000
dt <- strptime(paste(req_data$Date,  req_data$Time, sep =" "), "%d/%m/%Y %H:%M:%S")

plot(dt, gap, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## Close the file
dev.off()
