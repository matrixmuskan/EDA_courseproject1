library(data.table)

#Reading the power data using data.table lib since it is fast using fread function 
power_data = fread(input = 'household_power_consumption.txt') 

#Converting the date column as date format for comparsion 
power_data[,Date := as.Date(Date,format = "%d/%m/%Y")]

selected_dates = c(as.Date('2007-02-01'), as.Date('2007-02-02'))

#filtering the power_data based on the selected dates

filtered_data = power_data[Date %in% selected_dates,]
filtered_data[,Global_active_power := as.numeric(Global_active_power)]

png('plot1.png',width = 480,height = 480,units = "px")
par(mfrow = c(1,1),mar = c(5,5,5,5))
hist(filtered_data$Global_active_power,col = 'red',main = 'Global Active Power',xlab = 'Global Active Power(kilowatts)',ylab = 'Frequency')
silent = dev.off()
