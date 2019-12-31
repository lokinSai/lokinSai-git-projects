##Boruta on Madalon dataset
install.packages("Boruta")
library(Boruta)
library(mlbench)
b.data<-data.bal
b.data$L0_S14_F378=NULL
b.data$L0_S15_F409=NULL
b.data$L0_S20_F463=NULL
b.data$L1_S24_F751=NULL
b.data$L1_S24_F761=NULL
b.data$L1_S24_F1486=NULL
b.data$L3_S31_F3838=NULL
b.data$L3_S40_F3990=NULL
b.data$L3_S47_F4173=NULL
b.data$L3_S50_F4247=NULL
b.data$L3_S51_F4258=NULL

Boruta.numeric<-b.data[sample(nrow(b.data),1000)]
table(Boruta.numeric$Response)

summary(Boruta.numeric$L3_S29_F3367)

Boruta.n<-Boruta(Response~.,data=Boruta.numeric,doTrace=2,ntree=500)
Boruta.n
TentativeRoughFix(Boruta.n)
plot(Boruta.n)
getConfirmedFormula(Boruta.n)
attStats(Boruta.n)

Boruta.log<-glm(formula=Response~ Id+L0_S0_F4 + L0_S0_F6 + L0_S0_F16 + L0_S0_F18 + 
      L0_S0_F20 + L0_S0_F22 + L0_S1_F24 + L0_S1_F28 + L0_S2_F36 + 
      L0_S6_F122 + L0_S7_F142 + L1_S24_F1567 + L1_S24_F1632 + L1_S24_F1652 + 
      L1_S24_F1844 + L1_S24_F1846 + L1_S25_F1855 + L1_S25_F2086 + 
      L2_S26_F3073 + L2_S26_F3113 + L2_S26_F3121 + L3_S29_F3315 + 
      L3_S29_F3318 + L3_S29_F3321 + L3_S29_F3324 + L3_S29_F3327 + 
      L3_S29_F3330 + L3_S29_F3333 + L3_S29_F3336 + L3_S29_F3339 + 
      L3_S29_F3342 + L3_S29_F3345 + L3_S29_F3348 + L3_S29_F3351 + 
      L3_S29_F3357 + L3_S29_F3367 + L3_S29_F3370 + L3_S29_F3373 + 
      L3_S29_F3376 + L3_S29_F3379 + L3_S29_F3382 + L3_S29_F3385 + 
      L3_S29_F3388 + L3_S29_F3395 + L3_S29_F3401 + L3_S29_F3404 + 
      L3_S29_F3407 + L3_S29_F3412 + L3_S29_F3421 + L3_S29_F3424 + 
      L3_S29_F3430 + L3_S29_F3436 + L3_S29_F3439 + L3_S29_F3442 + 
      L3_S29_F3449 + L3_S29_F3455 + L3_S29_F3458 + L3_S30_F3494 + 
      L3_S30_F3499 + L3_S30_F3514 + L3_S30_F3519 + L3_S30_F3534 + 
      L3_S30_F3539 + L3_S30_F3544 + L3_S30_F3554 + L3_S30_F3574 + 
      L3_S30_F3609 + L3_S30_F3634 + L3_S30_F3644 + L3_S30_F3669 + 
      L3_S30_F3679 + L3_S30_F3689 + L3_S30_F3704 + L3_S30_F3744 + 
      L3_S30_F3749 + L3_S30_F3754 + L3_S30_F3759 + L3_S30_F3804 + 
      L3_S30_F3809 + L3_S30_F3819 + L3_S30_F3829 + L3_S32_F3850 + 
      L3_S33_F3855 + L3_S33_F3857 + L3_S33_F3859 + L3_S33_F3861 + 
      L3_S33_F3863 + L3_S33_F3865 + L3_S47_F4138 + L3_S47_F4148 + 
      L3_S47_F4168 + L3_S48_F4196,data=b.data)

summary(Boruta.log)


library(e1071)
svm.data.bal<-svm(formula=Response~Id+L0_S0_F4 + L0_S0_F6 + L0_S0_F16 + L0_S0_F18 + 
                    L0_S0_F20 + L0_S0_F22 + L0_S1_F24 + L0_S1_F28 + L0_S2_F36 + 
                    L0_S6_F122 + L0_S7_F142 + L1_S24_F1567 + L1_S24_F1632 + L1_S24_F1652 + 
                    L1_S24_F1844 + L1_S24_F1846 + L1_S25_F1855 + L1_S25_F2086 + 
                    L2_S26_F3073 + L2_S26_F3113 + L2_S26_F3121 + L3_S29_F3315 + 
                    L3_S29_F3318 + L3_S29_F3321 + L3_S29_F3324 + L3_S29_F3327 + 
                    L3_S29_F3330 + L3_S29_F3333 + L3_S29_F3336 + L3_S29_F3339 + 
                    L3_S29_F3342 + L3_S29_F3345 + L3_S29_F3348 + L3_S29_F3351 + 
                    L3_S29_F3357 + L3_S29_F3367 + L3_S29_F3370 + L3_S29_F3373 + 
                    L3_S29_F3376 + L3_S29_F3379 + L3_S29_F3382 + L3_S29_F3385 + 
                    L3_S29_F3388 + L3_S29_F3395 + L3_S29_F3401 + L3_S29_F3404 + 
                    L3_S29_F3407 + L3_S29_F3412 + L3_S29_F3421 + L3_S29_F3424 + 
                    L3_S29_F3430 + L3_S29_F3436 + L3_S29_F3439 + L3_S29_F3442 + 
                    L3_S29_F3449 + L3_S29_F3455 + L3_S29_F3458 + L3_S30_F3494 + 
                    L3_S30_F3499 + L3_S30_F3514 + L3_S30_F3519 + L3_S30_F3534 + 
                    L3_S30_F3539 + L3_S30_F3544 + L3_S30_F3554 + L3_S30_F3574 + 
                    L3_S30_F3609 + L3_S30_F3634 + L3_S30_F3644 + L3_S30_F3669 + 
                    L3_S30_F3679 + L3_S30_F3689 + L3_S30_F3704 + L3_S30_F3744 + 
                    L3_S30_F3749 + L3_S30_F3754 + L3_S30_F3759 + L3_S30_F3804 + 
                    L3_S30_F3809 + L3_S30_F3819 + L3_S30_F3829 + L3_S32_F3850 + 
                    L3_S33_F3855 + L3_S33_F3857 + L3_S33_F3859 + L3_S33_F3861 + 
                    L3_S33_F3863 + L3_S33_F3865 + L3_S47_F4138 + L3_S47_F4148 + 
                    L3_S47_F4168 + L3_S48_F4196,data=b.data)
pred.svm<-predict(svm.data.bal,df_test)
View(cbind(df_test[,"Response"],pred.svm))
plot(pred.svm)
plot(roc(df_test$Response, pred.svm))
