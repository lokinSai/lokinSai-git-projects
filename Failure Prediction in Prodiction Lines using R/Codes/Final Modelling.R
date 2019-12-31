setwd("D://Lokin//Data Analytics") ##setting directory
library(data.table) ##Loading required libraries
library(caret)      
library(ROSE)       
library(e1071)      
library(rpart) 
library(kernlab)

train_numeric<-fread("train_numeric.csv")  ##importing the train dataset csv file

y = nearZeroVar(train_numeric, saveMetrics = TRUE) ##Finding near zero variance vectors 
write.csv(y,file="nearzero_970.csv") ##writing list of vectors into seperate file


##Removing subset of near-zero variance vectors from the original dataset
newdata2<-subset(train_numeric,select=-c(L0_S15_F409 ,
                                         L1_S24_F751 ,
                                         L1_S24_F761 ,
                                         L1_S24_F1486,
                                         L1_S25_F2187,
                                         L1_S25_F2190,
                                         L1_S25_F2761,
                                         L1_S25_F2764,
                                         L3_S40_F3990,
                                         L3_S47_F4173,
                                         L0_S2_F52   ,
                                         L0_S3_F88   ,
                                         L0_S8_F146  ,
                                         L0_S8_F149  ,
                                         L0_S10_F269 ,
                                         L0_S14_F378 ,
                                         L0_S18_F435 ,
                                         L0_S20_F463 ,
                                         L0_S20_F466 ,
                                         L1_S24_F1371,
                                         L1_S24_F1840,
                                         L1_S25_F1865,
                                         L1_S25_F1873,
                                         L1_S25_F2478,
                                         L1_S25_F2481,
                                         L1_S25_F2857,
                                         L2_S26_F3055,
                                         L2_S26_F3077,
                                         L2_S26_F3125,
                                         L2_S27_F3148,
                                         L2_S27_F3170,
                                         L2_S27_F3218,
                                         L2_S28_F3241,
                                         L2_S28_F3263,
                                         L2_S28_F3311,
                                         L3_S29_F3485,
                                         L3_S29_F3488,
                                         L3_S29_F3491,
                                         L3_S30_F3594,
                                         L3_S30_F3599,
                                         L3_S30_F3614,
                                         L3_S30_F3619,
                                         L3_S30_F3654,
                                         L3_S30_F3659,
                                         L3_S30_F3694,
                                         L3_S30_F3699,
                                         L3_S30_F3714,
                                         L3_S30_F3719,
                                         L3_S30_F3724,
                                         L3_S30_F3729,
                                         L3_S30_F3734,
                                         L3_S30_F3739,
                                         L3_S30_F3779,
                                         L3_S30_F3789,
                                         L3_S30_F3814,
                                         L3_S30_F3824,
                                         L3_S31_F3838,
                                         L3_S33_F3867,
                                         L3_S33_F3869,
                                         L3_S33_F3871,
                                         L3_S33_F3873,
                                         L3_S34_F3876,
                                         L3_S34_F3878,
                                         L3_S34_F3880,
                                         L3_S34_F3882,
                                         L3_S35_F3884,
                                         L3_S35_F3898,
                                         L3_S35_F3903,
                                         L3_S35_F3908,
                                         L3_S35_F3913,
                                         L3_S36_F3926,
                                         L3_S36_F3930,
                                         L3_S36_F3934,
                                         L3_S36_F3938,
                                         L3_S37_F3944,
                                         L3_S37_F3946,
                                         L3_S37_F3948,
                                         L3_S37_F3950,
                                         L3_S39_F3964,
                                         L3_S39_F3968,
                                         L3_S39_F3972,
                                         L3_S39_F3976,
                                         L3_S40_F3988,
                                         L3_S40_F3992,
                                         L3_S40_F3994,
                                         L3_S41_F3996,
                                         L3_S41_F3998,
                                         L3_S41_F4002,
                                         L3_S43_F4060,
                                         L3_S43_F4065,
                                         L3_S43_F4070,
                                         L3_S43_F4075,
                                         L3_S43_F4080,
                                         L3_S43_F4090,
                                         L3_S44_F4100,
                                         L3_S44_F4103,
                                         L3_S44_F4106,
                                         L3_S44_F4109,
                                         L3_S45_F4126,
                                         L3_S45_F4128,
                                         L3_S45_F4130,
                                         L3_S45_F4132,
                                         L3_S47_F4178,
                                         L3_S47_F4183,
                                         L3_S47_F4188,
                                         L3_S48_F4200,
                                         L3_S48_F4202,
                                         L3_S48_F4204,
                                         L3_S49_F4206,
                                         L3_S49_F4216,
                                         L3_S49_F4221,
                                         L3_S49_F4226,
                                         L3_S49_F4231,
                                         L3_S50_F4245,
                                         L3_S50_F4247,
                                         L3_S50_F4249,
                                         L3_S50_F4251,
                                         L3_S51_F4256,
                                         L3_S51_F4258,
                                         L3_S51_F4260,
                                         L3_S51_F4262))


