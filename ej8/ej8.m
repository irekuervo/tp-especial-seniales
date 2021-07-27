close all
clear all
run('utils')
run('loadData')

for k = 1:5 % recorremos los audios 
    noisy = awgn(mics(:,k),20,'measured');
    pause(0.25) %sospecho que el random necesita un tiempo para que sea distinto
    mics(:,k) = noisy;
end

ret1 = -77.08e-6;
ret2 = ret1 + (-78.12e-6);
ret3 = ret2 + (-77.08e-6);
ret4 = ret3 + (-92.19e-6);

retardos = [ret1 ret2 ret3 ret4];

M=5;
senial_promedio = 1/M.*mics(:,1);
figure 
hold on
plot(mics(:,1))
for i=2:M
    senial_corrida = delayseq(mics(:,i),retardos(i-1),fs);
    senial_promedio = senial_promedio + 1/M.*senial_corrida;
    plot(senial_corrida)
end

%soundsc(senial_promedio,fs)
figure
hold on
plot(mics(:,1))
plot(senial_promedio)

figure(4)
spectrogram(mics(:,1),hamming(1024),[],'yaxis')
figure(5)
spectrogram(senial_promedio,hamming(1024),[],'yaxis')
