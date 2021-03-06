## First, set working directory

setwd("~/Desktop/Coursera/4explore/project1")

## Second, determine values for skip and nrows arguments of read.table()

time1 <- as.POSIXlt("2006-12-16 17:24:00")
time2 <- as.POSIXlt("2007-02-01 00:00:00")
time3 <- as.POSIXlt("2007-02-03 00:00:00")

skipminutes <- as.numeric(difftime(time2, time1, units = c("mins")))+1 
## +1 accounts for header
nrowminutes <- as.numeric(difftime(time3, time2, units = c("mins")))


## Third, read the data from 01/02/2007 to 02/02/2007

power <- read.table("household_power_consumption.txt", 
                    sep = ";",
                    ## specify col.names since header will be skipped
                    col.names = c("Date",
                                  "Time", 
                                  "Global_active_power", 
                                  "Global_reactive_power", 
                                  "Voltage", 
                                  "Global_intensity", 
                                  "Sub_metering_1", 
                                  "Sub_metering_2", 
                                  "Sub_metering_3"),
                    na.strings = "?",
                    skip = skipminutes, 
                    nrows = nrowminutes)


## Fourth, merge Date and Time columns into new Timestamp column

Timestamp <- (paste(power$Date, power$Time))
power <- cbind(power, Timestamp)


## Fifth, convert Timestamp column from character to date format

power$Timestamp <- strptime(power$Timestamp, "%d/%m/%Y %H:%M:%S")


## Sixth, create plot4.png

png(filename = "plot4.png")
par(mfrow = c(2, 2))
plot(power$Timestamp, 
     power$Global_active_power, 
     type = "l", 
     xlab = "", 
     ylab = "Global Active Power")
plot(power$Timestamp, 
     power$Voltage, 
     type = "l", 
     xlab = "datetime", 
     ylab = "Voltage")
with(power, plot(Timestamp, Sub_metering_1, 
                            type = "l", 
                            xlab = "", 
                            ylab = "Energy sub metering"))
with(power, lines(Timestamp, Sub_metering_2, col = "red"))
with(power, lines(Timestamp, Sub_metering_3, col = "blue"))
legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "blue", "red"), 
       lwd = c(1,1,1),
       bty = "n")
plot(power$Timestamp, 
     power$Global_reactive_power, 
     type = "l", 
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()