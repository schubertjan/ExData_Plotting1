library(lubridate)
library(dplyr)

#read the data and format date
setwd("~/Data_Science/Exploratory_Data")
epc <- tbl_df(read.csv("household_power_consumption.txt", sep = ";", stringsAsFactors = F))
epc$Date <- dmy(epc$Date)

#filter data and format other variables
epc <- filter(epc, Date == "2007-02-01" | Date == "2007-02-02")
epc$Date_time <- ymd_hms(paste(epc$Date,epc$Time,sep = "-"))
epc$Global_active_power[epc$Global_active_power == "?"] <- NA; epc$Global_active_power <- as.numeric(epc$Global_active_power)
epc$Global_reactive_power[epc$Global_reactive_power == "?"] <- NA; epc$Global_reactive_power <- as.numeric(epc$Global_reactive_power)
epc$Global_intensity[epc$Global_intensity == "?"] <- NA; epc$Global_intensity <- as.numeric(epc$Global_intensity)
epc$Voltage[epc$Voltage == "?"] <- NA; epc$Voltage <- as.numeric(epc$Voltage)
epc$Sub_metering_1[epc$Sub_metering_1 == "?"] <- NA; epc$Sub_metering_1 <- as.numeric(epc$Sub_metering_1)
epc$Sub_metering_2[epc$Sub_metering_2 == "?"] <- NA; epc$Sub_metering_2 <- as.numeric(epc$Sub_metering_2)
epc$Sub_metering_3[epc$Sub_metering_3 == "?"] <- NA; epc$Sub_metering_3 <- as.numeric(epc$Sub_metering_3)


#create the plot
setwd(paste0(getwd(),"/ExData_Plotting1"))
png("plot4.png")
par(mfrow = c(2,2))
with(epc,plot(Date_time,Global_active_power, 
              ylab = "Global Active Power (kilowatts)",
              xlab = "",
              type = "l"))
with(epc,plot(Date_time,Voltage, 
              xlab = "datetime",
              type = "l"))
with(epc,plot(Date_time,Sub_metering_1, 
              ylab = "Energy sub metering",
              xlab = "",
              type = "l"))
  with(epc,lines(Date_time,Sub_metering_2,col = "red"))
  with(epc,lines(Date_time,Sub_metering_3,col = "blue"))
  legend("topright",lty = 1,col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty = "n")
with(epc,plot(Date_time,Global_reactive_power, 
              xlab = "datetime",
              type = "l"))
dev.off()