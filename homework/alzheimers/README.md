# Detecting Alzheimer's Disease via Positron Emission Tomography

====
Positron Emission Tomography (PET) detects the metabolic processes in the body
and can be used to detec diseases in the brain, such as Alzheimer's Disease (AD). 
In the study of AD, there are two groups of subjects of particular interest:
one group is patients with mild cognitive impairment (MCI), and the other group
is AD patients. In this experiment we will build classification models to detect
AD from the features derived from PET imaging. 

===

## Data 

The dataset is in the Matlab data file `ad_data.mat`, where each patient is 
describe by 116 numerical features extracted from PET imaging. The dataset 
has been divided into a training set and a testing set. Training data (features) 
and labels are given in `X_train` and `y_train`, and testing data (features) 
and labels are given in `X_test` and `y_test`. You will find in the data
file 172 samples for training and 74 for testing.  The labels are given by 
1 (AD patient) and -1 (MCI patient). 


## Sparse Logistic Regression 

You will build classification models using the sparse logistic regression 
implemented by [SLEP](https://github.com/jiayuzhou/SLEP/blob/master/SLEP/functions/L1/L1R/LogisticR.m),
and investigate the effects of l1 regularization parameter on the number 
of features in the model (features with non-zero weights in `w`), and 
predictiveperformance on the testing data as measured by AUC 
(use Matlab function `perfcurve`). You can write a simple wrapper to 
call the `LogisticR`
```matlab
function [w, c] = logistic_l1_train(data, labels, par)
% OUTPUT w is equivalent to the first d dimension of weights in logistic train
% c is the bias term, equivalent to the last dimension in weights in logistic train.
% Specify the options (use without modification).
opts.rFlag = 1; % range of par within [0, 1].
opts.tol = 1e-6; % optimization precision
opts.tFlag = 4; % termination options.
opts.maxIter = 5000; % maximum iterations

[w, c] = LogisticR(data, labels, par, opts);
end
```
where `par` is the regularization parameter ranging from [0, 1]. Try 
the following parameters:
```matlab
par  = [0, 0.01, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1];
```
Write a brief report to analyze the results using what we learned 
in the class. In your report there should be two plots, showing how
AUC and number of features vary with different parameters in `par`. 

NOTE: in order to use `LogisticR` you will need to have a few 
dependent files of SLEP in your MATLAB search directory, which 
are `sll_opts.m` and `initFactor.m` located [here](https://github.com/jiayuzhou/SLEP/tree/master/SLEP/opts). You can copy those files to the folder of `LogisticR`. 

NOTE2: By default `LogisticR` does not allow zero as the regularization 
coefficient. You could do either of the following 1) use a small 
number e.g.,`1e-8`, other than 0; or 2) change the criteria 
in line 73 of [`LogisticR`](https://github.com/jiayuzhou/SLEP/blob/master/SLEP/functions/L1/L1R/LogisticR.m)
to be 
```matlab
if (z<0)
    error('\n z should be non-negative!\n');
end
```
