# Import necessary libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split, cross_val_score, KFold
from sklearn.linear_model import LinearRegression, Ridge
from sklearn.metrics import mean_squared_error

# Load Boston House Dataset from CSV
data = pd.read_csv("boston.csv")

# Check for missing values
missing_values = data.isnull().sum()
print("Missing Values:\n", missing_values)

# Export missing values to Excel
# missing_values.to_excel("missing_values.xlsx", header=["Missing Values"])

# Exploratory Data Analysis
# Distribution of the target variable (MEDV)
plt.figure(figsize=(12, 6))
sns.histplot(data['MEDV'], bins=30, kde=True)
plt.title('Distribution of House Prices')
plt.xlabel('Price (MEDV)')
plt.ylabel('Frequency')
plt.show()

# Correlation matrix
correlation_matrix = data.corr()
plt.figure(figsize=(12, 8))
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt='.2f')
plt.title('Correlation Matrix')
plt.show()

# Split the data into features (X) and target variable (y)
X = data.drop('MEDV', axis=1)
y = data['MEDV']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=42)

# Linear Regression Model
lr_model = LinearRegression()
lr_model.fit(X_train, y_train)

# 10-fold cross-validation for Linear Regression
cv_scores_lr = cross_val_score(lr_model, X_train, y_train, cv=10, scoring='neg_mean_squared_error')
avg_mse_lr = -np.mean(cv_scores_lr)

# Ridge Regression Model with hyper-parameter tuning
alphas = [0.1, 1, 10, 100]
best_alpha = None
best_mse_ridge = float('inf')

for alpha in alphas:
    ridge_model = Ridge(alpha=alpha)
    cv_scores_ridge = cross_val_score(ridge_model, X_train, y_train, cv=10, scoring='neg_mean_squared_error')
    avg_mse_ridge_cv = -np.mean(cv_scores_ridge)

    if avg_mse_ridge_cv < best_mse_ridge:
        best_mse_ridge = avg_mse_ridge_cv
        best_alpha = alpha

# Final Ridge Regression Model with the best hyper-parameter
ridge_model_final = Ridge(alpha=best_alpha)
ridge_model_final.fit(X_train, y_train)

# Evaluate models on the testing set
y_pred_lr = lr_model.predict(X_test)
mse_lr = mean_squared_error(y_test, y_pred_lr)

y_pred_ridge = ridge_model_final.predict(X_test)
mse_ridge = mean_squared_error(y_test, y_pred_ridge)

# Scatter plot between the original and predicted house prices
plt.figure(figsize=(12, 6))

plt.subplot(1, 2, 1)
plt.scatter(y_test, y_pred_lr)
plt.title('Linear Regression: Original vs Predicted Prices')
plt.xlabel('Original Prices')
plt.ylabel('Predicted Prices')

plt.subplot(1, 2, 2)
plt.scatter(y_test, y_pred_ridge)
plt.title('Ridge Regression: Original vs Predicted Prices')
plt.xlabel('Original Prices')
plt.ylabel('Predicted Prices')

plt.tight_layout()
plt.show()

# Experimental Report
print("\nExperimental Report:")
print("1. Linear Regression Model:")
print("   - Model Coefficients:", lr_model.coef_)
print("   - Average MSE on Training Set (10-fold Cross Validation):", avg_mse_lr)

print("\n2. Ridge Regression Model:")
print("   - Best Hyper-parameter (alpha) selected:", best_alpha)
print("   - Average MSE on Training Set (10-fold Cross Validation):", best_mse_ridge)

print("\n3. Evaluation on Testing Set:")
print("   - Linear Regression Model MSE on Testing Set:", mse_lr)
print("   - Ridge Regression Model MSE on Testing Set:", mse_ridge)
