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

# Plot 1 (will convert "?" to NAs, warning will occur)
x <- as.numeric(levels(powercons$Global_active_power))[powercons$Global_active_power]
png(filename = "plot1.png", width = 480, height = 480, units = "px", pointsize = 10, res = 72)
hist(x, col="red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()



