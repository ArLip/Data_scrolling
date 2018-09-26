%%ripple detection 
% this codes helps to detect ripples
% following Buzsaki et al High-Frequency Network Oscillation 
% in the Hippocampus Science 1992
% by showing 
    % 1. raw EEG data, down sampled to fs = 3000
    % 2. ripples 100-400 Hz
    % 3. sharp waves 1-50 Hz

close  all
clear all

%% load the necessary data and functions, downsample to fs=3000

% fetch the necessary functions
addpath('F:\openephys_to_nex\ripple_detection')

%data file
addpath('F:\mouse_sleep_data\Hta_12_2018-08-29_13-02-05_S001')

%EEG and accelometer data
data=load_open_ephys_data_faster('100_CH45.continuous');    % EEG data channel
dataacc=load_open_ephys_data_faster('100_AUX4.continuous'); % accelometer data

%downsampling
data_ds=data(1:10:end);
data_acc_ds=dataacc(1:10:end);

[r c] = size(data_ds);

%sampling rates 
Fs = 3000;
Fs_raw=30000;

% time interval from 0 to end

t= (0:length(data_ds)-1)/Fs;

%% filtering

rip =  designfilt('bandpassfir','FilterOrder',20, ...
         'CutoffFrequency1',100,'CutoffFrequency2',500, ...
         'SampleRate',3000);
ripple = filtfilt(rip,data_ds);


sw =  designfilt('bandpassfir','FilterOrder',20, ...
         'CutoffFrequency1',1,'CutoffFrequency2',50, ...
         'SampleRate',3000);
sharp_waves = filtfilt(sw,data_ds);

 

%% Figures

figure
plot(t,data_ds)

figure
plot(t, sharp_waves*1000)

figure 
plot(t, ripple*1000)

figure
plot(t,((data_acc_ds*300)-200))

figure
plot(t,data_ds+400, t, sharp_waves+2000, t, ripple*2+3000, t,((data_acc_ds*400)-1000))
legend('raw EEG','sharp wave','ripple','accelometer')