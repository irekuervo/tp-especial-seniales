close all;
% prueba para 2 senoidales arbitrarias muestradas a 48kHz, con una frecuencia dentro del
% espectro audible, y con un retardo determinado, menor al periodo de la
% misma para simular la cercania fisica de los microfonos

fs = 48000;
ts = 1/fs;

f=500;
T=1/f;
N = 1000;

xn=linspace(0,N*ts,N);

y1 = sin(2*pi*(f.*xn));
tau_rad = 0.2;
tau = tau_rad*T;
y2 = sin(2*pi*(f.*xn+tau_rad));
%% desplazamientos
tau_cc = utils.tau_correlacion_cruzada(y1,y2,fs); % esta va bien
tau_vent_hamming = utils.tau_ventaneo(N/2,y1,y2,1000,@hamming,fs);  % esta no
tau_vent_rect = utils.tau_ventaneo(N/2,y1,y2,500,@rectwin,fs);% esta no
tau_gccphat = gccphat(y2.',y1.',fs); % esta no

figure(1)
hold on
plot(xn,y1);
plot(xn,y2);
hold off

%% extras
figure(2)
plot(abs(fft(y1,fs)));
figure(3)
periodogram(y1,rectwin(N),N,fs)