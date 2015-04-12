plot4 <- function(){
     
     # Set working directory ... (my working directory is commented out)
     # If nothing is set, then file will be downloaded to current working directory
     # setwd("C:/Users/6220/Documents/C04-ExploratoryDataAnalysis/ExData_Plotting1")
     
     # Install Packages if not done already
     # install.packages("data.table")
     
     filename <- "./exdata%2Fdata%2Fhousehold_power_consumption.zip"
     filename2 <- "household_power_consumption.txt"
     
     # Check if file has been downloaded to working directory
     # If not, the file is downloaded then unzipped
     if (!file.exists(filename)){
          download.file(url="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile=filename) 
          datedownload <- date()
          unzip(filename)
     }
     
     library(data.table)
     suppressWarnings(consump <- fread(filename2, header=TRUE, sep=";"))
     
     # consump2 is a new data table which is a subset only for the appropriate dates
     consump2 <- consump[as.Date(consump$Date, format="%d/%m/%Y")==as.Date("2007-02-01") | as.Date(consump$Date, format="%d/%m/%Y")==as.Date("2007-02-02")]
     
     # Consolidate the date & time for correct chronological format
     datetime <- strptime(paste(as.Date(consump2$Date, format="%d/%m/%Y"), consump2$Time), format="%Y-%m-%d %H:%M:%S")
     
     # Plot as png file: 4 graphs in one file
     png(filename="plot4.png", width = 480, height = 480, units = "px")
     par(mfrow=c(2,2))
     plot(datetime, as.numeric(consump2$Global_active_power), type="l", main="", xlab="", ylab="Global Active Power")
     plot(datetime, as.numeric(consump2$Voltage), type="l", main="", ylab="Voltage")
     plot(datetime, as.numeric(consump2$Sub_metering_1), type="n", xlab="", ylab="Energy sub metering")
     points(datetime, as.numeric(consump2$Sub_metering_1), type="l", col="black")
     points(datetime, as.numeric(consump2$Sub_metering_2), type="l", col="red")
     points(datetime, as.numeric(consump2$Sub_metering_3), type="l", col="blue")
     legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty="solid", lwd="1", bty="n")
     plot(datetime, as.numeric(consump2$Global_reactive_power), type="l", col="black", ylab="Global_reactive_power")
     dev.off()
     
}