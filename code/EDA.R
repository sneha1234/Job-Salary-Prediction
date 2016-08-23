install.packages("tm")  # for text mining
install.packages("SnowballC")
library(quanteda)
library("tm")
library("SnowballC")
t<-read.csv("C:/sneha/spring16/Data_Science/project/code/Train_rev1.csv",nrows=200,stringsAsFactors=FALSE)
summary(t)
d<-t[51:7000,2:12]
tes<-t[1:10,2:12]
drops <- c("SalaryNormalized","Title")
d$Title <- tm_map(d$Title[1], content_transformer(tolower))
d$Title <- tm_map(d$Title, stemDocument)
tes<-tes[ , !(names(tes) %in% drops)]
lm.fit <- lm(SalaryNormalized ~ Company+Category+SourceName,data = d)
summary(lm.fit)
pred<-predict(lm.fit,tes)
View(pred)
count<-0
for(i in range(1,length(tes)))
{
   print(paste0("prd:",round(pred[i],0)))
   print(paste0("tes",tes$SalaryNormalized[i]))
   if(round(pred[i],0) ==tes$SalaryNormalized[i])
      count=count+1
}
plot(tes$SalaryNormalized,pred)
for(title in t[,2]){
  if(length(grep("Support Worker",title))>0) 
    print(title)
}


####processing title
text<-c()
for(title in t$Title)
  text<-paste(text,title,sep="")
tc<-text
myCorpus<-Corpus(VectorSource(text))

#myCorpus<-data.frame(text = sapply(myCorpus, as.character), stringsAsFactors = FALSE)
#myCorpus <- tm_map(myCorpus, removeWords, stopwords('english'))
#myCorpus <- tm_map(myCorpus, content_transformer(tolower))
#myCorpus <- tm_map(myCorpus, removePunctuation)
#dictCorpus <- myCorpus
#myCorpus <- tm_map(myCorpus, stemDocument)
#myCorpusTokenized <- lapply(myCorpus, scan_tokenizer)
#myTokensStemCompleted <- lapply(myCorpusTokenized, stemCompletion, dictCorpus)

text<-removeNumbers(text)
text<-removePunctuation(text)
tdm <- TermDocumentMatrix(Corpus(VectorSource(text)),control = list(removePunctuation = TRUE,stopwords = TRUE))
freq <- rowSums(as.matrix(tdm))   
ord <- order(freq)   
freq[tail(ord)]   
##inspect(tdm)
li<-c()
##finding top words in title
for(i in 113760:113810){
li<-append(li,freq[ord[i]])
}




