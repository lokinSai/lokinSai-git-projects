set.seed(1234)
Data <- train.data.rose.glm
train <- sample(nrow(Data), 0.8*nrow(Data))
train.glm <- Data[train,]
test.glm <- Data[-train,]

### LDA Model

library(MASS)
lda_fit <- qda(classe ~ ., data = train.glm, tol = 1.0e-15)

predict(lda_fit, newdata = test.glm)

lda_test_pred <- predict(lda_fit, newdata = test.glm)
lda_test_pred

lda_test_pred <- as.data.frame(lda_test_pred)
library(pROC)

lda_roc <- roc(response = test.glm$classe,
               predictor = lda_test_pred$posterior[, "fail"],
               ## we need to tell the function that the _first_ level is our event of interest
               levels = rev(levels(test.glm$classe)))
lda_roc

plot(lda_roc, print.thres = .5)

confusionMatrix(data = lda_test_pred$class, reference = test.glm$classe)

## to get the classes:
predict_class <- predict(lda_fit, newdata = test.glm)

## We choose `prob` to get class probabilities:
predict_prob <- predict(lda_fit, newdata = test.glm, type = "response")
predict_prob <- as.data.frame(predict_prob)
plot(predict_prob)

## cross-validation

ctrl <- trainControl(method = "repeatedcv", repeats = 5,
                     classProbs = TRUE,
                     summaryFunction = twoClassSummary)

set.seed(20792)
lda_mod <- train(classe ~ ., data = train.glm,
                 method = "lda",
                 ## Add the metric argument
                 trControl = ctrl, metric =  "ROC",
                 ## Also pass in options to `lda` using `...`
                 tol = 1.0e-15)

install.packages("doParallel")
library(doParallel)
## registerDoMC(cores = 2)
lda_mod
