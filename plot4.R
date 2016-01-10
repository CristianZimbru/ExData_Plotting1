  #Add data table  
  library(data.table)
  
  # Make sure that you set you current dir to the file folder or change the dbFile
  dbFile = "household_power_consumption.txt"
	
  if(file.exists(dbFile)){
    DB = fread(dbFile, sep=";", header=TRUE, na.string="?")
    
    # Setting the start date and end date for the interval 
    startDate = as.Date("2007-02-01")
    endDate = as.Date("2007-02-02")
    
    print("Selecting the records from 2007-02-01 & 2007-02-02 ...")
    # data - will contain the recods from the [startDate, endDate] interval
    data = DB[as.Date(strptime(DB$Date, format = "%d/%m/%Y")) >= startDate & 
                as.Date(strptime(DB$Date, format = "%d/%m/%Y")) <= endDate]
    
    datetime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
    
    print("Creating plot4.PNG file ...")
    png("plot4.png", width=480, height=480)
    
    par(mfrow = c(2,2))
    
    # First plot(left-top)
    plot(datetime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power")
    
    # Second plot(right - top)
    plot(datetime, data$Voltage, type="l", xlab="datetime", ylab="Voltage")
    
    # Third plot (left-bottom)
    plot(datetime ,data$Sub_metering_1, ylab = "Energy sub metering", type = "l", xlab="")
    lines(datetime, data$Sub_metering_2, type = "l", col="red")
    lines(datetime, data$Sub_metering_3, col = "blue")
    legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=1.5, col=c("black", "red", "blue"))
    
    # Forth plot (right-bottom)
    plot(datetime, data$Global_reactive_power, ylab="Global_reactive_power",xlab="datetime", type="l")
    
    # Close file
    dev.off()
    print("All Done!")
  } else {
    print("The file name doesn\'t exist")
  }