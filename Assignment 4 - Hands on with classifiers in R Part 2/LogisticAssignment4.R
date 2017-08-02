cat("\014")  #Clear Console
setwd("C:/Users/manu/Desktop/ML/Assignment4")

conditions <- read.table("Knowledge Modeling Train.txt",header = T)  
conditions_test <- read.table("Knowledge Modeling Test.txt",header = T)
conditions$UNS = as.factor(conditions$UNS)
conditions_test$UNS = as.factor(conditions_test$UNS)

is.factor(conditions$UNS)

conditions_features <- conditions[,-6]
conditions_test_features <- conditions_test[,-6]

conditions_label <- conditions[,6]
conditions_test_label <- conditions_test[,6]

library(nnet)
dataset <- read.table("D:/Machine Learning/Assignment_4/dataset.txt",sep=",",stringsAsFactors = FALSE,header=FALSE)
names(dataset)	<- c("DGN","PRE4",	"PRE5",	"PRE6",	"PRE7",	"PRE8",	"PRE9",	"PRE10",	"PRE11","PRE14",	"PRE17",	"PRE19",	"PRE25", "PRE30", "PRE32", "AGE", "Risk1Y")
folds<-nrow(conditions)/10;
trainIndex	<- sample(1:nrow(conditions),	0.8	*	nrow(conditions))
#train	<- dataset[trainIndex,	]
#test	<- dataset[-trainIndex,	]
for(i in 0:9)
{
  x=i*folds+1
  y=x+folds-1
  test<-conditions[x:y,]
  train<-conditions[-(x:y),]
  model <- glm(UNS ~.,family=binomial(link='logit'),data=train)
  #print(anova(model, test="Chisq"))
  t_pred_train = predict(model,train)
  conf_mat <- table(train$UNS,t_pred_train)
  accuracy_train <- sum(diag(conf_mat))/sum(conf_mat)
  accuracy_train=accuracy_train*100;  
  t_pred_test = predict(model,test)
  conf_mat <- table(test$UNS,t_pred_test)
  accuracy_test <- sum(diag(conf_mat))/sum(conf_mat)
  accuracy_test<-100*accuracy_test
  library(gplots)
  library(ROCR)
  #if(i==9)
  {
    pr <- prediction(t_pred_train, train$UNS)
    prf <- performance(pr, measure = "tpr", x.measure = "fpr")
    plot(prf)
    auc <- performance(pr, measure = "auc")
    auc <- auc@y.values[[1]]
    print(auc*100)
  }
}

