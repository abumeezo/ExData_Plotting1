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

#Plot four panels to screen as initial, exploratory graph
par(mfcol=c(2,2))

#Plot from plot2.R
with(power_consumption, plot(Date_Time, Global_active_power, type = "l",
                             ylab = "Global Active Power", xlab = "",cex.lab=1))

#Plot from plot3.R
with(power_consumption, plot(Date_Time, Sub_metering_1, type = "n",
                             ylab = "Energy sub metering", xlab = ""))
with(power_consumption,lines(Date_Time,Sub_metering_1,col="black"))
with(power_consumption,lines(Date_Time,Sub_metering_2,col="red"))
with(power_consumption,lines(Date_Time,Sub_metering_3,col="blue"))
#Remove legend border as seen in course assignment with bty="n"
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col=c("black","red","blue"),lwd=1,cex=0.65,bty="n")

#Now voltage plot
with(power_consumption,plot(Date_Time,Voltage,type="n",xlab="datetime"))
with(power_consumption,lines(Date_Time,Voltage,col="black"))

#Finally, Global reactive power plot
with(power_consumption,plot(Date_Time,Global_reactive_power,type="n",xlab="datetime"))
with(power_consumption,lines(Date_Time,Global_reactive_power,col="black"))

#Output plot to 480 x 480 png picture file with resolution set to 100 to look better than default
png(filename = "plot4.png",width = 480, height = 480,res = 100)
#par mfcol setting must occur after png() call, appears that it resets it to default
par(mfcol=c(2,2),mar=c(4,4,2,1.5))
with(power_consumption, plot(Date_Time, Global_active_power, type = "l",
                             ylab = "Global Active Power", xlab = "",cex.lab=1))

#Plot from plot3.R
with(power_consumption, plot(Date_Time, Sub_metering_1, type = "n",
                             ylab = "Energy sub metering", xlab = ""))
with(power_consumption,lines(Date_Time,Sub_metering_1,col="black"))
with(power_consumption,lines(Date_Time,Sub_metering_2,col="red"))
with(power_consumption,lines(Date_Time,Sub_metering_3,col="blue"))
#Remove legend border as seen in course assignment with bty="n"
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
       ,col=c("black","red","blue"),lwd=1,cex=0.65,bty="n")

#Now voltage plot
with(power_consumption,plot(Date_Time,Voltage,type="n",xlab="datetime"))
with(power_consumption,lines(Date_Time,Voltage,col="black"))

#Finally, Global reactive power plot
with(power_consumption,plot(Date_Time,Global_reactive_power,type="n",xlab="datetime"))
with(power_consumption,lines(Date_Time,Global_reactive_power,col="black"))

#Close the graphics device
dev.off()
     
