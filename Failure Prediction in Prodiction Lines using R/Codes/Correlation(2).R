
library(ggplot2)

newdata1_S0_NA<-read.csv("train_numeric_S0.csv")
newdata1_S0_NA<-na.omit(newdata1_S0_NA)


qplot(newdata1_S0_NA$L0_S0_F0,newdata1_S0_NA$L0_S0_F2)##Densly Corelated
qplot(newdata1_S0_NA$L0_S0_F4,newdata1_S0_NA$L0_S0_F6)
qplot(newdata1_S0_NA$L0_S0_F8,newdata1_S0_NA$L0_S0_F10)
qplot(newdata1_S0_NA$L0_S0_F12,newdata1_S0_NA$L0_S0_F14)## Probably linear Corelation but not dense
qplot(newdata1_S0_NA$L0_S0_F16,newdata1_S0_NA$L0_S0_F18)##Densly Corelated
qplot(newdata1_S0_NA$L0_S0_F20,newdata1_S0_NA$L0_S0_F22)##Perfect Corelation


## corelation with response variable 
qplot(newdata1_S0_NA$L0_S0_F0,newdata1_S0_NA$Response)
qplot(newdata1_S0_NA$L0_S0_F2,newdata1_S0_NA$Response)

##Correlation table between the columns 
CorMatrix<-cor(newdata1_S0_NA)


##correlation between the attributes 
for(j in 1:(ncol(newdata1_S0_NA)-1))
{
  for(i in j+1)
  {
    if(i==j)
    {
      break;
    }
    x=cor.test(newdata1_S0_NA[,j],newdata1_S0_NA[,i])
    if(x$estimate >= 0.5)
    {
      print(j)
      print(i)
      print(x$estimate)
    }
  }
}


