###Course 3 Week 4 Final Assignment###

###Part 1###

  # Read in data sets and combine relevant ones together
  XtestData <- read.table("UCI HAR Dataset/test/X_test.txt")
  XtrainData <- read.table("UCI HAR Dataset/train/X_train.txt")
  Xdata <- rbind(XtestData, XtrainData)
  subTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
  subTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
  Subjects <- rbind(subTest, subTrain)
  YtestData <- read.table("UCI HAR Dataset/test/y_test.txt")
  YtrainData <- read.table("UCI HAR Dataset/train/y_train.txt")
  Ydata <- rbind(YtestData, YtrainData)
  
  
###Part 2###
  
  features <- read.table("UCI HAR Dataset/features.txt")
  
  keepSDmean <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])
  
  Xdata <- Xdata[, keepSDmean]
  names(Xdata) <- features[keepSDmean, 2]
  names(Xdata) <- gsub("\\(|\\)", "", names(Xdata))
  names(Xdata) <- tolower(names(Xdata))
  
 ###Step 3###
  
  # Read Activity Labels
  activities <- read.table("UCI HAR Dataset/activity_labels.txt")
  activities[,2] = gsub("_", "", tolower(as.character(activities[,2])))
  Ydata[,1] = activities[Ydata[,1], 2]
  names(Ydata) <- "activity" 
  
  ###Step 4###
  
  # Add labels to activity names
  names(Subjects) <- "subject" 
  tidyData <- (cbind(Subjects, Ydata, Xdata))
  write.table(tidyData, "tidyData.txt")
  
  ###Step 5###
  
  ## Create second tiny data set with avg of each var for each act and each sub
  tidyData2 <- ddply(tidyData, .(subject, activity), function(x) colMeans(tidyData[3:68]))
  
  write.table(tidyData2, "tidyData2.txt", row.name=FALSE)
  
  identical(tidyData, tidyData2)
 
  
  