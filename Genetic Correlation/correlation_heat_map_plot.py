import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt


#the input file should contain these columms : trait	,rg	,se	,z-score,	p-value
# Load the data
df = pd.read_excel('/path_to_correlation_file/.xlsx')

# Assign row and column numbers
df['Yrows'] = np.arange(1, 10)
df['Xrows'] = 1

# Pivot the dataframe for heatmap
result = df.pivot(index='Yrows', columns='Xrows', values='rg')

# Create labels for the heatmap
labels = np.asarray([f"{trait} \n {rg:.3f}" for trait, rg in zip(df['trait'], df['rg'])]).reshape(-1, 1)

# Plotting
fig, ax = plt.subplots(figsize=(17, 10))

# Add title to the Heat map
plt.title("The title", fontsize=18, y=1.05)

# Remove ticks and axes
ax.set_xticks([])
ax.set_yticks([])
ax.axis('off')

# Create the heatmap
sns.heatmap(result, annot=labels, fmt="", cmap=sns.diverging_palette(10, 220, n=100), 
            linewidths=0.30, ax=ax, annot_kws={"size": 18})

# Show the plot
plt.show()
