# BCI-final

## Data description
In this project, one datasets are used to train and test the classification model, the link below is the dataset I used (they are from same experiment but displayed as different format). 

http://predict.cs.unm.edu/downloads.php

https://openneuro.org/datasets/ds003490/versions/1.1.0

This dataset comes from the experiment “EEG: 3-Stim Auditory Oddball and Rest in Parkinson's” done by Cavanagh, from University of New Mexico (UNM). There are 28 Parkinson's disease patients and 28 healthy control participants, they completed 1-min eyes-open resting EEG, 1-min eyes-closed resting EEG and 3-stimulus auditory oddball task EEG, but I only use the resting part in this project. All experiments were done at 9 am. Also, the healthy control group only took the experiment one time, and PD group took the experiment two times, separate by 7 days, one on medication and one off medication (their dopaminergic medications prescribed for PD were discontinued for 15 hours overnight). This dataset use Brain Vision data collection system with 64 EEG channels (CPz is the online reference and AFz is terminal grounded), 1 VEOG channel and 3 accelerometer channels (X, Y, Z) on hand to monitor patients tremor. The sampling rate of this dataset is 500 Hz and the electrode is sintered Ag/AgCl electrode. For more information, please refer to [7].

Paper [1] and [6] also use this dataset to train or test their classification model. Below is the table about ICs label by ICA in different steps. There are only 32 components since I only leave 32 channel as my data input, which will be describes in next section. I separate the analysis between eyes-closed an eyes-open since I want to see if there is more ICs that will be label as “muscle” or “eye” in eyes-open cases. 

![image](https://github.com/chih3997/BCI-final/assets/171775921/5f1e20be-700c-4b8d-9edc-b198b64db4dc)


## I.	Introduction
This project focuses on Parkinson’s disease (PD). The main target is to distinguish PD patients from healthy control (HC) group using resting state electroencephalography (EEG) signal. The PD resting EEG data is recorded in four cases: eyes-open resting EEG / eyes-closed resting EEG and on-medication cases / off-medication cases. The features used in this project are power spectral and entropy. Power spectral are extracted from different frequency bands, includes delta band (2 ~ 4 Hz), theta band (4 ~ 8 Hz), alpha band (8 ~ 13 Hz), beta band (13 ~ 30 Hz), and gamma band (30 ~ 45 Hz). 

## II. Model Framwork

![image](https://github.com/chih3997/BCI-final/assets/171775921/ce0569e3-c420-469b-ad4d-cc280fae1e6a)
 
Figure 1. The placement of 32 electrodes [1]


## III. Validation


![image](https://github.com/chih3997/BCI-final/assets/171775921/ef634a19-4151-4369-8eba-7814118eb657)

Figure 2. Method to evaluate performance


## IV. Usage

## V. Result

I define PD as Positive groups, HC as negative groups.

![image](https://github.com/chih3997/BCI-final/assets/171775921/3244223f-0ce1-4ceb-8aff-5b0975fc0ce0)


## VI. Reference
1. Majid Aljalal, Saeed A. Aldosari, Khalil AlSharabi, Akram M. Abdurraqeeb and Fahd A. Alturki, “Parkinson’s Disease Detection from Resting-State EEG Signals Using Common Spatial Pattern, Entropy, and Machine Learning Techniques”, Diagnostics 2022
2. Mohamed Shaban, Amy W. Amara, “Resting-state electroencephalography based deep-learning for the detection of Parkinson’s disease”, PLoS One. 2022
3. Md Fahim Anjum, Arturo Espinoza, Rachel Cole, Arun Singh, Patrick May, Ergun Uc, Soura Dasgupta, Nandakumar Narayanan, “Resting-state EEG measures cognitive impairment in Parkinson’s disease”, preprint
4. Sahar Yassine, Ute Gschwandtner, Manon Auffret, Joan Duprez, Marc Verin, Peter Fuhr, Mahmoud Hassan,  “Identification of Parkinson's Disease Subtypes from Resting-State Electroencephalography”, Wiley
5. G. Gimenez-Aparisi, E. Guijarro-Estelles, A. Chornet-Lurbe, S. Ballesta-Martinez, M. Pardo-Hernandez, Y. Ye-Lin, “Early detection of Parkinson’s disease: Systematic analysis of the influence of the eyes on quantitative biomarkers in resting state electroencephalography”, Heliyon 9 (2023) e20625
6. Mehran Shabanpour, Neda Kaboodvand, Behzad Iravani, “Parkinson's disease is characterized by sub-second resting-state spatio-oscillatory patterns: A contribution from deep convolutional neural network”, NeuroImage: Clinical Volume 36, 2022
7. James F. Cavanagh, Praveen Kumar, Andrea A. Mueller, Sarah Pirio Richardson, and Abdullah Mueen, “Diminished EEG Habituation to Novel Events Effectively Classifies Parkinson’s Patients”, Clinical Neurophysiology, Volume 129, Issue 2, February 2018



