#Create the folder ./Data in the working directory:
if (!file.exists("Data")){
  dir.create("./Data")
}

#Download the zip file:
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destFile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destFile)
DateDownloaded <- date()

#Extract the zip file into ./Data:
unzip(zipfile=destFile, exdir="./Data")
#Deleting the zip file from the working directory:
file.remove(destFile)
#Getting the name of the extracted file:
fileName <- list.files("./Data")
fileName <- paste("./Data", fileName, sep='/')

#Read the extracted file:
data10row <- read.table(fileName, nrows=10, header=TRUE, sep=";", na.strings="?", quote="")
class <- sapply(data10row, class)
dataAll <- read.table(fileName, header=TRUE, sep=";", na.strings="?", quote="", colClasses=class)

#Subset dataAll into the dates 2007-02-01 and 2007-02-02:
use <- (dataAll$Date == "1/2/2007") | (dataAll$Date == "2/2/2007")
dataSubset <- dataAll[use,]

#Delete dataAll and free memory:
rm(dataAll)
gc(verbose=FALSE)

#Make and save plot 1:
png("Plot1.png", width = 480, height = 480, units = "px")
hist(dataSubset$Global_active_power, xlab="Global Active Power (kilowatts)", col="red", main="Global Active Power")
dev.off()
