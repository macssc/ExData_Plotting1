data <- read.csv('household_power_consumption.txt', sep=';')

# Convert to dates 
data$Date <- as.Date(as.character(data$Date), '%d/%m/%Y')

# Reduce set to required dates
data <- subset(data, (Date >= '2007-02-01') & (Date <= '2007-02-02'))

# Remove missing rows
data <- subset(data, Global_active_power != '?')
data <- subset(data, Sub_metering_1 != '?')
data <- subset(data, Sub_metering_2 != '?')
data <- subset(data, Sub_metering_3 != '?')

# Convert to 'floats'
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))
data$Sub_metering_1 <- as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2 <- as.numeric(as.character(data$Sub_metering_2))
# Sub_metering_3 is already numeric
data$Global_reactive_power <- as.numeric(as.character(data$Global_reactive_power))

# Add a column with the date and time
data$DateTime <- strptime(paste(data$Date, data$Time), '%Y-%m-%d %H:%M:%S')

png(filename='plot4.png', width=480, height=480, units='px')
par(mfrow=c(2,2))

#top left
with(data, plot(DateTime, Global_active_power, type='l', xlab = '', ylab= 'Global Active Power'))

#top right
with(data, plot(DateTime, Voltage, type='l'))

#bottom left
with(data, plot(DateTime, Sub_metering_1, type='l', xlab = '', ylab= 'Energy sub metering'))
with(data, points(DateTime, Sub_metering_2, type='l', col='red'))
with(data, points(DateTime, Sub_metering_3, type='l', col='blue'))
legend('topright', c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lwd='1')

# bottom right
with(data, plot(DateTime, Global_reactive_power, type='l'))
dev.off()
