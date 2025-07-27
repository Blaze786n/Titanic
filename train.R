# Load required libraries
library(randomForest)

library(randomForest)

# Load the processed training data
train <- read.csv("processed_train.csv")

# Define the features and target variable
features <- c("Pclass", "Sex", "Age", "SibSp", "Parch", "Fare", "EmbarkedC", "EmbarkedQ", "EmbarkedS")

# Select the relevant columns for the features
train_data <- train[, features]  # Use only selected features
train_labels <- train$Survived   # Assuming 'Survived' is your target column

# Train the Random Forest model
set.seed(42)  # For reproducibility
rf_model <- randomForest(x = train_data, y = as.factor(train_labels), ntree = 100, mtry = 3)

# Print model summary to view results
print(rf_model)
