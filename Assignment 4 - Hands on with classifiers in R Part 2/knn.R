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

library(class)

knn_model <- knn(train = conditions, test = conditions_test, cl = conditions_label, k=1)
knn_model

library(gmodels)

CrossTable(x = conditions_test_label, y = knn_model, prop.chisq=FALSE)
