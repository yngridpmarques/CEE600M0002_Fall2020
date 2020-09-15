#reads in NOAA daily weather values
#generates linear trend in TAVG
#prints model results to "results.txt"
#Writen by Elizabeth Carter, ekcarter@syr.edu, 9/13/2020

import pandas as pd
import numpy as np
from statsmodels.api import OLS

weather_dat=pd.read_csv("2281205.csv")
Y = np.array(range(weather_dat.shape[0]))
X = np.array(weather_dat.TAVG)

Y=Y[np.logical_not(np.isnan(X))]
X=X[np.logical_not(np.isnan(X))]

results =OLS(X,Y).fit().summary()

text_file = open("results.txt", "w")
text_file.write(str(results))
text_file.close()
