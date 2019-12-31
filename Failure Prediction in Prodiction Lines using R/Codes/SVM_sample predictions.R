##SVM sample predictions on test data set

sample1<-test.final3[sample(nrow(test.final3),5000),]
pred_s1<-predict(svm.model,newdata=sample1,type="response",probability=TRUE)
prob1<-attr(pred_s1, "probabilities")
summary(prob1[,1])  ##summarising the probabilities
prob1_s1<-ifelse(prob1[,1]>0.446100,"pass","fail") ##converting into categorical from the predicted probabilities
confusionMatrix(sample1$Response,prob1_s1)

sample2<-test.final3[sample(nrow(test.final3),5000),]
pred_s2<-predict(svm.model,newdata=sample2,type="response",probability=TRUE)
prob2<-attr(pred_s2, "probabilities")
summary(prob2[,1])  ##summarising the probabilities
prob2_s2<-ifelse(prob2[,1]>0.413100,"pass","fail") ##converting into categorical from the predicted probabilities
confusionMatrix(sample2$Response,prob2_s2)

sample3<-test.final3[sample(nrow(test.final3),5000),]
pred_s3<-predict(svm.model,newdata=sample3,type="response",probability=TRUE)
prob3_s3<-attr(pred_s3, "probabilities")
summary(prob3_s3[,1])  ##summarising the probabilities
prob3_s3_new<-ifelse(prob3_s3[,1]>0.4461000,"pass","fail") ##converting into categorical from the predicted probabilities
confusionMatrix(sample3$Response,prob3_s3_new)
length(sample3$Response)

sample4<-test.final3[sample(nrow(test.final3),10000),]
pred_s4<-predict(svm.model,newdata=sample4,type="response",probability=TRUE)
prob4<-attr(pred_s4, "probabilities")
summary(prob4[,1])  ##summarising the probabilities
prob4_s4<-ifelse(prob4[,1]>0.4155000,"pass","fail") ##converting into categorical from the predicted probabilities
confusionMatrix(sample4$Response,prob4_s4)

