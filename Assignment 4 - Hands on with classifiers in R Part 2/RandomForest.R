cat("\014")  #Clear Console
setwd("C:/Users/manu/Desktop/ML/Assignment4")

conditions <- read.table("Knowledge Modeling Train Rf.txt",header = T)  
conditions_test <- read.table("Knowledge Modeling Test Rf.txt",header = T)
conditions$UNS = as.factor(conditions$UNS)
conditions_test$UNS = as.factor(conditions_test$UNS)

conditions_features <- conditions[,-6]
conditions_test_features <- conditions_test[,-6]

conditions_label <- conditions[,6]
conditions_test_label <- conditions_test[,6]

table(conditions$UNS)/nrow(conditions)

sample.ind <- sample(2,nrow(conditions),replace = T,prob = c(0.6,0.4))
user.dev <- conditions[sample.ind==1,]
user.val <- conditions[sample.ind==2,]

table(user.dev$UNS)/nrow(user.dev)
class(conditions$UNS)
library(randomForest)

rf <- randomForest(conditions$UNS ~ conditions$STG + conditions$SCG + conditions$STR + conditions$LPR + conditions$PEG,
                              conditions,
                              ntree=500,
                              importance=T)

plot(rf)
response <- predict(rf ,conditions)
response1 <- predict(rf ,conditions_test)
mean(response1==conditions_test_label)
confusionMatrix(data=response1,
                reference=conditions_test_label,
                positive='yes')

forest_model = randomForest(conditions$UNS ~ conditions$STG + conditions$SCG + conditions$STR + conditions$LPR + conditions$PEG,data=conditions,importance=TRUE,ntree=1000)
print(forest_model)
round(importance(forest_model),2)
rf.mds <- cmdscale(1 - forest_model$proximity, eig=TRUE)
op <- par(pty="s")
pairs(cbind(conditions[,4:5], rf.mds$points), cex=0.6, gap=0,
      col=c("red", "green", "blue")[as.numeric(conditions$UNS)],
      main="User Knowledge modelning Data: Predictors and MDS of Proximity Based on RandomForest")
par(op)
print(rf.mds$GOF)
varImpPlot(forest_model)
Prediction <- predict(forest_model, conditions_test)
Prediction
mean(Prediction == conditions_test_label)
predict(forest_model, conditions_test_label, predict.all=TRUE)
