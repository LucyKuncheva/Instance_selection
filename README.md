# instance_selection
Prototype/Instance Selection for the 1-nn Classifier (MATLAB)

#### George Dataset (George the fish)
<img src="https://github.com/LucyKuncheva/instance_selection/blob/master/GeorgeImage.jpg" width="200"/>

##### Data Files

 * `GeorgeTheFish.mat` contains the full data set (see the image `GeorgeImage.jpg`) of 300679x2 x-y coordinates in variable `GeorgeData` and the labels in variable `GeorgeLabels`. 

 * `GeorgeTheFish.csv` contains the full data set of 300679x2 x-y coordinates in columns 1 and 2 and the labels in column 3. 

 * `DataClean.mat` contains the sampled data set of 1000x2 x-y coordinates in variable `Data` and the labels in variable `Labels`. 

 * `DataNoise.mat` contains the same data as above in variable `DataN (= Data)` and the labels in variable `LabelsN`, where 10% have been changed to a different class (label noise).

 * `DataGeorge.csv` contains the sampled data (columns 1 and 2), the original labels (column 3) and the labels with noise (column 4).


##### Data Manipulation
 * `PlotGeorgeData.m` plots the original data, the sampled data and the classification regions of 1-nn with the clean and noisy reference sets.

 * `plot_george.m` a function which plots the classification regions for a given set of prototypes and their labels


##### Prototype Selection
 * `GeorgeExperimentDemo.m` runs a short version of the experiment with the clean data. The RMHC, MC1 and GA are run with 20 prototypes only and with reduced number of evaluations of the criterion function compared to that in [1]. The output in the MATLAB command window are the error rates, the number of prototypes, and the time in seconds for the respective prototype selection methods. A figure with 9 subplots is also constructed. Each subplot contains the classification regions for the George data. The title of the subplot is the method name and the number of prototypes in parentheses.

 * `edit_hart.m` is a function which runs Hart's condensing method.

 * `edit_wilson.m` is a function which runs Wilson's editing method.

 * `edit_wilson_hart.m` is a function which runs Wilson's editing method followed by Hart's condensing method.

 * `edit_rnge.m` is a function which runs Relative Neighbourhood Graph Editing (RNGE) editing method.
 
 * `edit_rnn.m` is a function which runs the Relative Nearest Neighbour (RNN) condensing method.

 * `edit_rmhc.m` is a function which runs the Random Mutation Hill Climbing (RMHC) hybrid algorithm.

 * `edit_random.m` is a function which runs the random search (Monte Carlo 1) for prototype selection.

 * `edit_ga.m` is a function which runs the Genetic Algorithm  for prototype selection detailed in [1].


##### Reference
[1] L Kuncheva. Prototype classifiers and the big fish. (under review)
