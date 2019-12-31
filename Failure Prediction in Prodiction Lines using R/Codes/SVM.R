library(e1071)
library(caret)
set.seed(1056)
svmFit <- train(classe ~L3_S33_F3873+
                  L0_S9_F210  +
                  L3_S30_F3774+
                  L1_S25_F2773+
                  L0_S0_F8    +
                  L2_S27_F3199+
                  L3_S45_F4130+
                  L3_S51_F4260+
                  L3_S34_F3878+
                  L3_S47_F4163+
                  L3_S34_F3876+
                  L2_S27_F3129+
                  L0_S22_F551 +
                  L3_S50_F4247+
                  L1_S25_F2758+
                  L3_S36_F3930+
                  L3_S41_F4008+
                  L3_S48_F4200+
                  L1_S25_F2618+
                  L3_S29_F3407+
                  L3_S40_F3982+
                  L3_S41_F4023+
                  L0_S7_F138  +
                  L3_S35_F3903+
                  L0_S0_F0    +
                  L0_S2_F40   +
                  L0_S9_F205  +
                  L1_S25_F1963+
                  L1_S25_F1924+
                  L2_S27_F3144+
                  L0_S21_F527 +
                  L3_S30_F3639+
                  L3_S29_F3336+
                  L3_S33_F3869+
                  L0_S7_F142  +
                  L2_S27_F3214+
                  L0_S16_F421 +
                  L3_S29_F3373+
                  L1_S25_F2540+
                  L2_S28_F3311+
                  L1_S25_F2131+
                  L0_S22_F576 +
                  L0_S2_F32   +
                  L3_S30_F3534+
                  L0_S0_F12   +
                  L0_S8_F149  +
                  L3_S29_F3333+
                  L0_S0_F18   +
                  L3_S47_F4153+
                  L3_S33_F3859+
                  L3_S39_F3972+
                  L1_S25_F2111+
                  L3_S30_F3524+
                  L3_S30_F3744+
                  L3_S44_F4121+
                  L3_S30_F3764+
                  L3_S30_F3544+
                  L3_S30_F3509+
                  L3_S33_F3855+
                  L0_S9_F195  +
                  L0_S6_F118  +
                  L3_S29_F3321+
                  L1_S24_F1695+
                  L2_S27_F3170+
                  L2_S26_F3073+
                  L1_S25_F2351+
                  L2_S26_F3055+
                  L3_S44_F4112+
                  L3_S39_F3976+
                  L0_S22_F546 +
                  L2_S27_F3133+
                  L3_S29_F3485+
                  L3_S29_F3382+
                  L1_S24_F839 +
                  L3_S29_F3354+
                  L3_S40_F3980+
                  L1_S25_F2121+
                  L3_S29_F3476+
                  L0_S2_F60   +
                  L3_S49_F4236+
                  L0_S22_F606 +
                  L3_S45_F4132+
                  L1_S24_F1798+
                  L3_S47_F4143+
                  L0_S6_F132  +
                  L2_S26_F3113+
                  L3_S45_F4124+
                  L2_S27_F3166+
                  L1_S25_F2441+
                  L3_S29_F3318+
                  L3_S44_F4109+
                  L0_S22_F571 +
                  L3_S30_F3494+
                  L1_S25_F2475+
                  L1_S25_F1943+
                  L1_S25_F2484+
                  L3_S38_F3952+
                  L1_S25_F2490+
                  L1_S24_F1803+
                  L2_S26_F3117+
                  L3_S30_F3634+
                  L0_S5_F116  +
                  L1_S25_F2126+
                  L3_S45_F4126+
                  L0_S0_F16   +
                  L0_S1_F28   +
                  L3_S33_F3857+
                  L3_S30_F3564+
                  L3_S49_F4231+
                  L0_S8_F146  +
                  L3_S36_F3934+
                  L1_S25_F2443+
                  L3_S29_F3330+
                  L0_S22_F556 +
                  L2_S26_F3040+
                  L0_S4_F104  +
                  L3_S29_F3461+
                  L0_S2_F48   +
                  L2_S27_F3148+
                  L0_S9_F175  +
                  L0_S22_F591 +
                  L3_S30_F3804+
                  L3_S47_F4148+
                  L1_S25_F2901+
                  L1_S25_F1968+
                  L3_S29_F3327+
                  L1_S25_F2429+
                  L3_S30_F3669+
                  L3_S41_F4020+
                  L0_S19_F453 +
                  L0_S9_F200  +
                  L0_S22_F611 +
                  L1_S25_F2322+
                  L3_S30_F3709+
                  L1_S25_F2106+
                  L3_S41_F4018+
                  L0_S20_F461 +
                  L3_S29_F3482+
                  L1_S24_F1778+
                  L1_S25_F1865+
                  L3_S29_F3315+
                  L3_S38_F3956+
                  L0_S18_F435 +
                  L0_S22_F586 +
                  L0_S6_F122  +
                  L0_S0_F4    +
                  L0_S0_F14   +
                  L3_S30_F3604+
                  L3_S30_F3664+
                  L1_S25_F2435+
                  L3_S29_F3351+
                  L3_S49_F4211,data = train.glm, method = "svmRadial",
                tuneLength = 10, trControl = trainControl(method = "repeatedcv",repeats = 5))

# A line plot of the average performance
plot(svmFit, scales = list(x = list(log = 2)))

# Predict class probabilities
predictedProbs <- predict(svmFit, newdata = test.glm, type = "prob")

