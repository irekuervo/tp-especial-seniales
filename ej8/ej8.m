close all
clear all
run('utils')
run('loadData')

retardos = [-3*ts -6*ts -9*ts -12*ts];



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

soundsc(senial_promedio,fs)
figure
hold on
plot(mics(:,1))
plot(senial_promedio)
