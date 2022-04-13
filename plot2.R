library(data.table)
library(ggplot2)
library(lubridate)
setwd("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R")
data <- fread("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R/household_power_consumption.txt")
data$Date <- as.Date(data$Date, format ="%d/%m/%Y" )
class(data$Date)

data <- data[data$Date>= "2007/02/01",]
data <- data[data$Date <= "2007/02/02"]

data$Global_active_power <- as.double(data$Global_active_power)
data$weekday <- with(data,ymd(Date)+hms(Time))


png("plot2.png", width = 480,height = 480)

ggplot(data, aes(x= weekday,y= Global_active_power)) + geom_step()+ 
  labs(y="Global Active Power (kilowatts)",x="") +
  scale_x_datetime(date_breaks = 'day', date_labels = '%a \n%d %b')


dev.off()
