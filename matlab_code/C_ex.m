clc; close all; clear;

folder_path = '../UNM_processed/seg/';
list_pd_off_closed = dir([folder_path '*pd_off_closed*.mat']);
N = length(list_pd_off_closed);
C = zeros(N, 32, 32);
C_pd_off_closed = zeros(32,32);

for i = 1 : N
    load([folder_path list_pd_off_closed(i).name]);
    C(i, :, :) = data * data' ./ trace(data * data');
end

C_pd_off_closed(:,:) = mean(C,1);
save("../UNM_processed/C_pd_off_closed.mat", 'C_pd_off_closed');