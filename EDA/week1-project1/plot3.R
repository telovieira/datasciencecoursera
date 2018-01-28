Sys.setlocale(category = "LC_TIME", locale = "English_United States.1252")
#Sys.getlocale("LC_TIME", locale = "Portuguese_Brazil.1252")

df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, dec = ".", stringsAsFactors=FALSE)
dsubdf <- subset(df, Date %in% c("1/2/2007","2/2/2007"))
dt <- strptime(paste(subdf$Date, subdf$Time, sep=" "), "%d/%m/%Y %H:%M:%S")

png("plot3.png", width=480, height=480)

plot(dt, subdf$Sub_metering_1, col = "black", type = "l", xlab="", ylab="Energy sub metering")
lines(dt, subdf$Sub_metering_2, col = "red")
lines(dt, subdf$Sub_metering_3, col = "blue")

legend('topright', legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black", "red", "blue"), cex = 0.8, lty=1, lwd=2.5,)

dev.off()
