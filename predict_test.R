# Load necessary libraries
library(randomForest)

# Load the training and test data
trainData <- read.csv("processed_train.csv")
testData <- read.csv("processed_test.csv")

# Preprocess the training data (you should have done this already)
# Example preprocessing steps (make sure you do the same for testData)
trainData$Sex <- as.factor(trainData$Sex)
trainData$Embarked <- as.factor(trainData$Embarked)

# Handle missing values and other preprocessing steps here
# For example:
trainData$Age[is.na(trainData$Age)] <- mean(trainData$Age, na.rm = TRUE)

# Build the Random Forest model on the training data
rf_model <- randomForest(Survived ~ ., data = trainData, ntree = 100, mtry = 3, importance = TRUE)

# Preprocess the test data in the same way (ensure consistency with trainData preprocessing)
testData$Sex <- as.factor(testData$Sex)
testData$Embarked <- as.factor(testData$Embarked)

# Handle missing values in the test data as well (e.g., fill missing 'Age' or 'Fare')
testData$Age[is.na(testData$Age)] <- mean(trainData$Age, na.rm = TRUE)
testData$Fare[is.na(testData$Fare)] <- mean(testData$Fare, na.rm = TRUE)

# Make predictions on the test data using the trained model
predictions <- predict(rf_model, newdata = testData)

# Prepare the submission file with PassengerId and predictions
submission <- data.frame(PassengerId = testData$PassengerId, Survived = predictions)

# Write the predictions to a CSV file for submission
write.csv(submission, "submission.csv", row.names = FALSE)

# Output the first few rows of the submission to check
head(submission)
