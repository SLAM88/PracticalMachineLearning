library(caret)
library(gbm)
library(plyr)

training <- read.csv("pml-training.csv")
testing <- read.csv("pml-testing.csv")

newtrain <- training[,!is.na(training[1,])]
drops <- c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "kurtosis_yaw_belt", "skewness_yaw_belt", "amplitude_yaw_belt", "kurtosis_yaw_dumbbell", "skewness_yaw_dumbbell", "kurtosis_yaw_forearm", "skewness_yaw_forearm", "amplitude_yaw_forearm")
newtrain <- newtrain[,!(colnames(newtrain) %in% drops)]
drops2 <- c("kurtosis_picth_belt", "skewness_roll_belt.1", "kurtosis_roll_arm", "kurtosis_picth_arm", "skewness_roll_arm", "skewness_pitch_arm", "kurtosis_yaw_arm", "skewness_yaw_arm", "kurtosis_roll_forearm", "kurtosis_picth_forearm", "skewness_roll_forearm", "skewness_pitch_forearm", "max_yaw_forearm", "min_yaw_forearm")
newtrain <- newtrain[,!(colnames(newtrain) %in% drops2)]
drops3 <- c("kurtosis_roll_belt", "skewness_roll_belt", "max_yaw_belt", "min_yaw_belt", "kurtosis_roll_dumbbell", "kurtosis_picth_dumbbell", "skewness_roll_dumbbell", "skewness_pitch_dumbbell", "num_window", "max_yaw_dumbbell", "min_yaw_dumbbell", "amplitude_yaw_dumbbell")
newtrain <- newtrain[,!(colnames(newtrain) %in% drops3)]

newtest <- testing[,!is.na(testing[1,])]
drops <- c("X", "user_name", "raw_timestamp_part_1", "raw_timestamp_part_2", "cvtd_timestamp", "new_window", "kurtosis_yaw_belt", "skewness_yaw_belt", "amplitude_yaw_belt", "kurtosis_yaw_dumbbell", "skewness_yaw_dumbbell", "kurtosis_yaw_forearm", "skewness_yaw_forearm", "amplitude_yaw_forearm")
newtest <- newtest[,!(colnames(newtest) %in% drops)]
drops2 <- c("kurtosis_picth_belt", "skewness_roll_belt.1", "kurtosis_roll_arm", "kurtosis_picth_arm", "skewness_roll_arm", "skewness_pitch_arm", "kurtosis_yaw_arm", "skewness_yaw_arm", "kurtosis_roll_forearm", "kurtosis_picth_forearm", "skewness_roll_forearm", "skewness_pitch_forearm", "max_yaw_forearm", "min_yaw_forearm")
newtest <- newtest[,!(colnames(newtest) %in% drops2)]
drops3 <- c("kurtosis_roll_belt", "skewness_roll_belt", "max_yaw_belt", "min_yaw_belt", "kurtosis_roll_dumbbell", "kurtosis_picth_dumbbell", "skewness_roll_dumbbell", "skewness_pitch_dumbbell", "num_window", "max_yaw_dumbbell", "min_yaw_dumbbell", "amplitude_yaw_dumbbell")
newtest <- newtest[,!(colnames(newtest) %in% drops3)]

set.seed(7634)
# Preloads CV options. Allows parallel processing for faster performance.
fitControl <- trainControl(method = "cv",number = 10, allowParallel=T)
# Runs the boosting ML algorithm on the training dataset
test <- train(classe ~., method = "gbm", data = newtrain, trControl = fitControl, verbose = FALSE)
