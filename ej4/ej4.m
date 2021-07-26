close all
clear all
run('utils')
run('loadData')

retardos_ventaneo = [];

Nw = 1000;

for k = 1:4 % recorremos los audios 
    [tau,tau_temporal] = utils.tau_ventaneo(mics(:,k),mics(:,k+1 ),Nw,fs,@hamming);
    retardos_ventaneo(k) = tau;
    %% histograma
    utils.figure()
    histogram(tau_temporal,1000);
    fileName = sprintf('Ej4_Histograma%d%d',k,k+1);
    utils.print(fileName);
    %% tau temporal
    utils.figure()
    plot(tau_temporal)
    fileName = sprintf('Ej4_EvolucionTau%d%d',k,k+1);
    utils.print(fileName);
end
posicion = [1.86 1.45]
utils.plot_habitacion(retardos_ventaneo,posicion,cuarto_x,cuarto_y,mics_pos,mics_colors)
utils.print('Ej4_Habitacion')

