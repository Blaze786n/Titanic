# Check if required packages are installed; if not, install them
if (!require(dplyr)) install.packages("dplyr", dependencies=TRUE)
if (!require(caret)) install.packages("caret", dependencies=TRUE)

# Load the libraries
library(dplyr)
library(caret)

# Load the dataset
data <- read.csv("train.csv")

# Drop the 'Cabin' column due to many missing values
data <- select(data, -Cabin)

# Convert 'Sex' column to binary (0 for male, 1 for female)
data$Sex <- ifelse(data$Sex == "female", 1, 0)

# Fill missing values in 'Age' using linear regression
# Split data into rows with and without missing 'Age' values
age_data <- data[!is.na(data$Age), ]
missing_age_data <- data[is.na(data$Age), ]

# Build a linear regression model to predict 'Age'
age_model <- lm(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked, data = age_data)

# Predict 'Age' for rows where 'Age' is missing
predicted_ages <- predict(age_model, newdata = missing_age_data)

# Fill missing 'Age' values with the predictions
data$Age[is.na(data$Age)] <- predicted_ages

# Fill missing 'Embarked' values with the most frequent value
data$Embarked[is.na(data$Embarked)] <- as.character(names(sort(table(data$Embarked), decreasing = TRUE))[1])

# One-hot encode the 'Embarked' column
data <- cbind(data, model.matrix(~ Embarked - 1, data))

# Remove the original 'Embarked' column after encoding
data <- select(data, -Embarked)

# Write the cleaned data to a new CSV file
write.csv(data, "processed_train.csv", row.names = FALSE)

# Check the final structure to confirm it’s ready for modeling
str(data)
