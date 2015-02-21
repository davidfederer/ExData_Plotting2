setwd("/Users/DAVIDandHILA/Documents/David/Coursera/Practical Machine Learning")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_em <- with(data=NEI, aggregate(Emissions, list(year), sum))

png(filename="plot1.png")
plot(total_em, type="b", main = "Total PM2.5 Emissions in the US Between 1999 and 2008", xlab = "Year", ylab = "PM2.5 Emissions (tons)")
dev.off()