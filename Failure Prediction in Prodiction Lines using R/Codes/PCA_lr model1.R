setwd("D://Lokin//Data Analytics")
library(data.table)
library(caret)
library(lmtest)
library(car)
library(pROC)
train_numeric<-fread("train_numeric.csv")
y = nearZeroVar(train_numeric, saveMetrics = TRUE)
write.csv(y,file="nearzero_970.csv")

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
newdata2[is.na(newdata2)]<-0

descrcorr2<-cor(newdata2)
write.csv(descrcorr2,file="descrcorr2.csv")
highCorr <- findCorrelation(descrcorr2, 0.75)
length(highCorr)

newdata2<-newdata2[,-highCorr]

maxs <- apply(newdata2, 2, max) 
mins <- apply(newdata2, 2, min)
scaled.newdata2 <- as.data.frame(scale(newdata2, center = mins, scale = maxs - mins))

Data2 <- scaled.newdata2[sample(nrow(scaled.newdata2),50000),]
Data2$Id<-NULL
library(ROSE)
Data.bal2<-ovun.sample(Response~.,data=Data2,method="both",p=0.5)$data

table(Data.bal2$Response)

Response<-Data.bal2[[1]]
Data.bal2[[1]]<-NULL
Data.bal.pc<-prcomp(Data.bal2)
summary(Data.bal.pc)


Data3<- predict(Data.bal.pc,newdata=Data.bal2)
Data3<-data.frame(Response,Data3)
write.csv(Data3,file="Data3.csv")
dim(Data3)
head(Data3)
##table(train.data1$train_pca_sample_1)
setwd("D://Lokin//Data Analytics")
Data3<-fread("Data3.csv")
Data3$V1<-NULL
train <- sample(nrow(Data3), 0.5*nrow(Data3))
train.final2<- Data3[train,]
test.final2<- Data3[-train,]


ctrl <- trainControl(method = "repeatedcv", number = 5, savePredictions = TRUE)
train.final2$Response<-as.factor(train.final2$Response)

test.final2$Response<-as.factor(test.final2$Response)
model_lr2<-train(Response~ 
                 PC1 +
                 PC2 +
                 PC3 +
                 PC4 +
                 PC5 +
                 PC6 +
                 PC7 +
                 PC8 +
                 PC9 +
                 PC10+
                 PC11+
                 PC12+
                 PC13+
                 PC14+
                 PC15+
                 PC16+
                 PC17+
                 PC18+
                 PC19+
                 PC20+
                 PC21+
                 PC22+
                 PC23+
                 PC24+
                 PC25+
                 PC26+
                 PC27+
                 PC28+
                 PC29+
                 PC30+
                 PC31+
                 PC32+
                 PC33+
                 PC34+
                 PC35+
                 PC36+
                 PC37+
                 PC38+
                 PC39+
                 PC40+
                 PC41+
                 PC42+
                 PC43+
                 PC44+
                 PC45+
                 PC46+
                 PC47+
                 PC48+
                 PC49+
                 PC50,data=train.final2,method="glm",family="binomial",trControl=ctrl,tuneLength=5)
               
summary(model_lr2)          
               
pred<-predict(model_lr2,data=test.final2,type="prob")
plot(pred[,2])

summary(pred[,2])
pred_new<-ifelse(pred[,2]> 0.50210,0,1)
confusionMatrix(test.final2$Response,pred_new)

