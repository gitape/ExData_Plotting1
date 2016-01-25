cat("\014") # clear console

# Read data into variable 'powercons'
# (Assumes file "household_power_consumption.txt" is in your working directory to save bandwidth)
powercons <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Subset 2 days of data (Feb 1, 2007 and Feb 2, 2007)
powercons <- subset(powercons, Date=="1/2/2007" | Date=="2/2/2007")

# Convert powercons$Time from factor to Time type
dates <- powercons$Date
times <- powercons$Time
x <- paste(dates, times)
y <- strptime(x, "%d/%m/%Y %H:%M:%S")
powercons$Time <- y
rm("x", "y", "times", "dates") # Clear memory

# Convert powercons$Date from factor to Date type
powercons$Date <- as.Date(powercons$Date, "%d/%m/%Y")

# Convert powercons$Sub_metering_# to numeric
powercons$Sub_metering_1 <- as.numeric(levels(powercons$Sub_metering_1))[powercons$Sub_metering_1]
powercons$Sub_metering_2 <- as.numeric(levels(powercons$Sub_metering_2))[powercons$Sub_metering_2]


png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 10, res = 72)
with(powercons, plot(Time, Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(powercons, lines(Time, Sub_metering_1))
with(powercons, lines(Time, Sub_metering_2, col = "red"))
with(powercons, lines(Time, Sub_metering_3, col = "blue"))
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()



