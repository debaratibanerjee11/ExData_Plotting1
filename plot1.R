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


# plot1
with(data, {
  png(filename = "plot1.png")
  hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()
})
