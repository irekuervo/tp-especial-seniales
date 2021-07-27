display('----------Ejercicio 3-----------');
%si se quiere correr solo, correr loadData y utils

corr_temp = [];
gcc_sin_ventaneo = [];

for k = 1:4 % recorremos los audios 
    %correlacion cruzada
    tau = utils.tau_correlacion_cruzada(mics(:,k),mics(:,k+1),fs);
    corr_temp  = [corr_temp tau];
    %gccphat
    tau = utils.tau_gcc_phat(mics(:,k),mics(:,k+1),fs);
    gcc_sin_ventaneo = [gcc_sin_ventaneo tau];
end

corr_temp
gcc_sin_ventaneo

posicion = [1.86 1.45]
utils.plot_habitacion(corr_temp,posicion,cuarto_x,cuarto_y,mics_pos,mics_colors)
utils.print('Ej3_Habitacion_cor_temp')
utils.plot_habitacion(gcc_sin_ventaneo,posicion,cuarto_x,cuarto_y,mics_pos,mics_colors)
utils.print('Ej3_Habitacion_gcc_temp')