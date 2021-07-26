classdef utils
    methods (Static)
        %% Correlacion Cruzada
        function tau = tau_correlacion_cruzada(x,y,fs)
            [r,lags] = xcorr(x,y);
            [maximo,index] = max(r);
            tau = lags(index)/fs;
        end
        %% GCC PHAT
        function gph = gcc_phat(x,y)
            N=length(x);
            dftx = fft(x,N);
            dfty = fft(y,N);
            Gph = (dftx.*conj(dfty))./(abs(dftx).*abs(dfty));
            gph = real(ifft(Gph));
        end
        
        %% TAU GCC PHAT
        function tau = tau_gcc_phat(x,y,fs)
            gph = utils.gcc_phat(x,y);
            N = length(gph);
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
            rate = 100;
            x = upsample(x,rate);
            y = upsample(y,rate);
            gph = utils.gcc_phat(x,y);
            N = length(gph);
            [M I] = max(gph);
            I = I - 1;
            if I > N/2
                tau = (I-N)/(fs*rate);
            else
                tau = I/(fs*rate);
            end
        end
        %% GCC PHAT Interpolado
        function tau = tau_gcc_phat_interpolado(x,y,fs)
            upsample = 100;
            gph = utils.gcc_phat(x,y);
            x = 1:length(x);
            xq = 1:2*length(x);
            gph = resample(gph,upsample,1);
            N = length(gph);
            [M I] = max(gph);
            I = I - 1;
            if I > N/2
                tau = (I-N)/(fs*upsample);
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
            lim = 10e-3;
            
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
        %% Ventaneo Interpolado
        function [tau,tau_temporal] = tau_ventaneo_interpolado(x,y,Nw,fs,window)
            [tau,tau_temporal] = utils.ventaneo_general(x,y,Nw,fs,window,@utils.tau_gcc_phat_interpolado);
        end
        %% pendiente fuente
        % para esta disposicion de microfonos, la solucion puede ser el
        % signo opuesto al que se devuelve, dependera de si es viable por
        % las dimensiones del cuarto
        function [angulo, pendiente]= pendiente_fuente(t_retardo)
            v_sonido = 340;
            distancia = 0.05;
            angulo = acos((v_sonido*t_retardo)/distancia);
            pendiente = tan(angulo);
        end
        %% plot habitacion
        % para esta disposicion de microfonos, la solucion puede ser el
        % signo opuesto al que se devuelve, dependera de si es viable por
        % las dimensiones del cuarto
        function plot_habitacion(retardos,fuente_pos,cuarto_x,cuarto_y,mics_pos,mics_color)
            figure
            grid on;
            hold on;
            xlim(cuarto_x);
            ylim(cuarto_y);
            for k = 1:5 % graficamos los mics
                mic_pos = mics_pos{k};
                plot(mic_pos(1),mic_pos(2),'o','Color',mics_color{k});
            end
            plot(fuente_pos(1),fuente_pos(2),'*','Color','black','MarkerSize',10);
            x_pos = linspace(0,cuarto_x(2));
            for k = 1:4
                [angulo, pendiente] = utils.pendiente_fuente(retardos(k));
                xk = mics_pos{k+1}(1);
                yk = mics_pos{k+1}(2);
                y_pos1 = pendiente.*x_pos + (yk - pendiente.*xk);
                plot(x_pos,y_pos1,'Color',mics_color{k+1});
            end
            legend('mic 1','mic 2','mic 3','mic 4','mic 5','fuente','par 1-2','par 2-3','par 3-4','par 4-5');
        end
        %% print
        % para mantener mismo estilo de plots
        function print(nombre)
            filename = strcat(nombre,'.png');
            print(filename,'-dpng','-r300');
        end
        %% figure
        % para mantener mismo estilo de plots
        function figure()
            figure('Position', [50 -50 800 300])
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
            semilogx(f,P1)
            
        end
    end
end