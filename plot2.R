## Initial Analysis of Data Regarding Electric Power Consumption
## =====================================================================
## Assignment for: Exploratory Data Analysis
## Submitted by: ppgmg
##
########################################################################
##
## plot2.R
##
## This script reads in the dataset on Electic Power Consumption from the
## course website, extracts the records from the dates 2007-02-01 and
## 2007-02-02, and outputs a time series plot of Global Active Power to 
## a PNG file.
##
########################################################################
##
## Data Processing
##

## Loading the data
## The data is loaded directly from the URL provided

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")

## obtain data from raw text file
## note header row, semi-colon separators and NA strings as question marks

data <- read.table(unz(temp,"household_power_consumption.txt"), sep=";", stringsAsFactor=FALSE, header=TRUE, na.strings="?")
unlink(temp)

## Creating new data set prior to analysis
## First, we converted the data in the date column to data of Date class 
## to assist in the subsetting of the data.

data$Date <- as.Date(data$Date,format="%d/%m/%Y")

## We then selected only the rows corresponding to the dates of the interest, 
## and stored the data in a new variable *data2*:

data2 <- data[data$Date=="2007-02-01" | data$Date=="2007-02-02",]

## Next, we converted the data in the time column into POSIXlt format, using
## the date in the date column, and stored the result in a new column.

datetime <- paste(as.character(data2$Date),data2$Time,sep=" ")
datetime <- strptime(datetime, format="%Y-%m-%d %H:%M:%S")
data2 <- cbind(datetime, data2)   ## append new column to existing data table

#######################################################################
##
## Creating the Plot
## Plot 2: Time Series Plot of Global Active Power
##

## We created the plot and saved it to a PNG file (in the working directory)
## with a width of 480 pixels and a height of 480 pixels. 
## Note that the results may differ from what is saved to the PNG file 
## if shown on screen. 

## open new PNG file
png("plot2.png", width=480, height=480)   

## plot time series of global active power by day
plot(data2$datetime,data2$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## close graphics file
dev.off()

## output will be stored in plot2.png
