####Week 13 Peer Project JHU Data Science
###Plot 2

#exploraty anylsis of data within date range 2007-02-01 - 2007-02-02


##create subdirectory for storing the files

filedirpath <- "./week13"

if(!file.exists(filedirpath)){
    dir.create(filedirpath)
}




##download data 

onlinedatapath <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"



zipfilepath <- "./week13/powerconsumption.zip"

if(!file.exists(zipfilepath)){
    download.file(onlinedatapath, zipfilepath)
}

rm(onlinedatapath)





##unzip file
#I was getting errors if I tried to read the file without unzipping

unzipfilepath <- paste(filedirpath, "/household_power_consumption.txt", sep = "")

if(!file.exists(unzipfilepath)){
    unzip(zipfilepath, exdir = filedirpath)
}


rm(zipfilepath)    



##read data from zip file

#find the rows within the date range
firstrow <- grep("1/2/2007", readLines(unzipfilepath))[1]

lastrow <- grep("3/2/2007", readLines(unzipfilepath))[1] - 1

#calculate the total rows
totalrows <- lastrow - firstrow + 1

#read unzipped file
powerdata <- read.table(unzipfilepath, header = F, sep=";", skip = (firstrow - 1), nrows = totalrows, na = "?")

#read header data
headerdata <- read.table(unzipfilepath, header = T, sep=";", nrows = 1, na = "?")

#adding column names
colnames(powerdata) <- colnames(headerdata)
rm(headerdata, firstrow, lastrow, totalrows, unzipfilepath)



## Cleaning data

#creating date time from Date and Time Columns
powerdata$DateTime <- strptime(paste(powerdata$Date, powerdata$Time), "%e/%m/%Y %H:%M:%S")

powerdata$Date <- strptime(powerdata$Date, "%e/%m/%Y")

powerdata$Time <- strptime(powerdata$Time, "%H:%Y:%S")


## Creating plot

plot(powerdata$DateTime, powerdata$Global_active_power,  type = "n", ylab = "Global Active Power (kilowatts)", xlab = "")

lines(powerdata$DateTime, powerdata$Global_active_power)






##Outputting plot as png
outputfilepath <- paste(filedirpath, "/plot2.png", sep = "")

dev.copy(png, filename = outputfilepath, height = 480, width = 480, units = "px")
dev.off()








