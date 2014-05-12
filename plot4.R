NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
data<-transform(NEI,type=factor(type),year=factor(year))
Combust<-as.data.frame(SCC[grep("combustion",SCC$SCC.Level.One,ignore.case=T) & 
                             grep("coal",SCC$SCC.Level.Three,ignore.case=T),1])
names(Combust)<-"SCC"
data3<-merge(Combust,data,by="SCC")
library("plyr")
plotdata4<-ddply(data3,.(year),summarize,sum=sum(Emissions))
library(ggplot2)
png("plot4.png")
gplot<-ggplot(plotdata4,aes(year,sum))
gplot+geom_point(size=4)+labs(title="PM2.5 Emission from coal combustion-related sources ",
                                           y="total PM2.5 emission each year")
dev.off()