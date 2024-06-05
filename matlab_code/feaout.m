clc; close all; clear;

load("../UNM_processed/feqfea_pd_on_closed.mat");

L = length(alpha);

data = strings(L, 6);
data(:,1) = delta;
data(:,2) = theta;
data(:,3) = alpha;
data(:,4) = beta;
data(:,5) = gamma;
data(:,6) = "pd_on_closed";

writematrix(data, "../feature.csv", "WriteMode","append");

