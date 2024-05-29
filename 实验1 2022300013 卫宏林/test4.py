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

# Split the data into features (X) and target variable (y)
X = data.drop('MEDV', axis=1)
y = data['MEDV']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1, random_state=42)

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

print("Ridge Regression Model Coefficients:")
print(ridge_model_final.coef_)
print("Ridge Regression Model Intercept:")
print(ridge_model_final.intercept_)
print("Ridge Regression Model Score:")
print(ridge_model_final.score(X_test, y_test))


y_pred_ridge = ridge_model_final.predict(X_test)
mse_ridge = mean_squared_error(y_test, y_pred_ridge)

plt.scatter(y_test, y_pred_ridge)
plt.title('Ridge Regression: Original vs Predicted Prices')
plt.xlabel('Original Prices')
plt.ylabel('Predicted Prices')

plt.tight_layout()
plt.show()

print("\n2. Ridge Regression Model:")
print("   - Best Hyper-parameter (alpha) selected:", best_alpha)
print("   - Average MSE on Training Set (10-fold Cross Validation):", best_mse_ridge)

print("\n3. Evaluation on Testing Set:")
print("   - Ridge Regression Model MSE on Testing Set:", mse_ridge)