
close all

original = mics(:,1);
noisy = awgn(mics(:,1),50,'measured');

plot(noisy)

%utils.plot_fft(original,fs)

utils.plot_fft(noisy,fs)