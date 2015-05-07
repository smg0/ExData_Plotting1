# Loads the Individual household electric power consumption Data Set
# into a data.table
#
# Returns a data.table with observations for 2007-02-01 and 2007-02-02
loadDataSet <- function()
{
    # Load required packages
    require(data.table)
    require(dplyr)

    # Load the data.table
    data <- fread("household_power_consumption.txt",na.strings=c("?"))

    # Combine the Date and Time measurement to create a new DateTime variable
    data <- mutate(data,DateTime=paste(Date,Time))

    # Transform the columns to the correct type. DateTime is converted
    # to POSIXct, Date to Date. All other columns are converted to
    # numeric, which is necessary since fread sets the column class to
    # character even though na.strings was used to specify '?' as NA.
    data <- transform(data,
                      Date=as.Date(Date,format="%d/%m/%Y"),
                      DateTime=as.POSIXct(DateTime,format="%d/%m/%Y %H:%M:%S"),
                      Global_active_power=as.numeric(Global_active_power),
                      Global_reactive_power=as.numeric(Global_reactive_power),
                      Voltage=as.numeric(Voltage),
                      Global_intensity=as.numeric(Global_intensity),
                      Sub_metering_1=as.numeric(Sub_metering_1),
                      Sub_metering_2=as.numeric(Sub_metering_2),
                      Sub_metering_3=as.numeric(Sub_metering_3))

    # return a subset of the data for the two days of interest
    data[Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"),]
}

# Creates plot4
#
# data - Individual household electric power consumption Data Set
# observations for 2007-02-01 and 2007-02-02
plot4 <- function(data)
{
    # Select the png graphics device
    png(filename="plot4.png",width=480,height=480)

    # Create the required plots
    par(mfcol=c(2,2))
    with(data,
         {plot(DateTime,
               Global_active_power,
               type="n",
               xlab="",
               ylab="Global Active Power")
          lines(DateTime,Global_active_power)
          
          plot(DateTime,
               Sub_metering_1,
               type="n",
               xlab="",
               ylab="Energy sub metering")
          lines(DateTime,Sub_metering_1,col="black")
          lines(DateTime,Sub_metering_2,col="red")
          lines(DateTime,Sub_metering_3,col="blue")
          legend("topright",
                 col=c("black","red","blue"),
                 legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
                 lwd=1,
                 lty=c(1,1,1),
                 bty="n")
          
          plot(DateTime,
               Voltage,
               type="n",
               xlab="datetime")
          lines(DateTime,Voltage)
          
          plot(DateTime,
               Global_reactive_power,
               type="n",
               xlab="datetime")
          lines(DateTime,Global_reactive_power)
          })

    # Close the graphics device
    dev.off()
}

# Load the data set
data <- loadDataSet()

# Create the plot file
plot4(data)
