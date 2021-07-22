n = 0:999;
x1 = cos(pi/4*n)+0.5*sin(pi/2*n);
fs = 1000;
t = 0:0.001:1-0.001;
x2 = cos(2*pi*125*t)+0.5*sin(2*pi*250*t);
freq = [125 250];

[s1,w,t1]=spectrogram(x1,[],8,[pi/4 pi/2]);
figure,
spectrogram(x1,'yaxis')
[s2,f,t2]=spectrogram(x2,[],128,freq,fs);
figure,
spectrogram(x2,[],[],[],fs,'yaxis')