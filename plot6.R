NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
data<-transform(NEI,type=factor(type),year=factor(year))
twocity<-data[data$fips=="24510"|data$fips=="06037",]
vehicle<-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicle)<-"SCC"
data6<-merge(vehicle,twocity,by="SCC")
data6$city[data6$fips=="24510"]<-"Baltimore"
data6$city[data6$fips=="06037"]<-"LA"
library("plyr")
plotdata6<-ddply(data6,.(year,city),summarize,sum=sum(Emissions))
png("plot6.png")
gplot<-ggplot(plotdata6,aes(year,sum))
gplot+geom_point(aes(color=city),size=4)+labs(title="PM2.5 Emission from motor vehicle sources",
                              y="total PM2.5 emission each year")
dev.off()