#Data table needed for more efficient creation of data+time merged variable
library(data.table)

#Read in the semicolon delimited data, where "?" corresponds to missing data
#data columns are of class: character, character, numeric, numeric, numeric, numeric, numeric, numeric, numeric. 
power_consumption <- read.delim("household_power_consumption.txt",sep=";",na.strings = "?"
                                ,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))
#Subset the data by the two desired days and reasign to data variable
power_consumption <- power_consumption[power_consumption[,1]=="1/2/2007"|power_consumption[,1]=="2/2/2007",]

#convert dates to Date objects. Takes time, so more efficient to do after subsetting data as done above.
#understanding as.POSIXct() gave the desired result of showing day names Thu, Fri, and Sat.
power_consumption$Date <- as.Date(power_consumption$Date, "%d/%m/%Y")
#Convert data to data table "by reference", so no copy made
setDT(power_consumption)
power_consumption[, Date_Time:= as.POSIXct(paste(power_consumption$Date, power_consumption$Time), format = "%Y-%m-%d %H:%M:%S")]

#Plot Energy submetering vs. day/time to screen as initial, exploratory graph
par(mfcol=c(1,1),mar=c(5,4,2,1))
#First "empty" graph to setup axes and labels. Use first variable, Sub_metering_1 to define y-axis range
with(power_consumption, plot(Date_Time, Sub_metering_1, type = "n",
                ylab = "Energy sub metering", xlab = ""))
#Now plot the points/lines. Used the function lines() for smooth plots
with(power_consumption,lines(Date_Time,Sub_metering_1,col="black"))
with(power_consumption,lines(Date_Time,Sub_metering_2,col="red"))
with(power_consumption,lines(Date_Time,Sub_metering_3,col="blue"))
#Plot the legend in top right corner, made size a little smaller than default with cex
#Had to define line width for them to even appear
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col=c("black","red","blue"),lwd=1,cex=0.65)

#Output plot to 480 x 480 png picture file with resolution set to 100 to look better than default
par(mfcol=c(1,1),mar=c(5,4,2,1))
png(filename = "plot3.png",width = 480, height = 480,res = 100)
#First "empty" graph to setup axes and labels. Use first variable, Sub_metering_1 to define y-axis range
with(power_consumption, plot(Date_Time, Sub_metering_1, type = "n",
                             ylab = "Energy sub metering", xlab = ""))
#Now plot the points/lines. Used the function lines() for smooth plots
with(power_consumption,lines(Date_Time,Sub_metering_1,col="black"))
with(power_consumption,lines(Date_Time,Sub_metering_2,col="red"))
with(power_consumption,lines(Date_Time,Sub_metering_3,col="blue"))
#Plot the legend in top right corner, made size a little smaller than default with cex
#Had to define line width for them to even appear
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col=c("black","red","blue"),lwd=1,cex=0.65)

#Close the graphics device
dev.off()
