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


##Changing type of data(character to numeric)
GAP <- as.numeric(data$Global_active_power)

## Converting dates
D_T <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
Sys.setlocale("LC_ALL", "English")


##Creating plot
plot(D_T, GAP, type="l", xlab="", ylab="Global Active Power (kilowatts)")

##Copying form screen to png file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()