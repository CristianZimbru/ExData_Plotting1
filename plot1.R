  #Add data table  
  library(data.table)
  
  # Make sure that you set you current dir to the file folder or change the dbFile
  dbFile = "household_power_consumption.txt"
  	
  if(file.exists(dbFile)) {
    DB = fread(dbFile, sep=";", header=TRUE, na.string="?")
    
    # Setting the start date and end date for the interval 
    startDate = as.Date("2007-02-01")
    endDate = as.Date("2007-02-02")
    
    print("Selecting the records from 2007-02-01 & 2007-02-02 ...")
    # data - will contain the recods from the [startDate, endDate] interval
    data = DB[as.Date(strptime(DB$Date, format = "%d/%m/%Y")) >= startDate & 
                as.Date(strptime(DB$Date, format = "%d/%m/%Y")) <= endDate]
    
    print("Creating plot1.PNG file ...")
    png("plot1.png", width=480, height=480)
    
    hist(data$Global_active_power, xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = 'red', breaks = 12)
    
    dev.off()
    print("All Done!")
  } else {
    print("The file name doesn\'t exist")
  }