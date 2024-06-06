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

![image](https://github.com/chih3997/BCI-final/assets/171775921/29b782b6-0295-418d-a3ca-f9eac89218bc)
Figure 1. Model framwork

### i. Data Pre-processing
1. Redundant channels are removed from the dataset, leaving only 32 EEG channels.
2. Choose events that represent eyes-open stage (S1, S2) and eyes-closed stage (S3, S4).
3. Re-reference all of the data to the common average and remove the mean of each channel.
4. Apply a band-pass filter with lower cut-off frequency at 1 Hz and higher cut-off frequency at 48 Hz to reduce low-frequency drift and high-frequency power line noise. I choose 48 Hz because I only need the data between 2 ~ 45 Hz and if I use 50 Hz there might be some power line noise remain. 
5. Remove eye movement and blink artifacts (especially on eyes-open cases) automatically by EEG artifact rejection toolbox -- artifact subspace reconstruction (ASR).
6. Apply ICA on the dataset and only keep the components that are marked as “Brain” with probability larger than 75%.
7. Divide data into 10 seconds data segments.

![image](https://github.com/chih3997/BCI-final/assets/171775921/ce0569e3-c420-469b-ad4d-cc280fae1e6a)  
Figure 2. The placement of 32 electrodes [1]

### ii. Feature Extraction

Since SVM and KNN are not good at handling large number of feature, to reduce number of feature, I divide the brain into 5 region: Frontal, Central, Parietal, Temporal, and Occipital, as indicated in Figure 2. The feature will be extracted based on the brain region. There are total 30 features, 5 for time domain and 25 for frequency domain.

For time domain features, calculate mean Renyi Entropy of the EEG segments of 5 brain regions.

For frequency domain features, perform FFT on data segments which are pre-filtered by the Hanning window and extract mean power from different frequency band of 5 brain regions, includes delta band (2 ~ 4 Hz), theta band (4 ~ 8 Hz), alpha band (8 ~ 13 Hz), beta band (13 ~ 30 Hz), and gamma band (30 ~ 45 Hz).

### iii. Classification
I use SVM and KNN to classify the data. The classification is done in different cases. List as below.
1. eyes-open resting EEG and on-medication PD vs HC 
2. eyes-closed resting EEG and on-medication PD vs HC
3. eyes-open resting EEG and off-medication cases PD vs HC
4. eyes-closed resting EEG and off-medication cases PD vs HC
5. eyes- open resting EEG off-medication cases PD vs on-medication PD
6. eyes-closed resting EEG off-medication cases PD vs on-medication PD


## III. Validation

In this project, the methods to evaluate the performance includes accuracy, precision, recall, and F1 score.

![image](https://github.com/chih3997/BCI-final/assets/171775921/ef634a19-4151-4369-8eba-7814118eb657)  
Figure 3. Method to evaluate performance


## IV. Usage

Code in folder **matlab_code**

1. **data_preprocessing.m** : pre-process the data.
2. **count_ics.m** : help to count average number of ics label by ICLabel.
3. **cut_data_seg.m** : cut data into 10 seconds segments.
4. **freq_analysis.m** : applying fft to extract frequency domain power spectral.
5. **freq_band_power.m** : extract power spectral from each frequency band.
6. **feature_output.m** : output all feature to a csv file.
7. **participants.m** : classify participants from their ID.

Code in folder **python_code**

1. **SVM_classifier.ipynb** : SVM classifier to classify PD and HC.
2. **KNN_classifier.ipynb** : KNN classifier to classify PD and HC.

## V. Result

I define PD as Positive groups, HC as negative groups when comparing PD and HC, and define off-PD as Positive groups, on-PD as negative groups when comparing on-PD and off-PD. KNN shows better performance on classification and both eyes-open and eyes-closed resting EEG can be used to distinguish PD and HC.

![image](https://github.com/chih3997/BCI-final/assets/171775921/470c380e-32fa-43d1-a031-c4c636de0dfc)  
Figure 4. SVM performance result

![image](https://github.com/chih3997/BCI-final/assets/171775921/3cc21a36-131c-4084-8cc2-7b3a2be1fc0f)  
Figure 5. KNN performance result


## VI. Reference
1. Majid Aljalal, Saeed A. Aldosari, Khalil AlSharabi, Akram M. Abdurraqeeb and Fahd A. Alturki, “Parkinson’s Disease Detection from Resting-State EEG Signals Using Common Spatial Pattern, Entropy, and Machine Learning Techniques”, Diagnostics 2022
2. Mohamed Shaban, Amy W. Amara, “Resting-state electroencephalography based deep-learning for the detection of Parkinson’s disease”, PLoS One. 2022
3. Md Fahim Anjum, Arturo Espinoza, Rachel Cole, Arun Singh, Patrick May, Ergun Uc, Soura Dasgupta, Nandakumar Narayanan, “Resting-state EEG measures cognitive impairment in Parkinson’s disease”, preprint
4. Sahar Yassine, Ute Gschwandtner, Manon Auffret, Joan Duprez, Marc Verin, Peter Fuhr, Mahmoud Hassan,  “Identification of Parkinson's Disease Subtypes from Resting-State Electroencephalography”, Wiley
5. G. Gimenez-Aparisi, E. Guijarro-Estelles, A. Chornet-Lurbe, S. Ballesta-Martinez, M. Pardo-Hernandez, Y. Ye-Lin, “Early detection of Parkinson’s disease: Systematic analysis of the influence of the eyes on quantitative biomarkers in resting state electroencephalography”, Heliyon 9 (2023) e20625
6. Mehran Shabanpour, Neda Kaboodvand, Behzad Iravani, “Parkinson's disease is characterized by sub-second resting-state spatio-oscillatory patterns: A contribution from deep convolutional neural network”, NeuroImage: Clinical Volume 36, 2022
7. James F. Cavanagh, Praveen Kumar, Andrea A. Mueller, Sarah Pirio Richardson, and Abdullah Mueen, “Diminished EEG Habituation to Novel Events Effectively Classifies Parkinson’s Patients”, Clinical Neurophysiology, Volume 129, Issue 2, February 2018



