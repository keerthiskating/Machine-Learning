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

library(aod)
library(ggplot2)
library(Rcpp)

logit_model = glm(UNS ~ ., data = conditions,family = binomial)
summary(logit_model)

anova(logit_model,test="Chisq")

library(pscl)
pR2(logit_model)

fitted.results <- predict(logit_model,newdata=subset(conditions_test,select=c(1,2,3,4,5)),type='response')
fitted.results <- ifelse(fitted.results > 0.2,1,0)

misClasificError <- mean(fitted.results != conditions_test_label)
print(paste('Accuracy',1-misClasificError))

library(caret)
confusionMatrix(data=fitted.results, reference=conditions_test_label)

library(ROCR)
# ROC and AUC
p <- predict(logit_model, newdata=subset(conditions_test,select=c(1,2,3,4,5)), type="response")
#pr <- prediction(p, conditions_test_label)
# TPR = sensitivity, FPR=specificity
prf <- performance(pr, measure = "tpr", x.measure = "fpr")
plot(prf)

auc <- performance(pr, measure = "auc")
auc <- auc@y.values[[1]]
auc