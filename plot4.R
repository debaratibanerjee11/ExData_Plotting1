
if (!file.exists("./household_power_consumption.txt")) {
  # download the data
  file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  file_name <- "household_power_consumption.zip"
  download.file(file_url, file_name, method = "curl")
  # unzip file
  unzip(file_name)
}
# read data
data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
# convert Date variable to Date class
data$Date <- as.Date(data$Date, "%d/%m/%Y")
# return subset data
data <- data[data$Date == "2007/02/01" | data$Date == "2007/02/02", ]



# plot4
with(data, {
  png(filename = "plot4.png")
  par(mfrow = c(2, 2))
  # 1st plot
  y <- data$Global_active_power
  x <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
  plot(x, y, type = "l", ylab = "Global Active Power", xlab = "")
  #2nd plot
  y <- data$Voltage
  x <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
  plot(x, y, type = "l", ylab = "Voltage", xlab = "datetime")
  #3rd plot
  x <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
  plot(x, data$Sub_metering_1, type = "n", ylab = "Energy sub metering", xlab = "")
  lines(x, data$Sub_metering_1, col = "black")
  lines(x, data$Sub_metering_2, col = "red")
  lines(x, data$Sub_metering_3, col = "blue")
  legend("topright", bty = "n", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  #4th plot
  y <- data$Global_reactive_power
  x <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")
  plot(x, y, type = "l", ylab = "Global_reactive_power", xlab = "datetime")
  dev.off()
})
