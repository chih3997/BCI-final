clc; close all; clear;

participant = readmatrix("IMPORT_ME_REST1.xlsx", 'OutputType', 'char');
P = length(participant);

hc = participant(:,5);
pd = participant(:,1);
on = (convertCharsToStrings(participant(:,2)) == 'ON');

hc_list = hc;
pd_on_list = pd;
pd_off_list = pd;

for i = 1 : P
    hc_list(i) = strcat(hc(i),'_1');
    
    if on(i)
        pd_on_list(i) = strcat(pd(i),'_1');
        pd_off_list(i) = strcat(pd(i),'_2');
    else
        pd_on_list(i) = strcat(pd(i),'_2');
        pd_off_list(i) = strcat(pd(i),'_1');
    end
end

save("participants.mat", 'hc_list', 'pd_on_list', 'pd_off_list');