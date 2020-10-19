source("getData.R")

buildPlot1 <- function() {
  consumption <- getConsumption()
  png("plot1.png")
  hist(consumption$Global_active_power, xlab="Global Active Power (kilowatts)", 
       main="Global Active Power", col="red")
  dev.off()
  dev.set(dev.prev())
}