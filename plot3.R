library(data.table)
library(ggplot2)
library(lubridate)
setwd("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R")
data <- fread("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R/household_power_consumption.txt")
data$Date <- as.Date(data$Date, format ="%d/%m/%Y" )
class(data$Date)

data <- data[data$Date>= "2007/02/01",]
data <- data[data$Date <= "2007/02/02"]

data$Sub_metering_1 <- as.double(data$Sub_metering_1)
data$Sub_metering_2 <- as.double(data$Sub_metering_2)
data$Sub_metering_3 <- as.double(data$Sub_metering_3)
data$weekday <- with(data,ymd(Date)+hms(Time))


png("plot3.png", width = 480,height = 480)

ggplot(data, aes(x= weekday)) +
  geom_line(aes(y= Sub_metering_1,colour = "Sub_metering_1")) +
  geom_line(aes(y=Sub_metering_2,colour = "Sub_metering_2")) + 
  geom_line(aes(y=Sub_metering_3,colour = "Sub_metering_3")) +
  scale_x_datetime(date_breaks = 'day', date_labels = '%a \n%d %b') +
  scale_color_manual("", breaks = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
                     values =c("Sub_metering_1" ="black", "Sub_metering_2" ="red", "Sub_metering_3"="blue") )+
  labs(y="Energy sub metering", x= "")

dev.off()
