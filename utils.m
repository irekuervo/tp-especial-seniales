classdef utils
    methods (Static)
        %% Correlacion Cruzada
        function tau = tau_correlacion_cruzada(x,y,fs)
            [r,lags] = xcorr(x,y);
            [maximo,index] = max(r);
            tau = lags(index)/fs;
        end
        %% GCC PHAT
        function tau = tau_gcc_phat(x,y,fs,window)
            N=length(x);
            xw = x.*window(N);
            yw = y.*window(N);
            dftx = fft(xw);
            dfty = fft(yw);
            Gph = (dftx.*conj(dfty))./(abs(dftx).*abs(dfty));
            idftGph = ifft(Gph);
            [M I] = max(idftGph);
            tau = I/fs;
        end
        %% Ventaneo
        function tau = tau_ventaneo(x,y,Nw,fs,window)
            n0 = 10000;
            dn = Nw/4;
            N = length(x);
            taus = [];
            while n0 + Nw < N
                x_seg = x(n0:(n0+Nw-1));
                y_seg = y(n0:(n0+Nw-1));
                tau_window =  gccphat(x_seg,y_seg,fs);
                %tau_window =  utils.tau_gcc_phat(x_seg,y_seg,fs,window);
                taus = [taus, tau_window];
                n0 = n0 + dn;
            end
            h = histogram(taus,Nw);
            [maxcount, bin] = max(h.Values);
            tau = h.BinEdges(bin);
        end
        %% pendiente fuente
        % para esta disposicion de microfonos, la solucion puede ser el
        % signo opuesto al que se devuelve, dependera de si es viable por
        % las dimensiones del cuarto
        function [angulo, pendiente]= pendiente_fuente(t_retardo,distancia,velocidad)
            angulo = acos((velocidad*t_retardo)/distancia);
            pendiente = tan(angulo);
        end
        %% print
        % para mantener mismo estilo de plots
        function print(nombre)
            filename = strcat(nombre,'png');
            print(filename,'-dpng','-r300');
        end
        %% print
        % para mantener mismo estilo de plots
        function figure()
            figure('Position', [100 100 1600 600])
        end
        %% plot_mics
        % para mantener consistencia de colores e identificar bien a los
        % microfonos
        function  plot_mics(xn,micn,mic_color)
            plot(xn,micn,'Color',mic_color,'LineWidth',0.7);
        end
    end
end