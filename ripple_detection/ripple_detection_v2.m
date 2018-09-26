%this codes helps to detect ripples
%by showing raw EEG data, down sampled to fs = 3000 
% following Buzsaki et al High-Frequency Network Oscillation 
% in the Hippocampus Science 1992

close  all
clear all

addpath('F:\2018_mouse_epilepsy\Hta_10_2018-09-08_13-57-25_sleep003')
%addpath('C:\Users\pyska\Desktop\openephys_to_nex')

gain=0.19499999284744263;

data=load_open_ephys_data_faster('100_CH12.continuous');
dataa = data*gain;
dataacc=load_open_ephys_data_faster('100_AUX1.continuous');
data_ds=data(1:10:end);

%amplitude correction

data_ds=(data(1:10:end))*gain;
data_acc_ds=dataacc(1:10:end);


[r c] = size(data_ds);

%sampling rate
Fs = 3000;
Fs_raw=30000;
Ts = 1/Fs;
end_time= (r/Fs)-1;

% time interval from 0 to end
t= (0:length(data_ds)-1)/Fs;



%filtering
ripple = eegfilt(data_ds', Fs,100,400);  %[smoothdata] = eegfilt(data,srate,locutoff,hicutoff);

%sharpwaves = lp_sharpwave_v2(data_ds);

%spikes = eegfilt(dataa', Fs_raw,500,10000);  %[smoothdata] = eegfilt(data,srate,locutoff,hicutoff);
%spikes_ds = spikes(1:10:end); 

%raw_eeg=lp_raw_v1(data_ds);

%figure

figure
plot(t,ripple')



figure 
plot (t,raw_eeg+400,t,sharpwaves+200,t, ripple',t,((data_acc_ds*200)-200))

figure
plot(t,data_ds+400, t, sharpwaves+200, t, ripple*3, t,((data_acc_ds*300)-200))
