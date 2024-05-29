# Importing the necessary libraries
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
# Load Boston House Dataset from CSV
data = pd.read_csv("boston.csv")

# Correlation matrix
correlation_matrix = data.corr()
plt.figure(figsize=(12, 8))
sns.heatmap(correlation_matrix, annot=True, cmap='coolwarm', fmt='.2f')
plt.title('Correlation Matrix')
plt.show()