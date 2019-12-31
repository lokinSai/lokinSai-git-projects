sample1<-test.final3[sample(nrow(test.final3),5000),]
pred_lr1<-predict(model_lr3,newdata=sample1,type="prob") ##prediction on the test dataset
summary(pred_lr1) ##summarising the probabilities
pred_new_lr1<-ifelse(pred_lr1[,2]>0.495567,"pass","fail") ##converting into categorical from the predicted probabilities
pred_new_lr1<-as.factor(pred_new_lr1)
confusionMatrix(sample1$Response,pred_new_lr1) ##The Confusion Matrix library(caret)


sample2<-test.final3[sample(nrow(test.final3),5000),]
pred_lr2<-predict(model_lr3,newdata=sample2,type="prob") ##prediction on the test dataset
summary(pred_lr2) ##summarising the probabilities
pred_new_lr2<-ifelse(pred_lr2[,2]>0.496452,"pass","fail") ##converting into categorical from the predicted probabilities
pred_new_lr2<-as.factor(pred_new_lr2)
confusionMatrix(sample2$Response,pred_new_lr2) ##The Confusion Matrix library(caret)

sample3<-test.final3[sample(nrow(test.final3),5000),]
pred_lr3_1<-predict(model_lr3,newdata=sample3,type="prob") ##prediction on the test dataset
summary(pred_lr3_1) ##summarising the probabilities
pred_new_lr3_1<-ifelse(pred_lr3_1[,2]>0.486548,"pass","fail") ##converting into categorical from the predicted probabilities
pred_new_lr3_1<-as.factor(pred_new_lr3_1)
confusionMatrix(sample3$Response,pred_new_lr3_1) ##The Confusion Matrix library(caret)

sample4<-test.final3[sample(nrow(test.final3),10000),]
pred_lr4<-predict(model_lr3,newdata=sample4,type="prob") ##prediction on the test dataset
summary(pred_lr4) ##summarising the probabilities
pred_new_lr4<-ifelse(pred_lr4[,2]>0.496452,"pass","fail") ##converting into categorical from the predicted probabilities
pred_new_lr4<-as.factor(pred_new_lr4)
confusionMatrix(sample4$Response,pred_new_lr4) ##The Confusion Matrix library(caret)


