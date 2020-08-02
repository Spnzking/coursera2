 xtrain = read.table(file.path(pathdata, "train", "X_train.txt"),header = FALSE)
 ytrain = read.table(file.path(pathdata, "train", "y_train.txt"),header = FALSE)
 subject_train = read.table(file.path(pathdata, "train", "subject_train.txt"),header = FALSE)
 xtest = read.table(file.path(pathdata, "test", "X_test.txt"),header = FALSE)
 ytest = read.table(file.path(pathdata, "test", "y_test.txt"),header = FALSE)
 subject_test = read.table(file.path(pathdata, "test", "subject_test.txt"),header = FALSE)
 features = read.table(file.path(pathdata, "features.txt"),header = FALSE)
 activityLabels = read.table(file.path(pathdata, "activity_labels.txt"),header = FALSE)
 colnames(xtrain) <- features[, 2]
 colnames(ytest) <- "activityId"
 colnames(ytrain) <- "activityId"
 colnames(subject_test) <- "subjectId"
 colnames(subject_train) <- "subjectId"
 colnames(activityLabels) <- c("activityId", "activityType")
 total_train <- cbind(ytrain, subject_train, xtrain)
 total <- rbind(total_test, total_train)
 colNames <- colnames(total)
 meanstd <- (grepl("activityId", colNames)| grepl("subjectId", colNames)| grepl("mean", colNames)| grepl("std", colNames))
 tidy1 <- total[meanstd == T]
 tidy2 <- merge(tidy1, activityLabels, by = "activityId", all.x = T)
 tidyset <- tidy2 %>% group_by(subjectId, activityId) %>% summarise_all(funs(mean))
 l <- merge(activityLabels, tidyset, by = "activityId")
 finaltidyset <- l
 write.table(finaltidyset, "finaltidyset.txt", row.names = F)
 