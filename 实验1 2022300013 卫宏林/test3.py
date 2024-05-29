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

# Linear Regression Model
lr_model = LinearRegression()
lr_model.fit(X_train, y_train)

print("Linear Regression Model Coefficients:")
print(lr_model.coef_)
print("Linear Regression Model Intercept:")
print(lr_model.intercept_)
print("Linear Regression Model Score:")
print(lr_model.score(X_test, y_test))


# 10-fold cross-validation for Linear Regression
cv_scores_lr = cross_val_score(lr_model, X_train, y_train, cv=10, scoring='neg_mean_squared_error')
avg_mse_lr = -np.mean(cv_scores_lr)

# Evaluate models on the testing set
y_pred_lr = lr_model.predict(X_test)
mse_lr = mean_squared_error(y_test, y_pred_lr)

# Scatter plot between the original and predicted house prices

plt.scatter(y_test, y_pred_lr)
plt.title('Linear Regression: Original vs Predicted Prices')
plt.xlabel('Original Prices')
plt.ylabel('Predicted Prices')
plt.show()

