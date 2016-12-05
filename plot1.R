#Read in the semicolon delimited data, where "?" corresponds to missing data
#data columns are of class: character, character, numeric, numeric, numeric, numeric, numeric, numeric, numeric. 
power_consumption <- read.delim("household_power_consumption.txt",sep=";",na.strings = "?"
                               ,colClasses = c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#Subset the data by the two desired days and reasign to data variable
power_consumption <- power_consumption[power_consumption[,1]=="1/2/2007"|power_consumption[,1]=="2/2/2007",]

#Checked if there are any NA values in subsetted data:
#sum(is.na(power_consumption))
#[1] 0
#There are none. Thus, this check is omitted in subsequent scripts.

#Plot histogram of Global Active Power to screen as initial, exploratory graph
par(mfcol=c(1,1),mar=c(5,4,2,1))
hist(power_consumption[,3],main="Global Active Power",col="red",
     xlab = "Global Active Power (kilowatts)",cex.axis=0.75,cex.lab=0.75,cex.main=0.75)

#Output hist to 480 x 480 PNG picture file with resolution set to 100 to look better than default
par(mfcol=c(1,1),mar=c(5,4,2,1))
png(filename = "plot1.png",width = 480, height = 480,res = 100)
hist(power_consumption[,3],main="Global Active Power",col="red",
     xlab = "Global Active Power (kilowatts)",cex.axis=0.75,cex.lab=0.75,cex.main=0.75)

#Close the graphics device
dev.off()


