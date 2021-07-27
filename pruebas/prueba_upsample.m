
Fs = 10000;
T = 1/Fs;
xn1 = linspace(0,1,Fs);

f = 500;
original = sin(2*pi*f.*xn1)';

delay1 = 5*T;
defasada = delayseq(original,delay1,Fs);

%figure
%hold on
%plot(original)
%plot(defasada)
gccphat(original,defasada,Fs)
utils.tau_gcc_phat(original,defasada,Fs)

