library(data.table)

#Reading the power data using data.table lib since it is fast using fread function 
power_data = fread(input = 'household_power_consumption.txt') 

#Converting the date column as date format for comparsion 
power_data[,Date := as.Date(Date,format = "%d/%m/%Y")]

selected_dates = c(as.Date('2007-02-01'), as.Date('2007-02-02'))

#filtering the power_data based on the selected dates

filtered_data = power_data[Date %in% selected_dates,]
filtered_data[,Global_active_power := as.numeric(Global_active_power)]
concat = paste(filtered_data$Date,filtered_data$Time,sep=' ') # concatenating date and time to convert it to a time format

totime = strptime(concat,"%Y-%m-%d %H:%M:%S") # to time format 

filtered_data[,Sub_metering_1 := as.numeric(Sub_metering_1)]
filtered_data[,Sub_metering_2 := as.numeric(Sub_metering_2)]
filtered_data[,Sub_metering_3 := as.numeric(Sub_metering_3)]

png('plot3.png',width = 480,height = 480,units = "px")
par(mfrow = c(1,1),mar = c(5,5,5,5))
plot(totime,filtered_data$Sub_metering_1,type = 'l',xlab = '',ylab = 'Energy sub metering')
points(totime,filtered_data$Sub_metering_2,type = 'l',col = 'red')
points(totime,filtered_data$Sub_metering_3,type = 'l',col = 'blue')
legend('topright', legend = c('Sub_metering_1','Sub_metering_2','Sub_metering_3'), lty = 1, col = c('black','red','blue'))
silent = dev.off()