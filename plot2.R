data <- read.csv('household_power_consumption.txt', sep=';')

# Convert to dates 
data$Date <- as.Date(as.character(data$Date), '%d/%m/%Y')

# Reduce set to required dates
data <- subset(data, (Date >= '2007-02-01') & (Date <= '2007-02-02'))

# Remove missing Global_active_power rows
data <- subset(data, Global_active_power != '?')

# Convert to 'floats'
data$Global_active_power <- as.numeric(as.character(data$Global_active_power))

# Add a column with the date and time
data$DateTime <- strptime(paste(data$Date, data$Time), '%Y-%m-%d %H:%M:%S')

png(filename='plot2.png', width=480, height=480, units='px')
with(data, plot(DateTime, Global_active_power, type='l', xlab = '', ylab= 'Global Active Power (kilowatts)'))
dev.off()
