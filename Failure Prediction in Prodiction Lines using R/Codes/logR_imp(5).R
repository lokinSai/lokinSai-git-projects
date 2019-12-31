getwd()
setwd("D://Lokin//Data Analytics")
train_numeric_S0<-read.csv("train_numeric_S0.csv")
train_numeric_S0<-na.omit(train_numeric_S0)

new_train<-train_numeric_S0[1:26946,]
new_test<-train_numeric_S0[26947:nrow(train_numeric_S0),]

logit.mod1 <- glm(Response~.,family=binomial(),data=new_train)
summary(logit.mod1)
logit.mod2 <- glm(Response~L0_S0_F8+L0_S0_F20+L0_S0_F22+L0_S0_F18+L0_S0_F6,family=binomial(),data=new_train)
summary(logit.mod2)
logit.mod3 <- glm(Response~L0_S0_F8+L0_S0_F18+L0_S0_F6,family=binomial(),data=new_train)
summary(logit.mod3)
logit.mod4 <- glm(Response~L0_S0_F8+L0_S0_F6,family=binomial(),data=new_train)
summary(logit.mod4)
p1<-predict(logit.mod1,new_train,type="response")
p2<-predict(logit.mod2,new_train,type="response")
p3<-predict(logit.mod3,new_train,type="response")
p4<-predict(logit.mod4,new_train,type="response")

View(cbind(new_train[,"Response"],p1,p2,p3,p4))

p1new <- ifelse(p1<0.5,0,1)
p2new <- ifelse(p2<0.5,0,1)
p3new <- ifelse(p3<0.5,0,1)
p4new <- ifelse(p4<0.5,0,1)

table(p1new)
table(p2new)
table(p3new)
table(p4new)


library(e1071)
svm.model<- svm(Response~L0_S0_F6+L0_S0_F8,data=new_train)
plot(svm.model)
svmp<-predict(svm.model,new_train)
cbind(svmp,new_train$Response)


install.packages("rpart")
library(rpart)
rpart.model<-rpart(Response~L0_S0_F6+L0_S0_F8,data=new_train)
summary(rpart.model)
rpart.pred<-predict(rpart.model,new_test)
cbind(rpart.pred,new_train$Response)

