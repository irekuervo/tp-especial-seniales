classdef utils
    methods (Static)
        %% Correlacion Cruzada
        function tau = tau_correlacion_cruzada(x,y,fs)
            [r,lags] = xcorr(x,y);
            [maximo,index] = max(r);
            tau = lags(index)/fs;
        end
        %% GCC PHAT
        function tau = tau_gcc_phat(x,y,fs)
            N=length(x);
            dftx = fft(x,N);
            dfty = fft(y,N);
            Gph = (dftx.*conj(dfty))./(abs(dftx).*abs(dfty));
            gph = real(ifft(Gph));
            [M I] = max(gph);
            I = I - 1;
            if I > N/2
                tau = (I-N)/fs;
            else
                tau = I/fs;
            end
        end
        %% GCC PHAT Resampleado
        function tau = tau_gcc_phat_resampleado(x,y,fs)
            upsample = 100;
            N=length(x);
            dftx = fft(x,N);
            dfty = fft(y,N);
            Gph = (dftx.*conj(dfty))./(abs(dftx).*abs(dfty));
            gph = real(ifft(Gph));
            gph = resample(gph,upsample,1);
            [M I] = max(gph);
            I = I - 1;
            if I > N/2
                tau = (I-N*upsample)/(fs*upsample);
            else
                tau = I/(fs*upsample);
            end
        end
        %% Ventaneo general
        function [tau,tau_temporal] = ventaneo_general(x,y,Nw,fs,window,cggphat)
            N = length(x);
            n0 = Nw/2;
            cantidadDeVentaneos = 500;
            dn = round(N/cantidadDeVentaneos);
            tau_temporal=[];
            w = window(Nw);
            lim = 10e-4;
            
            while n0 + Nw/2 < N
                n_start = n0-Nw/2+1;
                n_end = n0+Nw/2;
                xw = x(n_start:n_end).*w;
                yw = y(n_start:n_end).*w;
                tau_window = cggphat(xw,yw,fs);
                %descarto valores muy grandes, o nulos
                if abs(tau_window) < lim && abs(tau_window) > 0
                    tau_temporal = [tau_temporal, tau_window];
                end
                n0 = n0 + dn;
            end
            tau = mode(tau_temporal);
        end
        %% Ventaneo
        function [tau,tau_temporal] = tau_ventaneo(x,y,Nw,fs,window)
            [tau,tau_temporal] = utils.ventaneo_general(x,y,Nw,fs,window,@utils.tau_gcc_phat);
        end
        %% Ventaneo Resampleado
        function [tau,tau_temporal] = tau_ventaneo_resampleado(x,y,Nw,fs,window)
            [tau,tau_temporal] = utils.ventaneo_general(x,y,Nw,fs,window,@utils.tau_gcc_phat_resampleado);
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
            filename = strcat(nombre,'.png');
            %print(filename,'-dpng','-r300');
        end
        %% figure
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
        %% plot fft
        function plot_fft(x,fs)
            N = length(x);
            Y = fft(x);
            P2 = abs(Y/N);
            P1 = P2(1:N/2+1);
            P1(2:end-1) = 2*P1(2:end-1);
            f = fs*(0:(N/2))/N;
            figure
            semilogx(f,P1)
            title('Single-Sided Amplitude Spectrum of X(t)')
            xlabel('f (Hz)')
            ylabel('|P1(f)|')
        end
    end
end