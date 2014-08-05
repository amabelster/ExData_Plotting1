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

# Create the plot
# This code assumes that there is a "figure" folder in the working directory. The plot will be written to this folder
# First set the locale configuration to English, so that the names of the days appear in this language, like the plot
# given in the project
Sys.setlocale("LC_TIME", "English")
png(filename="figure/plot3.png", width = 480, height = 480, units = 'px')
with(data, plot(DateTime, Sub_metering_1, xlab="", ylab="Energy sub metering", type="l"))
with(data, lines(DateTime, Sub_metering_2, col="red"))
with(data, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", lty=c(1,1,1), col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.off()
