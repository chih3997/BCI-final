clc; close all; clear;

load('participants.mat');
P = length(hc_list);

data_folder_path = '../UNM_processed/rmICA/';
save_folder_path = '../UNM_processed/seg/';

if ~isfolder(save_folder_path)
    mkdir(save_folder_path);
end 

Fs = 500;
Ts = 10;
Ns = Fs * Ts;

for i = 1 : P
    for j = 1 : 6
        if j == 1
            file_path = strcat(data_folder_path,hc_list(i),'_PD_REST1_open.set');
            label = 'hc_open_';
        elseif j == 2
            file_path = strcat(data_folder_path,hc_list(i),'_PD_REST1_closed.set');
            label = 'hc_closed_';   
        elseif j == 3
            file_path = strcat(data_folder_path,pd_on_list(i),'_PD_REST1_open.set');
            label = 'pd_on_open_';
        elseif j == 4
            file_path = strcat(data_folder_path,pd_off_list(i),'_PD_REST1_open.set');
            label = 'pd_off_open_';
        elseif j == 5
            file_path = strcat(data_folder_path,pd_on_list(i),'_PD_REST1_closed.set');
            label = 'pd_on_closed_';            
        else
            file_path = strcat(data_folder_path,pd_off_list(i),'_PD_REST1_closed.set');
            label = 'pd_off_closed_';   
        end

        EEG = pop_loadset(char(file_path));
        data_raw = EEG.data;
        [ch, N] = size(data_raw);
        Nfile = floor(N/Ns);
        data = zeros(Nfile, ch, Ns);
        for k = 1 : Nfile
            data = data_raw(:, Ns*(k-1)+1:Ns*k);
            save([save_folder_path label int2str((i-1)*6 + k) '.mat'], 'data');
        end
        
    end

end
