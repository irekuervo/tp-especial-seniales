display('----------Ejercicio 4-----------');

retardos_ventaneo = [];

Nw = 1000;

for k = 1:4 % recorremos los audios 
    tau_temporal = utils.tau_ventaneo(mics(:,k),mics(:,k+1 ),Nw,fs,@hamming);
    tau = mode(tau_temporal);
    retardos_ventaneo(k) = tau;
    %% histograma
    figure
    histogram(tau_temporal,1000);
    fileName = sprintf('Ej4_Histograma%d%d',k,k+1);
    utils.print(fileName);
    %% tau temporal
    figure
    plot(tau_temporal)
    %ylim([-85e-6 -60e-6])
    fileName = sprintf('Ej4_EvolucionTau%d%d',k,k+1);
    utils.print(fileName);
end
retardos_ventaneo
posicion = [1.86 1.45]
utils.plot_habitacion(retardos_ventaneo,posicion,cuarto_x,cuarto_y,mics_pos,mics_colors)
utils.print('Ej4_Habitacion')

