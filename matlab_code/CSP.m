clc; close all; clear;

folder_path = '../UNM_processed/';

load("../UNM_processed/C_hc_open.mat");
load("../UNM_processed/C_hc_closed.mat");
load("../UNM_processed/C_pd_on_open.mat");
load("../UNM_processed/C_pd_on_closed.mat");
load("../UNM_processed/C_pd_off_open.mat");
load("../UNM_processed/C_pd_off_closed.mat");

% Chc = (C_hc_open * 168 + C_hc_closed * 162)/330;
% Cpd = (C_pd_on_open + C_pd_on_closed + C_pd_off_open + C_pd_off_closed)/4;

Chc = C_hc_closed;
Cpd = C_pd_off_closed;

CC = Chc + Cpd;

[V, D] = eig(Cpd, CC);

[d,ind] = sort(diag(D), 'descend');
Dd = D(ind,ind);
Vd = V(:,ind);

m = 5;
W = [Vd(:,1:m) Vd(:,end-m + 1:end)];
save("../UNM_processed/weight.mat", 'W');