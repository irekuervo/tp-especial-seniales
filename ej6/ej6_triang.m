close all
clear all
run('utils')
run('loadData')


%como el ruido es aleatorio, quiero probar los posibles valores que pueden
%salir
gcc_ventaneo_upsample = [];
for i =1:20
    %una vez cargados los audios, los editamos y volvemos a ejecutar los otros
    %puntos
    
    for k = 1:5 % recorremos los audios
        noisy = awgn(mics(:,k),20,'measured');
        pause(0.25) %sospecho que el random necesita un tiempo para que sea distinto
        mics(:,k) = noisy;
    end
    
    
    %% ventaneo
    Nw = 1000;
    for k = 1:4 % recorremos los audios
        tau_temporal = utils.tau_ventaneo_resampleado(mics(:,k),mics(:,k+1),Nw,fs,@triang);
        %h = histogram(tau_temporal,1000);
        tau = mode(tau_temporal);
        gcc_ventaneo_upsample(i,k) = tau;
%         %% histograma
%         figure
%         histogram(tau_temporal,1000);
%         fileName = sprintf('Ej6_Histograma%d%d',k,k+1);
%         utils.print(fileName);
%         %% tau temporal
%         figure
%         plot(tau_temporal)
%         %ylim([-85e-6 -60e-6])
%         fileName = sprintf('Ej6_EvolucionTau%d%d',k,k+1);
%         utils.print(fileName);
    end
end

figure
histogram(gcc_ventaneo_upsample(:,1),1000)
utils.print('Ej6_Triangular_Histograma_12');
figure
histogram(gcc_ventaneo_upsample(:,2),1000)
utils.print('Ej6_Triangular_Histograma_23');
figure
histogram(gcc_ventaneo_upsample(:,3),1000)
utils.print('Ej6_Triangular_Histograma_34');
figure
histogram(gcc_ventaneo_upsample(:,4),1000)
utils.print('Ej6_Triangular_Histograma_45');

tau12 = mean(gcc_ventaneo_upsample(:,1));
tau23 = mean(gcc_ventaneo_upsample(:,2));
tau34 = mean(gcc_ventaneo_upsample(:,3));
tau45 = mean(gcc_ventaneo_upsample(:,4));

retardos = [tau12 tau23 tau34 tau45]
% 1.0e-04 * -0.6823   -0.7656   -0.7604   -0.8750
posicion = [1.86 1.45];
utils.plot_habitacion(retardos,posicion,cuarto_x,cuarto_y,mics_pos,mics_colors)
utils.print('Ej6_Triangular_Habitacion')
