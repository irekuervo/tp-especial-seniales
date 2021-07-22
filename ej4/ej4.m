close all;

wn = 10000; %ventana en muestras
wt = ts*wn; %ventana en tiempo

clc;
fh = figure;
%recorremos todo el audio
for i=1:N-wn
    %cada un wn graficamos el progreso de los calculos
    if rem(i,wn) == 0
        t=i*ts; %tiempo del ventaneo
        figure(fh);
        %% plot entero
        subplot(3,1,1)
        plot(xn,mics{1});
        hold on;
        line([t t], [-0.08 0.06],'Color','red')
        hold off;
        hold on;
        subplot(3,1,1)
        line([t+wt t+wt], [-0.08 0.06],'Color','red')
        hold off;
        ylim([-0.08 0.06])
        %% plots de ventaneos
        wn_i = i+wn-1;
        if wn_i > N
            wn_i = N;
            wn = N - i + 1;
        end
        %%rectangular
        ventaneo_rectangular = mics{1}(i:wn_i);
        subplot(3,1,2);
        plot(ventaneo_rectangular)
        %% hamming
        ventana_hamming = hamming(wn).';
        ventaneo_hamming = ventaneo_rectangular.*ventana_hamming;
        subplot(3,1,3);
        plot(ventaneo_hamming)
        drawnow;
    end
end
