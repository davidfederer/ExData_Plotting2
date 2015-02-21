setwd("/Users/DAVIDandHILA/Documents/David/Coursera/Practical Machine Learning")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

total_em_baltimore_2 <- with(data=NEI[NEI$fips==24510,], aggregate(Emissions, list(year, type), sum))
colnames(total_em_baltimore_2) <- c("Year", "Type", 'Emissions')


library(ggplot2)
png(filename="plot3.png", width=600)
qplot(Year, Emissions, data=total_em_baltimore_2, col=Type, geom="line", main="Emissions in Baltimore Between 1999 and 2008 by Year and Emission Type", ylab="PM2.5 Emissions (tons)") + theme(legend.position="bottom")
dev.off()