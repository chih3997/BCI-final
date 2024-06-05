# BCI-final

## Data description
In this project, one datasets are used to train and test the classification model, the link below is the dataset I used (they are from same experiment but displayed as different format). 

http://predict.cs.unm.edu/downloads.php

https://openneuro.org/datasets/ds003490/versions/1.1.0

This dataset comes from the experiment “EEG: 3-Stim Auditory Oddball and Rest in Parkinson's” done by Cavanagh, from University of New Mexico (UNM). There are 28 PD patients and 28 healthy control participants, they completed 1-min eyes-open resting EEG, 1-min eyes-closed resting EEG and 3-stimulus auditory oddball task EEG, but I only use the resting part in this project. All experiments were done at 9 am. Also, the healthy control group only took the experiment one time, and PD group took the experiment two times, separate by 7 days, one on medication and one off medication (their dopaminergic medications prescribed for PD were discontinued for 15 hours overnight). This dataset use Brain Vision data collection system with 64 EEG channels (CPz is the online reference and AFz is terminal grounded), 1 VEOG channel and 3 accelerometer channels (X, Y, Z) on hand to monitor patients tremor. The sampling rate of this dataset is 500 Hz and the electrode is sintered Ag/AgCl electrode. For more information, please refer to [7].

Paper [1] and [6] also use this dataset to train or test their classification model. Below is the table about ICs label by ICA in different steps. There are only 32 components since I only leave 32 channel as my data input, which will be describes in next section. I separate the analysis between eyes-closed an eyes-open since I want to see if there is more ICs that will be label as “muscle” or “eye” in eyes-open cases. We can see that there are more “muscle” components in eyes-open cases. Also, after filtering, the average number of “Brain” component increased significantly and there are almost no “Line Noise” component.

![image](https://github.com/chih3997/BCI-final/assets/171775921/5f1e20be-700c-4b8d-9edc-b198b64db4dc)




## I.	Introduction
This project focuses on Parkinson’s disease (PD). The main target is to distinguish PD patients from healthy control (HC) group using resting state electroencephalography (EEG) signal. The PD resting EEG data is recorded in four cases: eyes-open resting EEG / eyes-closed resting EEG and on-medication cases / off-medication cases.

## II. Model Framwork

## III. Validation
## IV. Usage
## V. Result
## VI. Reference


