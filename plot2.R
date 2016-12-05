#Data table needed for more efficient creation of data+time merged variable
library(data.table)

#Read in the semicolon delimited data, where "?" corresponds to missing data
#data columns are of class: character, character, numeric, numeric, numeric, numeric, numeric, numeric, numeric. 
power_consumption <- read.table("household_power_consumption.txt",header = T,sep=";",na.strings = "?"
                                ,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#Subset the data by the two desired days and reasign to data variable
power_consumption <- power_consumption[power_consumption$Date=="1/2/2007"|power_consumption$Date=="2/2/2007",]

#convert dates to Date objects. Takes time, so more efficient to do after subsetting data as done above.
#understanding as.POSIXct() gave the desired result of showing day names Thu, Fri, and Sat.
power_consumption$Date <- as.Date(power_consumption$Date, "%d/%m/%Y")
#Convert data to data table "by reference", so no copy made
setDT(power_consumption)
power_consumption[, Date_Time:= as.POSIXct(paste(power_consumption$Date, power_consumption$Time), format = "%Y-%m-%d %H:%M:%S")]

#Plot Global Active Power vs. day/time to screen as initial, exploratory graph
par(mfcol=c(1,1),mar=c(5,4,2,1))
with(power_consumption, plot(Date_Time, Global_active_power, type = "l",
                             ylab = "Global Active Power (kilowatts)", xlab = ""))

#Output plot to 480 x 480 png picture file with resolution set to 100 to look better than default
par(mfcol=c(1,1),mar=c(5,4,2,1))
png(filename = "plot2.png",width = 480, height = 480,res = 100)
with(power_consumption, plot(Date_Time, Global_active_power, type = "l",
                             ylab = "Global Active Power (kilowatts)", xlab = ""))

#Close the graphics device
dev.off()

