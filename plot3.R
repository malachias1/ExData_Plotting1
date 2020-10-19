source("getData.R")

plot3 <- function(consumption) {
  with(consumption, {
    plot(date_time, Sub_metering_1, xlab="", 
         ylab="Energy Sub-metering", 
         type="l", col="black")
    lines(date_time, Sub_metering_2, col="red")
    lines(date_time, Sub_metering_3, col="blue")
    legend("topright", 
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
           col=c("black", "red", "blue"),
           lty=c(1,1,1))
  })
}

buildPlot3 <- function() {
  consumption <- getConsumption()
  png("plot3.png")
  plot3(consumption)
  dev.off()
  dev.set(dev.prev())
}