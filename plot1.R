library(data.table)
library(ggplot2)
setwd("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R")
data <- fread("C:/Users/GerardoMora/OneDrive - CONTRATOS Y SERVICIOS PF SA DE CV/Escritorio/R/household_power_consumption.txt")
data$Date <- as.Date(data$Date, format ="%d/%m/%Y" )
class(data$Date)

data <- data[data$Date>= "2007/02/01",]
data <- data[data$Date <= "2007/02/02"]

data$Global_active_power <- as.double(data$Global_active_power)
data$Global_active_powe_range <- ifelse(data$Global_active_power<1,0,
                                        ifelse(data$Global_active_power<2,1,
                                        ifelse(data$Global_active_power<3,2,
                                        ifelse(data$Global_active_power<4,3,
                                        ifelse(data$Global_active_power<5,4,
                                        ifelse(data$Global_active_power<6,5,
                                        ifelse(data$Global_active_power<7,6,
                                        ifelse(data$Global_active_power<8,7))))))))

png("plot1.png", width = 480,height = 480)

ggplot(data, aes(x= Global_active_powe_range)) + 
  geom_histogram(binwidth = 0.5, color= "black", fill = "red") +
  
labs(title = "Global Active Power", x= "Global Active Power (kilowatts)", 
     y="Frequency" )
dev.off()
