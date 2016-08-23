import pandas as pd
import nltk 
import re
from sklearn.feature_extraction.text import CountVectorizer
from sklearn.feature_extraction.text import TfidfVectorizer
import numpy as np
from nltk.corpus import stopwords
from geopy.geocoders import Nominatim
import sys
reload(sys)
sys.setdefaultencoding("ISO-8859-1")
df = pd.read_csv('C:/sneha/spring16/Data_Science/project/code/y.csv')#read data to a dataframe
df1 = pd.DataFrame(data=df,columns=['ContractTime','Company','Category','SourceName','level','LocationNormalized'])#take only slected columns
dd = pd.get_dummies(df1, prefix=['ContractTime','Company','Category','SourceName','level'])#dummy code those columns
df=df.drop('ContractTime',axis=1)##drop the original columns from the main dataframe 
df=df.drop('Company',axis=1)#..................................................
df=df.drop('Category',axis=1)#..................................................
df=df.drop('SourceName',axis=1)#..................................................
df=df.drop('level',axis=1)
df=df.drop('level',axis=1)
df=pd.concat([df,dd], axis=1)#add new dummy coded columns to data frame
stop = set(stopwords.words('english'))
stop.update(['.', ',', '"', "'", '?', '!', ':', ';', '(', ')', '[', ']', '{', '}']) # remove punctuation 
#vectorizer = TfidfVectorizer(min_df=1,stop_words=stop)
#df['FullDescription'] = df['FullDescription'].apply(lambda x: x.decode('unicode_escape').encode('ascii', 'ignore').strip())
#corpus=df['FullDescription']
#X = vectorizer.fit_transform(corpus)
#a=pd.DataFrame(vectorizer.get_feature_names()) #features(ngrams)
#b=pd.DataFrame(X.toarray())#tf idf values of ngrams
#result=pd.DataFrame(b.values,columns= (a.iloc[:,0]).tolist())#combine the 2
#df=df.drop('FullDescription',axis=1)#drop the original columns from the main dataframe 
#df=df.drop('LocationNormalized',axis=1)#drop the original columns from the main dataframe 
#df=df.drop('SalaryRaw',axis=1)#drop the original columns from the main dataframe 
#result=pd.concat([df,result],axis=1)#added tf idf of column "Full Description"
newdf=pd.DataFrame(columns=['Latitude', 'Longitude'])
##Latitude Longitude generation
geolocator = Nominatim()
for i in range(0,len(df.index)):
	L=geolocator.geocode(df['LocationNormalized'][i],timeout=None)
	if L is not None:
		h=pd.DataFrame([[L.latitude,L.longitude]],columns=['Latitude', 'Longitude'])
	else:
		h=pd.DataFrame([[0,0]],columns=['Latitude', 'Longitude'])##put 0 for incorrect locations/errors
	newdf=newdf.append(h,ignore_index=True)
result=pd.concat([df,newdf],axis=1)
result=result.drop('LocationNormalized',axis=1)
##title processing
bigram_vectorizer = TfidfVectorizer(ngram_range=(1,2),token_pattern=r'\b\w+\b', min_df=1,stop_words=stop)#create bigrams
df['Title']=df['Title'].apply(lambda x: x.decode('unicode_escape').encode('ascii', 'ignore').strip())
corpus=df['Title']
X = bigram_vectorizer.fit_transform(corpus)
a=pd.DataFrame(bigram_vectorizer.get_feature_names())
b=pd.DataFrame(X.toarray())
result1=pd.DataFrame(b.values,columns= (a.iloc[:,0]).tolist())
result=result.drop('Title',axis=1)
result=pd.concat([result,result1],axis=1)
result.to_csv("C:/sneha/spring16/Data_Science/project/code/ynew.csv",index=False)
