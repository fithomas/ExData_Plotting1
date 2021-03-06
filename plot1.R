# ****************************************************************************************************************
# Filename:       plot1.R 
# Description:    This program dowloads the data and creates the first plot as a png file.
# ****************************************************************************************************************

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
# 4) Prepare the first plot, which should be a histogram of global active power 
# ****************************************************************************************************************

with(data2,hist(Global_active_power,col="red",breaks=25,xlab="Global Active Power (kilowatts)",main="Global Active Power"))


# ****************************************************************************************************************
# 5) Export the first plot 
# ****************************************************************************************************************

png("plot1.png", width=480, height=480, units="px")
with(data2,hist(Global_active_power,col="red",breaks=25,xlab="Global Active Power (kilowatts)",main="Global Active Power"))
dev.off()

