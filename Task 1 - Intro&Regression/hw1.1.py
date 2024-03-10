import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split

# Load Boston House Dataset from CSV
data = pd.read_csv("boston.csv")

# Check for missing values
missing_values = data.isnull().sum()
print("Missing Values:\n", missing_values)


# Define the Linear Regression class
class LinearRegressionCustom:
    def __init__(self, learning_rate=0.01, n_iterations=1000):
        self.learning_rate = learning_rate
        self.n_iterations = n_iterations
        self.weights = None
        self.bias = None

    def fit(self, X, y):
        # Initialize weights and bias
        self.weights = np.zeros(X.shape[1])
        self.bias = 0

        # Gradient Descent
        for _ in range(self.n_iterations):
            # Calculate predictions
            predictions = self.predict(X)

            # Compute gradients
            d_weights = -(2 / X.shape[0]) * np.dot(X.T, (y - predictions))
            d_bias = -(2 / X.shape[0]) * np.sum(y - predictions)

            # Update weights and bias
            self.weights -= self.learning_rate * d_weights
            self.bias -= self.learning_rate * d_bias

    def predict(self, X):
        return np.dot(X, self.weights) + self.bias


# Split the data into features (X) and target variable (y)
X = data.drop('MEDV', axis=1)
y = data['MEDV']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=42)

# Linear Regression Model
lr_model = LinearRegressionCustom(learning_rate=0.01, n_iterations=1000)
X_train_bias = np.c_[np.ones(X_train.shape[0]), X_train]  # Add a column of ones for the bias term
lr_model.fit(X_train_bias, y_train)

# Predictions on the test set
X_test_bias = np.c_[np.ones(X_test.shape[0]), X_test]  # Add a column of ones for the bias term
y_pred_lr = lr_model.predict(X_test_bias)

# Mean Squared Error for Linear Regression
mse_lr = np.mean((y_test - y_pred_lr) ** 2)

# Scatter plot between the original and predicted house prices
plt.figure(figsize=(12, 6))
plt.scatter(y_test, y_pred_lr)
plt.title('Linear Regression: Original vs Predicted Prices')
plt.xlabel('Original Prices')
plt.ylabel('Predicted Prices')
plt.show()

# Experimental Report
print("\nExperimental Report:")
print("1. Linear Regression Model:")
print("   - Model Coefficients:", lr_model.weights)
print("   - Bias Term:", lr_model.bias)
print("   - Mean Squared Error on Testing Set:", mse_lr)
