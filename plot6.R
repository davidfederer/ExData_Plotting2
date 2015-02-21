setwd("/Users/DAVIDandHILA/Documents/David/Coursera/Practical Machine Learning")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


sector <- SCC[SCC$EI.Sector %in% c("Mobile - On-Road Gasoline Light Duty Vehicles","Mobile - On-Road Gasoline Heavy Duty Vehicles", "Mobile - On-Road Diesel Light Duty Vehicles", "Mobile - On-Road Diesel Heavy Duty Vehicles", "Mobile - Aircraft", "Mobile - Commercial Marine Vessels", "Mobile - Locomotives"),c("SCC", "EI.Sector")]



new_NEI_baltimore <- merge(NEI[NEI$fips %in% c("24510", "06037"),], sector, by.x="SCC", by.y="SCC", all=FALSE)
new_NEI_baltimore_aggr <- with(data=new_NEI_baltimore, aggregate(Emissions, list(year,fips, EI.Sector), sum))
colnames(new_NEI_baltimore_aggr) <- c("Year", "Fips", "Sector", "Emissions")
new_NEI_baltimore_aggr$Fips <- ifelse(new_NEI_baltimore_aggr$Fips == "24510", "Baltimore City", "Los Angeles County")

library(ggplot2)
png(filename="plot6.png", width=1500)
g <- ggplot(new_NEI_baltimore_aggr, aes(x=Year, y=Emissions))
g + geom_point(aes(color=Sector), size=4, alpha=1/2) + geom_smooth(size=1, method="lm", se=FALSE) + facet_grid(facets=Fips~Sector, scales="free") +labs(title="Emissions From Motor Vehicle Sources 1999–2008") + theme(legend.position="bottom")
dev.off()