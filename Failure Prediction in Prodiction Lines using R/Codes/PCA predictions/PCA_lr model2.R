model_lr3<-train(Response~ 
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
                   PC49,data=train.final2,family="binomial",method="glm",trControl=ctrl,tuneLength=5)

summary(model_lr3)          

pred_lr3<-predict(model_lr3,data=test.final2,type="prob")
plot(pred_lr3[,1]) 
summary(pred_lr3[,1])
library(pROC)

pred_new_lr3<-ifelse(pred_lr3[,1]> 0.49580,1,0)
confusionMatrix(test.final2$Response,pred_new_lr3)
