import pandas as pd
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier, plot_tree
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
import matplotlib.pyplot as plt
import seaborn as sns

# Load the Seeds dataset
data = pd.read_csv('seeds_dataset.txt', sep='\s+', header=None)

# Split the data into features and target variable
X = data.iloc[:, :-1]
y = data.iloc[:, -1]

# Split the dataset into training and testing sets
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=1)

# Initialize the Decision Tree Classifier
clf = DecisionTreeClassifier()

# Fit the model
clf.fit(X_train, y_train)

# Make predictions
y_pred = clf.predict(X_test)

# Evaluate the model
print("Accuracy:", accuracy_score(y_test, y_pred))
print("\nClassification Report:\n", classification_report(y_test, y_pred))

# Plot confusion matrix
# cm = confusion_matrix(y_test, y_pred)
# plt.figure(figsize=(8, 6))
# sns.heatmap(cm, annot=True, fmt='d', cmap='Blues', xticklabels=['Kama', 'Rosa', 'Canadian'], yticklabels=['Kama', 'Rosa', 'Canadian'])
# plt.title('Confusion Matrix')
# plt.ylabel('Actual label')
# plt.xlabel('Predicted label')
# plt.show()

# Simplified Visualization
plt.figure(figsize=(35, 25))
plot_tree(clf, filled=True, feature_names=X.columns, class_names=['Kama', 'Rosa', 'Canadian'], fontsize=10)
plt.show()
