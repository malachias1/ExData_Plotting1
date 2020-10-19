source("getData.R")

plot2 <- function(consumption) {
  with(consumption,
       plot(date_time, Global_active_power, ylab="Global Active Power (kilowatts)", 
            type="l"))
}

buildPlot2 <- function() {
  consumption <- getConsumption()
  png("plot2.png")
  plot2(consumption)
  dev.off()
  dev.set(dev.prev())
}