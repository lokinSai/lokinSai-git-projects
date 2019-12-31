ensemble_prob<-data.frame(pred_rpart[,2],pred_lr3[,2],prob3[,1]) ##combining predicted probabilities from all three models
class(ensemble_prob) 

ensemble_avg_dum<-(ensemble_prob$pred_rpart...2.*0.5+ensemble_prob$pred_lr3...2.*0.1+ensemble_prob$prob3...1.*0.4) ##taking weighted average
summary(ensemble_avg_dum)   ##summarising the probabilities
plot(ensemble_avg_dum)
ensemble_avg_class_dum<-ifelse(ensemble_avg_dum>0.39300,"pass","fail")   ##converting into categorical from the predicted probabilities

confusionMatrix(ensemble_avg_class_dum,test.final3$Response)


##MCC

num=(11860*1182)-(661*597)
denom=sqrt((11860+597)*(11860+661)*(11882+661)*(1182*597))
mcc=num/denom
