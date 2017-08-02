cat("\014")  #Clear Console
setwd("C:\\Users\\manu\\Desktop\\ML\\Assignment2")  #Setting working dir

conditions <- read.table("Knowledge Modeling Train.txt",header = T)  
conditions_test <- read.table("Knowledge Modeling Test.txt",header = T)

conditions_test_label <- conditions_test[,6]

library(neuralnet)
library(nnet)
fit.factors <- nnet(UNS ~ STG+SCG+STR+LPR+PEG, data.frame(UNS=c('W', 'L', 'W'), x=c('1', '2' , '3')), size=1)
nn_model = neuralnet(UNS ~ STG+SCG+STR+LPR+PEG,data=conditions,hidden=c(2),err.fct="sse",threshold = 0.00001,rep = 25)
nn_model = neuralnet(UNS ~ STG+SCG+STR+LPR+PEG,data=conditions,hidden=c(4),err.fct="sse",threshold = 0.00001,rep = 25) #Error = 2.5
nn_model = neuralnet(UNS ~ STG+SCG+STR+LPR+PEG,data=conditions,hidden=c(8),err.fct="sse",threshold = 0.00001,rep = 25) #Error = 

nn.results <- compute(nn_model, conditions_test)

plot(nn_model,rep="best") 

compute(nn_model, as.factor(conditions))
