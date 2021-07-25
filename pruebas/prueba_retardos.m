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
tau = utils.tau_correlacion_cruzada(sig1,refsig,fs);
tau0 = gccphat(sig1,refsig,fs)
tau1 = utils.tau_gcc_phat(sig1,refsig,fs)
tau2 = utils.tau_gcc_phat_resampleado(sig1,refsig,fs)
tau3 = utils.tau_gcc_phat_interpolado(sig1,refsig,fs)
tau4 = utils.tau_ventaneo(sig1,refsig,window_size,fs,@hamming)
tau5 = utils.tau_ventaneo_resampleado(sig1,refsig,window_size,fs,@hamming)
tau6 = utils.tau_ventaneo_interpolado(sig1,refsig,window_size,fs,@hamming)

%% un poco de ruido
refsig_noisy = awgn(refsig,20,'measured');
sig1_noisy = awgn(sig1,20,'measured');

tau_noise = utils.tau_correlacion_cruzada(sig1_noisy,refsig_noisy,fs)
tau_noise_0 = gccphat(sig1_noisy,refsig_noisy,fs)
tau_noise_1 = utils.tau_gcc_phat(sig1_noisy,refsig_noisy,fs)
tau_noise_2 = utils.tau_gcc_phat_resampleado(sig1_noisy,refsig_noisy,fs)
tau_noise_3 = utils.tau_gcc_phat_interpolado(sig1_noisy,refsig_noisy,fs)
tau_noise_4 = utils.tau_ventaneo(sig1_noisy,refsig_noisy,window_size,fs,@hamming)
tau_noise_5 = utils.tau_ventaneo_resampleado(sig1_noisy,refsig_noisy,window_size,fs,@hamming)
tau_noise_6 = utils.tau_ventaneo_interpolado(sig1_noisy,refsig_noisy,window_size,fs,@hamming)

%% mucho ruido
refsig_noisy = awgn(refsig,40);
sig1_noisy = awgn(sig1,40);

tau_lot_noise = utils.tau_correlacion_cruzada(sig1_noisy,refsig_noisy,fs)
tau_lot_noise_0 = gccphat(sig1_noisy,refsig_noisy,fs)
tau_lot_noise_1 = utils.tau_gcc_phat(sig1_noisy,refsig_noisy,fs)
tau_lot_noise_2 = utils.tau_gcc_phat_resampleado(sig1_noisy,refsig_noisy,fs)
tau_lot_noise_3 = utils.tau_gcc_phat_interpolado(sig1_noisy,refsig_noisy,fs)
tau_lot_noise_4 = utils.tau_ventaneo(sig1_noisy,refsig_noisy,window_size,fs,@hamming)
tau_lot_noise_5 = utils.tau_ventaneo_resampleado(sig1_noisy,refsig_noisy,window_size,fs,@hamming)
tau_lot_noise_6 = utils.tau_ventaneo_interpolado(sig1_noisy,refsig_noisy,window_size,fs,@hamming)

%% ahora los ventaneos con filtro
bpf = fir1(80,[0.02 0.1],'bandpass'); %todavia no esta diseñado
filtradoRef = filter(bpf,1,audios(:,1));
filtradoSig1 = filter(bpf,1,audios(:,2));

tau_filtrado_0 = utils.tau_ventaneo_resampleado(filtradoSig1,filtradoRef,window_size,fs,@hamming)
tau_filtrado_1 = utils.tau_ventaneo_interpolado(filtradoSig1,filtradoRef,window_size,fs,@hamming)
