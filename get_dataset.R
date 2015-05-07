# Downloads and unzips the Individual household electric power
# consumption Data Set
get_dataset <- function()
{
    # Download the data set archive if not present
    if(!file.exists("household_power_consumption.zip"))
    {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      "household_power_consumption.zip",
                      method="curl")
        
        # store download timestamp
        fd<-file("household_power_consumption_timestamp.txt")
        writeLines(date(), fd)
        close(fd)
    }
    
    # Unzip the archive data if not present
    if(!file.exists("household_power_consumption.txt"))
    {
        unzip("household_power_consumption.zip")
    }
}

# Run the download upon loading of this script
get_dataset()
