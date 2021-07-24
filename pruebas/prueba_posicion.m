clear all;
close all;

%pimero correr loadData asi tengo toda la info
run('loadData');

%elijo la posicion, deberia andar con cualquiera
figure
grid on;
hold on;
fuente_pos=[1 3];
plot(fuente_pos(1),fuente_pos(2),'x');
%prueba manual de retardos asumiendo que la fuente esta en una posicion
%conocida
xlim(cuarto_x);
ylim(cuarto_y);

tiempos=[];
for k = 1:5 % recorremos los audios 
    mic_pos = mics_pos{k};
    distancia = norm(mic_pos - fuente_pos);
    tiempo= distancia/c;
    tiempos=[tiempos, tiempo];
    plot(mic_pos(1),mic_pos(2),'o');
end

retardos=[];
for k =1:4 %veo los retardos 
    retardo=abs(tiempos(k)-tiempos(k+1));
    retardos=[retardos, retardo];
end

%pruebo a ver si puedo reconstruir la fuente con esta cuenta


x_pos = linspace(0,cuarto_x(2));
angulos=[];
for k = 1:4 % recorremos los audios 
    [angulo, pendiente] = utils.pendiente_fuente(retardos(k),0.05,c);
    angulos = [angulos, rad2deg(angulo)];
    xk = mics_pos{k}(1);
    yk = mics_pos{k}(2);
    y_pos1 = pendiente.*x_pos + (yk - pendiente.*xk);
    y_pos2 = -pendiente.*x_pos + (yk + pendiente.*xk);
    plot(x_pos,y_pos1);
    plot(x_pos,y_pos2);
end

%barbaro, quedo demostrado que funciona, y ahora entendi cómo empiricamente
%asumiendo que ya donde esta la fuente (sin procesar el audio)



