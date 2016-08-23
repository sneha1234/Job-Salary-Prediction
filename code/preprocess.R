###title preprocessing
library(tm)
library(SnowballC)
t<-read.csv("C:/sneha/spring16/Data_Science/project/code/Train_rev1.csv",nrows=200,stringsAsFactors=FALSE)
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
      #print(paste("outside v",v))
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
  print(paste("temp1",temp1))
  t[i,2]<-temp1
  
  ###remove locations
  temp<-scan_tokenizer(removePunctuation(t[i,2]))
  for(w in scan_tokenizer(removePunctuation(t[i,2])))
    if(w %in% scan_tokenizer(removePunctuation(t[i,4])))
       temp<-gsub(w,"",temp,ignore.case = TRUE)
  
  temp1<-""
  for(k in temp)
    temp1<-paste(temp1,k) 
  t[i,2]<-tolower(temp1)
  
  
}
write.csv(file = "C:/sneha/spring16/Data_Science/project/code/Train.csv",t)