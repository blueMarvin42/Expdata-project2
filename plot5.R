NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
data<-transform(NEI,type=factor(type),year=factor(year))
data2<-data[data$fips=="24510",]
vehicle<-as.data.frame(SCC[grep("vehicles",SCC$SCC.Level.Two,ignore.case=T),1])
names(vehicle)<-"SCC"
data5<-merge(vehicle,data2,by="SCC")
library("plyr")
library("ggplot")
plotdata5<-ddply(data5,.(year),summarize,sum=sum(Emissions))
png("plot5.png")
gplot<-ggplot(plotdata5,aes(year,sum))
gplot+geom_point(size=4)+labs(title="PM2.5 Emission from motor vehicle sources in Baltimore City",
                              y="total PM2.5 emission each year")
dev.off()
