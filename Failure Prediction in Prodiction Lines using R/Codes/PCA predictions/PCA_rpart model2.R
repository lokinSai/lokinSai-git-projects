library(rpart)
model_rpart2<-rpart(Response~ 
  PC1 +
  PC2 +
  PC3 +
  PC4 +
  PC6 +
  PC7 +
  PC8 +
  PC9 +
  PC11+
  PC12+
  PC13+
  PC14+
  PC15+
  PC16+
  PC17+
  PC18+
  PC19+
  PC21+
  PC22+
  PC23+
  PC24+
  PC26+
  PC31+
  PC33+
  PC34+
  PC36+
  PC37+
  PC39+
  PC42+
  PC43+
  PC44+
  PC45+
  PC46+
  PC47+
  PC49,data=train.final2,method="class")

summary(model_rpart2)
pred_rpart2<-predict(model_rpart2,data=test.final2,type="prob")
plot(pred_rpart2[,2]) 
summary(pred_rpart2[,2])

pred_new_rpart2<-ifelse(pred_rpart2[,2]>0.6142,0,1)
confusionMatrix(test.final2$Response,pred_new_rpart2)
