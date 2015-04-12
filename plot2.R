plot2 <- function(){
     
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
     
     # Plot as png file: Global Active Power with chronological date/time on x-axis
     png(filename="plot2.png", width = 480, height = 480, units = "px")
     plot(datetime, as.numeric(consump2$Global_active_power), type="l", main="", xlab="", ylab="Global Active Power (kilowatts)")
     dev.off()
     
}