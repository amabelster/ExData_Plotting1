# Read the data
# This code assumes that the data file is in a "Data" folder in the working directory
#
# Since we only need the data from two days (1/2/2007 and 2/2/2007), this code reads
# only these data
library(sqldf)
fn<-"Data\\household_power_consumption.txt"
data <- read.csv.sql(fn, sep=";", sql = 'select * from file where Date = "1/2/2007" or Date = "2/2/2007"')

# Alternatively, if memory isn't a problem you could load all the data and then subset
# the data needed for the project
data.all <- read.table(fn, sep=";", header=TRUE, na.strings = "?", stringsAsFactors = FALSE)
data <- subset(data.all, data.all$Date %in% c("1/2/2007", "2/2/2007"))

# convert Date and Time to DateTime with POSIXlt format
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

# Plot 1
# the plot will be saved in a "figure" folder in the working directory
png(filename="figure/plot1.png", width = 480, height = 480, units = 'px')
hist(data$Global_active_power, main="Global Active Power", xlab="Global Active Power (kilowatts)", col="red")
dev.off()