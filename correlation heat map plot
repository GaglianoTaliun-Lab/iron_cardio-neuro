import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt

#the input file should contain these columms : trait	,rg	,se	,z-score,	p-value
df=pd.read_excel('path to correlation file')
df['Yrows']=[1,2,3,4,5,6,7,8,9]
df['Xrows']=[1,1,1,1,1,1,1,1,1]
trait = ((np.asarray(df['trait'])).reshape(1,9))
rg = ((np.asarray(df['rg'])).reshape(1,9))
result = df.pivot(index='Yrows',columns='Xrows',values='rg')
print(result)
labels = (np.asarray(["{0} \n {1:.3f}".format(symb,value)
                      for symb, value in zip(trait.flatten(),
                                               rg.flatten())])
         ).reshape(9,1)

fig, ax = plt.subplots(figsize=(17,10))

# Add title to the Heat map
title = "The title"
plt.title(title,fontsize=18)
ttl = ax.title
ttl.set_position([0.5,1.05])

ax.set_xticks([])
ax.set_yticks([])
ax.axis('off')
sns.heatmap(result,annot=labels,fmt="",cmap=sns.diverging_palette(10,220, n=100),linewidths=0.30,ax=ax,annot_kws={"size": 18})

plt.show()
