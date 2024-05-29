import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split, KFold

# Step 1: Data Preprocessing
data = pd.read_csv("2022300013卫宏林/boston.csv")
X = data.drop(columns=["MEDV"]).values
y = data["MEDV"].values

# Add a column of ones to the feature matrix for the intercept term
X = np.c_[np.ones(X.shape[0]), X]

# Split data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=42)

# Step 2: Model Training
def train_linear_regression(X_train, y_train):
    # Calculate the coefficients using the least squares method
    coefficients = np.linalg.inv(X_train.T @ X_train) @ X_train.T @ y_train
    return coefficients

coefficients = train_linear_regression(X_train, y_train)

# Step 3: Model Evaluation
def cross_validation_mse(X, y, k=10):
    kf = KFold(n_splits=k)
    mse_values = []
    for train_index, val_index in kf.split(X):
        X_train_fold, X_val_fold = X[train_index], X[val_index]
        y_train_fold, y_val_fold = y[train_index], y[val_index]
        # Train the model on the training fold
        coefficients_fold = train_linear_regression(X_train_fold, y_train_fold)
        # Make predictions on the validation fold
        y_pred_fold = X_val_fold @ coefficients_fold
        # Calculate MSE for the fold
        mse_fold = np.mean((y_pred_fold - y_val_fold) ** 2)
        mse_values.append(mse_fold)
    return np.mean(mse_values)

average_mse = cross_validation_mse(X_train, y_train)

# Step 4: Prediction
y_pred_test = X_test @ coefficients

# Step 5: Performance Evaluation
mse_test = np.mean((y_pred_test - y_test) ** 2)

print("Coefficients:", coefficients)
print("Average MSE on training set (10-fold cross-validation):", average_mse)
print("MSE on testing set:", mse_test)
