library(rpart)
model_rpart<-rpart(Response~.,data=train.final3,method="class")
pred_rpart<-predict(model_rpart,newdata=test.final3,type="prob")
summary(pred_rpart[,2])
plot(pred_rpart[,2])

pred_rpart_new<-ifelse(pred_rpart[,2]>0.6970,1,0)
confusionMatrix(pred_rpart_new,test.final3$Response)

train.final3$Response<-as.factor(train.final3$Response)
test.final3$Response<-as.factor(test.final3$Response)
model_lr3<-train(Response~.,data=train.final3,family="binomial",method="glm")
summary(model_lr3)
pred_lr3<-predict(model_lr3,newdata=test.final3,type="prob")
pred_lr3_2<-predict(model_lr3,newdata=test.final3,type="raw")
summary(pred_lr3)
summary(pred_lr3_2)
pred_new_lr3<-ifelse(pred_lr3[,2]>0.49620,1,0)
confusionMatrix(test.final3$Response,pred_new_lr3)
confusionMatrix(test.final3$Response,pred_lr3_2)

train.final3 <- train.final2[,1:101]
test.final3 <- test.final2[,1:101]
train.final4<-train.final2[,1:76]
test.final4<-train.final2[,1:76]
train.final5<-train.final2[,1:51]
test.final5<-train.final2[,1:51]


library(e1071)

svm.model<-svm(Response~.,data=train.final3)
svm.model2<-svm(Response~.,data=train.final4)
svm.model3<-svm(Response~.,data=train.final5)
##tune.modelsvm<-tune.svm(Response~.,data=train.final3, kernel="radial", 
         ##gamma=seq(0.1, 0.9, len=9), cost=seq(20, 50, len=5), probability = TRUE, tunecontrol=tune.control(cross=5))

pred_svm3<-predict(svm.model,newdata=test.final3,type="response")
pred_svm4<-predict(svm.model2,newdata=test.final4,type="response")
pred_svm5<-predict(svm.model2,newdata=test.final5,type="response")

plot(pred_svm3)
plot(pred_svm4)
summary(pred_svm3)
summary(pred_svm4)
pred_svm3_new<-ifelse(pred_svm3> 0.38150,1,0)
pred_svm4_new<-ifelse(pred_svm3> 0.94980,1,0)
library(caret)
confusionMatrix(test.final3$Response,pred_svm3)
confusionMatrix(test.final3$Response,pred_svm4_new)
plot(pred_lr3[,1]) 
summary(pred_lr3)
library(pROC)

pred_new_lr3<-ifelse(pred_lr3 < 0.45,0,1)
confusionMatrix(test.final3$Response,pred_svm3)
