#
# Ensure required libraries are available
#
ensureLibraries <- function() {
  if (!require(data.table)) {
    stop("The data.table package is required, but the package does not exist.")
  }
  
  if (!require(dplyr)) {
    stop("The dplyr package is required, but the package does not exist.")
  }
  
  if (!require(tidyr)) {
    stop("The tidyr package is required, but the package does not exist.")
  }
  
  if (!require(stringr)) {
    stop("The stringr package is required, but the package does not exist.")
  }
  
  if (!require(readr)) {
    stop("The readr package is required, but the package does not exist.")
  }

    if (!require(lubridate)) {
    stop("The lubridate package is required, but the package does not exist.")
  }
}

dataDir <- function() {
  path <- file.path(".", "data")
  if (!dir.exists(path)) {
    dir.create(path)
  }
  path
}

consumptionZipFile <- function() {
  file.path(dataDir(), "household_power_consumption.zip")
}

consumptionTxtFile <- function() {
  file.path(dataDir(), "household_power_consumption.txt")
}

#
# Download consumption file if it has not already been downloaded.
# Unzip the downloaded file to the data directory.
# Remove the zip file.
#
downloadConsumption <- function() {
  if(!file.exists(consumptionTxtFile())) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                  consumptionZipFile(), method="curl")
    unzip(consumptionZipFile(), exdir=dataDir())
    file.remove(consumptionZipFile())
  }
}

repairNumeric <- function(x) {
  if(x == "?") {
    NA
  } else {
    as.numeric(x)
  }
}

getConsumption <- function() {
  ensureLibraries()
  downloadConsumption()
  
  as_tibble(read.csv(consumptionTxtFile(), sep=";", header = TRUE) %>%
              filter(Date=="1/2/2007" |  Date=="2/2/2007") %>%
              mutate(date_time=strptime(sprintf("%s %s", Date, Time), format="%d/%m/%Y %H:%M:%S")) %>%
              mutate(Global_active_power=sapply(Global_active_power, repairNumeric),
                     Global_reactive_power=sapply(Global_reactive_power, repairNumeric),
                     Voltage=sapply(Voltage, repairNumeric),
                     Global_intensity=sapply(Global_intensity, repairNumeric),
                     Sub_metering_1=sapply(Sub_metering_1, repairNumeric),
                     Sub_metering_2=sapply(Sub_metering_2, repairNumeric),
                     Sub_metering_3=sapply(Sub_metering_3, repairNumeric)) %>%
              select(-Date, -Time))
}