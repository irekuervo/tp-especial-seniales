close all;



%% FIGURA 1 - vemos los audios superpuestos
utils.figure()
hold on
grid on

for k = 1:5 % recorremos los audios 
    mic_audio = mics(:,k);
    mic_color = mics_colors{k};
    utils.plot_mics(xn,mic_audio,mic_color);
end

lgd = legend('mic 1','mic 2','mic 3','mic 4','mic 5');
lgd.NumColumns = 2;
title('Sonido capturado por los 5 microfonos');

%eje x
xlim([0 xn(end)])
xticks(0:0.5:xn(end));
xlabel('Tiempo (s)');
%eje y
ylabel('Amplitud');
utils.print('Ej1_AudiosSuperpuestos');


%% FIGURA 2 - vemos un segmento de los audios

utils.figure()
hold on
grid on

x0 = 0.6320; %punto arbitrario que me gusto
xf = 0.6335;  %punto arbitrario que me gusto
xn_seg = x0:ts:xf;
xn0 = round(x0/ts);
xnf = round(xf/ts);


for k = 1:5 % recorremos los audios 
    mic_audio = mics(:,k);
    mic_audio_segmento = mic_audio(xn0:xnf);
    mic_color = mics_colors{k};
    utils.plot_mics(xn_seg,mic_audio_segmento,mic_color);
end

lgd = legend('mic 1','mic 2','mic 3','mic 4','mic 5');
lgd.NumColumns = 2;
title('Sonido capturado por los 5 microfonos');

%eje x

xlabel('Tiempo (s)');
%eje y
ylabel('Amplitud');
utils.print('Ej1_SegmentoAudios');

%% FIGURA 3 - analisis de espectro para la potencia
mic_audio = mics(:,1);

% veo en el tiempo como se compoirta
utils.figure()
spectrogram(mic_audio,1024,120,[],fs,'yaxis')
utils.print('Ej1_Espectrograma');

% lo contrasto con la potencia en el espectro

utils.figure()
[pxx,f] = periodogram(mic_audio,rectwin(N),N,fs);
grid on
title('Densidad Espectral de Potencia')
xlabel('Frecuencia [Hz]')
ylabel('Potencia/Frecuencia [dB/Hz]')
utils.print('Ej1_PotenciaTotal');

utils.figure()
loglog(f,pxx);
grid on
title('Densidad Espectral de Potencia')
xlabel('Frecuencia [Hz]')
ylabel('Potencia/Frecuencia [dB/Hz]')
utils.print('Ej1_PotenciaTotal');

