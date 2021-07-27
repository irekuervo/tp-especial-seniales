close all
clear all
run('utils')
run('loadData')
display('----------Ejercicio 2-----------');
%de forma grafica y aproximada, se exportan los data cursor de 5 maximos
%arbitrarios de las señales superpuestas que sirven de referencia para
%calcular los retardos entre microfonos

%se toma como referencia el grafico del ejercicio 1

% picos=[];
% for i=1:5
% 	picos = [picos, picos_cursor(6-i).Position(1)]; %vienen al reves
% end
%
% retardos_a_ojo=[];
% for i=1:4
%     retardo=picos(i)-picos(i+1);
% 	retardos_a_ojo=[retardos_a_ojo,retardo];
% end

%me da un retardo de 62.5us para los primeros dos y 83.33us para los ultimos
%dos, lo cual se condice con que primero llega al microfono 1 y por ultimo
%al 5, incrementandose el retardo

%esto implica que la fuente esta en el 2do cuadrante de un sistema
%cartesiano centrado en el primer microfono

%aca esta el resultado
retardos = 1.0e-06 *[-62.5000  -62.5000  -83.3333  -83.3333]
posicion = [1.86 1.45]
utils.plot_habitacion(retardos,posicion,cuarto_x,cuarto_y,mics_pos,mics_colors)
utils.print('Ej2_Fuente')

