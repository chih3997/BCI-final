clc; close all; clear;

Fs = 500;
T = 1 / Fs;
L = 5 * Fs;
t = (1:L) * T;

folder_path = '../UNM_processed/seg/';
list_pd_off_closed = dir([folder_path '*pd_off_closed*.mat']);
N = length(list_pd_off_closed);

Y = zeros(N, 32, L);

for j = 1 : N
    load([folder_path list_pd_off_closed(j).name]);
    win = hanning(L);
    Ys = zeros(6, L);

    for ch = 1 : 32
        for i = 1 : 6
            start = (i - 1) * 500 + 1;
            data_x = data(ch,start:start+2499);
            data_win = win' .* data_x;
            Ys(i,:) = 10*log10(abs(fftshift(fft(data_win))));    
        end
        Y(j,ch,:) = mean(Ys, 1);
    end       
end

save("../UNM_processed/fft_pd_off_closed.mat", 'Y');


