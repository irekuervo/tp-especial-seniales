close all;

retardos_gccphat = [];

for k = 1:4 % recorremos los audios 
    [tau,tau_temporal] = utils.tau_ventaneo(mics(:,k+1),mics(:,k),fs,fs,@rectwin);
    retardos_gccphat = [retardos_gccphat tau];
    utils.figure();
    plot(tau_temporal);
    file_name = sprintf('tau_temporal_mic%d%d', k+1,k);
    utils.print(file_name);
end

retardos_gccphat
