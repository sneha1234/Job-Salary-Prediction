x<-cor(jd$SalaryNormalized,jd)
View(x)
mylimit=as.numeric(seq(-1.0,1.0,by=0.1))
y<-x[1:211]
       