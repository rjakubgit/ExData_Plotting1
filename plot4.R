#Part1. Loading data


##Creating directory and downloading ziped file

if(!file.exists("data")){ dir.create("data")  }

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,destfile="./data/power_consumption.zip")


##Unziping file
unzip(zipfile="./data/power_consumption.zip",exdir="./data")


##Loading the required data to R
big_data <- read.table("./data/household_power_consumption.txt",sep=";", dec=".", header=TRUE, stringsAsFactors=FALSE)
data <- big_data[big_data$Date %in% c("1/2/2007","2/2/2007") ,]

rm("url","big_data")



#Part2. Creating png file


##Changing type of data (character to numeric)
GAP <- as.numeric(data$Global_active_power)

submet1 <- as.numeric(data$Sub_metering_1)
submet2 <- as.numeric(data$Sub_metering_2)
submet3 <- as.numeric(data$Sub_metering_3)

voltage <- as.numeric(data$Voltage)

GRP <- as.numeric(data$Global_reactive_power)


## Converting dates
D_T <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Sys.setlocale("LC_ALL", "English")


##Creating plot
par(mfcol = c(2, 2))

##figure1
plot(D_T, GAP, type="l", xlab="", ylab="Global Active Power")

##figure2
plot(D_T, submet1, type="l", ylab="Energy sub metering", xlab="")
lines(D_T, submet2, type="l", col="red")
lines(D_T, submet3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), 
		lty=1, lwd=1, cex=0.6, bty="n")

##figure3
plot(D_T, voltage, type="l", xlab="datetime", ylab="Voltage")

##figure4
plot(D_T, GRP, type="l", xlab="datetime", ylab="Global_reactive_power")

##Copying form screen to png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()