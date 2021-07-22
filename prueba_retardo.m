%vamos a testear el algoritmo con senoidales sencillas
close all;

f=3000;
T=1/f;
Lt=5*T;
n=100;
x=linspace(0,Lt,n);

y1=sin(2*pi*(f.*x-0));

fi=0.4;
tau=fi*T;
y2=sin(2*pi*(f.*x-fi));
y2(1:(tau*n/Lt))=0;

figure
hold on
grid on
plot(x,y1)
plot(x,y2)
NFFT = 2^nextpow2(n); % Next power of 2 from length of y
Y1 = fft(y1,NFFT)/n;
figure
hold on
grid on
plot(abs(Y1)) 

return
G=(Y1.*conj(Y2))./(abs(Y1).*abs(Y2));
figure
hold on
grid on
plot(abs(ifft(G))) 