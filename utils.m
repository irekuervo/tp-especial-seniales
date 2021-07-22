classdef utils
    methods (Static)
        function res = func1(a,b)
            res = a * b;
        end
        function  plot_mics(xn,micn,mic_color)
            plot(xn,micn,'Color',mic_color,'LineWidth',0.7);
        end
    end
end