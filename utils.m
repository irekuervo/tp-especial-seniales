classdef utils
    methods (Static)
        function angulo = angulo_fuente(t,d,c)
            angulo = acos((c*t)/d);
        end
        function print(nombre)
            filename = strcat('prints/',nombre);
            filename = strcat(filename,'png');
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