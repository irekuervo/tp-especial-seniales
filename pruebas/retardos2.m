clear all
close all

%% prueba gong
%load gong;
%refsig = y;
%delay1 = 0.1; %segs
%sig1 = delayseq(refsig,delay1,Fs);

%soundsc(sig1,Fs)

%tau_est = gccphat(sig1,refsig,Fs);

%tau1 = utils.tau_correlacion_cruzada(sig1,refsig,Fs);
%tau2 = utils.tau_gcc_phat(sig1,refsig,Fs,@rectwin);
%window_size = Fs;
%tau3 = utils.tau_ventaneo(sig1,refsig,window_size,Fs,@rectwin);

%% prueba con los audios
fs=48000;
load('audios.mat');
[numRows,numCols] = size(audios);

refsig = audios(:,1);
sig1 = audios(:,2);

window_size = 2000;
tau_est = gccphat(sig1,refsig,fs)
tau1 = utils.tau_gcc_phat(sig1,refsig,fs,@rectwin)


%tau2 = utils.tau_ventaneo(sig1,refsig,window_size,fs,@rectwin)




