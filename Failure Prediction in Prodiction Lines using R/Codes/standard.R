library(data.table)

install.packages("Boruta")
library(Boruta)
library(mlbench)
getwd()
setwd("D://Lokin//Data Analytics//Modeling")
data.rose<-fread("data.bal.ou.csv")
##First Iteration
Boruta.n<-Boruta(class~.,data=data.rose,doTrace=2,ntree=500)
plot(Boruta.n)
Boruta.n
getConfirmedFormula(Boruta.n)
attStats(Boruta.n)
getSelectedAttributes(Boruta.n)

##Second Iteration
Boruta2.n<-Boruta(class~.,data=data.rose2,doTrace=2,ntree=500)
Boruta2.n
plot(Boruta2.n)
getConfirmedFormula(Boruta2.n)
attStats(Boruta2.n)
getSelectedAttributes(Boruta2.n)

set.seed(1)
Boruta3.short<-Boruta(class~.,data=data.rose2,doTrace=2,maxRuns=12)
Boruta3.short
TentativeRoughFix(Boruta3.short)

train <- sample(nrow(data.rose2), 0.8*nrow(data.rose2))
df_80 <- data.rose2[train,]
df_20 <- data.rose2[-train,]


library(e1071)
svm.data.bal<-svm(formula=class ~ L0_S13_F356 + L3_S33_F3859 + L3_S30_F3754 + L3_S30_F3544 + 
                    L3_S30_F3519 + L0_S1_F24 + L0_S1_F28 + L3_S33_F3865 + L3_S30_F3794 + 
                    L3_S30_F3499 + L3_S29_F3379 + L0_S0_F16 + L3_S30_F3749 + 
                    L3_S29_F3401 + L3_S30_F3709 + L3_S30_F3819 + L3_S30_F3759 + 
                    L3_S30_F3744 + L3_S30_F3494 + L3_S35_F3889 + L3_S30_F3809 + 
                    L3_S30_F3804 + L3_S30_F3774 + L3_S30_F3604 + L3_S30_F3784 + 
                    L3_S29_F3439 + L3_S33_F3857 + L3_S29_F3315 + L0_S0_F20 + 
                    L0_S0_F22 + L3_S29_F3430 + L3_S29_F3382,data=df_80)
pred.svm<-predict(svm.data.bal,df_20)
View(cbind(df_20[,"class"],pred.svm))
plot(pred.svm)

library("pROC")
plot(roc(df_20$class, pred.svm))
