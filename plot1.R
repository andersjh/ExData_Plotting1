library("dplyr")
library("lubridate")

plot1 = function() {
	pc <- read.table("household_power_consumption.txt", sep=";", header=T, stringsAsFactors = F)
	data = filter(pc, Date %in% c("1/2/2007","2/2/2007")) %>% select(Date, Global_active_power)
	data[,1] <- dmy(data[,1])
	data[,2] <- as.numeric(data[,2])
	rm(pc)
	png("plot1.png", width=480, height=480)
    hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
    dev.off()
	
}