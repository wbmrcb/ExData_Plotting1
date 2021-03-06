
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

png("plot3.png", width = 480, height = 480)
plot(data$Sub_metering_1 ~ data$posix,
	 type = "l",
	 xlab = "",
	 ylab = "Energy sub metering",
	 col="black")
lines(data$Sub_metering_2 ~ data$posix,
	  col="red")
lines(data$Sub_metering_3 ~ data$posix,
	  col="blue")
legend("topright",
	   legend=c("Sub_metering_1",
	   		 "Sub_metering_2",
	   		 "Sub_metering_3"),
	   lwd=c(1,1,1), col=c("black","red", "blue"))
dev.off()
