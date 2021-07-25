
close all
run('loadData');
load('kaiser.mat');
load('rect.mat');
load('hamming.mat');

%original = mics(:,1);
%figure
%periodogram(original)
window_size = 2000;

taus_kaiser = [];
for i=1:50
    x = awgn(mics(:,1),20,'measured');
    y = awgn(mics(:,5),20,'measured');
    
    x_f = filter(filtro_kaiser,1,x);
    y_f = filter(filtro_kaiser,1,y);
    taus_kaiser(i) = utils.tau_ventaneo(x_f,y_f,window_size,fs,@hamming);
end
figure
hold on
grid on
plot(taus_kaiser)
mean(taus_kaiser)


