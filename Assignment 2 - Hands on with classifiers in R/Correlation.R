cat("\014")  #Clear Console
setwd("C:\\Users\\manu\\Desktop\\ML")  #Setting working dir

#Getting data into dataframe
conditions <- read.table("Knowledge Modeling Train.txt",header = T)  

library(corrplot)

M<-cor(conditions)

corrplot(M,method = "number")
hist(conditions$UNS)

sort(abs(M[,"UNS"]))
