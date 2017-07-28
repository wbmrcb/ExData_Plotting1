
colclasses <- c("character","character",
				"numeric", "numeric", "numeric", "numeric", 
				"numeric", "numeric", "numeric")

date1 <- as.Date("2007-02-01")
date2 <- as.Date("2007-02-02")

header <- read.table("household_power_consumption.txt",
					 header = FALSE,
					 colClasses = "character",
					 sep = ";",
					 nrows = 1)

data <- read.table("household_power_consumption.txt",
				   header = TRUE,
				   colClasses = colclasses,
				   sep = ";",
				   na.strings = "?",
				   skip = 66500,
				   nrows = 3500)

colnames(data) <- header

data$Date <- as.Date(data$Date, format="%d/%m/%Y")

data <- data[data[["Date"]] == date1 | data[["Date"]] == date2, ]

data$posix <- as.POSIXct(strptime(paste(data$Date, data$Time, sep = " "),
								  format = "%Y-%m-%d %H:%M:%S"))

png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power,
	 main = "Global Active Power",
	 xlab = "Global Active Power (killowatts)",
	 col = "red")
dev.off()
