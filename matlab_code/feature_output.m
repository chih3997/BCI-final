clc; close all; clear;

folder_path = '../UNM_processed/seg/';
list_hc_closed = dir([folder_path '*hc_closed*.mat']);
N = length(list_hc_closed);
ch = [1 2 3 7 8 11 12 14 15 21];
m = length(ch);
S = zeros(N, m);

for i = 1 : N
    load([folder_path list_hc_closed(i).name]);
    Sdata = data(ch,:);
    for j = 1 : m
        S(i,j) = wentropy(Sdata(j,:),"Entropy","Renyi","Distribution","global");
    end
end

load("../UNM_processed/feqfea_hc_closed.mat");

L = length(alpha);

feature = strings(L, 5 + m + 1);
feature(:,1) = delta;
feature(:,2) = theta;
feature(:,3) = alpha;
feature(:,4) = beta;
feature(:,5) = gamma;
feature(:,6:end-1) = S;
feature(:,end) = "hc_closed";

% writematrix(feature, "../feature_all.csv", "WriteMode","append");
writematrix(feature, "../hc_on_closed.csv", "WriteMode","append");