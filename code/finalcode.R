rm(list =ls(all = TRUE))
library(tm)
library(SnowballC)
t<-read.csv("C:/sneha/spring16/Data_Science/project/code/Train_rev1.csv",nrows=244769,stringsAsFactors=FALSE)
t<-t[,!((names(t) %in% c("FullDescription","SalaryRaw")))]
##---------START OF LEVEL CODE----------------------------------------------------------------
t$level<-"Mid-Level"
for(i in 1:length(t$Title)){
  if(grepl("Senior",t[i,2] , ignore.case = TRUE) | grepl("Manager",t[i,2] , ignore.case = TRUE) | grepl("Head",t[i,2] , ignore.case = TRUE) | grepl("Chef",t[i,2] , ignore.case = TRUE) | grepl("Lead",t[i,2] , ignore.case = TRUE)){
    t [i,13]<- "Senior"
  }
  else if (grepl("Junior",t[i,2] ,ignore.case = TRUE) | grepl("Entry",t[i,2] , ignore.case = TRUE))
  {
    t[i,13]<- "Junior"
  }
  else{
    t[i,13]<- "Mid-Level"
  }
}
print("done adding level")
##--------------END OF LEVEL CODE-------------------------------------------------------------------

###title preprocessing
topwords<-c("^Manager$","^director$","^advisor$","^managersenior$","^administrator$","^worker$","^teacher$","^analyst$","^consultant$","^nurse$","^developer$","^engineer$")
pos<-0
removewords<-c("^job$","^jobs$","^Senior$","^Junior$")
for(i in 1:length(t[,2])){#for every value in column title,i is row number
  for(x in topwords){ ### for every top word
    titl<-paste0(t[i,2])
    v<-scan_tokenizer(removePunctuation(titl)) ##current title
    pos<-grep(x,v,ignore.case = TRUE) ## position of word in title
    if((length(pos)>0) && (pos<length(v)) ){
      for(l in (pos+1):length(v))###remove everything after position
      {
        v<-gsub(v[l],"",v)
      }
      temp<-""
      
      for(k in v)
        temp<-paste(temp,k)
      t[i,2]<-temp
    }
    
  }
  ###remove words
  temp1<-""
  temp<-scan_tokenizer(removePunctuation(t[i,2]))
  for(g in removewords)
    temp<-gsub(g,"",temp,ignore.case = TRUE)
  for(k in temp)
    temp1<-paste(temp1,k) 
  
  t[i,2]<-temp1
  
  ###remove locations
  temp<-scan_tokenizer(removePunctuation(t[i,2]))
  for(w in scan_tokenizer(removePunctuation(t[i,2])))
    if(w %in% scan_tokenizer(removePunctuation(t[i,3])))
      temp<-gsub(w,"",temp,ignore.case = TRUE)
  
  temp1<-""
  for(k in temp)
    temp1<-paste(temp1,k) 
  
  t[i,2]<-tolower(temp1)
  
  
}

##--------FOR REMOVING DUPLICATES ROWS--------------------------------
print("extracting unique")
y <- data.frame(t)
dat1<-y[!duplicated(y[,2]),]
length(dat1)
dat2<-y[!duplicated(y[,4]),]
length(dat2)
dat3<-y[!duplicated(y[,7]),]
length(dat3)
View(dat3)
dat4 <-y[!duplicated(y[,8]),]
dat5 <- y[!duplicated(y[,10]),]
View(dat5)
c <- rbind(dat1,dat2,dat3,dat4,dat5)
dat6<-c[!duplicated(c[,1]),]
View(dat6)
##---------END OF CODE FOR DUPLICATE ROWS-----------------------------------------------------
dat6<-dat6[,!((names(dat6) %in% c("LocationRaw")))]
write.csv(file = "C:/sneha/spring16/Data_Science/project/code/Train.csv",dat6)