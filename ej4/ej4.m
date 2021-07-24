close all;

retardos_gccphat = [];

for k = 1:4 % recorremos los audios 
    tau = utils.tau_ventaneo(mics{k+1},mics{k},fs,fs,@rectwin);
    retardos_gccphat = [retardos_gccphat tau];
end

retardos_gccphat
