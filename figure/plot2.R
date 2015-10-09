rm(list=ls())

setwd("/Users/carl/Projects/Coursera/coursera/Exploratory")

TwoDays <- 2 * 24 * 60 
SkipRows <- grep("^1/2/2007;00:00:00", readLines("household_power_consumption.txt"))
SkipRows <- SkipRows - 1

col_names <- read.table("household_power_consumption.txt", sep = ";", nrows=1, stringsAsFactors = FALSE, header = TRUE)

DF <- read.table("household_power_consumption.txt", sep = ";", 
                 skip = SkipRows, 
                 nrows = TwoDays, 
                 na.strings = c("?",""), 
                 stringsAsFactors = FALSE)

DF <- setNames(DF, c(names(col_names)))
remove(col_names)

DF$Date <- as.Date(DF$Date, format = "%d/%m/%Y")
DF$DateTime <- strptime(paste(DF$Date, DF$Time), "%Y-%m-%d %H:%M:%S")
DF$Time <- strptime(DF$DateTime, "%Y-%m-%d %H:%M:%S")
# done collecting and cleaning data

png(file = "plot2.png", width = 480, height = 480)

with(DF,
     plot(DateTime, Global_active_power,
          type = "l",
          ylab = "Global Active Power (kilowatts)",
          xlab = "")     )

dev.off()