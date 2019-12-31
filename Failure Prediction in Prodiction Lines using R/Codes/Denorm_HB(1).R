setwd("D://Lokin//Data Analytics")

getwd()

traindata1<-read.csv("train_numeric_S0.csv")
traindata1<-na.omit(traindata1)
head(traindata1)
sig=4
mu=1
for(i in 1:33682) {
  for(j in 3:14){
    x<-traindata1[i,j]
    traindata1[i,j]=(x*sig)+mu
  }
}
summary(traindata1)

boxplot(traindata1$L0_S0_F0)
hist(traindata1$L0_S0_F0)

boxplot(traindata1$L0_S0_F2)
hist(traindata1$L0_S0_F2)

boxplot(traindata1$L0_S0_F4)
hist(traindata1$L0_S0_F4)

boxplot(traindata1$L0_S0_F6)
hist(traindata1$L0_S0_F6)


boxplot(traindata1$L0_S0_F8)
hist(traindata1$L0_S0_F8)

boxplot(traindata1$L0_S0_F10)
hist(traindata1$L0_S0_F10)

boxplot(traindata1$L0_S0_F12)
hist(traindata1$L0_S0_F12)

boxplot(traindata1$L0_S0_F14)
hist(traindata1$L0_S0_F14)

boxplot(traindata1$L0_S0_F16)
hist(traindata1$L0_S0_F16)

boxplot(traindata1$L0_S0_F18)
hist(traindata1$L0_S0_F18)

boxplot(traindata1$L0_S0_F20)
hist(traindata1$L0_S0_F20)

boxplot(traindata1$L0_S0_F22)
hist(traindata1$L0_S0_F22)



