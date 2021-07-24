%constantes
fs=48000;
ts=1/fs;
c=340; %velocidad del sonido
cuarto_x = [0 3]; %dimension x del cuarto
cuarto_y = [0 4]; %dimension y del cuarto

%datos de los audios de cada microfono


N = 4000;
xn=linspace(0,N*ts,N); %eje para todos los audios

taus=[0 6.44382204451092e-05 6.17287135362419e-05 5.89407021648752e-05 5.60748775184456e-05];
mics={};

for k = 1:5 % recorremos los audios
    mic = sin(2*pi.*(1000.*xn + fs*taus(k)));
    mics = [mics, mic];
end



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

