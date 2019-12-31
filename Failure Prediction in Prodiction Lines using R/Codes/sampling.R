library(data.table)
library(xgboost)
library(ROSE)
library(pROC)
library(FSelector)
getwd()

setwd("D://Lokin//Data Analytics//Modeling")
data.bal<-fread("data.bal.csv")

#split data into train and validation 
set.seed(1234)

df_train<-data.bal[sample(nrow(data.bal),0.7*nrow(data.bal)),]
table(df_train$Response)

df_test<-data.bal[sample(nrow(data.bal),0.3*nrow(data.bal)),]
table(df_test$Response)

kmcc <- function(y_true, y_prob) {
  DT <- pk.table(y_true = y_true, y_prob = y_prob, key="y_prob")
  
  nump <- sum(y_true)
  numn <- length(y_true)- nump
  
  DT[, tn_v:= cumsum(as.numeric(y_true == 0))]
  DT[, fp_v:= cumsum(as.numeric(y_true == 1))]
  DT[, fn_v:= numn - tn_v]
  DT[, tp_v:= nump - fp_v]
  DT[, tp_v:= nump - fp_v]
  DT[, mcc_v:= (tp_v * tn_v - fp_v* fn_v) / sqrt((tp_v + fp_v) * (tp_v + fn_v) * (tn_v + fp_v) * (tn_v + fn_v))]
  DT[, mcc_v:= ifelse(!is.finite(mcc_v), 0, mcc_v)]
  
  return(max(DT[['mcc_v']]))
}
mcc_eval <- function(y_prob, dtrain) {
  y_true <- getinfo(dtrain, "label")
  best_mcc <- mcc(y_true, y_prob)
  return(list(metric="MCC", value=best_mcc))
}

params<- list(objective = "binary:logistic",
              eta = 0.01,
              max_depth = 14, # start with 6
              min_child_weight = 1,
              subsample = 1,
              colsample_bytree = 0.3,  # 0.3 to 0.5
              base_score = 0.1,
              eval_metric = mcc_eval,
              maximize = TRUE)

xgtrain <- xgb.DMatrix(data = data.matrix(df_train), label = df_train$Response, missing = NA)
xgtest <- xgb.DMatrix(data = data.matrix(df_test), missing = NA)

model_xgb <- xgb.train(params = params, xgtrain, nrounds = 1000, verbose = T)

##logistic regression
log.data.bal<-glm(Response~.,family = binomial(link = "logit"),data=df_train)
pred.log<-predict(log.data.bal,df_test)
View(cbind(df_test[,"Response"],pred.log))
plot(pred.log)
plot(roc(df_test$Response, pred.log))



##svm
library(e1071)
svm.data.bal<-svm(formula=Response~.,data=df_train)
pred.svm<-predict(svm.data.bal,df_test)
View(cbind(df_test[,"Response"],pred.svm))
plot(pred.svm)
plot(roc(df_test$Response, pred.svm))



pred<-predict(model_xgb,xgtest)
View(cbind(df_test[,"Response"],pred))
plot(pred)
plot(roc(df_test$Response, pred))
pnew<-ifelse(pred<0.05,1,0)