confusionMatrix(predictedProbs,test.glm$classe)

svmmodel_1<- svm(classe ~L3_S33_F3873+
                  L0_S9_F210  +
                  L3_S30_F3774+
                  L1_S25_F2773+
                  L0_S0_F8    +
                  L2_S27_F3199+
                  L3_S45_F4130+
                  L3_S51_F4260+
                  L3_S34_F3878+
                  L3_S47_F4163+
                  L3_S34_F3876+
                  L2_S27_F3129+
                  L0_S22_F551 +
                  L3_S50_F4247+
                  L1_S25_F2758+
                  L3_S36_F3930+
                  L3_S41_F4008+
                  L3_S48_F4200+
                  L1_S25_F2618+
                  L3_S29_F3407+
                  L3_S40_F3982+
                  L3_S41_F4023+
                  L0_S7_F138  +
                  L3_S35_F3903+
                  L0_S0_F0    +
                  L0_S2_F40   +
                  L0_S9_F205  +
                  L1_S25_F1963+
                  L1_S25_F1924+
                  L2_S27_F3144+
                  L0_S21_F527 +
                  L3_S30_F3639+
                  L3_S29_F3336+
                  L3_S33_F3869+
                  L0_S7_F142  +
                  L2_S27_F3214+
                  L0_S16_F421 +
                  L3_S29_F3373+
                  L1_S25_F2540+
                  L2_S28_F3311+
                  L1_S25_F2131+
                  L0_S22_F576 +
                  L0_S2_F32   +
                  L3_S30_F3534+
                  L0_S0_F12   +
                  L0_S8_F149  +
                  L3_S29_F3333+
                  L0_S0_F18   +
                  L3_S47_F4153+
                  L3_S33_F3859+
                  L3_S39_F3972+
                  L1_S25_F2111+
                  L3_S30_F3524+
                  L3_S30_F3744+
                  L3_S44_F4121+
                  L3_S30_F3764+
                  L3_S30_F3544+
                  L3_S30_F3509+
                  L3_S33_F3855+
                  L0_S9_F195  +
                  L0_S6_F118  +
                  L3_S29_F3321+
                  L1_S24_F1695+
                  L2_S27_F3170+
                  L2_S26_F3073+
                  L1_S25_F2351+
                  L2_S26_F3055+
                  L3_S44_F4112+
                  L3_S39_F3976+
                  L0_S22_F546 +
                  L2_S27_F3133+
                  L3_S29_F3485+
                  L3_S29_F3382+
                  L1_S24_F839 +
                  L3_S29_F3354+
                  L3_S40_F3980+
                  L1_S25_F2121+
                  L3_S29_F3476+
                  L0_S2_F60   +
                  L3_S49_F4236+
                  L0_S22_F606 +
                  L3_S45_F4132+
                  L1_S24_F1798+
                  L3_S47_F4143+
                  L0_S6_F132  +
                  L2_S26_F3113+
                  L3_S45_F4124+
                  L2_S27_F3166+
                  L1_S25_F2441+
                  L3_S29_F3318+
                  L3_S44_F4109+
                  L0_S22_F571 +
                  L3_S30_F3494+
                  L1_S25_F2475+
                  L1_S25_F1943+
                  L1_S25_F2484+
                  L3_S38_F3952+
                  L1_S25_F2490+
                  L1_S24_F1803+
                  L2_S26_F3117+
                  L3_S30_F3634+
                  L0_S5_F116  +
                  L1_S25_F2126+
                  L3_S45_F4126+
                  L0_S0_F16   +
                  L0_S1_F28   +
                  L3_S33_F3857+
                  L3_S30_F3564+
                  L3_S49_F4231+
                  L0_S8_F146  +
                  L3_S36_F3934+
                  L1_S25_F2443+
                  L3_S29_F3330+
                  L0_S22_F556 +
                  L2_S26_F3040+
                  L0_S4_F104  +
                  L3_S29_F3461+
                  L0_S2_F48   +
                  L2_S27_F3148+
                  L0_S9_F175  +
                  L0_S22_F591 +
                  L3_S30_F3804+
                  L3_S47_F4148+
                  L1_S25_F2901+
                  L1_S25_F1968+
                  L3_S29_F3327+
                  L1_S25_F2429+
                  L3_S30_F3669+
                  L3_S41_F4020+
                  L0_S19_F453 +
                  L0_S9_F200  +
                  L0_S22_F611 +
                  L1_S25_F2322+
                  L3_S30_F3709+
                  L1_S25_F2106+
                  L3_S41_F4018+
                  L0_S20_F461 +
                  L3_S29_F3482+
                  L1_S24_F1778+
                  L1_S25_F1865+
                  L3_S29_F3315+
                  L3_S38_F3956+
                  L0_S18_F435 +
                  L0_S22_F586 +
                  L0_S6_F122  +
                  L0_S0_F4    +
                  L0_S0_F14   +
                  L3_S30_F3604+
                  L3_S30_F3664+
                  L1_S25_F2435+
                  L3_S29_F3351+
                  L3_S49_F4211,data = train.glm)

predictedProbs1_class <- predict(svmmodel, newdata = test.glm)
plot(predictedProbs1_class)
predictedProbs1_class

library(kernlab)
library(caret)
library(ipred)
# Predict class probabilities

Predict_Probs <- predict(svmmodel,newdata =test.glm,type ="prob")
