data <- read.csv('household_power_consumption.txt', sep=';')

# Convert to dates 
data$Date <- as.Date(as.character(data$Date), '%d/%m/%Y')

# Reduce set to required dates
data <- subset(data, (Date >= '2007-02-01') & (Date <= '2007-02-02'))

# Remove missing Global_active_power rows
data <- subset(data, Global_active_power != '?')

png(filename='plot1.png', width=480, height=480, units='px')
hist(as.numeric(as.character(data$Global_active_power)), 
                col='red',
                xlab='Global Active Power (kilowatts)', 
                main='Global Active Power')
dev.off()
