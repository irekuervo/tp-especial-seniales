clear all;
close all;

run('loadData');

%armado para diseniar codigo sencillo

retardos = [];
Nw = 2000;
for k = 1:4 % recorremos los audios
    retardos(k) = utils.tau_gcc_phat_interpolado(mics(:,k),mics(:,k+1 ),fs);
end
utils.plot_habitacion(retardos,cuarto_x,cuarto_y,mics_pos,mics_colors)




