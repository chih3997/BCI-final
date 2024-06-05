clc; close all; clear;

Fs = 500;
T = 1 / Fs;
L = 5 * Fs;
t = (1:L) * T;

folder_path = '../UNM_processed/seg/';
list_hc_closed = dir([folder_path '*hc_closed*.mat']);
N = length(list_hc_closed);
ch = [1 2 3 7 8 11 12 14 15 21];
% load("../UNM_processed/weight.mat");
W = eye(length(ch));
[~, m] = size(W);
S = zeros(N, m);

for i = 1 : N
    load([folder_path list_hc_closed(i).name]);
    Sdata = W' * data(ch,:);
    for j = 1 : m
        S(i,j) = wentropy(Sdata(j,:),"Entropy","Renyi","Distribution","global");
    end
    % S(i,:) = S(i,:) / sum(S(i,:));
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