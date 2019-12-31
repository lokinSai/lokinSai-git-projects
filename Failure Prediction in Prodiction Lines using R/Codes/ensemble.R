
install.packages("caretEnsemble")
library(caretEnsemble)
control <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions=TRUE, classProbs=TRUE)
algorithmList <- c('glm', 'svmRadial','rpart')
##stacking model
models <- caretList(Response~.,data=train.final3,trControl=control, methodList=algorithmList)
results <- resamples(models)
summary(results)
dotplot(results)

modelCor(results)
splom(results)
##model running using cross validation
stackControl <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions=TRUE, classProbs=TRUE)
stack.glm <- caretStack(models, method="svmRadial", metric="Accuracy", trControl=stackControl)
print(stack.glm)

##prediction using the model
stack_pred<-predict(stack.glm,test.final3,type="prob")
summary(stack_pred)
plot(stack_pred)
stack_pred_new<-ifelse(stack_pred>0.9979000,"fail","pass")
confusionMatrix(stack_pred_new,test.final3$Response)



