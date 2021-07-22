close all;
clear all;

f=25;
T=1/f;
fs=40;
Ts=1/fs;

t=2*T; %duracion de muestreo
N=t/Ts+1; %cantidad de muestras
n=linspace(0,t,N); %dominio discreto

y=sin(2*pi*f*n); %muestras

% analisis temporal
figure
hold on
grid on

stem(n,y);

n2=linspace(0,t,1000);
y2=sin(2*pi*f*n2);

plot(n2,y2);

% analisis en frecuencia
figure
grid on

syms x
y_f(x) = sin(2*pi*f*x)*(heaviside(x)-heaviside(x-t));
range=[-t/2 (3/2)*t];
fplot(y_f,range) ;

figure
hold on
grid on
Y_F = fourier(y_f(x/(2*pi)));
fplot(abs(Y_F))

Y2=fft(y);
stem(abs(Y2));


