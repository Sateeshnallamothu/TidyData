library(dplyr)
setwd('TidyData')

#  assignment 3
# read common files.
act.lbl<-fread('UCI HAR Dataset/activity_labels.txt')  ## activity labels. 
cn<-fread('UCI HAR Dataset/features.txt')   ## read column/feature names
# read test data.
subject.test<-fread('UCI HAR Dataset/test/subject_test.txt')  ## test subject ids (1 to 30)
tstx<-fread('UCI HAR Dataset/test/X_test.txt',col.names=cn$V2)  ## read test data with variables
tsty<-fread('UCI HAR Dataset/test/y_test.txt')  ## test label 

#select features with 'mean' in it. 
tstx.final<-tstx[,grep("mean\\(\\)|std\\(\\)|gravityMean\\)",colnames(tstx)),with=FALSE]    ## list of mean() cols
 
# add activity and subject
tstx.final[,`:=`(Activity=act.lbl[tsty$V1]$V2,Subject=subject.test$V1)]    
table(tstx.final$Subject)
table(tstx.final$Activity)

# add meaningful names to columns/features. 
colnames(tstx.final)<-gsub('^t',"time",colnames(tstx.final))
# find mean of all features by Activity and by Suject. 
tidy.summ<-tstx.final%>%
  group_by(Activity,Subject)%>%
  summarize_all(mean)
#print
tidy.summ
# write to a file.
