clc; close all; clear;

chn = 5;
load("../UNM_processed/fft_pd_on_closed.mat");
[P, ~, ~] = size(Y);

chf = [1 2 3 4 26 27 28 29 32];
chc = [5 6 7 21 22 24 25];
chp = [9 10 11 12 13 17 18 19 20];
cht = [8 23];
cho = [14 15 16 30 31];

fft_pd_on_closed_f = mean(Y(:,chf,:),2);
fft_pd_on_closed_c = mean(Y(:,chc,:),2);
fft_pd_on_closed_p = mean(Y(:,chp,:),2);
fft_pd_on_closed_t = mean(Y(:,cht,:),2);
fft_pd_on_closed_o = mean(Y(:,cho,:),2);
fft_pd_on_closed_total = mean(Y,2);

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
        if j == 1
            fft_pd_on_closed = fft_pd_on_closed_f;
        elseif j == 2
            fft_pd_on_closed = fft_pd_on_closed_c;
        elseif j == 3
            fft_pd_on_closed = fft_pd_on_closed_p;
        elseif j == 4
            fft_pd_on_closed = fft_pd_on_closed_t;
        else
            fft_pd_on_closed = fft_pd_on_closed_o;
        end
        delta(i,j) = sum(fft_pd_on_closed(i,1,delta_idx));
        theta(i,j) = sum(fft_pd_on_closed(i,1,theta_idx));
        alpha(i,j) = sum(fft_pd_on_closed(i,1,alpha_idx));
        beta(i,j) = sum(fft_pd_on_closed(i,1,beta_idx));
        gamma(i,j) = sum(fft_pd_on_closed(i,1,gamma_idx));
    end
    total = sum(fft_pd_on_closed_total(i,:,total_idx), 'all');
    delta(i,:) = delta(i,:) / total;
    theta(i,:) = theta(i,:) / total;
    alpha(i,:) = alpha(i,:) / total;
    beta(i,:) = beta(i,:) / total;
    gamma(i,:) = gamma(i,:) / total;
end

save("../UNM_processed/freq_pd_on_closed.mat", 'delta', 'theta', 'alpha', 'beta', 'gamma');

