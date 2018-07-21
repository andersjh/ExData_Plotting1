library("dplyr")
library("lubridate")

plot2 = function() {
	pc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F)
	data = filter(pc, Date %in% c("1/2/2007","2/2/2007")) %>% select(Date, Time, Global_active_power)
	data[,1] <- dmy(data[,1])
	data[,3] <- as.numeric(data[,3])
	data <- mutate(data, datetime =  as.POSIXct(strptime(paste(Date, Time, sep=" "), "%Y-%m-%d %H:%M:%S")))
	rm(pc)
	png("plot2.png", width=480, height=480)
	with(data, plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
	dev.off()
	
}