Sys.setlocale(category = "LC_TIME", locale = "English_United States.1252")
#Sys.getlocale("LC_TIME", locale = "Portuguese_Brazil.1252")

df <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, dec = ".", stringsAsFactors=FALSE)
subdf <- subset(df, Date %in% c("1/2/2007","2/2/2007"))

dt <- strptime(paste(subdf$Date, subdf$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
gap <- as.numeric(subdf$Global_active_power)

png("plot2.png", width=480, height=480)

plot(dt , gap, xlab="", ylab="Global Active Power (kilowatts)", type = "l")
dev.off()
