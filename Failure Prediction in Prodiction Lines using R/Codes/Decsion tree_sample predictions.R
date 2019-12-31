sample1<-test.final3[sample(nrow(test.final3),5000),]
pred_rpart1<-predict(model_rpart,newdata=sample1,type="prob")
summary(pred_rpart1[,2])
pred_rpart_new1<-ifelse(pred_rpart1[,2]> 0.2097,"pass","fail") ##converting into categorical from the predicted probabilities
pred_rpart_new1<-as.factor(pred_rpart_new1)
confusionMatrix(pred_rpart_new1,sample1$Response) ##The Confusion Matrix library(caret)

sample2<-test.final3[sample(nrow(test.final3),5000),]
pred_rpart2<-predict(model_rpart,newdata=sample2,type="prob")
summary(pred_rpart2[,2])
pred_rpart_new2<-ifelse(pred_rpart2[,2]> 0.2097,"pass","fail") ##converting into categorical from the predicted probabilities
pred_rpart_new2<-as.factor(pred_rpart_new2)
confusionMatrix(pred_rpart_new2,sample2$Response) ##The Confusion Matrix library(caret)

sample3<-test.final3[sample(nrow(test.final3),5000),]
pred_rpart3<-predict(model_rpart,newdata=sample3,type="prob")
summary(pred_rpart3[,2])
pred_rpart_new3<-ifelse(pred_rpart3[,2]> 0.2097,"pass","fail") ##converting into categorical from the predicted probabilities
pred_rpart_new3<-as.factor(pred_rpart_new3)
confusionMatrix(pred_rpart_new3,sample3$Response) ##The Confusion Matrix library(caret)

sample4<-test.final3[sample(nrow(test.final3),10000),]
pred_rpart4<-predict(model_rpart,newdata=sample4,type="prob")
summary(pred_rpart4[,2])
pred_rpart_new4<-ifelse(pred_rpart4[,2]> 0.2097,"pass","fail") ##converting into categorical from the predicted probabilities
pred_rpart_new4<-as.factor(pred_rpart_new4)
confusionMatrix(pred_rpart_new4,sample4$Response) ##The Confusion Matrix library(caret)
