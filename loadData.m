clear all;
close all;

%constantes
fs=48000;
ts=1/fs;
c=340; %velocidad del sonido
cuarto_x = [0 3]; %dimension x del cuarto
cuarto_y = [0 4]; %dimension y del cuarto

%datos de los audios de cada microfono
load('audios.mat');
[numRows,numCols] = size(audios);

N = numRows;
xn=linspace(0,numRows*ts,numRows); %eje para todos los audios

mics=audios; %nombre que me gusto mas

% soundsc(mics(:,2),fs) por si lo quiero escuchar

%posicion de los mics y la fuente (hipoteticamente)
mic1_pos=[2 1];
mic2_pos=[2.05 1];
mic3_pos=[2.1 1];
mic4_pos=[2.15 1];
mic5_pos=[2.2 1];
fuente_pos=[3.5 3.5];

mics_pos={mic1_pos,mic2_pos,mic3_pos,mic4_pos,mic5_pos};

%colores
mic1_color=[0 0.4470 0.7410];
mic2_color=[0.8500 0.3250 0.0980];
mic3_color=[0.9290 0.6940 0.1250];
mic4_color=[0.4940 0.1840 0.5560];
mic5_color=[0.4660 0.6740 0.1880];

mics_colors={mic1_color,mic2_color,mic3_color,mic4_color,mic5_color};

