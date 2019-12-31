## Logistic regression model 4 with 63 attributes

model4 <- glm(classe~L3_S29_F3351+L3_S30_F3604+L3_S49_F4211+L3_S30_F3664+
                L1_S25_F2435+L0_S6_F122+L3_S29_F3315+L3_S38_F3956+L0_S9_F200+
                L0_S22_F586+L0_S0_F14+L0_S18_F435+L0_S20_F461+L1_S25_F1865+
                L3_S29_F3482+L0_S0_F4+L1_S25_F1968+L0_S22_F611
              +L3_S47_F4148+L0_S9_F175+L3_S30_F3669+L1_S25_F2106+L0_S19_F453+
                L1_S25_F2429+L1_S25_F2322+L3_S41_F4020+L0_S22_F591+
                L0_S2_F48+L3_S30_F3804+L3_S41_F4018+L3_S30_F3709+L0_S8_F146+L2_S27_F3148+
                L3_S30_F3634+L0_S2_F40+L1_S25_F2443+L0_S2_F60+L3_S29_F3461+
                L3_S29_F3318+L2_S26_F3113+L0_S22_F556+L3_S29_F3330+L1_S25_F2901+
                L0_S1_F28+L0_S4_F104+L3_S29_F3327+L3_S36_F3934+L3_S38_F3952+
                L0_S0_F16+L1_S25_F1943+L3_S49_F4231+L1_S24_F1778+L0_S0_F0+
                L2_S26_F3040+L1_S24_F1695+L3_S30_F3764+L3_S30_F3564+
                L0_S22_F606+L1_S25_F2351+L3_S30_F3524+L3_S29_F3476
              ,data = train.glm,family = binomial())
summary(model4)

model4_prob <- predict(model4,test.glm,type = "response")
plot(model4_prob)
summary(model4_prob)
model4_probnew<-ifelse(model4_prob>0.523300,1,0)
model4_test_predictions<-cbind(test.glm[,"classe"],model4_probnew)
model4_test_predictions <- as.data.frame(model4_test_predictions)
model4_cm <- confusionMatrix(test.glm[[327]],model4_probnew)
model4_cm

pred4 <- prediction(model4_prob,test.glm$classe)
perf4 <- performance(pred4,measure = "tpr",x.measure = "fpr")
plot(perf4)
auc <- performance(pred4, measure = "auc")
auc4 <- auc@y.values[[1]]
auc4

## Logistic regression of model 4 with cross-validation
ctrl <- trainControl(method = "repeatedcv", number = 10, savePredictions = TRUE)

model4.cv <- train(classe~L3_S29_F3351+L3_S30_F3604+L3_S49_F4211+L3_S30_F3664+
                     L1_S25_F2435+L0_S6_F122+L3_S29_F3315+L3_S38_F3956+L0_S9_F200+
                     L0_S22_F586+L0_S0_F14+L0_S18_F435+L0_S20_F461+L1_S25_F1865+
                     L3_S29_F3482+L0_S0_F4+L1_S25_F1968+L0_S22_F611
                   +L3_S47_F4148+L0_S9_F175+L3_S30_F3669+L1_S25_F2106+L0_S19_F453+
                     L1_S25_F2429+L1_S25_F2322+L3_S41_F4020+L0_S22_F591+
                     L0_S2_F48+L3_S30_F3804+L3_S41_F4018+L3_S30_F3709+L0_S8_F146+L2_S27_F3148+
                     L3_S30_F3634+L0_S2_F40+L1_S25_F2443+L0_S2_F60+L3_S29_F3461+
                     L3_S29_F3318+L2_S26_F3113+L0_S22_F556+L3_S29_F3330+L1_S25_F2901+
                     L0_S1_F28+L0_S4_F104+L3_S29_F3327+L3_S36_F3934+L3_S38_F3952+
                     L0_S0_F16+L1_S25_F1943+L3_S49_F4231+L1_S24_F1778+L0_S0_F0+
                     L2_S26_F3040+L1_S24_F1695+L3_S30_F3764+L3_S30_F3564+
                     L0_S22_F606+L1_S25_F2351+L3_S30_F3524+L3_S29_F3476,data=train.glm,method ="glm",family ="binomial",trControl=ctrl,tuneLength=5)
model4.cv

summary(model4.cv)


model4.cv_pred = predict(model4.cv, newdata=test.glm,type="prob")
summary(model4.cv_pred)
model4.cv_tprob4<-cbind(test.glm[,"classe"],model4.cv_pred)
model4.cv_probnew<-ifelse(model4.cv_pred[,2]>0.525932,1,0)


confusionMatrix(model4.cv_probnew, test.glm$classe)

library(ROCR) # Compute AUC for predicting Class with the model

pred4_cv <- prediction(model4.cv_pred[,2],test.glm$classe)
perf <- performance(pred4_cv,measure = "tpr",x.measure = "fpr")
plot(perf)
auc4<- performance(pred4_cv, measure = "auc")
auc4<- auc4@y.values[[1]]
auc4

model4.cv_probnew<-ifelse(model4.cv_pred[,2]>0.40,1,0)
confusionMatrix(model4.cv_probnew, test.glm$classe)
