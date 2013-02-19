####################################################
##Mini ScaleR vs Bigmemory package benchmark
##Using AirlineDataset of 2007 as dataset to benchmark test
##Test1 - Loading Data Times
##Test2 - Linear Regression
##Author: Julian Lee <julian.lee@revolutionanalytics.com>
####################################################


require(RevoScaleR)
require(bigmemory)
require(biganalytics)
require(biglm)

## filenames, location, etc. 
dataDir <- "D:/Datasets/"

midAirlineCsv <- file.path(dataDir, "Airline2007.csv")
midAirlineXdf <- file.path(dataDir, "Airline2007.xdf")


## define the csv file as a data source
airlineDataSource <- RxTextData(file=midAirlineCsv)

###########################################
##Test 1 - Loading Data####################

##ScaleR
system.time(rxImport(inData=airlineDataSource, outFile = midAirlineXdf, overwrite=TRUE))

##BigMemory
system.time(airlineBigAnalytics <- read.big.matrix(midAirlineCsv,header=T))

###########################################

###########################################
##Test 2 - Linear Regression on 2 Variables

##ScaleR
system.time(rxLinMod(ArrDelay ~ DepTime + Year, midAirlineXdf))

##Big Memory
system.time(blm <- biglm.big.matrix(ArrDelay ~ DepTime + Year, data=airlineBigAnalytics))

###########################################

##END OF TEST #############################

