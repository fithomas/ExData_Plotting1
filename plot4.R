# ****************************************************************************************************************
# Filename:       plot4.R 
# Description:    This program dowloads the data and creates the fourth plot as a png file.
# ****************************************************************************************************************

# set the language settings
Sys.setlocale("LC_ALL", "English")

# ****************************************************************************************************************
# 1) Get the data
# ****************************************************************************************************************

# Create a directory for the data, if it not exists
if(!file.exists("data")){
  dir.create("data")
}

# Download the household power consumption data, if it not exists
if(!file.exists("data/household_power_consumption.zip")){
  # Defines the download url
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url,"data/household_power_consumption.zip")  
}

# Get the data from the zipped file
if(file.exists("data/household_power_consumption.zip")){
  data<-read.table(unz("data/household_power_consumption.zip","household_power_consumption.txt"),sep=";",header=TRUE,na.strings="?")
  # Note, na.strings is set to "?"!
}else{
  stop("The required data is not available. Please check the download URL (https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip)")
}


# ****************************************************************************************************************
# 2) A short data check
# ****************************************************************************************************************

# Get the number of rows and columns
dim(data)
# > dim(data)
# [1] 2075259       9
# The number of rows and columns equals to the provided description.

# Get the column names
names(data)
# > names(data)
# [1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power" "Voltage"              
# [6] "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"        "Sub_metering_3"


# ****************************************************************************************************************
# 3) Prepare the data 
# ****************************************************************************************************************

# Convert the date
data$Date<-as.Date(data$Date, "%d/%m/%Y")

# Create a date/time attribute
data$DateTime<-strptime(paste(data$Date,data$Time,sep=" "), "%Y-%m-%d %H:%M:%S")

# Subset the data
data2<-data[data$Date >= "2007-02-01" & data$Date <= "2007-02-02",]



# ****************************************************************************************************************
# 4) Prepare the fourth plot, which should be a timesieries plot of energy sub metering 
# ****************************************************************************************************************

# Combine multiple plots
par(mfrow=c(2,2))

# 4a
with(data2,plot(DateTime,Global_active_power,type="n", main="",ylab="Global Active Power",xlab=""))
with(data2,lines(DateTime,Global_active_power,type="l"))

# 4b
with(data2,plot(DateTime,Voltage,type="n", main="",ylab="Voltage",xlab="datetime"))
with(data2,lines(DateTime,Voltage,type="l"))

# 4c
with(data2,plot(DateTime,Sub_metering_1,type="n", main="",ylab="Energy sub metering",xlab=""))
with(data2,lines(DateTime,Sub_metering_1,type="l"))
with(data2,lines(DateTime,Sub_metering_2,type="l",col="red"))
with(data2,lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n")

# 4d
with(data2,plot(DateTime,Global_reactive_power,type="n", main="",xlab="datetime"))
with(data2,lines(DateTime,Global_reactive_power,type="l"))

par(mfrow=c(1,1))


# ****************************************************************************************************************
# 5) Export the fourth plot 
# ****************************************************************************************************************

png("plot4.png", width=480, height=480, units="px")

par(mfrow=c(2,2))

# 4a
with(data2,plot(DateTime,Global_active_power,type="n", main="",ylab="Global Active Power",xlab=""))
with(data2,lines(DateTime,Global_active_power,type="l"))

# 4b
with(data2,plot(DateTime,Voltage,type="n", main="",ylab="Voltage",xlab="datetime"))
with(data2,lines(DateTime,Voltage,type="l"))

# 4c
with(data2,plot(DateTime,Sub_metering_1,type="n", main="",ylab="Energy sub metering",xlab=""))
with(data2,lines(DateTime,Sub_metering_1,type="l"))
with(data2,lines(DateTime,Sub_metering_2,type="l",col="red"))
with(data2,lines(DateTime,Sub_metering_3,type="l",col="blue"))
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col=c("black","red","blue"),lty=1,bty="n")

# 4d
with(data2,plot(DateTime,Global_reactive_power,type="n", main="",xlab="datetime"))
with(data2,lines(DateTime,Global_reactive_power,type="l"))

par(mfrow=c(1,1))


dev.off()

