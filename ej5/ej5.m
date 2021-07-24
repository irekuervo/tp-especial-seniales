clear all

run('loadData');


for k = 1:5 % recorremos los audios 
    noisy = awgn(mics(:,k),20,'measured');
    mics(:,k) = noisy;
end

%soundsc(mics(:,1),fs)

%run('../ej1/ej1');
%run('../ej2/ej2');
run('../ej3/ej3');
run('../ej4/ej4');