newdata2<-as.data.frame(newdata2)
newdata2[is.na(newdata2)]<-0     ## imputing NA values with zeros

descrcorr2<-cor(newdata2)
write.csv(descrcorr2,file="descrcorr2.csv")
highCorr <- findCorrelation(descrcorr2, 0.75) ##finding highly correlated attributes with cutoff 0.75
length(highCorr)

newdata2<-newdata2[,-highCorr] ##Removing highly correlated attributes and reducing from 970 to 601 attributes

maxs <- apply(newdata2, 2, max) 
mins <- apply(newdata2, 2, min) ##applying center and scaling method to eliminate skewness
scaled.newdata2 <- as.data.frame(scale(newdata2, center = mins, scale = maxs - mins))

Data2 <- scaled.newdata2[sample(nrow(scaled.newdata2),50000),] ##Sampling 50000 observations from original train dataset
Data2$Id<-NULL ##Making ID column null

Data.bal2<-ovun.sample(Response~.,data=Data2,method="both",p=0.5)$data ##Over and under sampling from 
                                                                       ## ROSE library to balance the class


Response<-Data.bal2[[1]] ##seperating the response variable to do PCA
Data.bal2[[1]]<-NULL
Data.bal.pc<-prcomp(Data.bal2) ##using prcomp function to perfom PCA 
summary(Data.bal.pc) ##Shows cummulative variance and respective loadings of each component


Data3<- predict(Data.bal.pc,newdata=Data.bal2) ##Transforming Components in terms of 50000 observations
Data3<-data.frame(Response,Data3)              ## Attaching the response varaible to the component dataset
dim(Data3)                                     ## to see the dimensionality


train <- sample(nrow(Data3), 0.5*nrow(Data3))  ##dividing the dataset into 50 percent train & test
train.final2<- Data3[train,]
test.final2<- Data3[-train,]

train.final3 <- train.final2[,1:101]          ##selecting the first 100 components which cover over 85 percent varaince
test.final3 <- test.final2[,1:101]            ##selecting the first 100 components which cover over 85 percent varaince

train.final3$Response<-ifelse(train.final3$Response==1,"fail","pass") ##changing the binary into names 
test.final3$Response<-ifelse(test.final3$Response==1,"fail","pass")
train.final3$Response<-as.factor(train.final3$Response) ##Making variable names into factor levels
test.final3$Response<-as.factor(test.final3$Response)

##SVM modelling
svm.model<-svm(Response~.,data=train.final3,probability=TRUE,cost=0.05,method="svmRadial") ##library(e1071)

pred_svm3<-predict(svm.model,newdata=test.final3,type="response",probability=TRUE) ##Prediction on test dataset
prob3<-attr(pred_svm3, "probabilities")

summary(prob3[,1])  ##summarising the probabilities

prob3_svm<-ifelse(prob3[,1]> 0.4461000,"pass","fail") ##converting into categorical from the predicted probabilities

confusionMatrix(test.final3$Response,prob3_svm)      ##The Confusion Matrix library(caret)


##decision tree modelling
model_rpart<-rpart(Response~.,data=train.final3,method="class",cp=0.003) ##library(rpart)
summary(model_rpart)
plotcp(model_rpart)
printcp(model_rpart)
pred_rpart<-predict(model_rpart,newdata=test.final3,type="prob") ##prediction on the test dataset
summary(pred_rpart[,2])   ##summarising the probabilities
plot(pred_rpart[,2])     ##probability plot

pred_rpart_new<-ifelse(pred_rpart[,2]> 0.2097,"pass","fail") ##converting into categorical from the predicted probabilities

pred_rpart_new<-as.factor(pred_rpart_new)
confusionMatrix(pred_rpart_new,test.final3$Response) ##The Confusion Matrix library(caret)


##Logistic regression modelling
model_lr3<-train(Response~.,data=train.final3,family="binomial",method="glm") ##logistic regression modelling
summary(model_lr3)

pred_lr3<-predict(model_lr3,newdata=test.final3,type="prob") ##prediction on the test dataset
summary(pred_lr3) ##summarising the probabilities

pred_new_lr3<-ifelse(pred_lr3[,2]>0.498492,"pass","fail") ##converting into categorical from the predicted probabilities
pred_new_lr3<-as.factor(pred_new_lr3)
confusionMatrix(test.final3$Response,pred_new_lr3) ##The Confusion Matrix library(caret)

##ensembling using weighted average
ensemble_prob<-data.frame(pred_rpart[,2],pred_lr3[,2],prob3[,1]) ##combining predicted probabilities from all three models
class(ensemble_prob)  

ensemble_avg<-(ensemble_prob$pred_rpart...2.*0.4+ensemble_prob$pred_lr3...2.*0.2+ensemble_prob$prob3...1.*0.4) ##taking weighted average
summary(ensemble_avg)   ##summarising the probabilities
plot(ensemble_avg)
ensemble_avg_class<-ifelse(ensemble_avg>0.52040 ,"pass","fail")   ##converting into categorical from the predicted probabilities

confusionMatrix(ensemble_avg_class,test.final3$Response) ##The Confusion Matrix library(caret)


