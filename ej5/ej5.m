clear all

run('loadData');


for k = 1:5 % recorremos los audios 
    noisy = awgn(mics(:,k),20);
    filtro = fir1(80,[0.005 0.02],'bandpass',hamming(81));
    filtered = filter(filtro,1,noisy);
    mics(:,k) = filtered;
end

soundsc(mics(:,1),fs)

%run('../ej1/ej1');
%run('ej2');
run('../ej3/ej3');
%run('../ej4/ej4');