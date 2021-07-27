close all
clear all
run('utils')
run('loadData')

load('hamming');

filtro = Num;

figure
freqz(filtro,1)
utils.print('Ej7_filtro_respuesta');
zplane(filtro)
utils.print('Ej7_filtro_polos');
%% agrego el ruido y filtro
for k = 1:5 % recorremos los audios 
    noisy = awgn(mics(:,k),20,'measured');
    pause(.25)
    filtered = filter(filtro,1,noisy);
    mics(:,k) = filtered;
end

run('../ej1/ej1');
run('../ej4/ej4');

