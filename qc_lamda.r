data<-read.table("/path", h=T, as.is=T)
names(data)[names(data) == 'P.value'] <- 'P'
p=data$P # p means p-value column name
Zsq=qchisq(1-p, 1)
lambda=median(Zsq)/0.456
lambda 

