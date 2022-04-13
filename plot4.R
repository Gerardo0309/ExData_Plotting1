library(data.table)
library(ggplot2)
library(lubridate)
library(ggpubr)
setwd("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R")
data <- fread("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R/household_power_consumption.txt")
data$Date <- as.Date(data$Date, format ="%d/%m/%Y" )
class(data$Date)

data <- data[data$Date>= "2007/02/01",]
data <- data[data$Date <= "2007/02/02"]

data$Global_active_power <- as.double(data$Global_active_power)
data$Sub_metering_1 <- as.double(data$Sub_metering_1)
data$Sub_metering_2 <- as.double(data$Sub_metering_2)
data$Sub_metering_3 <- as.double(data$Sub_metering_3)
data$Voltage <- as.double(data$Voltage)
data$Global_reactive_power <- as.double(data$Global_reactive_power)

data$weekday <- with(data,ymd(Date)+hms(Time))




plot1 <- ggplot(data, aes(x= weekday,y= Global_active_power)) + geom_step()+ 
  labs(y="Global Active Power (kilowatts)",x="") +
  scale_x_datetime(date_breaks = 'day', date_labels = '%a \n%d %b')

plot2 <- ggplot(data, aes(x= weekday,y= Voltage)) + geom_step()+ 
  labs(y="Voltage",x="datetime") +
  scale_x_datetime(date_breaks = 'day', date_labels = '%a \n%d %b')

plot3 <- ggplot(data, aes(x= weekday)) +
  geom_line(aes(y= Sub_metering_1,colour = "Sub_metering_1")) +
  geom_line(aes(y=Sub_metering_2,colour = "Sub_metering_2")) + 
  geom_line(aes(y=Sub_metering_3,colour = "Sub_metering_3")) +
  scale_x_datetime(date_breaks = 'day', date_labels = '%a \n%d %b') +
  scale_color_manual("", breaks = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                     values =c("Sub_metering_1" ="black", "Sub_metering_2" ="red", "Sub_metering_3"="blue") )+
  labs(y="Energy sub metering", x= "")

plot4 <- ggplot(data, aes(x= weekday,y= Global_reactive_power)) + geom_step()+ 
  labs(y="Global reactive power",x="datetime") +
  scale_x_datetime(date_breaks = 'day', date_labels = '%a \n%d %b')
png("plot4.png", width = 480,height = 480)
ggarrange(plot1,plot2,plot3,plot4)

dev.off()
