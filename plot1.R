## First, Set working directory

setwd("~/Desktop/Coursera/4explore/project1/ExData_Plotting1")


## Second, determine values for skip and nrows arguments

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


## Fourth, create plot1.png

png(filename = "plot1.png")
hist(power$Global_active_power, main = "Global Active Power", 
                                xlab = "Global Active Power (kilowatts)", 
                                col = "red")
dev.off()