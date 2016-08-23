require(FactoMineR)
library(corrplot)
library(caret)
a <- read.csv("C:/sneha/spring16/Data_Science/project/code/x.csv")
#write.csv(file="C:/sneha/spring16/Data_Science/project/code/y.csv",a)
corr <- cor(a$SalaryNormalized, a,method="pearson") 
View(corr)
hist(corr,xlab = "Correlation with Response variable",ylab = "No. of Attributes",col = "blue")
library(reshape2)
Id<-a$Id
b <- subset(melt(corr), corr > 0.2)
b2 <- subset(melt(corr), corr < -0.15)
a1<-a[ , (names(a) %in% b$Var2)]
a2<-a[ , (names(a) %in% b2$Var2)]
a1$Id<-Id
a2$Id<-Id
v<-merge(a1,a2,by="Id")
View(v)
correlationMatrix <- cor(v[3:length(v)])
highlyCorrelated <- findCorrelation(correlationMatrix, cutoff=0.75)  
print(length(v))
print(length(highlyCorrelated))
drops<-list()
for(nam in colnames(v)){
  num<-which(colnames(v)==nam)
  if(num %in% highlyCorrelated)
    drops<-c(drops,nam)
}
v<-v[,!(names(v) %in% drops)]
View(v)
write.csv(v, file = "C:/sneha/spring16/Data_Science/project/code/r.csv",row.names = FALSE)
