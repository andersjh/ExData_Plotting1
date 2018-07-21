library("dplyr")
library("lubridate")

plot3 = function() {
	pc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F)
	data = filter(pc, Date %in% c("1/2/2007","2/2/2007")) %>% 
	select(Date, Time, Global_active_power, Sub_metering_1, Sub_metering_2, Sub_metering_3)
	data[,1] <- dmy(data[,1])
	data[,3] <- as.numeric(data[,3])
	data[,4] <- as.numeric(data[,4])
	data[,5] <- as.numeric(data[,5])
	data <- mutate(data, datetime =  as.POSIXct(strptime(paste(Date, Time, sep=" "), "%Y-%m-%d %H:%M:%S")))
	rm(pc)
	png("plot3.png", width=480, height=480)
	with(data, plot(datetime, Sub_metering_1, type="l", col="black", xlab="", ylab="Energy Sub Metering"))
	with(data, lines(datetime, Sub_metering_2, type="l", col="red"))
	with(data, lines(datetime, Sub_metering_3, type="l", col="blue"))
	legend("topright", c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=2, lty=1, col=c("black","red","blue"))
	dev.off()
	
}