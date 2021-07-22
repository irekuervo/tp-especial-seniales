close all;

%% FIGURA 1 - vemos los audios superpuestos
figure('Position', [100 100 1600 600])
hold on
grid on

for k = 1:numel(mics) % recorremos los audios 
    mic_audio = mics{k};
    mic_color = mics_colors{k};
    plot_bonito(xn,mic_audio,mic_color);
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



%% FIGURA 2 - vemos un segmento de los audios

figure('Position', [100 100 1600 600])
hold on
grid on

x0 = 0.6320; %punto arbitrario que me gusto
xf = 0.6335;  %punto arbitrario que me gusto
xn_seg = x0:ts:xf;
xn0 = round(x0/ts);
xnf = round(xf/ts);


for k = 1:numel(mics) % recorremos los audios 
    mic_audio = mics{k};
    mic_audio_segmento = mic_audio(xn0:xnf);
    mic_color = mics_colors{k};
    plot_bonito(xn_seg,mic_audio_segmento,mic_color);
end

lgd = legend('mic 1','mic 2','mic 3','mic 4','mic 5');
lgd.NumColumns = 2;
title('Sonido capturado por los 5 microfonos');

%eje x

xlabel('Tiempo (s)');
%eje y
ylabel('Amplitud');

%% FIGURA 3 - analisis de espectro para la potencia
mic_audio = mics{1};

% veo en el tiempo como se compoirta
figure('Position', [100 100 1600 600])
spectrogram(mic_audio,1024,120,[],fs,'yaxis')

% lo contrasto con la potencia en el espectro

xdft = fft(mic_audio);
xdft = xdft(1:N/2+1);
psdx = (1/(fs*N)) * abs(xdft).^2;
psdx(2:end-1) = 2*psdx(2:end-1);
freq = 0:fs/N:fs/2;

figure
plot(freq,10*log10(psdx))
grid on
title('Densidad Espectral de Potencia')
xlabel('Frecuencia [Hz]')
ylabel('Potencia/Frecuencia [dB/Hz]')

%como se trata de la voz humana, muestro el rango esperado
%tomo el rango de 125 a 8k
figure
freq = 125:fs/N:8000;
psdx = psdx(125:length(freq)+124);
plot(freq,10*log10(psdx));
grid on
title('Densidad Espectral de Potencia')
xlabel('Frecuencia [Hz]')
ylabel('Potencia/Frecuencia [dB/Hz]')

