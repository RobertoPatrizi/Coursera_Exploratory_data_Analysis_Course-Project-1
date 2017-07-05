# Course: Exploratory Data Analysis
# Week 1 - Assignment: Course Project 1

## loading useful packages
library(data.table)
library(dplyr)

## setting working directory for R programs
wdir <- "G://Anno 2017/Johns_Hopkins_Data_Science/4. Exploratory Data Analysis/Developments"
setwd(wdir)

## source file
f1 <- "household_power_consumption.txt"

# load source file
power_dt <- data.table::fread(f1
            , sep = ';' , dec = '.'
            , stringsAsFactors = FALSE
            , header = TRUE
            , nrows = -1L
            , na.strings = "NA"
            , colClasses = 
                c(rep('character', 9)))

power_dt <- 
    power_dt[power_dt$Date %in% 
                 c("1/2/2007","2/2/2007") ,]

Date_Time <- strptime(paste(power_dt$Date
                    , power_dt$Time
                    , sep = ' ')
            , "%d/%m/%Y %H:%M:%S") 

Date_Time <- as.POSIXct(Date_Time)
power_dt <- select(power_dt, -Date, -Time)
power_dt <- cbind(Date_Time, power_dt)

# making Plot 3
png("plot3.png"
    , width=480
    , height=480)

gap <- as.numeric(power_dt$Global_active_power)

subMeter1 <- 
    as.numeric(power_dt$Sub_metering_1)
subMeter2 <- 
    as.numeric(power_dt$Sub_metering_2)
subMeter3 <- 
    as.numeric(power_dt$Sub_metering_3)

plot(power_dt$Date_Time
     , subMeter1
     , type="l"
     , ylab="Energy Submetering", xlab="")

lines(power_dt$Date_Time
      , subMeter2
      , type="l", col="red")

lines(power_dt$Date_Time
      , subMeter3
      , type="l", col="blue")

legend("topright"
       , c("Sub_metering_1"
           , "Sub_metering_2"
           , "Sub_metering_3")
       , lty = 1, lwd = 2.5
       , col = c("black", "red", "blue"))

dev.off()

