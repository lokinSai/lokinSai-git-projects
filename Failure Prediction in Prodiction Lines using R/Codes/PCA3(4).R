traindata<-cbind(train_numeric_S0[1:14])
traindata<-na.omit(traindata)
summary(traindata)
pca3<-princomp(data.rose2,scores=TRUE,cor=TRUE)
summary(pca3)
loadings(pca3)
plot(pca3)


traindta_comp1<-traindata

traindta_comp1$L0_S0_F8=NULL
traindta_comp1$L0_S0_F10=NULL
traindta_comp1$L0_S0_F16=NULL
 
model3<-glm(Response~.,family=binomial(link=logit),data=traindta_comp1)
summary(model3)


model4<-glm(Response~L0_S0_F18+L0_S0_F6+L0_S0_F20+L0_S0_F22,family=binomial(link=logit),data=traindta_comp1)
summary(model4)



