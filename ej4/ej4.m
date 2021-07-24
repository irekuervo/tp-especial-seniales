close all;

retardos_gccphat = [];

Nw = 2000;

for k = 1:4 % recorremos los audios 
    tau = utils.tau_ventaneo(mics(:,k),mics(:,k+1 ),Nw,fs,@hamming);
    retardos_gccphat = [retardos_gccphat tau];
    %utils.figure();
    %plot(tau_temporal);
    %file_name = sprintf('tau_temporal_mic%d%d', k,k+1);
    %utils.print(file_name);
end

retardos_gccphat
