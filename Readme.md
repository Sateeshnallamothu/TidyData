# Tidy data files
## Script flow
### The script will first load necessary data.table package and sets the directory to working path. After that, it will read common files (like features and subject vector), test and training data sets along with subject and activity labels. 
### The next step is to select the necessary columns (i.e. columns with mean() and std()) from both test and training data sets. Using data.table functions, we next need to add the activity description and subject numbers to the test and training tables. 
### merge the two data sets using rbind to combine master tidy data. In order to specify the unit of measurement, replace 't' with time(in Sec) and 'f' with frequency (in Hz).
### Using pipeline operator '%>%', the master tidy data is grouped by the Activity and the Subject. After then, the 'mean/average' of all the features are calculated using 'summary_all' function. 
## Tidy Master data.
### tidymaster.txt is the final tidy data merging test and training data sets and includes mean() and std() columns only. 
### masterfeatures.txt is the code book for the master data. 
## Summary data
### tidysummary.txt is the summary of average of each variable for each activity and each subject.
