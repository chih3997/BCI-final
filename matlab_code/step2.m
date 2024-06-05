clc; clear; close all;

folder_path = '../UNM_processed/';
list_raw_closed = dir([folder_path 'raw/*closed*.csv']);
list_filtered_closed = dir([folder_path 'filtered/*closed*.csv']);
list_ASR_closed = dir([folder_path 'ASR/*closed*.csv']);
list_raw_open = dir([folder_path 'raw/*open*.csv']);
list_filtered_open = dir([folder_path 'filtered/*open*.csv']);
list_ASR_open = dir([folder_path 'ASR/*open*.csv']);
P = length(list_raw_closed);

times_raw_closed = zeros(P, 7);
times_filtered_closed = zeros(P, 7);
times_ASR_closed = zeros(P, 7);
times_raw_open = zeros(P, 7);
times_filtered_open = zeros(P, 7);
times_ASR_open = zeros(P, 7);

k = 1;

for i = 1 : P
    file_path = [list_raw_closed(i).folder '\' list_raw_closed(i).name];
    label = readmatrix(file_path);
    [~, idx] = max(label, [], 2);
    for j = 1 : 7
        times_raw_closed(k, j) = sum(idx == j);
    end

    file_path = [list_filtered_closed(i).folder '\' list_filtered_closed(i).name];
    label = readmatrix(file_path);
    [~, idx] = max(label, [], 2);
    for j = 1 : 7
        times_filtered_closed(k, j) = sum(idx == j);
    end

    file_path = [list_ASR_closed(i).folder '\' list_ASR_closed(i).name];
    label = readmatrix(file_path);
    [~, idx] = max(label, [], 2);
    for j = 1 : 7
        times_ASR_closed(k, j) = sum(idx == j);
    end

    file_path = [list_raw_open(i).folder '\' list_raw_open(i).name];
    label = readmatrix(file_path);
    [~, idx] = max(label, [], 2);
    for j = 1 : 7
        times_raw_open(k, j) = sum(idx == j);
    end

    file_path = [list_filtered_open(i).folder '\' list_filtered_open(i).name];
    label = readmatrix(file_path);
    [~, idx] = max(label, [], 2);
    for j = 1 : 7
        times_filtered_open(k, j) = sum(idx == j);
    end

    file_path = [list_ASR_open(i).folder '\' list_ASR_open(i).name];
    label = readmatrix(file_path);
    [~, idx] = max(label, [], 2);
    for j = 1 : 7
        times_ASR_open(k, j) = sum(idx == j);
    end

    k = k + 1;
end



mean_raw_closed = mean(times_raw_closed);
mean_filtered_closed = mean(times_filtered_closed);
mean_ASR_closed = mean(times_ASR_closed);
mean_raw_open = mean(times_raw_open);
mean_filtered_open = mean(times_filtered_open);
mean_ASR_open = mean(times_ASR_open);


figure;
plot(mean_raw_closed);
hold on;
plot(mean_filtered_closed);
plot(mean_ASR_closed);
legend("raw_closed", "filtered_closed", "ASR_closed");
hold off;

figure;
plot(mean_raw_open);
hold on;
plot(mean_filtered_open);
plot(mean_ASR_open);
legend("raw_open", "filtered_open", "ASR_open");
hold off;