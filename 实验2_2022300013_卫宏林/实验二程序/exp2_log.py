import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, confusion_matrix, classification_report

# Load the Seeds dataset
data = pd.read_csv('seeds_dataset.txt', sep='\s+', header=None)

# Add column names to the dataset
column_names = ['area', 'perimeter', 'compactness', 'length_of_kernel', 'width_of_kernel', 
                'asymmetry_coefficient', 'length_of_kernel_groove', 'seed_type']
data.columns = column_names

# Split the data into features and target variable
X = data.drop('seed_type', axis=1)
y = data['seed_type']

# Split the data into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Create an instance of Logistic Regression
model = LogisticRegression(max_iter=10000)  # Increased max_iter for convergence

# Fit the model to the training data
model.fit(X_train, y_train)

# Make predictions on the test data
y_pred = model.predict(X_test)

# Calculate the accuracy of the model
accuracy = accuracy_score(y_test, y_pred)
print("Accuracy:", accuracy)

# Print classification report
print("\nClassification Report:\n", classification_report(y_test, y_pred))

# Compute confusion matrix
cm = confusion_matrix(y_test, y_pred)

# Plot confusion matrix
plt.figure(figsize=(8, 6))
sns.heatmap(cm, annot=True, fmt='g', cmap='Blues', xticklabels=model.classes_, yticklabels=model.classes_)
plt.title('Confusion Matrix')
plt.xlabel('Predicted Label')
plt.ylabel('True Label')
plt.show()
