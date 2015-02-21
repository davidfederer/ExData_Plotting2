setwd("/Users/DAVIDandHILA/Documents/David/Coursera/Practical Machine Learning")

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")


sector <- SCC[SCC$EI.Sector %in% c("Fuel Comb - Electric Generation - Coal","Fuel Comb - Industrial Boilers, ICEs - Coal", "Fuel Comb - Comm/Institutional - Coal"),c("SCC", "EI.Sector")]

new_NEI <- merge(NEI, sector, by.x="SCC", by.y="SCC", all=FALSE)
new_NEI_aggr <- with(data=new_NEI, aggregate(Emissions, list(year, EI.Sector), sum))
colnames(new_NEI_aggr) <- c("Year", "Sector", "Emissions")


library(ggplot2)
png(filename="plot4.png", width=700)
g <- ggplot(new_NEI_aggr, aes(x=Year, y=Emissions))
g + geom_point(aes(color=Sector), size=4, alpha=1/2) + geom_smooth(size=1, method="lm", se=FALSE) + facet_grid(facets=.~Sector, scales="free") +labs(title="Emissions From Coal Combustion-Related Sources 1999–2008") + theme(legend.position="bottom")
dev.off()