close all;

gcc_ventaneo = [];

Nw = 2000;

for k = 1:4 % recorremos los audios 
    tau = utils.tau_ventaneo(mics(:,k),mics(:,k+1 ),Nw,fs,@hamming);
    gcc_ventaneo = [gcc_ventaneo tau];
end

gcc_ventaneo
