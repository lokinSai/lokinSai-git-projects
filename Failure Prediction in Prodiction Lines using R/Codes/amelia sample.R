install.packages("Amelia")
install.packages("Zelig")
library(Amelia)
library(Zelig)
data("freetrade")
missmap(freetrade)
freetrade$signed<-as.factor(freetrade$signed)


write.csv(freetrade,file="freetrade.csv")

Cdata<-amelia(freetrade,p2s=2,m=5,ords="polity",noms="signed",idvars=c("year","country"))


overimpute(Cdata,var="tariff")

write.amelia(obj=mdata, file.stem = "mdata")


hist(Cdata$imputations[[3]]$tariff, col="grey", border="white")
