

ctrl <- trainControl(method = "repeatedcv", repeats = 5,
                     classProbs = TRUE,
                     summaryFunction = twoClassSummary)
## The same resamples are used
set.seed(20792)
train.final3$Response<-as.factor(train.final3$Response)

knn_mod <- train(Response ~., data = train.final3,
                 method = "knn",
                 trControl = ctrl,
                 ## tuning parameter values to evaluate
                 tuneGrid = data.frame(k = seq(1, 25, by = 2)),
                 metric =  "ROC")

knn_mod

ggplot(knn_mod)

test.final3$Response<-as.factor(test.final3$Response)

library(ROCR) # Compute AUC for predicting Class with the model
test.glm$classe<-ifelse(test.glm$classe=="fail",1,0)
## We choose `prob` to get class probabilities:
predict_prob <- predict(knn_mod, newdata = test.final3, type = "prob")
summary(predict_prob)
predict_prob_new<-ifelse(predict_prob[,1]>0.2048,"fail","pass")
confusionMatrix(predict_prob_new,test.final3$Response)
## The same resamples are used
set.seed(20792)


## Conduct o a paired t-test on the resampled AUC values to control for
## resample-to-resample variability:
compare_models(knn_mod, metric = "ROC")
