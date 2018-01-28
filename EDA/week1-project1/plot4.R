Sys.setlocale(category = "LC_TIME", locale = "English_United States.1252")
#Sys.getlocale("LC_TIME", locale = "Portuguese_Brazil.1252")

df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, dec = ".", stringsAsFactors=FALSE)
subdf <- subset(df, Date %in% c("1/2/2007","2/2/2007"))

png("plot4.png", width=480, height=480)
par(mfrow = c(2,2))

#plot 1
dt <- strptime(paste(subdf$Date, subdf$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
gap <- as.numeric(subdf$Global_active_power)
plot(dt , gap, xlab="", ylab="Global Active Power (kilowatts)", type = "l")

# plot 2
vo <- as.numeric(subdf$Voltage)
plot(dt , vo, xlab="", ylab="Voltage", type = "l")

# plot 3
plot(dt, subdf$Sub_metering_1, col = "black", type = "l", xlab="", ylab="Energy sub metering")
lines(dt, subdf$Sub_metering_2, col = "red")
lines(dt, subdf$Sub_metering_3, col = "blue")


# plot 4
grp <- as.numeric(subdf$Global_reactive_power)
plot(dt , grp, xlab="", ylab="Global Reactive Power", type = "l")

dev.off()