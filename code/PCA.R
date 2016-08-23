library(corrplot)
install.packages("FactoMineR")
a <- read.csv("C:/sneha/spring16/Data_Science/project/code/x.csv")
##datMy.scale<- scale(a[2:ncol(a)],center=TRUE,scale=TRUE)
##corMatMy <- cor(datMy.scale)
##corrplot(corMatMy, order = "hclust")
##pca <- PCA(a, scale.unit=TRUE, ncp=5, graph=T)
##dimdesc(pca)
##summary(pca, ncp = 5)
pr.out <- prcomp(a, scale=TRUE)
#names(pr.out)
pr.out$rotation
#biplot(pr.out, scale=0)
pr.var <- pr.out$sdev^2
pve <- pr.var /sum(pr.var)
plot(pve, xlab = "Principal Component", ylab = "variance", ylim = c(0,1), type = 'b')
plot(cumsum(pve), xlab = "Principal Component", ylab = "variance", ylim = c(0,1), type = 'b')
#################################################
drops<-c("SalaryNormalized")
sa<-a[2]
a<-a[,!(names(a) %in% drops)]
a$SalaryNormalized<-sa
a
