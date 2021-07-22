classdef utils
    methods (Static)
        function tau = tau_par_microfono(n,x,y,wn,w,fs)
            x_seg = x(n:(n+wn-1));
            y_seg = y(n:(n+wn-1));
            xw = x_seg.*w(wn).';
            yw = y_seg.*w(wn).';
            dftx = fft(xw);
            dfty = fft(yw);
            Gph = (dftx.*conj(dfty))./(abs(dftx).*abs(dfty));
            idftGph = ifft(Gph);
            
            [M I] = max(idftGph);
            
            if I > wn/2
                tau = abs(wn-I)/fs;
                plot(x_seg)
                hold on
                plot(y_seg)
                str = sprintf('Tau: %0.5e',tau);
                legend(str)
                hold off
            else
                tau = 0;
            end
        end
        function angulo = angulo_fuente(t,d,c)
            angulo = acos((c*t)/d);
        end
        function print(nombre)
            filename = strcat(nombre,'png');
            print(filename,'-dpng','-r300');
        end
        function figure()
            figure('Position', [100 100 1600 600])
        end
        function  plot_mics(xn,micn,mic_color)
            plot(xn,micn,'Color',mic_color,'LineWidth',0.7);
        end
    end
end