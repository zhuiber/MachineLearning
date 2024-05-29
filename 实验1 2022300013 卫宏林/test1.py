# Importing the necessary libraries
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
# Load Boston House Dataset from CSV
data = pd.read_csv("boston.csv")

# Distribution of the target variable (MEDV)
plt.figure(figsize=(12, 6))
sns.histplot(data['MEDV'], bins=30, kde=True)
plt.xlabel('房价 (MEDV)',fontname='SimHei',fontsize=15)
plt.ylabel('频率',fontname='SimHei',fontsize=15)
plt.show()