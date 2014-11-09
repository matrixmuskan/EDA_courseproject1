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


png('plot2.png',width = 480,height = 480,units = "px")
par(mfrow = c(1,1),mar = c(5,5,5,5))
plot(totime,filtered_data$Global_active_power,type = 'l',xlab = '',ylab = 'Global Active Power (kilowatts)')
silent = dev.off()


