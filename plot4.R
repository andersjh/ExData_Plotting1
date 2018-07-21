library("dplyr")
library("lubridate")

plot4 = function() {
	pc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F)
	data = filter(pc, Date %in% c("1/2/2007","2/2/2007")) %>% 
	select(Date, Time, Global_active_power, Sub_metering_1, Sub_metering_2, Sub_metering_3, Global_reactive_power,Voltage)
	data[,1] <- dmy(data[,1])
	data[,3] <- as.numeric(data[,3])
	data[,4] <- as.numeric(data[,4])
	data[,5] <- as.numeric(data[,5])
	data[,6] <- as.numeric(data[,6])
	data[,7] <- as.numeric(data[,7])
	data <- mutate(data, datetime =  as.POSIXct(strptime(paste(Date, Time, sep=" "), "%Y-%m-%d %H:%M:%S")))
	rm(pc)
	png("plot4.png", width=480, height=480)
	par(mfcol = c(2,2))
	# first plot
	with(data, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
    # second plot
	with(data, plot(datetime, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy Sub Metering"))
	with(data, lines(datetime, Sub_metering_2, type="l", col="red"))
	with(data, lines(datetime, Sub_metering_3, type="l", col="blue"))
	legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=2, lty=1, col=c("black","red","blue"))
	# third plot
	with(data, plot(datetime, Voltage, type="l"))
	# fourth plot
	with(data, plot(datetime, Global_reactive_power, type="l"))
	dev.off()
	#par(mfcol=c(1,1))
	
}