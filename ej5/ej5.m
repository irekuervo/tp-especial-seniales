close all
clear all
run('utils')
run('loadData')

%una vez cargados los audios, los editamos y volvemos a ejecutar los otros
%puntos

for k = 1:5 % recorremos los audios 
    noisy = awgn(mics(:,k),20,'measured');
    pause(0.25) %sospecho que el random necesita un tiempo para que sea distinto
    mics(:,k) = noisy;
end

%soundsc(mics(:,1),fs)

run('../ej1/ej1');

retardos_a_ojo = [1.0417e-04 1.0417e-04 8.3333e-05 6.2500e-05]

run('../ej3/ej3');
run('../ej4/ej4');

close all