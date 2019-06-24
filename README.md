# instance_selection
Prototype/Instance Selection for the 1-nn Classifier (MATLAB)

#### George Dataset (George the fish)
<img src="https://github.com/LucyKuncheva/instance_selection/blob/master/GeorgeImage.jpg" width="200"/>

Data Files

  * `GeorgeTheFish.mat` contains the full data set (see the image `GeorgeImage.jpg`) of 300679x2 x-y coordinates in variable `GeorgeData` and the labels in variable `GeorgeLabels`. 
  
  * `GeorgeTheFish.csv` contains the full data set of 300679x2 x-y coordinates in columns 1 and 2 and the labels in column 3. 

  * `DataClean.mat` contains the sampled data set of 1000x2 x-y coordinates in variable `Data` and the labels in variable `Labels`. 

  * `DataNoise.mat` contains the same data as above in variable `DataN (= Data)` and the labels in variable `LabelsN`, where 10% have been changed to a different class (label noise).
  
  * `DataGeorge.csv` contains the sampled data (columns 1 and 2), the original labels (column 3) and the labels with noise (column 4).
  
Data Manipulation
  * `PlotGeorgeData.m` plots the original data, the sampled data and the classification regions of 1-nn with the clean and noisy reference sets.

#### UNDER CONSTRUCTION
