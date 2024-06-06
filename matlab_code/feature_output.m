clc; close all; clear;

folder_path = '../UNM_processed/seg/';
list_hc_open = dir([folder_path '*hc_open*.mat']);
N = length(list_hc_open);
chf = [1 2 3 4 26 27 28 29 32];
chc = [5 6 7 21 22 24 25];
chp = [9 10 11 12 13 17 18 19 20];
cht = [8 23];
cho = [14 15 16 30 31];
chn = 5;
E = zeros(N, chn);

for i = 1 : N
    load([folder_path list_hc_open(i).name]);
    for j = 1 : chn
        if j == 1
            Sdata = data(chf,:);
            m = length(chf);
        elseif j == 2
            Sdata = data(chc,:);
            m = length(chc);
        elseif j == 3
            Sdata = data(chp,:);
            m = length(chp);
        elseif j == 4
            Sdata = data(cht,:);
            m = length(cht);
        else
            Sdata = data(cho,:);
            m = length(cho);
        end
        S = zeros(m, 1);
        for k = 1 : m
            S(k) = wentropy(Sdata(k,:),"Entropy","Renyi","Distribution","global");
        end
        E(i,j) = mean(S);
    end

end

load("../UNM_processed/freq_hc_open.mat");

L = length(alpha);

feature = strings(L, chn*6 + 1);
feature(:,1:5) = delta;
feature(:,6:10) = theta;
feature(:,11:15) = alpha;
feature(:,16:20) = beta;
feature(:,21:25) = gamma;
feature(:,26:30) = E;
feature(:,end) = "hc_open";

writematrix(feature, "../feature_all.csv", "WriteMode","append");
% writematrix(feature, "../hc_on_closed.csv", "WriteMode","append");