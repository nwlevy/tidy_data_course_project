runanalysis <-function()
{
    #read in the train data set
    train<-read.table("./UCI HAR Dataset/train/X_train.txt")
    
    #read in the activity numbers
    activity<-scan("./UCI HAR Dataset/train/y_train.txt")
    
    #read in the participant numbers
    participant<-scan("./UCI HAR Dataset/train/subject_train.txt")
    
    #add participant and activity columns to the train data set
    train<-cbind(participant,activity,train)
    
    
    #read in the test data set
    test<-read.table("./UCI HAR Dataset/test/X_test.txt")
    
    #read in the activity numbers
    activity<-scan("./UCI HAR Dataset/test/y_test.txt")
    
    #read in the participant numbers
    participant<-scan("./UCI HAR Dataset/test/subject_test.txt")
    
    #add participant and activity columns to the train data set
    test<-cbind(participant,activity,test)
    
    #merge the test and train data sets
    comb<-rbind(train,test)
    
    ##read in the feature names
    features<-read.table("./UCI HAR Dataset/features.txt",col.names=c("num","feature"))
    
    ##flag the features that correspond to mean() or std(), excluding meanFreq()
    relevantcols<-grep("mean[^F]|std()",features$feature)
    
    ##subset comb to just include participant, activity, and the relevant features
    newcomb<-comb[,c(1,2,relevantcols+2)]
    
    ###convert the activity numbers to factor variables
    activity_labels<-c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING")
    newcomb$activity<-factor(newcomb$activity,labels=activity_labels)
    
    ####make descriptive labels for features
    feattest<-features[relevantcols,2]
    feattest1<-gsub("^t","time ",feattest)
    feattest2<-gsub("^f","frequency domain signal ",feattest1)
    feattest3<-gsub("BodyBody","Body ",feattest2)
    feattest4<-gsub("Mag"," magnitude ",feattest3)
    feattest5<-gsub("Acc"," acceleration ",feattest4)
    feattest6<-gsub("Gyro","angulular_velocity",feattest5)
    feattest7<-gsub("std","standard deviation",feattest6)
    feattest8<-gsub(" ","_",feattest7)
    feattest9<-gsub("-","_",feattest8)
    feattest10<-gsub("__","_",feattest9)
    feattest11<-gsub("angulular","angular",feattest10)
    feattest12<-gsub("Bodyangular","Body_angular",feattest11)
    feattest13<-gsub("velocityJerk","velocity_jerk",feattest12)
    feattest14<-gsub("time","time_domain_signal",feattest13)
    
    ####add columns to data frame
    colnames(newcomb)<-c("participant","activity",feattest14)
    
    #####melt newcomb in order to make the data easier to group
    newcomb<-melt(newcomb,id=c("participant","activity"),measure.vars=colnames(newcomb)[3:68])
    
    #####group the data by participant, and then by activity
    newcomb<-dcast(newcomb,participant + activity ~ variable,mean)
    
    
}