source("plot2.R")
source("plot3.R")

buildPlot4 <- function() {
  consumption <- getConsumption()
  png("plot4.png")
  par(mfcol=c(2,2))
  plot2(consumption)
  plot3(consumption)
  with(consumption,
       plot(date_time, Voltage, type="l"))
  with(consumption,
       plot(date_time, Global_reactive_power, type="l"))
  dev.off()
  dev.set(dev.prev())
}