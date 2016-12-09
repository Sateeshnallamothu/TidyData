library(dplyr)
library(data.table)
setwd('TidyData')

#  assignment 3
# read common files.
act.lbl<-fread('UCI HAR Dataset/activity_labels.txt')  ## activity labels. 
cn<-fread('UCI HAR Dataset/features.txt')   ## read column/feature names

# read test data.
subject.test<-fread('UCI HAR Dataset/test/subject_test.txt')  ## test subject ids (1 to 30)
tstx<-fread('UCI HAR Dataset/test/X_test.txt',col.names=cn$V2)  ## read test data with variables
tsty<-fread('UCI HAR Dataset/test/y_test.txt')  ## test label 

# read training data.
subject.train<-fread('UCI HAR Dataset/train/subject_train.txt')  ## traiin subject ids (1 to 30)
trnx<-fread('UCI HAR Dataset/train/X_train.txt',col.names=cn$V2)  ## read train data with variables
trny<-fread('UCI HAR Dataset/train/y_train.txt')  ## train label 

#select features with 'mean' and 'std' in it.   test data
tstx.final<-tstx[,grep("mean\\(\\)|std\\(\\)|gravityMean\\)",colnames(tstx)),with=FALSE]    ## list of mean() cols

#select features with 'mean' and 'std' in it.   training data
trnx.final<-trnx[,grep("mean\\(\\)|std\\(\\)|gravityMean\\)",colnames(trnx)),with=FALSE]    ## list of mean() cols

# add activity and subject to test
tstx.final[,`:=`(Activity=act.lbl[tsty$V1]$V2,Subject=subject.test$V1)] 

# add activity and subject to training data
trnx.final[,`:=`(Activity=act.lbl[trny$V1]$V2,Subject=subject.train$V1)]

# merger both test and train into single data.table.
master.data <- rbind(tstx.final,trnx.final)

# quick check
table(master.data$Subject)
table(master.data$Activity)

# add meaningful names to columns/features. 
colnames(master.data)<-gsub('^t',"time",colnames(master.data))
colnames(master.data)<-gsub('\\(t',"(time",colnames(master.data))
colnames(master.data)<-gsub('^f',"frequency",colnames(master.data))

# write master data to a file.
write.table(master.data,file="tidymaster.txt",row.names = FALSE)

#create master code book with feature names
write.table(colnames(master.data),file='masterfeatures.txt',row.names=F,col.names=F)

# find mean of all features by Activity and by Suject. 
tidy.summary<-master.data %>%
  group_by(Activity,Subject) %>%
  summarize_all(mean)

#print
tidy.summary

# write summary to a file.
write.table(tidy.summary,file="tidysummary.txt",row.names = FALSE)
 
#create code book with feature names
write.table(colnames(tidy.summary),file='tidyfeatures.txt',row.names=F,col.names=F)
