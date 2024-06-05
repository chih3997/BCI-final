clc; clear; close all;

list = dir('*REST1*.mat');
P = length(list);

folder_path = '../UNM_processed/';

if ~isfolder(folder_path)
    mkdir('../UNM_processed/');
    mkdir('../UNM_processed/', 'raw');
    mkdir('../UNM_processed/', 'filtered');
    mkdir('../UNM_processed/', 'ASR');
    mkdir('../UNM_processed/', 'rmICA');
end 

for i = 1 : P
    x = list(i).name;
    x2 = x(1:end-4);
    
    for type = 1 : 2  
        load(x);
        EEG = pop_select( EEG, 'channel',{'Fp1','Fp2','F3','F4','C3','C4','P3','P4','O1','O2','F7','F8','T7','T8','P7','P8','Fz','Cz','FC1','FC2','CP1','CP2','FC5','FC6','CP5','CP6','AF3','AF4','PO3','PO4','Oz','Pz'});
        if (type == 1)
            EEG = pop_rmdat( EEG, {'S  1','S  2'},[0 1.02],0);
            state = 'open';
        else
            EEG = pop_rmdat( EEG, {'S  3','S  4'},[0 1.02],0);
            state = 'closed';
        end

        EEG = pop_reref(EEG,[]);
        EEG = pop_rmbase(EEG,[],[]);
        
        % raw data ica
        % EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on');
        % EEG = pop_iclabel(EEG, 'default');
        % EEG = pop_saveset(EEG, 'filename',[x2 '_' state '.set'],'filepath',[folder_path '/raw/']);
        % writematrix(EEG.etc.ic_classification.ICLabel.classifications, [folder_path '/raw/' x2 '_' state '_icalabel.csv']);
    
        % filtered data
        EEG = pop_eegfiltnew(EEG, 'locutoff',1,'hicutoff',48);
        % EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on');
        % EEG = pop_iclabel(EEG, 'default');
        % EEG = pop_saveset(EEG, 'filename',[x2 '_' state '.set'],'filepath',[folder_path '/filtered/']);
        % writematrix(EEG.etc.ic_classification.ICLabel.classifications, [folder_path '/filtered/' x2 '_' state '_icalabel.csv']);

        % ASR data
        EEG = pop_clean_rawdata(EEG, 'FlatlineCriterion','off','ChannelCriterion','off','LineNoiseCriterion','off','Highpass','off','BurstCriterion',20,'WindowCriterion','off','BurstRejection','off','Distance','Euclidian');
        % EEG = pop_runica(EEG, 'icatype', 'runica', 'extended',1,'rndreset','yes','interrupt','on');
        % EEG = pop_iclabel(EEG, 'default');
        % EEG = pop_saveset(EEG, 'filename',[x2 '_' state '.set'],'filepath',[folder_path '/ASR/']);
        % writematrix(EEG.etc.ic_classification.ICLabel.classifications, [folder_path '/ASR/' x2 '_' state '_icalabel.csv']);

        idx = find(EEG.etc.ic_classification.ICLabel.classifications(:,1) >= 0.75);
        idx = idx';
        EEG = pop_subcomp(EEG, idx, 0, 1);
        EEG = pop_saveset(EEG, 'filename',[x2 '_' state '.set'],'filepath',[folder_path '/rmICA/']);
    end
end