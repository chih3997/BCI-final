clc; close all; clear;

chn = 1;
load("../UNM_processed/fft_hc_open.mat");
fft_hc_open = mean(Y,2);
[P, ~, ~] = size(fft_hc_open);
delta = zeros(P,chn);
theta = zeros(P,chn);
alpha = zeros(P,chn);
beta = zeros(P,chn);
gamma = zeros(P,chn);

Fs = 500;
T = 1 / Fs;
L = 5 * Fs;
t = (1:L) * T;
f = Fs/L*(-L/2:L/2-1);

delta_idx_l = (f > 2);
delta_idx_h = (f <= 4);
delta_idx = find(delta_idx_l & delta_idx_h);

theta_idx_l = (f > 4);
theta_idx_h = (f <= 8);
theta_idx = find(theta_idx_l & theta_idx_h);

alpha_idx_l = (f > 8);
alpha_idx_h = (f <= 13);
alpha_idx = find(alpha_idx_l & alpha_idx_h);

beta_idx_l = (f > 13);
beta_idx_h = (f <= 30);
beta_idx = find(beta_idx_l & beta_idx_h);

gamma_idx_l = (f > 30);
gamma_idx_h = (f <= 45);
gamma_idx = find(gamma_idx_l & gamma_idx_h);

total_idx = find(delta_idx_l & gamma_idx_h);

for i = 1 : P
    for j = 1 : chn
        delta(i,j) = sum(fft_hc_open(i,j,delta_idx));
        theta(i,j) = sum(fft_hc_open(i,j,theta_idx));
        alpha(i,j) = sum(fft_hc_open(i,j,alpha_idx));
        beta(i,j) = sum(fft_hc_open(i,j,beta_idx));
        gamma(i,j) = sum(fft_hc_open(i,j,gamma_idx));
    end
    total = sum(fft_hc_open(i,:,total_idx), 'all');
    delta(i,:) = delta(i,:) / total;
    theta(i,:) = theta(i,:) / total;
    alpha(i,:) = alpha(i,:) / total;
    beta(i,:) = beta(i,:) / total;
    gamma(i,:) = gamma(i,:) / total;
end

save("../UNM_processed/feqfea_hc_open_new.mat", 'delta', 'theta', 'alpha', 'beta', 'gamma');

