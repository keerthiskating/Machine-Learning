cat("\014")  #Clear Console
setwd("C:/Users/manu/Desktop/ML/Assignment4")

conditions <- read.table("Knowledge Modeling Train.txt",header = T)  
conditions_test <- read.table("Knowledge Modeling Test.txt",header = T)
conditions$UNS = as.factor(conditions$UNS)
conditions_test$UNS = as.factor(conditions_test$UNS)

conditions_features <- conditions[,-6]
conditions_test_features <- conditions_test[,-6]

conditions_label <- conditions[,6]
conditions_test_label <- conditions_test[,6]

library(rpart)
library(adabag)

bagging_model = bagging(UNS~.,data=conditions,mfinal = 10)
predict_bagging = predict (bagging_model,conditions)

library(e1071)
library(caret)

table(predict_bagging,conditions_label)

